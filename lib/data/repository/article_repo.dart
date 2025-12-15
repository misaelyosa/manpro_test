import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleRepository {
  final _firestore = FirebaseFirestore.instance;
  final String _collection = 'articles';

  Future<QuerySnapshot> getArticles() {
    return _firestore
        .collection(_collection)
        .orderBy('date', descending: true)
        .get();
  }

  Future<void> addArticle(Map<String, dynamic> data) {
    return _firestore.collection(_collection).add(data);
  }

  Future<void> updateArticle(String id, Map<String, dynamic> data) {
    return _firestore.collection(_collection).doc(id).update(data);
  }

  Future<void> deleteArticle(String id) {
    return _firestore.collection(_collection).doc(id).delete();
  }
}
