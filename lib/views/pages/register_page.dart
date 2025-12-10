import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/register_provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterProvider(context: context),
      child: Consumer<RegisterProvider>(
        builder: (context, prov, _) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(title: const Text("Register")),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: prov.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: prov.emailController,
                        decoration: const InputDecoration(
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email),
                        ),
                        validator: prov.validateEmail,
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: prov.namaController,
                        decoration: const InputDecoration(
                          labelText: "Nama",
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (v) => prov.validateNotEmpty(v, "Nama"),
                      ),
                      const SizedBox(height: 12),

                      TextFormField(
                        controller: prov.noTelpController,
                        decoration: const InputDecoration(
                          labelText: "No. Telepon",
                          prefixIcon: Icon(Icons.phone),
                        ),
                        validator: (v) =>
                            prov.validateNotEmpty(v, "No. Telepon"),
                      ),
                      const SizedBox(height: 12),

                      ValueListenableBuilder<bool>(
                        valueListenable: prov.obscurePassword,
                        builder: (_, obscure, __) {
                          return TextFormField(
                            controller: prov.passwordController,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () =>
                                    prov.obscurePassword.value = !obscure,
                              ),
                            ),
                            validator: prov.validatePassword,
                          );
                        },
                      ),

                      const SizedBox(height: 12),

                      ValueListenableBuilder<bool>(
                        valueListenable: prov.obscureConfirmPassword,
                        builder: (_, obscure, __) {
                          return TextFormField(
                            controller: prov.confirmPasswordController,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              labelText: "Konfirmasi Password",
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  obscure
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () =>
                                    prov.obscureConfirmPassword.value =
                                        !obscure,
                              ),
                            ),
                            validator: prov.validateConfirmPassword,
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        onPressed: prov.onRegister,
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
        },
      ),
    );
  }
}
