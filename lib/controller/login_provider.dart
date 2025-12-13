import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/views/widget_tree.dart';

class LoginProvider extends ChangeNotifier {
  BuildContext? _context;
  LoginProvider.withContext(BuildContext context) {
    _context = context;
  }

  final AuthService _auth = AuthService();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> login() async {
    try {
      final user = await _auth.loginWithEmail(
        loginEmailController.text.trim(),
        loginPasswordController.text.trim(),
      );

      if (user == null) {
        throw Exception("Login returned null user");
      }

      // Save user to SharedPreferences
      await _auth.logUserSharedpref(user.uid);

      // Navigate after success
      Navigator.pushReplacement(
        _context!,
        MaterialPageRoute(builder: (context) => WidgetTree()),
      );
    } catch (e) {
      log("Login failed: $e");

      ScaffoldMessenger.of(
        _context!,
      ).showSnackBar(SnackBar(content: Text('Login failed')));
    }
  }
}
