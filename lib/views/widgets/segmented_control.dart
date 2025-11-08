import 'package:flutter/material.dart';

class SegmentedControl extends StatefulWidget {
  const SegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
    this.labels = const ['Mendatang', 'Terdahulu'],
  });

  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final List<String> labels;

  @override
  State<SegmentedControl> createState() => _SegmentedControlState();
}

class _SegmentedControlState extends State<SegmentedControl> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Row(
        children: List.generate(widget.labels.length, (i) {
          final isSelected = i == widget.selectedIndex;
          return Expanded(
            child: GestureDetector(
              onTap: () {
                widget.onSelected(i);
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: isSelected ? Colors.red.shade700 : Colors.white,
                ),
                child: Text(
                  widget.labels[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black,
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
