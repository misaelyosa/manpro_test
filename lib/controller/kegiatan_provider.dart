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
  }

  final KegiatanRepo _repositoryKegiatan = KegiatanRepo();
  final AuthService _auth = AuthService();

  int selectedIndex = 0;
  List<Kegiatan> items = [];
  bool fetchingKegiatan = false;
  bool _loaded = false;

  final List<Kegiatan> events = [];

  List<Kegiatan> get upcoming =>
      events.where((e) => e.tanggalKegiatan.isAfter(DateTime.now())).toList();

  List<Kegiatan> get past =>
      events.where((e) => !e.tanggalKegiatan.isAfter(DateTime.now())).toList();

  Future<void> onSelected(int i) async {
    selectedIndex = i;
    items = selectedIndex == 0 ? upcoming : past;
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
      return; // STOP here
    }
    // Build message
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

    // Send WhatsApp
    await sendWaFonnte(adminPhone: '62895399852711', message: message);
    ScaffoldMessenger.of(
      _context!,
    ).showSnackBar(SnackBar(content: Text("Daftar ke ${e.namaKegiatan}")));
    notifyListeners();
  }

  Future<void> sendWaFonnte({
    required String adminPhone,
    required String message,
  }) async {
    final url = Uri.parse('https://api.fonnte.com/send');
    const token = '6BivGVvK7AG4WaUUsHMg'; // Masukkan token Fonnte Anda

    final response = await http.post(
      url,
      headers: {'Authorization': token},
      body: {'target': adminPhone, 'message': message},
    );

    print("Status: ${response.statusCode}");
    print("Response: ${response.body}");
  }
}
