import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/views/pages/wellcome_page.dart';

class RegisterProvider extends ChangeNotifier {
  final BuildContext context;
  RegisterProvider({required this.context}) {
    _emailController = TextEditingController();
    _namaController = TextEditingController();
    _noTelpController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    obscurePassword = ValueNotifier(true);
    obscureConfirmPassword = ValueNotifier(true);
  }

  final formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _namaController;
  late TextEditingController _noTelpController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  late ValueNotifier<bool> obscurePassword;
  late ValueNotifier<bool> obscureConfirmPassword;

  TextEditingController get emailController => _emailController;
  TextEditingController get namaController => _namaController;
  TextEditingController get noTelpController => _noTelpController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

    
  final AuthService _auth = AuthService();
  // ===========================
  // VALIDATIONS
  // ===========================
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email wajib diisi";
    final regex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!regex.hasMatch(value)) return "Format email tidak valid";
    return null;
  }

  String? validateNotEmpty(String? value, String field) {
    if (value == null || value.isEmpty) return "$field wajib diisi";
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password wajib diisi";
    if (value.length < 6) return "Password minimal 6 karakter";
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Konfirmasi password wajib diisi";
    }
    if (value != passwordController.text) {
      return "Password tidak cocok";
    }
    return null;
  }

  // ===========================
  // ACTION
  // ===========================
  bool isRegistering = false;
  Future<void> onRegister() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    isRegistering = true;
    notifyListeners();

    final firestore = FirebaseFirestore.instance;

    final email = emailController.text.trim();
    final nama = namaController.text.trim();
    final noTelp = noTelpController.text.trim();
    final password = passwordController.text;

    try {
      // 1. Register to Firebase Authentication
      User? user = await _auth.registerWithEmail(email, password);

      final uid = user?.uid;

      // 2. Save profile data to Firestore
      _auth.addUserToCollection(uid!, email, nama, noTelp, "user");

      // 3. Navigate to Welcome Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => WellcomePage()),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan";
      } else if (e.code == 'invalid-email') {
        message = "Format email salah";
      } else if (e.code == 'weak-password') {
        message = "Password terlalu lemah";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      isRegistering = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _noTelpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    obscurePassword.dispose();
    obscureConfirmPassword.dispose();

    super.dispose();
  }
}
