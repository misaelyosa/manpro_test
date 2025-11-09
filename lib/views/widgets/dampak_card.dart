import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';

class DampakCard extends StatefulWidget {
  const DampakCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.width,
  });
  final String title;
  final String subtitle;
  final double? width; // optional width

  @override
  State<DampakCard> createState() => _DampakCardState();
}

class _DampakCardState extends State<DampakCard> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: widget.width, // gunakan width jika diberikan
        padding: const EdgeInsets.all(16),
        // margin di-handle di parent agar spacing antar kartu konsisten
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.darkRed,
                // gunakan warna dari theme
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              widget.subtitle,
              style: TextStyle(fontSize: 14, color: AppColors.gray),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
