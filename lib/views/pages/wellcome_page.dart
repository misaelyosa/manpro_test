import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/login_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/pages/register_page.dart';
import 'package:rasadharma_app/views/widget_tree.dart';

class WellcomePage extends StatelessWidget {
  WellcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider.withContext(context),
      child: Consumer<LoginProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            body: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Lottie Animation
                      Lottie.asset(
                        "assets/anim/Welcome.json",
                        height: 350,
                        width: 350,
                      ),
                      SizedBox(height: 20),
                      // Welcome Text
                      Text(
                        'Welcome to Rasa Dharma App',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkRed,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      // Login Card
                      Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: AppColors.white,
                        child: Padding(
                          padding: EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              // Email Field
                              TextField(
                                controller: prov.loginEmailController,
                                decoration: InputDecoration(
                                  hintText: 'Email',
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    color: AppColors.darkRed,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: AppColors.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.lightGray,
                                ),
                              ),
                              SizedBox(height: 20),
                              // Password Field
                              TextField(
                                controller: prov.loginPasswordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                    color: AppColors.darkRed,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: AppColors.primary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide(
                                      color: AppColors.primary,
                                      width: 2,
                                    ),
                                  ),
                                  filled: true,
                                  fillColor: AppColors.lightGray,
                                ),
                              ),
                              SizedBox(height: 30),
                              // Login Button
                              ElevatedButton(
                                onPressed: prov.login,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primary,
                                  foregroundColor: AppColors.white,
                                  minimumSize: Size(double.infinity, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      // Guest Login
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WidgetTree(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text("Log In as Guest"),
                      ),
                      SizedBox(height: 10),
                      // Register
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        child: Text("Register New Account"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
