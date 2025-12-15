import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/data/repository/article_repo.dart';

class AddArticleProvider extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final readTimeController = TextEditingController();

  bool isFeatured = false;
  bool isLoading = false;

  void toggleFeatured(bool value) {
    isFeatured = value;
    notifyListeners();
  }

  bool validate() {
    return titleController.text.trim().isNotEmpty &&
        contentController.text.trim().isNotEmpty &&
        readTimeController.text.trim().isNotEmpty;
  }

  Future<void> submit() async {
    if (!validate()) {
      throw Exception("Please fill all required fields");
    }

    isLoading = true;
    notifyListeners();

    try {
      final article = Article(
        id: '',
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        readTime: readTimeController.text.trim(),
        date: DateTime.now(),
        isFeatured: isFeatured,
      );

      await _repository.addArticle(article.toJson());
      clear();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clear() {
    titleController.clear();
    contentController.clear();
    readTimeController.clear();
    isFeatured = false;
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    readTimeController.dispose();
    super.dispose();
  }
}
