import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/history.dart';
import 'package:rasadharma_app/data/enums/collection_enums.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/data/repository/sejarah_repo.dart';

class SejarahProvider extends ChangeNotifier {
  BuildContext? _context;
  SejarahProvider.withContext(BuildContext content) {
    _context = content;
    getSejarah();
    checkAdmin();
  }

  final SejarahRepo _repositorySejarah = SejarahRepo();
  final AuthService _auth = AuthService();
  final SejarahRepo _sejarahRepo = SejarahRepo();

  final List<Sejarah> sejarahData = [];
  bool isAdmin = false;

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

  Future<void> checkAdmin() async {
    final user = await _auth.getLoggedUser();
    if (user == null) return;

    // adjust according to your user model
    isAdmin = user.role == 'admin';
    notifyListeners();
  }

  Future<void> createSejarah({
    required String judul,
    required DateTime tahun,
    required String deskripsi,
  }) async {
    try {
      final firestore = FirebaseFirestore.instance;
      final sejarahRef = firestore.collection(CollectionEnums.sejarah).doc();

      final sejarah = Sejarah(
        id: sejarahRef.id,
        judul: judul,
        tahun: tahun,
        deskripsi: deskripsi,
      );

      await sejarahRef.set(sejarah.toJson());
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text('Sejarah "$judul" berhasil ditambahkan')),
      );
      sejarahData.add(sejarah);
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(
        _context!,
      ).showSnackBar(SnackBar(content: Text('Gagal menambahkan kegiatan: $e')));
    }
  }
}
