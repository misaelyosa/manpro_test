import 'package:flutter/material.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/app_header.dart';

class DetailDonasiPage extends StatefulWidget {
  const DetailDonasiPage({super.key, required this.money});
  final int money;

  @override
  State<DetailDonasiPage> createState() => _DetailDonasiPageState();
}

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
        ),
      ],
    ),
  );
}

class _DetailDonasiPageState extends State<DetailDonasiPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Detail Donasi",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
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
                        Text(
                          'Rp ${widget.money.toString().replaceAllMapped(RegExp(r'(\d)(?=(\d{3})+(?!\d))'), (m) => '${m[1]}.')}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColors.darkRed,
                          ),
                        ),
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
                            "assets/images/qr_placeholder.jpg",
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
            ),
          ],
        ),
      ),
    );
    ;
  }
}
