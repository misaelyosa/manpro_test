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
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 0.5,
          foregroundColor: AppColors.darkRed,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          title: const Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              "Edit Profile",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.darkRed,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Consumer<EditProfileProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return Padding(
                padding: const EdgeInsets.all(16.0),
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
                        validator: (value) =>
                            provider.validateNotEmpty(value, 'Nama'),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        readOnly: true,
                        controller: provider.emailController,
                        textAlignVertical: TextAlignVertical.center,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            onPressed: () {
                              verifyEmailPassDialog(
                                context,
                                provider.emailController.text,
                              );
                            },
                            icon: Icon(Icons.edit, color: AppColors.primary),
                          ),
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
                        validator: (value) =>
                            provider.validateNotEmpty(value, 'No Telepon'),
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
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          child: provider.isUpdating
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Update Profile',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
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
}

Future<void> verifyEmailPassDialog(BuildContext context, String email) async {
  final passController = TextEditingController();
  // final emailController = TextEditingController();

  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (ctx) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: const Text(
          "Konfirmasi Perubahan Email",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
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
            style: TextButton.styleFrom(),
            onPressed: () => Navigator.pop(ctx),
            child: const Text("Batal", style: TextStyle(color: AppColors.gray)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text(
              "Lanjutkan",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ],
      );
    },
  );
}
