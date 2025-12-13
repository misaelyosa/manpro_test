import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/kegiatan_provider.dart';
import 'package:rasadharma_app/data/notifiers.dart';
import 'package:rasadharma_app/views/pages/donasi_page.dart';
import 'package:rasadharma_app/views/pages/home_page.dart';
import 'package:rasadharma_app/views/pages/kegiatan_pages.dart';
import 'package:rasadharma_app/views/pages/kontak_page.dart';
import 'package:rasadharma_app/views/pages/more_pages.dart';
import 'package:rasadharma_app/views/widgets/navbar_widget.dart';

List<Widget> pages = [
  HomePage(),
  KegiatanPages(),
  DonasiPage(),
  KontakPage(),
  MorePages(),
];

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    var currIndex = 0;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => KegiatanProvider.withContext(context),
        ),
      ],
      child: Scaffold(
        // Update the state of the app.
        body: ValueListenableBuilder(
          valueListenable: selectedPage,
          builder: (context, value, child) {
            return pages.elementAt(value);
          },
        ),
        bottomNavigationBar: NavbarWidget(),
      ),
    );
  }
}
