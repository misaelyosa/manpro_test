import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';

class KegiatanRepo {
  final CollectionReference _kegiatanCollection = FirebaseFirestore.instance
      .collection(CollectionEnums.kegiatan);

  Future<QuerySnapshot> getKegiatanStream() {
    return _kegiatanCollection.get();
  }

  Future<void> deleteKegiatan(String kegiatanId) async {
    try {
      await _kegiatanCollection.doc(kegiatanId).delete();
    } catch (e) {
      throw Exception('Gagal menghapus kegiatan: $e');
    }
  }

  Future<void> updateKegiatan({
    required String eventId,
    required String namaKegiatan,
    required String kategori,
    required DateTime tanggalKegiatan,
    required String waktuMulai,
    required String waktuSelesai,
    required String lokasi,
    required String deskripsi,
    required int capacity,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection('kegiatan')
          .doc(eventId)
          .update({
            'nama_kegiatan': namaKegiatan,
            'kategori': kategori,
            'tanggal_kegiatan': Timestamp.fromDate(tanggalKegiatan),
            'waktu_mulai': waktuMulai,
            'waktu_selesai': waktuSelesai,
            'lokasi': lokasi,
            'deskripsi': deskripsi,
            'capacity': capacity,
          });
    } catch (e) {
      throw Exception('Gagal menghapus kegiatan: $e');
    }
  }
}
