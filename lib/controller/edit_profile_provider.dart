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

  /// 🔐 EMAIL LOCK
  bool canEditEmail = false;

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
  // VALIDATION
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
  // EMAIL RE-AUTH
  // ===========================
  Future<void> verifyPassword(String password) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null || user.email == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User tidak ditemukan',
      );
    }

    final credential = EmailAuthProvider.credential(
      email: user.email!,
      password: password,
    );

    await user.reauthenticateWithCredential(credential);
  }

  void enableEmailEdit() {
    canEditEmail = true;
    notifyListeners();
  }

  // ===========================
  // UPDATE PROFILE
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
      await _auth.updateUserInCollection(_currentUser!.id, {
        'nama': newNama,
        'no_telp': newNoTelp,
      });

      if (newEmail != _currentUser!.email) {
        await _auth.updateEmail(newEmail);

        await _auth.updateUserInCollection(_currentUser!.id, {
          'email': newEmail,
        });

        await _auth.logUserSharedpref(_currentUser!.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Email berhasil diubah. Silakan verifikasi email baru dan login ulang.',
            ),
          ),
        );

        await _auth.logout();
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => WellcomePage()),
          (_) => false,
        );
      } else {
        await _auth.logUserSharedpref(_currentUser!.id);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile berhasil diperbarui')),
        );

        Navigator.pop(context);
      }

      canEditEmail = false;
    } on FirebaseAuthException catch (e) {
      String message = "Terjadi kesalahan";

      if (e.code == 'email-already-in-use') {
        message = "Email sudah digunakan";
      } else if (e.code == 'requires-recent-login') {
        message = "Silakan login ulang untuk mengubah email";
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
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
