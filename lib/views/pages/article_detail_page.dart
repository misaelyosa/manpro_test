import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';

class ArticleDetailPage extends StatefulWidget {
  const ArticleDetailPage({super.key});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  // Dummy admin status and edit mode
  final bool isAdmin = true;
  bool isEditMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        actions: isAdmin
            ? [
                IconButton(
                  icon: Icon(isEditMode ? Icons.save : Icons.edit),
                  onPressed: () {
                    setState(() {
                      isEditMode = !isEditMode;
                    });
                  },
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'delete') {
                      // Show delete confirmation
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: AppColors.primary),
                          SizedBox(width: 8),
                          Text('Delete Article'),
                        ],
                      ),
                    ),
                  ],
                ),
              ]
            : null,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: isEditMode ? _buildEditMode() : _buildReadMode(),
      ),
    );
  }

  Widget _buildReadMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Understanding Dharma in Modern Life",
          style: TextStyle(
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
            const Text(
              "5 min read",
              style: TextStyle(fontSize: 14, color: AppColors.gray),
            ),
            const SizedBox(width: 16),
            const Icon(Icons.calendar_today, size: 16, color: AppColors.gray),
            const SizedBox(width: 4),
            const Text(
              "December 15, 2024",
              style: TextStyle(fontSize: 14, color: AppColors.gray),
            ),
          ],
        ),
        const SizedBox(height: 24),
        const Text(
          "In our fast-paced modern world, the ancient concept of dharma remains as relevant as ever. Dharma, often translated as 'righteous duty' or 'moral law,' provides a framework for living that transcends cultural and temporal boundaries.\n\nThe essence of dharma lies not in rigid rules, but in understanding our interconnectedness with all beings and acting from a place of wisdom and compassion. When we align our actions with dharmic principles, we create harmony not only within ourselves but also in our relationships and communities.\n\nOne of the key aspects of dharma is the recognition that our individual purpose is intimately connected to the greater good. This doesn't mean sacrificing our personal aspirations, but rather finding ways to pursue our goals while contributing positively to the world around us.\n\nPracticing dharma in daily life can be as simple as speaking truthfully, treating others with kindness, and making decisions that consider their impact on future generations. It's about cultivating awareness of our thoughts, words, and actions, and choosing those that promote peace, justice, and well-being.\n\nAs we navigate the complexities of modern existence, dharma serves as a compass, guiding us toward choices that honor both our individual growth and our collective responsibility. By embracing these timeless principles, we can find meaning and purpose in our contemporary lives while contributing to a more harmonious world.",
          style: TextStyle(fontSize: 16, color: AppColors.gray, height: 1.6),
        ),
      ],
    );
  }

  Widget _buildEditMode() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildEditField(
          "Title",
          "Understanding Dharma in Modern Life",
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildEditField("Read Time", "5 min read", maxLines: 1),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildEditField("Date", "December 15, 2024", maxLines: 1),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildEditField(
          "Content",
          "In our fast-paced modern world, the ancient concept of dharma remains as relevant as ever. Dharma, often translated as 'righteous duty' or 'moral law,' provides a framework for living that transcends cultural and temporal boundaries.\n\nThe essence of dharma lies not in rigid rules, but in understanding our interconnectedness with all beings and acting from a place of wisdom and compassion.",
          maxLines: 15,
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Checkbox(
              value: true,
              onChanged: (value) {
                // Handle featured toggle
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

  Widget _buildEditField(
    String label,
    String initialValue, {
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
          maxLines: maxLines,
          controller: TextEditingController(text: initialValue),
          decoration: InputDecoration(
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
