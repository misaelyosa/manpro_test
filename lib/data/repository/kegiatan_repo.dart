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
}
