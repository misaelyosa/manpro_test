import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasadharma_app/data/classes/history.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';

class SejarahRepo {
  final CollectionReference _sejarahCollection = FirebaseFirestore.instance
      .collection(CollectionEnums.sejarah);

  Future<QuerySnapshot> getSejarahStream() {
    return _sejarahCollection.get();
  }
}
