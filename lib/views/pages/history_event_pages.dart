import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/history_event_card.dart';

List<Kegiatan> dummyHistoryEvents = [
  Kegiatan(
    id: 'evt_001',
    namaKegiatan: 'Bakti Sosial Desa',
    kategori: 'Sosial',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 14)),
    waktuMulai: '08:00',
    waktuSelesai: '12:00',
    lokasi: 'Desa Sukamaju',
    deskripsi: 'Kegiatan bakti sosial bersama warga desa.',
    registeredAmount: 45,
    capacity: 50,
  ),
  Kegiatan(
    id: 'evt_001',
    namaKegiatan: 'Bakti Sosial Desa',
    kategori: 'Sosial',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 14)),
    waktuMulai: '08:00',
    waktuSelesai: '12:00',
    lokasi: 'Desa Sukamaju',
    deskripsi: 'Kegiatan bakti sosial bersama warga desa.',
    registeredAmount: 45,
    capacity: 50,
  ),
  Kegiatan(
    id: 'evt_001',
    namaKegiatan: 'Bakti Sosial Desa',
    kategori: 'Sosial',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 14)),
    waktuMulai: '08:00',
    waktuSelesai: '12:00',
    lokasi: 'Desa Sukamaju',
    deskripsi: 'Kegiatan bakti sosial bersama warga desa.',
    registeredAmount: 45,
    capacity: 50,
  ),
  Kegiatan(
    id: 'evt_001',
    namaKegiatan: 'Bakti Sosial Desa',
    kategori: 'Sosial',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 14)),
    waktuMulai: '08:00',
    waktuSelesai: '12:00',
    lokasi: 'Desa Sukamaju',
    deskripsi: 'Kegiatan bakti sosial bersama warga desa.',
    registeredAmount: 45,
    capacity: 50,
  ),
  Kegiatan(
    id: 'evt_001',
    namaKegiatan: 'Bakti Sosial Desa',
    kategori: 'Sosial',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 14)),
    waktuMulai: '08:00',
    waktuSelesai: '12:00',
    lokasi: 'Desa Sukamaju',
    deskripsi: 'Kegiatan bakti sosial bersama warga desa.',
    registeredAmount: 45,
    capacity: 50,
  ),
  Kegiatan(
    id: 'evt_002',
    namaKegiatan: 'Donor Darah PMI',
    kategori: 'Kesehatan',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 30)),
    waktuMulai: '09:00',
    waktuSelesai: '13:00',
    lokasi: 'Gedung Serbaguna',
    deskripsi: 'Kegiatan donor darah bekerja sama dengan PMI.',
    registeredAmount: 80,
    capacity: 100,
  ),
  Kegiatan(
    id: 'evt_003',
    namaKegiatan: 'Pelatihan Kepemimpinan',
    kategori: 'Pelatihan',
    tanggalKegiatan: DateTime.now().subtract(const Duration(days: 60)),
    waktuMulai: '08:30',
    waktuSelesai: '16:00',
    lokasi: 'Aula Kampus',
    deskripsi: 'Pelatihan dasar kepemimpinan untuk anggota baru.',
    registeredAmount: 30,
    capacity: 30,
  ),
];

class HistoryEventPages extends StatelessWidget {
  const HistoryEventPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkRed,
        elevation: 0.5,
        title: Text(
          "Riwayat Kegiatan",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.darkRed,
          ),
        ),
      ),

      body: _body(context),
    );
  }
}

Widget _body(BuildContext context) {
  final List<Kegiatan> historyEvents = dummyHistoryEvents;

  return SafeArea(
    child: Column(
      children: [
        // OPTIONAL: bisa taruh filter / info di sini
        const SizedBox(height: 8),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: historyEvents.isEmpty
                ? _emptyState()
                : ListView.separated(
                    itemCount: historyEvents.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final event = historyEvents[index];
                      return HistoryEventCard(
                        event: event,
                        status: statusByDate(event.tanggalKegiatan),
                      );
                    },
                  ),
          ),
        ),
      ],
    ),
  );
}

Widget _emptyState() {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.history, size: 64, color: Colors.grey.shade400),
        const SizedBox(height: 12),
        Text(
          'Belum ada riwayat kegiatan',
          style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
        ),
      ],
    ),
  );
}

String statusByDate(DateTime eventDate) {
  final today = DateTime.now();
  final normalizedToday = DateTime(today.year, today.month, today.day);

  final normalizedEvent = DateTime(
    eventDate.year,
    eventDate.month,
    eventDate.day,
  );

  if (normalizedEvent.isBefore(normalizedToday)) {
    return 'Selesai';
  }
  return 'Terdaftar';
}
