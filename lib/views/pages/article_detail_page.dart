import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/article_detail_provider.dart';
import 'package:rasadharma_app/data/classes/article.dart';
import 'package:rasadharma_app/theme/colors.dart';

class ArticleDetailPage extends StatelessWidget {
  final Article article;
  final bool isAdmin;

  const ArticleDetailPage({
    super.key,
    required this.article,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleDetailProvider(
        article: article,
        isAdmin: isAdmin,
      ),
      child: const _ArticleDetailView(),
    );
  }
}

class _ArticleDetailView extends StatelessWidget {
  const _ArticleDetailView();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleDetailProvider>();

    return PopScope(
      // Ensure that if the user pops while editing, it toggles read mode first
      canPop: !provider.isAdmin || !provider.isEditMode,
      onPopInvoked: (didPop) {
        if (!didPop && provider.isAdmin && provider.isEditMode) {
          provider.toggleEditMode();
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Article Detail",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.darkRed,
          elevation: 0.5,
          actions: provider.isAdmin
              ? [
                  IconButton(
                    icon: Icon(
                      provider.isEditMode ? Icons.save : Icons.edit,
                    ),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            if (provider.isEditMode) {
                              try {
                                await provider.save();
                                
                                if (context.mounted) {
                                  // --- EDIT SUCCESS: SHOW SNACKBAR AND POP ---
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Article updated"),
                                    ),
                                  );
                                  // POP back to the ArticlePage to refresh the list
                                  Navigator.pop(context, true); 
                                }
                              } catch (e) {
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(e.toString()),
                                    ),
                                  );
                                }
                              }
                            } else {
                              provider.toggleEditMode();
                            }
                          },
                  ),
                  PopupMenuButton<String>(
                    onSelected: (value) async {
                      if (value == 'delete') {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text("Delete Article"),
                            content: const Text(
                              "Are you sure you want to delete this article?",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text("Cancel"),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text(
                                  "Delete",
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                        );

                        if (confirm == true && context.mounted) {
                          // Note: Assuming provider.delete(context) handles the actual deletion
                          await provider.delete(context);
                          
                          // --- DELETE SUCCESS: POP ---
                          // POP back to the ArticlePage to refresh the list
                          if (context.mounted) {
                             Navigator.pop(context, true); 
                          }
                        }
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'delete',
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text("Delete Article"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ]
              : null,
        ),
        body: provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: provider.isEditMode
                    ? _EditMode()
                    : _ReadMode(),
              ),
      ),
    );
  }
}

/* ---------------- READ MODE ---------------- */

class _ReadMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleDetailProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider.titleController.text,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.darkRed,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.access_time, size: 16, color: AppColors.gray),
            const SizedBox(width: 4),
            Text(
              provider.readTimeController.text,
              style: const TextStyle(fontSize: 14, color: AppColors.gray),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.calendar_today, size: 16, color: AppColors.gray),
            const SizedBox(width: 4),
            Text(
              provider.article.date.toString().split(' ').first,
              style: const TextStyle(fontSize: 14, color: AppColors.gray),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          provider.contentController.text,
          style: const TextStyle(
            fontSize: 16,
            height: 1.6,
            color: AppColors.gray,
          ),
        ),
      ],
    );
  }
}

/* ---------------- EDIT MODE ---------------- */

class _EditMode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ArticleDetailProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _EditField(
          label: "Title",
          controller: provider.titleController,
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        _EditField(
          label: "Read Time",
          controller: provider.readTimeController,
          maxLines: 1,
        ),
        const SizedBox(height: 16),
        _EditField(
          label: "Content",
          controller: provider.contentController,
          maxLines: 15,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Checkbox(
              value: provider.isFeatured,
              onChanged: (value) {
                if (value != null) {
                  provider.toggleFeatured(value);
                }
              },
              activeColor: AppColors.primary,
            ),
            const Text(
              "Featured Article",
              style: TextStyle(
                color: AppColors.darkRed,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/* ---------------- SHARED FIELD ---------------- */

class _EditField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final int maxLines;

  const _EditField({
    required this.label,
    required this.controller,
    required this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.darkRed,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}