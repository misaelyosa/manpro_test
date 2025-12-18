import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/user.dart';
import 'package:rasadharma_app/data/repository/auth_service.dart';
import 'package:rasadharma_app/views/pages/wellcome_page.dart';

class EditProfileProvider extends ChangeNotifier {
  final BuildContext context;
  EditProfileProvider({required this.context}) {
    _emailController = TextEditingController();
    _namaController = TextEditingController();
    _noTelpController = TextEditingController();
  }

  final formKey = GlobalKey<FormState>();

  late TextEditingController _emailController;
  late TextEditingController _namaController;
  late TextEditingController _noTelpController;

  TextEditingController get emailController => _emailController;
  TextEditingController get namaController => _namaController;
  TextEditingController get noTelpController => _noTelpController;

  final AuthService _auth = AuthService();
  UserBHT? _currentUser;
  bool isLoading = true;
  bool isUpdating = false;

  Future<void> loadUserData() async {
    final user = await _auth.getLoggedUser();
    if (user != null) {
      _currentUser = user;
      _emailController.text = user.email;
      _namaController.text = user.nama;
      _noTelpController.text = user.noTelp;
    }
    isLoading = false;
    notifyListeners();
  }

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

  // ===========================
  // ACTION
  // ===========================
  Future<void> onUpdateProfile() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    if (_currentUser == null) return;

    isUpdating = true;
    notifyListeners();

    final newEmail = emailController.text.trim();
    final newNama = namaController.text.trim();
    final newNoTelp = noTelpController.text.trim();

    try {
      // Update Firestore
      Map<String, dynamic> updates = {'nama': newNama, 'no_telp': newNoTelp};
      await _auth.updateUserInCollection(_currentUser!.id, updates);

      // If email changed, update Auth and send verification
      if (newEmail != _currentUser!.email) {
        await _auth.updateEmail(newEmail);
        updates['email'] = newEmail;

        // Update Firestore email too
        await _auth.updateUserInCollection(_currentUser!.id, {
          'email': newEmail,
        });

        // Update SharedPref
        await _auth.logUserSharedpref(_currentUser!.id);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Profile updated. Verification email sent to new email. Please verify and login again.',
            ),
          ),
        );

        // Logout and go to welcome
        await _auth.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => WellcomePage()),
          (route) => false,
        );
      } else {
        // Update SharedPref
        await _auth.logUserSharedpref(_currentUser!.id);

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Profile updated successfully')));

        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan";
      } else if (e.code == 'invalid-email') {
        message = "Format email salah";
      } else if (e.code == 'requires-recent-login') {
        message = "Silakan login ulang untuk mengubah email";
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      isUpdating = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _noTelpController.dispose();
    super.dispose();
  }
}
