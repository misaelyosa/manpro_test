import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/views/widget_tree.dart';

class LoginProvider extends ChangeNotifier {
  BuildContext? _context;
  LoginProvider.withContext(BuildContext context) {
    _context = context;
    checkAlreadyLoggedIn();
  }

  final AuthService _auth = AuthService();
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  Future<void> checkAlreadyLoggedIn() async {
    final user = await _auth.getLoggedUser();

    if (user != null && _context != null) {
      Navigator.pushReplacement(
        _context!,
        MaterialPageRoute(builder: (_) => WidgetTree()),
      );
    }
  }

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

      final message = e?.toString() ?? 'Login failed';
      ScaffoldMessenger.of(
        _context!,
      ).showSnackBar(SnackBar(content: Text("login gagal: $message")));
    }
  }

  Future<void> forgotPassword() async {
    final email = loginEmailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text('Please enter your email first')),
      );
      return;
    }

    try {
      await _auth.sendPasswordReset(email);
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text('Password reset email sent. Check your inbox spam folder.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text(e?.toString() ?? 'Failed to send reset email')),
      );
    }
  }

  /// Send password reset using provided email (used by modal)
  Future<void> forgotPasswordWithEmail(String email) async {
    final trimmed = email.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text('Please enter your email')),
      );
      return;
    }

    try {
      await _auth.sendPasswordReset(trimmed);
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text('Password reset email sent. Check your inbox spam folder.')),
      );
    } catch (e) {
      ScaffoldMessenger.of(_context!).showSnackBar(
        SnackBar(content: Text(e?.toString() ?? 'Failed to send reset email')),
      );
    }
  }
}
