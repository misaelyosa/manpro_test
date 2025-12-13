import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/register_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:lottie/lottie.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(context: context),
      child: Consumer<RegisterProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.darkRed,
              elevation: 0,
              title: Text(
                "Register",
                style: TextStyle(
                  color: AppColors.darkRed,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
            ),
            body: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon at the top
                    Lottie.asset(
                      "assets/anim/register.json",
                      height: 200,
                      width: 200,
                    ),
                    SizedBox(height: 20),
                    // Register Title
                    Text(
                      'Create Your Account',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: AppColors.darkRed,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 40),
                    // Register Card
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      color: AppColors.white,
                      child: Padding(
                        padding: EdgeInsets.all(24.0),
                        child: Form(
                          key: prov.formKey,
                          child: Column(
                            children: [
                              // Email Field
                              TextFormField(
                                controller: prov.emailController,
                                decoration: InputDecoration(
                                  labelText: "Email",
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
                                validator: prov.validateEmail,
                              ),
                              SizedBox(height: 16),
                              // Name Field
                              TextFormField(
                                controller: prov.namaController,
                                decoration: InputDecoration(
                                  labelText: "Nama",
                                  labelStyle: TextStyle(
                                    color: AppColors.darkRed,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.person,
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
                                validator: (v) =>
                                    prov.validateNotEmpty(v, "Nama"),
                              ),
                              SizedBox(height: 16),
                              // Phone Field
                              TextFormField(
                                controller: prov.noTelpController,
                                decoration: InputDecoration(
                                  labelText: "No. Telepon",
                                  labelStyle: TextStyle(
                                    color: AppColors.darkRed,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.phone,
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
                                validator: (v) =>
                                    prov.validateNotEmpty(v, "No. Telepon"),
                              ),
                              SizedBox(height: 16),
                              // Password Field
                              ValueListenableBuilder<bool>(
                                valueListenable: prov.obscurePassword,
                                builder: (_, obscure, __) {
                                  return TextFormField(
                                    controller: prov.passwordController,
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                      labelText: "Password",
                                      labelStyle: TextStyle(
                                        color: AppColors.darkRed,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.primary,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () =>
                                            prov.obscurePassword.value =
                                                !obscure,
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
                                    validator: prov.validatePassword,
                                  );
                                },
                              ),
                              SizedBox(height: 16),
                              // Confirm Password Field
                              ValueListenableBuilder<bool>(
                                valueListenable: prov.obscureConfirmPassword,
                                builder: (_, obscure, __) {
                                  return TextFormField(
                                    controller: prov.confirmPasswordController,
                                    obscureText: obscure,
                                    decoration: InputDecoration(
                                      labelText: "Konfirmasi Password",
                                      labelStyle: TextStyle(
                                        color: AppColors.darkRed,
                                      ),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: AppColors.primary,
                                      ),
                                      suffixIcon: IconButton(
                                        icon: Icon(
                                          obscure
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color: AppColors.primary,
                                        ),
                                        onPressed: () =>
                                            prov.obscureConfirmPassword.value =
                                                !obscure,
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
                                    validator: prov.validateConfirmPassword,
                                  );
                                },
                              ),
                              SizedBox(height: 30),
                              // Register Button
                              ElevatedButton(
                                onPressed: prov.onRegister,
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
                                  "Register",
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
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
