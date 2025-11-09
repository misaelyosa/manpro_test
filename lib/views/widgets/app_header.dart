import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';

class AppHeader extends StatelessWidget {
  final String title;
  final bool showBack;
  final VoidCallback? onBack;

  const AppHeader({
    super.key,
    required this.title,
    this.showBack = false,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          showBack
              ? IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.primary),
                  onPressed: onBack ?? () => Navigator.of(context).pop(),
                )
              : const SizedBox(width: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(width: 40), // placeholder
        ],
      ),
    );
  }
}
