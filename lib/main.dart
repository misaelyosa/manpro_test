import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/kegiatan_provider.dart';
import 'package:rasadharma_app/firebase_options.dart';
import 'package:rasadharma_app/views/pages/wellcome_page.dart';

/// The application entry point.
///
/// This function is called when the application is launched.
/// It runs the application by calling [runApp] with an instance of [MainApp].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => KegiatanProvider.withContext(context),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.amber[100],
        ),
        home: SafeArea(child: Scaffold(body: WellcomePage())),
      ),
    );
  }
}
