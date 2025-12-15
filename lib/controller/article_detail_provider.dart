import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/data/repository/article_repo.dart';

class ArticleDetailProvider extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();
  final Article article;
  final bool isAdmin;

  bool isEditMode = false;
  bool isLoading = false;

  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController readTimeController;
  bool isFeatured;

  ArticleDetailProvider({
    required this.article,
    required this.isAdmin,
  }) : isFeatured = article.isFeatured {
    titleController = TextEditingController(text: article.title);
    contentController = TextEditingController(text: article.content);
    readTimeController = TextEditingController(text: article.readTime);
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

    await _repository.updateArticle(
      article.id,
      {
        'title': titleController.text.trim(),
        'content': contentController.text.trim(),
        'read_time': readTimeController.text.trim(),
        'is_featured': isFeatured,
      },
    );

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

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    readTimeController.dispose();
    super.dispose();
  }
}
