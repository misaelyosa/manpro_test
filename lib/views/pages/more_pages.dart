import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/pages/donasi_page.dart';
import 'package:rasadharma_app/views/pages/kegiatan_pages.dart';
import 'package:rasadharma_app/views/pages/kontak_page.dart';
import 'package:rasadharma_app/views/pages/sejarah_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

final String apiKey = "6BivGVvK7AG4WaUUsHMg";

class MorePages extends StatefulWidget {
  const MorePages({super.key});

  @override
  State<MorePages> createState() => _MorePagesState();
}

class _MorePagesState extends State<MorePages> {
  final String name = "Eric Yoel";
  final String email = "pootisspy931@gmail.com";
  final String phone = "62895399852711";
  final String event = "Baca buku smeakin sehat";
  final List<Map<String, Object>> menuItems = const [
    {"icon": Icons.history, "label": "Sejarah", "page": SejarahPage()},
    {"icon": Icons.event, "label": "Kegiatan", "page": KegiatanPages()},
    {"icon": Icons.favorite, "label": "Donasi", "page": DonasiPage()},
    {"icon": Icons.people, "label": "Kontak", "page": KontakPage()},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      // pastikan body tidak berada di belakang AppBar
      extendBodyBehindAppBar: false,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white, // set eksplisit
        elevation: 0.5,
        toolbarOpacity: 1,
        // foregroundColor biasanya untuk icon/text default. gunakan warna yang sesuai
        foregroundColor: AppColors.darkRed,
        // pastikan status bar juga konsisten
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "More",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
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

                  // bangun daftar menu dengan for-loop (lebih eksplisit)
                  for (final item in menuItems)
                    ListTile(
                      leading: Icon(
                        item["icon"] as IconData,
                        color: AppColors.primary,
                      ),
                      title: Text(item["label"] as String),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        final page = item["page"] as Widget;
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => page),
                        );
                      },
                    ),

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
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: AppColors.primary,
                    ),
                    title: const Text("Pengaturan Aplikasi"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      // TODO: navigasi ke halaman pengaturan jika ada
                    },
                  ),
                  ListTile(
                    leading: const Icon(
                      Icons.settings,
                      color: AppColors.primary,
                    ),
                    title: const Text("Send Whatsapp Messages"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async {
                      await sendWaFonnte(
                        adminPhone: '628999990508', // ganti dengan nomor admin
                        message:
                            "Ada pendaftar baru:\nNama: ${name}\nEmail: ${email}\nNomor Whatsapp: ${phone}\nSaya mendaftar untuk event : ${event}",
                      );
                      // TODO: navigasi ke halaman pengaturan jika ada
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> sendWaFonnte({
  required String adminPhone,
  required String message,
}) async {
  final url = Uri.parse('https://api.fonnte.com/send');
  const token = '6BivGVvK7AG4WaUUsHMg'; // Masukkan token Fonnte Anda

  final response = await http.post(
    url,
    headers: {'Authorization': token},
    body: {'target': adminPhone, 'message': message},
  );

  print("Status: ${response.statusCode}");
  print("Response: ${response.body}");
}
