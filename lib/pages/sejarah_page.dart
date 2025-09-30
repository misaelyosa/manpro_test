import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';
import '../widgets/timeline_item.dart';

class SejarahPage extends StatelessWidget {
  const SejarahPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sejarahData = [
      {
        "year": "1901",
        "title": "Pendirian",
        "desc": "Organisasi Boen Hian Tong didirikan sebagai wadah untuk pelestarian budaya Tionghoa.",
        "color": AppColors.primary,
      },
      {
        "year": "1950",
        "title": "Perkembangan",
        "desc": "Organisasi berkembang dengan membuka sekolah dan pusat kebudayaan.",
        "color": AppColors.darkRed,
      },
      {
        "year": "2000",
        "title": "Modernisasi",
        "desc": "Mengadaptasi teknologi modern untuk mendukung kegiatan organisasi.",
        "color": AppColors.gold,
      },
      {
        "year": "2020",
        "title": "Era Digital",
        "desc": "Peluncuran aplikasi dan platform digital untuk menjangkau generasi muda.",
        "color": AppColors.primary,
      },
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: "Sejarah", showBack: true),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const Text(
                    "Sejarah Boen Hian Tong",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Sejarah Boen Hian Tong",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkRed,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Boen Hian Tong berdiri lebih dari seabad lalu dan terus berperan "
                        "dalam melestarikan budaya Tionghoa di Semarang.",
                        style: TextStyle(fontSize: 14, color: AppColors.gray),
                      ),
                      const SizedBox(height: 20),

                      Column(
                        children: List.generate(sejarahData.length, (i) {
                          final item = sejarahData[i];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30),
                            child: TimelineItem(
                              year: item["year"] as String,
                              title: item["title"] as String,
                              description: item["desc"] as String,
                              color: item["color"] as Color,
                              isLast: i == sejarahData.length - 1,
                            ),
                          );
                        }),
                      ),
                    ],
                  ),


                  Column(
                    children: List.generate(sejarahData.length, (i) {
                      final item = sejarahData[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TimelineItem(
                          year: item["year"] as String,
                          title: item["title"] as String,
                          description: item["desc"] as String,
                          color: item["color"] as Color,
                          isLast: i == sejarahData.length - 1,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
