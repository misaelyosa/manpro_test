import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/timeline_item.dart';

class SejarahPage extends StatefulWidget {
  const SejarahPage({super.key});

  @override
  State<SejarahPage> createState() => _SejarahPageState();
}

class _SejarahPageState extends State<SejarahPage> {
  final sejarahData = [
    {
      "year": "1901",
      "title": "Pendirian",
      "desc":
          "Organisasi Boen Hian Tong didirikan sebagai wadah untuk pelestarian budaya Tionghoa.",
      "color": AppColors.primary,
    },
    {
      "year": "1950",
      "title": "Perkembangan",
      "desc":
          "Organisasi berkembang dengan membuka sekolah dan pusat kebudayaan.",
      "color": AppColors.darkRed,
    },
    {
      "year": "2000",
      "title": "Modernisasi",
      "desc":
          "Mengadaptasi teknologi modern untuk mendukung kegiatan organisasi.",
      "color": AppColors.gold,
    },
    {
      "year": "2020",
      "title": "Era Digital",
      "desc":
          "Peluncuran aplikasi dan platform digital untuk menjangkau generasi muda.",
      "color": AppColors.primary,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkRed,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Sejarah",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                "Sejarah Boen Hian Tong",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.darkRed,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                "Boen Hian Tong berdiri lebih dari seabad lalu dan terus berperan "
                                "dalam melestarikan budaya Tionghoa di Semarang.",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.gray,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
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
