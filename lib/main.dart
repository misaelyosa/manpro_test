import 'package:flutter/material.dart';
import 'theme/colors.dart';
import 'pages/home_page.dart';
import 'pages/kegiatan_page.dart';
import 'pages/donasi_page.dart';
import 'pages/kontak_page.dart';
import 'pages/more_page.dart';
import 'widgets/bottom_nav.dart';

void main() {
  runApp(const RasaDharmaApp());
}

class RasaDharmaApp extends StatelessWidget {
  const RasaDharmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rasa Dharma',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'ModernSans',
        scaffoldBackgroundColor: AppColors.background,
        primaryColor: AppColors.primary,
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  final _pages = const [
    HomePage(),
    KegiatanPage(),
    DonasiPage(),
    KontakPage(),
    MorePage(),
  ];

  void _onTap(int i) => setState(() => _index = i);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _pages[_index]),
      bottomNavigationBar: BottomNav(currentIndex: _index, onTap: _onTap),
    );
  }
}
