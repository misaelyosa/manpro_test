import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';

class UntukApa extends StatefulWidget {
  const UntukApa({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
  final String title;
  final String subtitle;
  final IconData icon;

  @override
  State<UntukApa> createState() => _UntukApaState();
}

class _UntukApaState extends State<UntukApa> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),

      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.cream,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(widget.icon, color: AppColors.primary, size: 30),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRed,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  widget.subtitle,
                  style: TextStyle(fontSize: 14, color: AppColors.gray),
                  // softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
