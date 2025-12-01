import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';

class KegiatanRepo {
  final CollectionReference _userDoorprize =
      FirebaseFirestore.instance.collection(CollectionEnums.kegiatan);
}