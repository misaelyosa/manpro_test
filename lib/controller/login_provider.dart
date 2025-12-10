import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';

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
  
    } catch (e) {
      print("Error: $e");
    }
  }
}
