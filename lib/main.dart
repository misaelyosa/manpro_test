import 'package:bhtapp/views/pages/wellcome_page.dart';
import 'package:flutter/material.dart';

/// The application entry point.
///
/// This function is called when the application is launched.
/// It runs the application by calling [runApp] with an instance of [MainApp].
void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.amber[100],
      ),
      home: SafeArea(child: Scaffold(body: WellcomePage())),
    );
  }
}
