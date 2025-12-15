import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/add_article_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';

class AddArticlePage extends StatelessWidget {
  const AddArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AddArticleProvider(),
      child: const _AddArticleView(),
    );
  }
}

class _AddArticleView extends StatelessWidget {
  const _AddArticleView();

  @override
  Widget build(BuildContext context) {
    final prov = context.watch<AddArticleProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Add Article",
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
          TextButton(
            onPressed: prov.isLoading
                ? null
                : () async {
                    await _submit(context);
                  },
            child: prov.isLoading
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text(
                    "Save",
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField(
              "Title",
              "Enter article title",
              controller: prov.titleController,
              maxLines: 1,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              "Content",
              "Write your article content here...",
              controller: prov.contentController,
              maxLines: 15,
            ),
            const SizedBox(height: 16),
            _buildTextField(
              "Read Time",
              "e.g. 5 min read",
              controller: prov.readTimeController,
              maxLines: 1,
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: prov.isFeatured,
                  onChanged: (v) => prov.toggleFeatured(v ?? false),
                  activeColor: AppColors.primary,
                ),
                const Text(
                  "Mark as Featured Article",
                  style: TextStyle(
                    color: AppColors.darkRed,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: prov.isLoading
                    ? null
                    : () async {
                        await _submit(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: prov.isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Publish Article",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    final prov = context.read<AddArticleProvider>();

    try {
      await prov.submit();
      
      // Successfully added article, return true to signal refresh on parent page.
      if (context.mounted) {
        // We use pop with a result of 'true'
        Navigator.pop(context, true); 
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }
  }

  Widget _buildTextField(
    String label,
    String hint, {
    required TextEditingController controller,
    required int maxLines,
  }) {
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
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.gray),
            filled: true,
            fillColor: AppColors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide:
                  const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}