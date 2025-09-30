import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';

class DonasiPage extends StatelessWidget {
  const DonasiPage({super.key});

  void _showThankYouDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Terima Kasih"),
        content: const Text("Terima kasih atas donasi Anda."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const AppHeader(title: "Donasi"),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      const Text(
                        "Dukung Kegiatan Kami",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.darkRed,
                        ),
                      ),
                      const SizedBox(height: 20),

                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gold, width: 2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Image.asset(
                          "assets/images/qr_placeholder.png",
                          width: 180,
                          height: 180,
                        ),
                      ),

                      const SizedBox(height: 20),
                      const Text(
                        "Pindai QR atau tekan tombol di bawah untuk berdonasi.",
                        textAlign: TextAlign.center,
                      ),

                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () => _showThankYouDialog(context),
                          icon: const Icon(Icons.volunteer_activism),
                          label: const Text("Donasi Sekarang"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
