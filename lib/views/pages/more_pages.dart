import 'package:flutter/material.dart';

class MorePages extends StatefulWidget {
  const MorePages({super.key});

  @override
  State<MorePages> createState() => _MorePagesState();
}

class _MorePagesState extends State<MorePages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Portal More",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
      ),
      body: SafeArea(child: Center(child: Text("INI MORE"))),
    );
  }
}
