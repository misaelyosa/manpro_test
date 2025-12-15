import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';

class AddArticlePage extends StatelessWidget {
  const AddArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            onPressed: () {
              // Save article logic
            },
            child: const Text(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField("Title", "Enter article title", maxLines: 1),
            const SizedBox(height: 16),
            _buildTextField("Excerpt", "Enter article excerpt", maxLines: 3),
            const SizedBox(height: 16),
            _buildTextField("Content", "Write your article content here...", maxLines: 15),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTextField("Read Time", "e.g., 5 min read", maxLines: 1),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTextField("Category", "e.g., Meditation", maxLines: 1),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Checkbox(
                  value: true, // Dummy value
                  onChanged: (value) {
                    // Handle featured toggle
                  },
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
                onPressed: () {
                  // Publish article logic
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
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

  Widget _buildTextField(String label, String hint, {required int maxLines}) {
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
              borderSide: const BorderSide(color: AppColors.primary, width: 2),
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
        ),
      ],
    );
  }
}