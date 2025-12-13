import 'package:flutter/material.dart';
import 'package:rasadharma_app/views/pages/detail_donasi_page.dart';
import 'package:rasadharma_app/views/widgets/dampak_card.dart';
import 'package:rasadharma_app/views/widgets/untuk_apa.dart';

import '../../theme/colors.dart';

class DonasiPage extends StatefulWidget {
  const DonasiPage({super.key});

  @override
  State<DonasiPage> createState() => _DonasiPageState();
}

class _DonasiPageState extends State<DonasiPage> {
  final List<int> nominalDonasi = [50000, 100000, 250000, 500000];
  int selectedNominal = 500000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        toolbarOpacity: 1,
        // foregroundColor: AppColors.white,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Portal Donasi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.yellow[50],
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 50,
                          ),
                        ),
                        Text(
                          'Berikan Dukungan Anda',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red[900],
                          ),
                          softWrap: true,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Donasi anda akan membantu kegiatan sosial, budaya, dan kemanusiaan yang kami lakukan ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Dampak Donasi Anda",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkRed,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    alignment: WrapAlignment.center,
                    children: const [
                      DampakCard(
                        title: "1200+",
                        subtitle: "Keluarga Terbantu",
                        width: 140,
                      ),
                      DampakCard(
                        title: "50+",
                        subtitle: "Kegiatan per tahun",
                        width: 140,
                      ),
                      DampakCard(
                        title: "15",
                        subtitle: "Tahun Pengabdian",
                        width: 140,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Untuk Apa Donasi Anda?",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkRed,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 10),
                UntukApa(
                  icon: Icons.shopping_bag_rounded,
                  title: "Bantuan Sosial",
                  subtitle:
                      "Sembako, bantuan kesehatan, dan pendidikan untuk masyarakat kurang mampu",
                ),
                SizedBox(height: 10),
                UntukApa(
                  icon: Icons.menu_book_rounded,
                  title: "Pelestarian Budaya",
                  subtitle:
                      "Kegiatan budaaya, festival, dan pendidikan tradisi untuk generasi muda",
                ),
                SizedBox(height: 10),
                UntukApa(
                  icon: Icons.satellite_alt_rounded,
                  title: "Operasional",
                  subtitle:
                      "Pemeliharaan Gedung, utilitas, dan kegiatan rutin organisasi",
                ),

                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pilih Jumlah Donasi",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: AppColors.darkRed,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 20),
                LayoutBuilder(
                  builder: (context, constraints) {
                    final double totalWidth = constraints.maxWidth;
                    const double spacing = 12;
                    final double itemWidth = (totalWidth - spacing) / 2;

                    return Wrap(
                      spacing: spacing,
                      runSpacing: 12,
                      children: [
                        for (final nominal in nominalDonasi)
                          GestureDetector(
                            onTap: () =>
                                setState(() => selectedNominal = nominal),
                            child: Container(
                              width: itemWidth, // width tetap supaya 2 kolom
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                color: nominal == selectedNominal
                                    ? Colors.red[50]
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: nominal == selectedNominal
                                      ? Colors.red
                                      : Colors.grey.shade300,
                                  width: 1.2,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment:
                                    MainAxisAlignment.center, // tinggi ikut isi
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Rp ${nominal.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: nominal == selectedNominal
                                          ? Colors.red[700]
                                          : Colors.black,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Aksi tombol donasi sekarang
                      print('Donasi Rp $selectedNominal sekarang');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailDonasiPage(money: selectedNominal);
                          },
                        ),
                      );
                      // Tambahkan navigasi atau logika pembayaran di sini
                    },
                    icon: Icon(Icons.favorite, color: Colors.white, size: 24),
                    label: Text(
                      'Donasi Sekarang',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
