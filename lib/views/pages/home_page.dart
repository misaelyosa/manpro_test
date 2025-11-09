import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/pages/donasi_page.dart';
import 'package:rasadharma_app/views/pages/kegiatan_pages.dart';
import 'package:rasadharma_app/views/pages/kontak_page.dart';
import 'package:rasadharma_app/views/pages/sejarah_page.dart';
import 'package:rasadharma_app/views/widgets/menu_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> _recentActivities = [
      {
        "title": "Seminar Toleransi",
        "desc": "Diskusi tentang kerukunan antar umat beragama...",
        "date": "15 Jan 2024",
      },
      {
        "title": "Bakti Sosial",
        "desc": "Pembagian sembako kepada masyarakat...",
        "date": "08 Jan 2024",
      },
      {
        "title": "Festival Budaya",
        "desc": "Perayaan Imlek dengan pertunjukan barongsai...",
        "date": "22 Feb 2024",
      },
      {
        "title": "Donor Darah",
        "desc": "Kegiatan donor darah bersama PMI Semarang...",
        "date": "05 Mar 2024",
      },
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkRed,
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: Colors.green),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Rasa Dharma',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
                ),
              ),
              Text(
                'Boen Hian Tong',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu, color: AppColors.darkRed),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: AppColors.darkRed),
              child: Text(
                'Drawer Header',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListTile(title: const Text('Item 1'), onTap: () {}),
            ListTile(title: const Text('Item 2'), onTap: () {}),
            ListTile(
              title: const Text('Exit'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.darkRed,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Menjaga Budaya, Mengabdi untuk Sesama',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            softWrap: true,
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Menghimpun masyarakat Tionghoa untuk melestarikan budaya dan berkontribusi positif kepada komunitas melalui berbagai kegiatan sosial dan budaya.',
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Menu Utama",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),
                const SizedBox(height: 10),
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1,
                  padding: const EdgeInsets.all(8),
                  children: [
                    MenuCard(
                      icon: Icons.menu_book,
                      title: "Sejarah",
                      subtitle: "Pelajari sejarah organisasi kami",
                      onTap: () {
                        // lihat sejarah
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SejarahPage();
                            },
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.calendar_today,
                      title: "Kegiatan",
                      subtitle: "Lihat kegiatan mendatang",
                      onTap: () {
                        // lihat kegiatan
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return KegiatanPages();
                            },
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.favorite,
                      title: "Donasi",
                      subtitle: "Berikan dukungan Anda",
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return DonasiPage();
                            },
                          ),
                        );
                      },
                    ),
                    MenuCard(
                      icon: Icons.people,
                      title: "Kontak",
                      subtitle: "Hubungi pengurus",
                      onTap: () {
                        // lihat kontak
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return KontakPage();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Text(
                      "Kegiatan Terbaru",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkRed,
                      ),
                      softWrap: true,
                      textAlign: TextAlign.start,
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {
                        // lihat semua
                      },
                      child: Text(
                        "Lihat Semua",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkRed,
                        ),
                        softWrap: true,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // Carousel / PageView
                SizedBox(
                  height: 180,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _recentActivities.length,
                    itemBuilder: (context, index) {
                      final Map<String, String> a = _recentActivities[index];
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          // aman akses page: kalau belum ready, gunakan currentPage sebagai fallback
                          double pageValue;
                          if (_pageController.hasClients &&
                              _pageController.page != null) {
                            pageValue = _pageController.page!;
                          } else {
                            pageValue = _currentPage.toDouble();
                          }

                          double diff = (pageValue - index).abs();
                          double scale =
                              (1 - (diff * 0.2)).clamp(0.8, 1.0) as double;

                          return Transform.scale(
                            scale: scale,
                            child: Card(
                              color: AppColors.white,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      a['title'] ?? '',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      a['desc'] ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    const Spacer(),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: Text(
                                        a['date'] ?? '',
                                        style: const TextStyle(
                                          color: AppColors.gray,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                // Carousel Indicators
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_recentActivities.length, (index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 12 : 8,
                      height: _currentPage == index ? 12 : 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? AppColors.primary
                            : AppColors.gray.withOpacity(0.4),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
