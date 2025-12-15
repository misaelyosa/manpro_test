import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/data/repository/article_repo.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';

class ArticlePageProvider extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();

  List<Article> articles = [];
  Article? featuredArticle;
  bool isLoading = false;
  bool isAdmin = false;
  final AuthService _auth = AuthService();

  ArticlePageProvider(){
    checkAdmin();
  }

  Future<void> fetchArticles() async {
    isLoading = true;
    notifyListeners();

    final snapshot = await _repository.getArticles();

    articles = snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList();

    featuredArticle = articles.where((a) => a.isFeatured).isNotEmpty
        ? articles.firstWhere((a) => a.isFeatured)
        : null;

    isLoading = false;
    notifyListeners();
  }

  Future<void> checkAdmin() async {
    final user = await _auth.getLoggedUser();
    if (user == null) return;

    isAdmin = user.role == 'admin';
    notifyListeners();
  }
}
