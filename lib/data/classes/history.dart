import 'package:cloud_firestore/cloud_firestore.dart';

class Sejarah {
  final String id;
  final String judul;
  final DateTime tahun;
  final String deskripsi;

  Sejarah({
    required this.id,
    required this.judul,
    required this.tahun,
    required this.deskripsi,
  });

  factory Sejarah.fromJson(Map<String, dynamic> json){
    return Sejarah(
    id: json['id'], 
    judul: json['judul'],
    tahun: (json['tanggal_kegiatan'] as Timestamp).toDate(),
    deskripsi: json['deskripsi'] 
    );
  }

  Map<String, dynamic> toJson() => {
    'id' : id,
    'judul' : judul,
    'tahun' : Timestamp.fromDate(tahun),
    'deskripsi' : deskripsi,
  };
}