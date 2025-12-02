import 'package:cloud_firestore/cloud_firestore.dart';

class Kegiatan {
  final String id;
  final String namaKegiatan;
  final String kategori;
  final DateTime tanggalKegiatan;
  final String waktuMulai;
  final String waktuSelesai;
  final String lokasi;
  final String deskripsi;
  final int registeredAmount;
  final int capacity;

  Kegiatan({
    required this.id,
    required this.namaKegiatan,
    required this.kategori,
    required this.tanggalKegiatan,
    required this.waktuMulai,
    required this.waktuSelesai,
    required this.lokasi,
    required this.deskripsi,
    required this.registeredAmount,
    required this.capacity,
  });

  factory Kegiatan.fromJson(Map<String, dynamic> json) {
    return Kegiatan(
      id: json['id'] as String? ?? '',
      namaKegiatan: json['nama_kegiatan'] as String? ?? '',
      kategori: json['kategori'] as String? ?? '',
      tanggalKegiatan: json['tanggal_kegiatan'] is Timestamp
          ? (json['tanggal_kegiatan'] as Timestamp).toDate()
          : json['tanggal_kegiatan'] != null
          ? DateTime.tryParse(json['tanggal_kegiatan'].toString()) ??
                DateTime.now()
          : DateTime.now(),

      waktuMulai: json['waktu_mulai'] as String? ?? '',
      waktuSelesai: json['waktu_selesai'] as String? ?? '',
      lokasi: json['lokasi'] as String? ?? '',
      deskripsi: json['deskripsi'] as String? ?? '',

      registeredAmount: json['registered_amount'] is int
          ? json['registered_amount'] as int
          : int.tryParse(json['registered_amount']?.toString() ?? '0') ?? 0,

      capacity: json['capacity'] is int
          ? json['capacity'] as int
          : int.tryParse(json['capacity']?.toString() ?? '0') ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'nama_kegiatan': namaKegiatan,
    'kategori': kategori,
    'tanggal_kegiatan': Timestamp.fromDate(tanggalKegiatan),
    'waktu_mulai': waktuMulai,
    'waktu_selesai': waktuSelesai,
    'lokasi': lokasi,
    'deskripsi': deskripsi,
    'registered_amount': registeredAmount,
    'capacity': capacity,
  };
}
