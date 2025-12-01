import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';

class KegiatanProvider extends ChangeNotifier {
  BuildContext? _context;
  KegiatanProvider.withContext(BuildContext context) {
    _context = context;
    items = selectedIndex == 0 ? upcoming : past;
  }

  int selectedIndex = 0;
  List<Kegiatan> items = [];

  final List<Kegiatan> events = [
    Kegiatan(
      id: '1',
      category: 'Budaya',
      title: 'Perayaan Imlek 2025',
      date: DateTime(2025, 1, 29),
      timeStr: '19:00 - 22:00',
      location: 'Gedung Utama Rasa Dharma',
      description:
          'Perayaan tahun baru Imlek dengan pertunjukan seni tradisional dan makan bersama.',
      registered: 85,
      capacity: 120,
    ),
    Kegiatan(
      id: '2',
      category: 'Sosial',
      title: 'Bakti Sosial Bulanan',
      date: DateTime(2025, 2, 15),
      timeStr: '08:00 - 12:00',
      location: 'Kelurahan Pancoran',
      description: 'Kegiatan bakti sosial untuk membantu warga sekitar.',
      registered: 32,
      capacity: 50,
    ),
    Kegiatan(
      id: '3',
      category: 'Budaya',
      title: 'Pertunjukan Barongsai',
      date: DateTime(2024, 11, 10),
      timeStr: '16:00 - 18:00',
      location: 'Lapangan Depan',
      description: 'Pertunjukan barongsai dalam rangka festival lokal.',
      registered: 120,
      capacity: 150,
    ),
  ];

  List<Kegiatan> get upcoming =>
      events.where((e) => e.date.isAfter(DateTime.now())).toList();

  List<Kegiatan> get past =>
      events.where((e) => !e.date.isAfter(DateTime.now())).toList();

  void onSelected(int i) {
    selectedIndex = i;
    items = selectedIndex == 0 ? upcoming : past;
    notifyListeners();
  }

  void onRegister(Kegiatan e) {
    ScaffoldMessenger.of(
      _context!,
    ).showSnackBar(SnackBar(content: Text("Daftar ke ${e.title}")));
    notifyListeners();
  }
}
