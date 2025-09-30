import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';
import 'sejarah_page.dart';
import 'kegiatan_page.dart';
import 'donasi_page.dart';
import 'kontak_page.dart';

class MorePage extends StatelessWidget {
  const MorePage({super.key});

  @override
  Widget build(BuildContext context) {
    final menuItems = [
      {"icon": Icons.history, "label": "Sejarah", "page": const SejarahPage()},
      {"icon": Icons.event, "label": "Kegiatan", "page": const KegiatanPage()},
      {"icon": Icons.favorite, "label": "Donasi", "page": const DonasiPage()},
      {"icon": Icons.people, "label": "Kontak", "page": const KontakPage()},
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: "More"),
          Expanded(
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Menu Tambahan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                ),
                ...menuItems.map((item) => ListTile(
                      leading:
                          Icon(item["icon"] as IconData, color: AppColors.primary),
                      title: Text(item["label"] as String),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => item["page"] as Widget),
                        );
                      },
                    )),
                const Divider(),
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Pengaturan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                ),
                const ListTile(
                  leading: Icon(Icons.settings, color: AppColors.primary),
                  title: Text("Pengaturan Aplikasi"),
                  trailing: Icon(Icons.chevron_right),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
