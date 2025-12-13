import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rasadharma_app/data/classes/Events.dart';
import 'package:rasadharma_app/data/classes/user.dart';
import 'package:rasadharma_app/data/enums/pref_keys_enums.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/data/repository/kegiatan_repo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class KegiatanProvider extends ChangeNotifier {
  BuildContext? _context;
  KegiatanProvider.withContext(BuildContext context) {
    _context = context;
    getKegiatan();
    checkAdmin();
  }

  final KegiatanRepo _repositoryKegiatan = KegiatanRepo();
  final AuthService _auth = AuthService();

  int selectedIndex = 0;
  List<Kegiatan> items = [];
  bool fetchingKegiatan = false;
  bool _loaded = false;
  bool isAdmin = false;

  final List<Kegiatan> events = [];
  final Map<String, bool> _registrationStatus = {};

  bool isRegistered(String eventId) => _registrationStatus[eventId] ?? false;

  List<Kegiatan> get upcoming =>
      events.where((e) => e.tanggalKegiatan.isAfter(DateTime.now())).toList();

  List<Kegiatan> get past =>
      events.where((e) => !e.tanggalKegiatan.isAfter(DateTime.now())).toList();

  Future<void> onSelected(int i) async {
    selectedIndex = i;
    items = selectedIndex == 0 ? upcoming : past;
    notifyListeners();
  }

  Future<void> checkAdmin() async {
    final user = await _auth.getLoggedUser();
    if (user == null) return;

    // adjust according to your user model
    isAdmin = user.role == 'admin';
    notifyListeners();
  }

  Future<void> getKegiatan() async {
    if (_loaded) return;
    fetchingKegiatan = true;
    notifyListeners();
    QuerySnapshot querySnapshot = await _repositoryKegiatan.getKegiatanStream();
    events.clear();
    for (var doc in querySnapshot.docs) {
      events.add(
        Kegiatan(
          id: doc["id"],
          namaKegiatan: doc["nama_kegiatan"],
          kategori: doc["kategori"],
          tanggalKegiatan: doc["tanggal_kegiatan"].toDate(),
          waktuMulai: doc["waktu_mulai"],
          waktuSelesai: doc["waktu_selesai"],
          lokasi: doc["lokasi"],
          deskripsi: doc["deskripsi"],
          registeredAmount: doc["registered_amount"],
          capacity: doc["capacity"],
        ),
      );
    }
    items = selectedIndex == 0 ? upcoming : past;
    fetchingKegiatan = false;
    _loaded = true;
    notifyListeners();
  }

  Future<void> checkRegistrationStatus(String eventId) async {
    final user = await _auth.getLoggedUser();
    if (user == null) return;

    if (_registrationStatus.containsKey(eventId)) return;

    final doc = await FirebaseFirestore.instance
        .collection('kegiatan')
        .doc(eventId)
        .collection('registrations')
        .doc(user.id)
        .get();

    _registrationStatus[eventId] = doc.exists;
    notifyListeners();
  }

  Future<void> onRegister(Kegiatan e) async {
    final UserBHT? user = await _auth.getLoggedUser();
    if (user == null) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        const SnackBar(
          content: Text(
            "Silahkan login terlebih dahulu untuk mendaftar kegiatan",
          ),
        ),
      );
      return;
    }

    final firestore = FirebaseFirestore.instance;
    final kegiatanRef = firestore.collection('kegiatan').doc(e.id);
    final registrationRef = kegiatanRef
        .collection('registrations')
        .doc(user.id);

    try {
      await firestore.runTransaction((transaction) async {
        final kegiatanSnap = await transaction.get(kegiatanRef);

        if (!kegiatanSnap.exists) {
          throw Exception("Kegiatan tidak ditemukan");
        }

        final int currentCount = kegiatanSnap['registered_amount'] ?? 0;
        final int capacity = kegiatanSnap['capacity'] ?? 0;

        if (currentCount >= capacity) {
          throw Exception("Kegiatan sudah penuh");
        }

        final registrationSnap = await transaction.get(registrationRef);
        if (registrationSnap.exists) {
          throw Exception("Anda sudah terdaftar di kegiatan ini");
        }

        // Create subcollection document
        transaction.set(registrationRef, {
          'registeredAt': FieldValue.serverTimestamp(),
        });

        // Update counter
        transaction.update(kegiatanRef, {
          'registered_amount': currentCount + 1,
        });
      });

      // ===============================
      // WhatsApp notification
      // ===============================
      final message =
          '''
            Ada pendaftar baru event 📢

            Nama: ${user.nama}
            Email: ${user.email}
            No. WhatsApp: ${user.noTelp}

            Detail Event:
            Nama Event: ${e.namaKegiatan}
            Kategori: ${e.kategori}
            Tanggal: ${e.tanggalKegiatan.toLocal()}
            Waktu: ${e.waktuMulai} - ${e.waktuSelesai}
            Lokasi: ${e.lokasi}

            Terima kasih 🙏
            ''';

      await sendWaFonnte(adminPhone: '6287855570801', message: message);

      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text("Berhasil daftar ${e.namaKegiatan}")),
      );

      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(
        _context!,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> sendWaFonnte({
    required String adminPhone,
    required String message,
  }) async {
    final url = Uri.parse('https://api.fonnte.com/send');
    const token = '6BivGVvK7AG4WaUUsHMg';

    final response = await http.post(
      url,
      headers: {'Authorization': token},
      body: {'target': adminPhone, 'message': message},
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");
  }
}
