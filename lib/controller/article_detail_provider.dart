import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/data/repository/article_repo.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';

class ArticleDetailProvider extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();
  final Article article;
  bool isAdmin = false;
  final AuthService _auth = AuthService();

  bool isEditMode = false;
  bool isLoading = false;

  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController readTimeController;
  bool isFeatured;

  ArticleDetailProvider({required this.article})
    : isFeatured = article.isFeatured {
    titleController = TextEditingController(text: article.title);
    contentController = TextEditingController(text: article.content);
    readTimeController = TextEditingController(text: article.readTime);
    checkAdmin();
  }

  void toggleEditMode() {
    isEditMode = !isEditMode;
    notifyListeners();
  }

  Future<void> save() async {
    if (titleController.text.trim().isEmpty ||
        contentController.text.trim().isEmpty) {
      throw Exception("Title and content cannot be empty");
    }

    isLoading = true;
    notifyListeners();

    await _repository.updateArticle(article.id, {
      'title': titleController.text.trim(),
      'content': contentController.text.trim(),
      'read_time': readTimeController.text.trim(),
      'is_featured': isFeatured,
    });

    isEditMode = false;
    isLoading = false;
    notifyListeners();
  }

  Future<void> delete(BuildContext context) async {
    await _repository.deleteArticle(article.id);
  }

  void toggleFeatured(bool value) {
    isFeatured = value;
    notifyListeners();
  }

  Future<void> checkAdmin() async {
    final user = await _auth.getLoggedUser();
    if (user == null) return;

    isAdmin = user.role == 'admin';
    notifyListeners();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    readTimeController.dispose();
    super.dispose();
  }
}
