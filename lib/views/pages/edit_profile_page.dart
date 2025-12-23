import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/edit_profile_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditProfileProvider(context: context)..loadUserData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: const Text("Edit Profile"),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: AppColors.primary,
          elevation: 0.5,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: SafeArea(
          child: Consumer<EditProfileProvider>(
            builder: (context, provider, _) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: provider.formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: provider.namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) => provider.validateNotEmpty(v, 'Nama'),
                      ),
                      const SizedBox(height: 16),

                      /// 🔐 EMAIL FIELD
                      TextFormField(
                        controller: provider.emailController,
                        readOnly: !provider.canEditEmail,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: const OutlineInputBorder(),
                          suffixIcon: !provider.canEditEmail
                              ? IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: AppColors.primary,
                                  ),
                                  onPressed: () async {
                                    final ok = await verifyEmailPassDialog(
                                      context,
                                      provider,
                                      provider.emailController.text,
                                    );
                                    if (ok) provider.enableEmailEdit();
                                  },
                                )
                              : null,
                        ),
                        validator: provider.validateEmail,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: provider.noTelpController,
                        decoration: const InputDecoration(
                          labelText: 'No Telepon',
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) =>
                            provider.validateNotEmpty(v, 'No Telepon'),
                      ),
                      const SizedBox(height: 24),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: provider.isUpdating
                              ? null
                              : provider.onUpdateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: provider.isUpdating
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Update Profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<bool> verifyEmailPassDialog(
    BuildContext context,
    EditProfileProvider provider,
    String email,
  ) async {
    final passController = TextEditingController();
    bool verified = false;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Konfirmasi Password"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                initialValue: email,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email Saat Ini",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: passController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text("Batal"),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await provider.verifyPassword(passController.text);
                  verified = true;
                  Navigator.pop(ctx);
                } catch (_) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Password salah")),
                  );
                }
              },
              child: const Text("Lanjutkan"),
            ),
          ],
        );
      },
    );
    return verified;
  }
}
