import 'package:bhtapp/data/notifiers.dart';
// import 'package:bhtapp/views/widget_tree.dart';
import 'package:bhtapp/views/widgets/nav_items.dart';
import 'package:flutter/material.dart';

class NavbarWidget extends StatefulWidget {
  const NavbarWidget({super.key});

  @override
  State<NavbarWidget> createState() => _NavbarWidgetState();
}

class _NavbarWidgetState extends State<NavbarWidget> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPage,
      builder: (context, value, child) {
        return SafeArea(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                NavItems(
                  index: 0,
                  icon: Icons.home,
                  label: "Home",
                  isSelected: value == 0,
                  onTap: (i) {
                    selectedPage.value = 0;
                  },
                ),
                NavItems(
                  index: 1,
                  icon: Icons.calendar_today,
                  label: "Kegiatan",
                  isSelected: value == 1,
                  onTap: (i) {
                    selectedPage.value = 1;
                  },
                ),
                NavItems(
                  index: 2,
                  icon: Icons.favorite_border,
                  label: "Donasi",
                  isSelected: value == 2,
                  onTap: (i) {
                    selectedPage.value = 2;
                  },
                ),
                NavItems(
                  index: 3,
                  icon: Icons.people,
                  label: "Kontak",
                  isSelected: value == 3,
                  onTap: (i) {
                    selectedPage.value = 3;
                  },
                ),
                NavItems(
                  index: 4,
                  icon: Icons.more_horiz,
                  label: "More",
                  isSelected: value == 4,
                  onTap: (i) {
                    selectedPage.value = 4;
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
