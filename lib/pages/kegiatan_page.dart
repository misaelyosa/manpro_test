import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';
import 'pendaftaran_page.dart';

class KegiatanPage extends StatelessWidget {
  const KegiatanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final upcomingEvents = [
      {
        "title": "Lomba Barongsai",
        "date": "01 Okt 2025",
        "time": "10:00",
        "place": "Gedung Rasa Dharma"
      },
      {
        "title": "Pelatihan Musik Tradisi",
        "date": "05 Nov 2025",
        "time": "14:00",
        "place": "Auditorium"
      },
    ];

    final pastArticles = [
      {
        "title": "Seminar Toleransi",
        "date": "15 Jan 2024",
        "snippet": "Diskusi tentang kerukunan antar umat beragama..."
      },
      {
        "title": "Bakti Sosial",
        "date": "08 Jan 2024",
        "snippet": "Pembagian sembako kepada masyarakat..."
      },
    ];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppHeader(title: "Kegiatan"),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Daftar Kegiatan",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
                ),
              ),
            ),
            Container(
              color: AppColors.white,
              child: const TabBar(
                indicatorColor: AppColors.primary,
                labelColor: AppColors.primary,
                unselectedLabelColor: AppColors.gray,
                tabs: [
                  Tab(text: "Mendatang"),
                  Tab(text: "Artikel"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  // Mendatang
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: upcomingEvents.length,
                    itemBuilder: (context, i) {
                      final e = upcomingEvents[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e["title"]!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                              const SizedBox(height: 6),
                              Text("${e["date"]} • ${e["time"]}"),
                              Text(e["place"]!,
                                  style: const TextStyle(
                                    color: AppColors.gray,
                                    fontSize: 13,
                                  )),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => PendaftaranPage(
                                          eventTitle: e["title"]!,
                                        ),
                                      ),
                                    );
                                  },
                                  child: const Text("Daftar"),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),

                  // Artikel
                  ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: pastArticles.length,
                    itemBuilder: (context, i) {
                      final a = pastArticles[i];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: ListTile(
                          leading: const Icon(Icons.article,
                              color: AppColors.primary),
                          title: Text(a["title"]!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold)),
                          subtitle: Text(a["snippet"]!),
                          trailing: Text(
                            a["date"]!,
                            style: const TextStyle(
                                fontSize: 12, color: AppColors.gray),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
