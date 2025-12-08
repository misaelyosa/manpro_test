import 'package:flutter/material.dart';
import 'package:rasadharma_app/views/pages/wellcome_page.dart';

/// === Widget Stateless untuk Register Page ===
/// Widget ini TIDAK membuat controllers sendiri.
/// Parent harus menyediakan:
/// - GlobalKey<FormState> formKey
/// - TextEditingController untuk setiap field
/// - ValueNotifier<bool> untuk toggle visibilitas password (opsional)
/// - VoidCallback onRegister untuk eksekusi register
class RegisterPage extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController namaController;
  final TextEditingController noTelpController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  // visibility toggles (biarkan parent mengatur state)
  final ValueNotifier<bool> obscurePassword;
  final ValueNotifier<bool> obscureConfirmPassword;

  // callback saat tombol register ditekan (parent yang tangani)
  final VoidCallback onRegister;

  const RegisterPage({
    Key? key,
    required this.formKey,
    required this.emailController,
    required this.namaController,
    required this.noTelpController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.onRegister,
  }) : super(key: key);

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Email wajib diisi";
    final regex = RegExp(r"^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (!regex.hasMatch(value)) return "Format email tidak valid";
    return null;
  }

  String? _validateNotEmpty(String? value, String fieldName) {
    if (value == null || value.isEmpty) return "$fieldName wajib diisi";
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "Password wajib diisi";
    if (value.length < 6) return "Password minimal 6 karakter";
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty)
      return "Konfirmasi password wajib diisi";
    if (value != passwordController.text) return "Password tidak cocok";
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: _validateEmail,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: namaController,
                  decoration: const InputDecoration(
                    labelText: "Nama",
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (v) => _validateNotEmpty(v, "Nama"),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: noTelpController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    labelText: "No. Telepon",
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (v) => _validateNotEmpty(v, "No. Telepon"),
                ),
                const SizedBox(height: 12),
                // Password dengan ValueListenableBuilder agar stateless bisa rebuild bagian ini
                ValueListenableBuilder<bool>(
                  valueListenable: obscurePassword,
                  builder: (context, obscure, _) {
                    return TextFormField(
                      controller: passwordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        labelText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () =>
                              obscurePassword.value = !obscurePassword.value,
                        ),
                      ),
                      validator: _validatePassword,
                    );
                  },
                ),
                const SizedBox(height: 12),
                ValueListenableBuilder<bool>(
                  valueListenable: obscureConfirmPassword,
                  builder: (context, obscure, _) {
                    return TextFormField(
                      controller: confirmPasswordController,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        labelText: "Konfirmasi Password",
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () => obscureConfirmPassword.value =
                              !obscureConfirmPassword.value,
                        ),
                      ),
                      validator: _validateConfirmPassword,
                    );
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: onRegister,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// === Contoh parent yang meng-hold state (controllers & value notifiers) ===
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _emailController;
  late final TextEditingController _namaController;
  late final TextEditingController _noTelpController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;

  // ValueNotifiers untuk toggle visibility
  late final ValueNotifier<bool> _obscurePassword;
  late final ValueNotifier<bool> _obscureConfirmPassword;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _namaController = TextEditingController();
    _noTelpController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();

    _obscurePassword = ValueNotifier<bool>(true);
    _obscureConfirmPassword = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _namaController.dispose();
    _noTelpController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    _obscurePassword.dispose();
    _obscureConfirmPassword.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (_formKey.currentState?.validate() ?? false) {
      // Ambil data dari controller
      final email = _emailController.text.trim();
      final nama = _namaController.text.trim();
      final noTelp = _noTelpController.text.trim();
      final password = _passwordController.text;

      // TODO: panggil API / logic register di sini
      // Contoh sederhana:
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Mendaftar: $email / $nama / $noTelp')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return WellcomePage();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RegisterPage(
      formKey: _formKey,
      emailController: _emailController,
      namaController: _namaController,
      noTelpController: _noTelpController,
      passwordController: _passwordController,
      confirmPasswordController: _confirmPasswordController,
      obscurePassword: _obscurePassword,
      obscureConfirmPassword: _obscureConfirmPassword,
      onRegister: _handleRegister,
    );
  }
}
