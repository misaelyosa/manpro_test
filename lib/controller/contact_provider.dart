import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasadharma_app/data/classes/contact_person.dart';
import 'package:rasadharma_app/data/repository/contact_repo.dart';

class ContactProvider extends ChangeNotifier {
  final ContactRepository _repository = ContactRepository();

  final List<ContactPerson> _contacts = [];
  List<ContactPerson> get contacts => List.unmodifiable(_contacts);

  bool isAdmin = false;
  bool fetchingContacts = false;

  ContactProvider() {
    getContacts();
    checkAdmin();
  }

  Future<void> checkAdmin() async {
    // TODO: replace with AuthService
    isAdmin = true;
    notifyListeners();
  }

  /// GET — SAME STYLE AS getKegiatan()
  Future<void> getContacts() async {
    fetchingContacts = true;
    notifyListeners();

    QuerySnapshot querySnapshot =
        await _repository.getContacts();

    _contacts.clear();

    for (var doc in querySnapshot.docs) {
      _contacts.add(
        ContactPerson(
          id: doc.id,
          name: doc['name'],
          role: doc['role'],
          time: doc['time'],
          info: doc['info'],
        ),
      );
    }

    fetchingContacts = false;
    notifyListeners();
  }

  /// ADD
  Future<void> addContact(ContactPerson person) async {
    await _repository.addContact({
      'name': person.name,
      'role': person.role,
      'time': person.time,
      'info': person.info,
      'createdAt': FieldValue.serverTimestamp(),
    });

    await getContacts(); // refresh like kegiatan
  }

  /// DELETE
  Future<void> deleteContact(String id) async {
    await _repository.deleteContact(id);
    _contacts.removeWhere((c) => c.id == id);
    notifyListeners();
  }
}
