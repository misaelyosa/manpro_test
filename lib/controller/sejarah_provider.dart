import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/history.dart';
import 'package:rasadharma_app/data/repository/sejarah_repo.dart';

class SejarahProvider extends ChangeNotifier {
  BuildContext? _context;
  SejarahProvider.withContext(BuildContext content) {
    _context = content;
    getSejarah();
  }

  final SejarahRepo _repositorySejarah = SejarahRepo();
  final List<Sejarah> sejarahData = [];

  Future<void> getSejarah() async {
    sejarahData.clear();
    QuerySnapshot querySnapshot = await _repositorySejarah.getSejarahStream();
    for (var doc in querySnapshot.docs) {
      sejarahData.add(
        Sejarah(
          id: doc['id'],
          judul: doc['judul'],
          tahun: doc['tahun'].toDate(),
          deskripsi: doc['deskripsi'],
        ),
      );
    }
    notifyListeners();
  }
}
