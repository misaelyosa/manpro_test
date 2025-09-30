import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';
import '../widgets/quick_access_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(viewportFraction: 0.9);
  int _currentPage = 0;

  final List<Map<String, String>> _recentActivities = [
    {
      "title": "Seminar Toleransi",
      "desc": "Diskusi tentang kerukunan antar umat beragama...",
      "date": "15 Jan 2024"
    },
    {
      "title": "Bakti Sosial",
      "desc": "Pembagian sembako kepada masyarakat...",
      "date": "08 Jan 2024"
    },
    {
      "title": "Festival Budaya",
      "desc": "Perayaan Imlek dengan pertunjukan barongsai...",
      "date": "22 Feb 2024"
    },
    {
      "title": "Donor Darah",
      "desc": "Kegiatan donor darah bersama PMI Semarang...",
      "date": "05 Mar 2024"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: "Rasa Dharma"),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hero Banner
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Menjaga Budaya,\nMengabdi untuk Sesama",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Menghimpun masyarakat Tionghoa untuk melestarikan budaya dan tradisi yang luhur",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.cream,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Menu Utama Title
                  const Text(
                    "Menu Utama",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Quick Access Cards
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      QuickAccessCard(
                        icon: Icons.history,
                        label: "Sejarah",
                        onTap: () => Navigator.pushNamed(context, "/sejarah"),
                      ),
                      QuickAccessCard(
                        icon: Icons.event,
                        label: "Kegiatan",
                        onTap: () => Navigator.pushNamed(context, "/kegiatan"),
                      ),
                      QuickAccessCard(
                        icon: Icons.favorite,
                        label: "Donasi",
                        onTap: () => Navigator.pushNamed(context, "/donasi"),
                      ),
                      QuickAccessCard(
                        icon: Icons.people,
                        label: "Kontak",
                        onTap: () => Navigator.pushNamed(context, "/kontak"),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Kegiatan Terbaru Title
                  const Text(
                    "Kegiatan Terbaru",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Carousel
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (index) {
                        setState(() => _currentPage = index);
                      },
                      itemCount: _recentActivities.length,
                      itemBuilder: (context, index) {
                        final a = _recentActivities[index];
                        return AnimatedBuilder(
                          animation: _pageController,
                          builder: (context, child) {
                            double scale = 1.0;
                            if (_pageController.position.haveDimensions) {
                              scale = (_pageController.page! - index).abs();
                              scale = (1 - (scale * 0.2)).clamp(0.8, 1.0);
                            }
                            return Transform.scale(
                              scale: scale,
                              child: Card(
                                margin: const EdgeInsets.symmetric(horizontal: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        a["title"]!,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        a["desc"]!,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Text(
                                          a["date"]!,
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

                  const SizedBox(height: 10),

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
        ],
      ),
    );
  }
}
