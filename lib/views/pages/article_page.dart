import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/pages/add_article_page.dart';
import 'package:rasadharma_app/views/pages/article_detail_page.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Articles",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkRed,
        elevation: 0.5,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddArticlePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFeaturedArticle(context),
            const SizedBox(height: 24),
            _buildSectionTitle("Latest Articles"),
            const SizedBox(height: 16),
            _buildArticleGrid(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturedArticle(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleDetailPage()),
        );
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Text(
                  "FEATURED",
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Understanding Dharma in Modern Life",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Explore how ancient wisdom can guide us through contemporary challenges and help us live more meaningful lives.",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.gray,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 16,
                    color: AppColors.gray,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "5 min read",
                    style: TextStyle(fontSize: 12, color: AppColors.gray),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.gray,
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    "Dec 15, 2024",
                    style: TextStyle(fontSize: 12, color: AppColors.gray),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.darkRed,
      ),
    );
  }

  Widget _buildArticleGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double cardWidth = constraints.maxWidth > 600
            ? (constraints.maxWidth - 16) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: List.generate(6, (index) {
            return SizedBox(
              width: cardWidth,
              child: _buildArticleCard(index, context),
            );
          }),
        );
      },
    );
  }

  Widget _buildArticleCard(int index, context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ArticleDetailPage()),
        );
      },
      child: _buildArticleCardContent(index),
    );
  }

  Widget _buildArticleCardContent(int index) {
    final articles = [
      {
        "title": "The Path of Mindfulness",
        "excerpt":
            "Discover the ancient practice of mindfulness and its relevance in today's fast-paced world.",
        "readTime": "3 min read",
        "date": "Dec 12, 2024",
      },
      {
        "title": "Karma and Daily Actions",
        "excerpt":
            "How our everyday choices shape our spiritual journey and impact our future.",
        "readTime": "4 min read",
        "date": "Dec 10, 2024",
      },
      {
        "title": "Meditation Techniques",
        "excerpt":
            "Simple yet powerful meditation practices for beginners and advanced practitioners.",
        "readTime": "6 min read",
        "date": "Dec 8, 2024",
      },
      {
        "title": "Sacred Texts Wisdom",
        "excerpt":
            "Timeless teachings from ancient scriptures that guide modern spiritual seekers.",
        "readTime": "5 min read",
        "date": "Dec 5, 2024",
      },
      {
        "title": "Inner Peace Journey",
        "excerpt":
            "Steps to cultivate lasting peace and harmony within yourself and your relationships.",
        "readTime": "4 min read",
        "date": "Dec 3, 2024",
      },
      {
        "title": "Spiritual Growth",
        "excerpt":
            "Understanding the stages of spiritual development and how to progress mindfully.",
        "readTime": "7 min read",
        "date": "Dec 1, 2024",
      },
    ];

    final article = articles[index];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              article["title"]!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.darkRed,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Text(
              article["excerpt"]!,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.gray,
                height: 1.3,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  article["readTime"]!,
                  style: const TextStyle(fontSize: 10, color: AppColors.gray),
                ),
                Text(
                  article["date"]!,
                  style: const TextStyle(fontSize: 10, color: AppColors.gray),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
