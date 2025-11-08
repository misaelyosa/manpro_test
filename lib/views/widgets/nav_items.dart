import 'package:flutter/material.dart';

class NavItems extends StatefulWidget {
  const NavItems({
    super.key,
    required this.index,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });
  final int index;
  final IconData icon;
  final String label;
  final bool isSelected;
  final ValueChanged<int> onTap;

  @override
  State<NavItems> createState() => _NavItemsState();
}

class _NavItemsState extends State<NavItems> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    Color activeColorBg = Colors.red;
    Color inactiveColorBg = Colors.white;
    Color inactiveColor = Colors.grey;
    Color activeColor = Colors.white;
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          isPressed = true;
        });
      },
      onTapUp: (details) {
        setState(() {
          isPressed = false;
        });
        widget.onTap(widget.index);
      },
      onTapCancel: () {
        setState(() {
          isPressed = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        // padding: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // color: isPressed ? activeColorBg : inactiveColorBg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              widget.icon,
              color: widget.isSelected ? activeColorBg : inactiveColor,
            ),
            SizedBox(height: 4),
            Text(
              widget.label,
              style: TextStyle(
                color: widget.isSelected ? activeColorBg : inactiveColor,
                fontWeight: widget.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
