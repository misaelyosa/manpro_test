import 'package:cloud_firestore/cloud_firestore.dart';

class ContactRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// GET
  Future<QuerySnapshot> getContacts() async {
    return await _firestore
        .collection('contacts')
        .orderBy('createdAt', descending: false)
        .get();
  }

  /// ADD
  Future<void> addContact(Map<String, dynamic> data) async {
    await _firestore.collection('contacts').add(data);
  }

  /// DELETE
  Future<void> deleteContact(String id) async {
    await _firestore.collection('contacts').doc(id).delete();
  }
}
