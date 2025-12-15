import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String content;
  final String readTime;
  final DateTime date;
  final bool isFeatured;

  Article({
    required this.id,
    required this.title,
    required this.content,
    required this.readTime,
    required this.date,
    required this.isFeatured,
  });

  factory Article.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Article(
      id: doc.id,
      title: data['title'],
      content: data['content'],
      readTime: data['read_time'],
      date: (data['date'] as Timestamp).toDate(),
      isFeatured: data['is_featured'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'read_time': readTime,
      'date': Timestamp.fromDate(date),
      'is_featured': isFeatured,
    };
  }
}
