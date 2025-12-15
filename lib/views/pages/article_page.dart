import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/article_provider.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/pages/add_article_page.dart';
import 'package:rasadharma_app/views/pages/article_detail_page.dart';
// NOTE: Removed 'package:intl/intl.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Retain ChangeNotifierProvider for state management
    return ChangeNotifierProvider(
      create: (_) => ArticlePageProvider()..fetchArticles(),
      // We wrap the Consumer in a Builder to get a context that is a descendant
      // of the ChangeNotifierProvider.
      child: Builder(
        builder: (context) {
          // Get a non-listening reference to the provider once here.
          final articleProvider = Provider.of<ArticlePageProvider>(
            context,
            listen: false,
          );

          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                "Articles",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkRed,
              elevation: 0.5,
              actions: [
                Consumer<ArticlePageProvider>(
                  builder: (context, prov, _) {
                    if (!prov.isAdmin) return const SizedBox.shrink();

                    return IconButton(
                      icon: const Icon(Icons.add),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddArticlePage(),
                          ),
                        ).then((value) {
                          if (value == true) {
                            articleProvider.fetchArticles();
                          }
                        });
                      },
                    );
                  },
                ),
              ],
            ),
            // Use Consumer to rebuild when the provider updates
            body: Consumer<ArticlePageProvider>(
              builder: (context, prov, _) {
                if (prov.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (prov.featuredArticle != null)
                        _FeaturedArticle(
                          article: prov.featuredArticle!,
                          provider: articleProvider,
                        ),
                      const SizedBox(height: 24),
                      _buildSectionTitle("Latest Articles"),
                      const SizedBox(height: 16),
                      _ArticleGrid(
                        articles: prov.articles,
                        provider: articleProvider,
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
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
}

// Refactored _FeaturedArticle
class _FeaturedArticle extends StatelessWidget {
  final Article article;
  // Pass the provider reference for refreshing the list
  final ArticlePageProvider provider;

  const _FeaturedArticle({required this.article, required this.provider});

  // Helper method to format the date without external libraries
  String _formatDateWithoutTime(dynamic date) {
    if (date == null) return "N/A";
    String dateString = date.toString();
    int spaceIndex = dateString.indexOf(' ');
    if (spaceIndex != -1) {
      return dateString.substring(0, spaceIndex);
    }
    int tIndex = dateString.indexOf('T');
    if (tIndex != -1) {
      return dateString.substring(0, tIndex);
    }
    if (dateString.length <= 10) return dateString;
    return "N/A";
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDateWithoutTime(article.date);

    return GestureDetector(
      onTap: () {
        // --- KEY CHANGE HERE: Use .then() to call fetchArticles() on return ---
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ArticleDetailPage(article: article),
          ),
        ).then((wasModified) {
          // The ArticleDetailPage returns 'true' on successful edit or delete.
          if (wasModified == true) {
            provider.fetchArticles();
          }
        });
        // ---------------------------------------------------------------------
      },
      child: Container(
        // ... (rest of _FeaturedArticle code)
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
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                article.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                article.content,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
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
                  Text(
                    article.readTime,
                    style: const TextStyle(fontSize: 12, color: AppColors.gray),
                  ),
                  const SizedBox(width: 16),
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: AppColors.gray,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    formattedDate,
                    style: const TextStyle(fontSize: 12, color: AppColors.gray),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Retained _ArticleGrid
class _ArticleGrid extends StatelessWidget {
  final List<Article> articles;
  // Pass the provider reference for refreshing the list
  final ArticlePageProvider provider;

  const _ArticleGrid({required this.articles, required this.provider});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 600;
        final cardWidth = isWide
            ? (constraints.maxWidth - 16) / 2
            : constraints.maxWidth;

        return Wrap(
          spacing: 16,
          runSpacing: 16,
          children: articles.map((article) {
            return SizedBox(
              width: isWide ? cardWidth : constraints.maxWidth,
              child: GestureDetector(
                onTap: () {
                  // --- KEY CHANGE HERE: Use .then() to call fetchArticles() on return ---
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ArticleDetailPage(article: article),
                    ),
                  ).then((wasModified) {
                    // The ArticleDetailPage returns 'true' on successful edit or delete.
                    if (wasModified == true) {
                      provider.fetchArticles();
                    }
                  });
                  // ---------------------------------------------------------------------
                },
                child: _ArticleCard(article: article),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

// MODIFIED _ArticleCard (No logic change needed here, just data presentation)
class _ArticleCard extends StatelessWidget {
  // ... (rest of _ArticleCard remains unchanged)
  final Article article;

  const _ArticleCard({required this.article});

  // Helper method to format the date without external libraries
  String _formatDateWithoutTime(dynamic date) {
    if (date == null) return "N/A";
    String dateString = date.toString();
    int spaceIndex = dateString.indexOf(' ');
    if (spaceIndex != -1) {
      return dateString.substring(0, spaceIndex); // Returns "YYYY-MM-DD"
    }
    int tIndex = dateString.indexOf('T');
    if (tIndex != -1) {
      return dateString.substring(0, tIndex); // Returns "YYYY-MM-DD"
    }
    if (dateString.length <= 10) return dateString;
    return "N/A";
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = _formatDateWithoutTime(article.date);

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
            // Title style updated to match featured article (size 20, bold)
            Text(
              article.title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize:
                    18, // Slightly smaller than featured (20) but larger than original (16)
                fontWeight: FontWeight.bold,
                color: AppColors.darkRed,
              ),
            ),
            const SizedBox(height: 8),
            // Content style updated to match featured article (size 14)
            Text(
              article.content,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.gray,
                height: 1.3,
              ),
            ),
            const SizedBox(
              height: 12,
            ), // Increased spacing before the footer row
            // Footer row updated to match featured article icons and layout
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.start, // Align to start for better grouping
              children: [
                const Icon(Icons.access_time, size: 16, color: AppColors.gray),
                const SizedBox(width: 4),
                Text(
                  article.readTime,
                  style: const TextStyle(fontSize: 12, color: AppColors.gray),
                ),
                const SizedBox(width: 16),
                const Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: AppColors.gray,
                ),
                const SizedBox(width: 4),
                // Date text updated to match featured article size
                Text(
                  formattedDate,
                  style: const TextStyle(fontSize: 12, color: AppColors.gray),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
