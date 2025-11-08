import 'package:bhtapp/data/notifiers.dart';
import 'package:bhtapp/views/pages/donasi_page.dart';
import 'package:bhtapp/views/pages/home_page.dart';
import 'package:bhtapp/views/pages/kegiatan_pages.dart';
import 'package:bhtapp/views/pages/kontak_page.dart';
import 'package:bhtapp/views/pages/more_pages.dart';
import 'package:bhtapp/views/widgets/navbar_widget.dart';
import 'package:flutter/material.dart';

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

    return Scaffold(
      // Update the state of the app.
      body: ValueListenableBuilder(
        valueListenable: selectedPage,
        builder: (context, value, child) {
          return pages.elementAt(value);
        },
      ),
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
