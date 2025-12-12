import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/login_provider.dart';
import 'package:rasadharma_app/views/pages/register_page.dart';
import 'package:rasadharma_app/views/pages/register_page.dart';
import 'package:rasadharma_app/views/widget_tree.dart';

class WellcomePage extends StatelessWidget {
  const WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider.withContext(context),
      child: Consumer<LoginProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset("assets/anim/ai_elaborating.json", height: 300),
                  SizedBox(height: 20),
                  Text('Welcome to Rasa Dharma App'),
                  SizedBox(height: 20),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Email',
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: prov.login,
                    child: Text('Login', style: TextStyle(fontSize: 20)),
                  ),

                  SizedBox(height: 10),
                  Text("or"),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WidgetTree()),
                      );
                    },
                    child: Text("Log In as Guest"),
                  ),

                  SizedBox(height: 10),
                  Text("or"),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text("Register New Account"),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
