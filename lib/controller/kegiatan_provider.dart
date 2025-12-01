import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';
import 'package:rasadharma_app/data/repository/kegiatan_repo.dart';

class KegiatanProvider extends ChangeNotifier {
  BuildContext? _context;
  KegiatanProvider.withContext(BuildContext context) {
    _context = context;
    getKegiatan();
  }

  final KegiatanRepo _repositoryKegiatan = KegiatanRepo();

  int selectedIndex = 0;
  List<Kegiatan> items = [];
  bool fetchingKegiatan = false;
  bool _loaded = false;

  final List<Kegiatan> events = [
    // Kegiatan(
    //   id: '1',
    //   category: 'Budaya',
    //   title: 'Perayaan Imlek 2025',
    //   date: DateTime(2025, 1, 29),
    //   timeStr: '19:00 - 22:00',
    //   location: 'Gedung Utama Rasa Dharma',
    //   description:
    //       'Perayaan tahun baru Imlek dengan pertunjukan seni tradisional dan makan bersama.',
    //   registered: 85,
    //   capacity: 120,
    // ),
    // Kegiatan(
    //   id: '2',
    //   category: 'Sosial',
    //   title: 'Bakti Sosial Bulanan',
    //   date: DateTime(2025, 2, 15),
    //   timeStr: '08:00 - 12:00',
    //   location: 'Kelurahan Pancoran',
    //   description: 'Kegiatan bakti sosial untuk membantu warga sekitar.',
    //   registered: 32,
    //   capacity: 50,
    // ),
    // Kegiatan(
    //   id: '3',
    //   category: 'Budaya',
    //   title: 'Pertunjukan Barongsai',
    //   date: DateTime(2024, 11, 10),
    //   timeStr: '16:00 - 18:00',
    //   location: 'Lapangan Depan',
    //   description: 'Pertunjukan barongsai dalam rangka festival lokal.',
    //   registered: 120,
    //   capacity: 150,
    // ),
  ];

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

  void onRegister(Kegiatan e) {
    ScaffoldMessenger.of(
      _context!,
    ).showSnackBar(SnackBar(content: Text("Daftar ke ${e.namaKegiatan}")));
    notifyListeners();
  }
}
