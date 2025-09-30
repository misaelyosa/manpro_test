import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';

class KontakPage extends StatefulWidget {
  const KontakPage({super.key});

  @override
  State<KontakPage> createState() => _KontakPageState();
}

class _KontakPageState extends State<KontakPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _message = "";
  bool _isSending = false;

  final List<Map<String, String>> _contactPersons = [
    {
      "name": "Budi Santoso",
      "role": "Ketua Organisasi",
      "time": "Senin - Jumat (09:00 - 17:00)",
      "info": "Hubungi untuk kerjasama resmi dan surat menyurat."
    },
    {
      "name": "Lina Wijaya",
      "role": "Koordinator Acara",
      "time": "Selasa - Sabtu (10:00 - 18:00)",
      "info": "Hubungi terkait kegiatan, acara, dan pendaftaran peserta."
    },
    {
      "name": "Hendra Gunawan",
      "role": "Bendahara",
      "time": "Senin - Kamis (08:00 - 16:00)",
      "info": "Hubungi mengenai donasi, laporan keuangan, dan sponsor."
    },
  ];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isSending = true);
    await Future.delayed(const Duration(seconds: 2));
    setState(() => _isSending = false);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pesan Terkirim"),
        content:
            const Text("Terima kasih atas pesan Anda. Kami akan segera membalas."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("OK"),
          ),
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
          const AppHeader(title: "Kontak", showBack: true),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Section: Informasi Kontak
                  const Text(
                    "Informasi Kontak",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: AppColors.primary),
                      title: const Text("Telepon"),
                      subtitle: const Text("+62 812 3456 7890"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.email, color: AppColors.primary),
                      title: const Text("Email"),
                      subtitle: const Text("info@rasadharma.org"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: AppColors.primary),
                      title: const Text("Alamat"),
                      subtitle: const Text("Jl. Boen Hian Tong No. 10, Semarang"),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Section: Daftar Kontak Person
                  const Text(
                    "Kontak Person",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Column(
                    children: _contactPersons.map((person) {
                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                person["name"]!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(person["role"]!,
                                  style: const TextStyle(color: AppColors.gray)),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  const Icon(Icons.access_time,
                                      size: 16, color: AppColors.primary),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(
                                      person["time"]!,
                                      style: const TextStyle(fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                person["info"]!,
                                style: const TextStyle(fontSize: 13, height: 1.3),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 30),

                  // Section: Form Pesan
                  const Text(
                    "Kirim Pesan",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.darkRed,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Nama *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (v) =>
                                v == null || v.isEmpty ? "Harus diisi" : null,
                            onSaved: (v) => _name = v ?? "",
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Email *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            validator: (v) => v == null || !v.contains("@")
                                ? "Email tidak valid"
                                : null,
                            onSaved: (v) => _email = v ?? "",
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: "Pesan *",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            maxLines: 4,
                            validator: (v) =>
                                v == null || v.isEmpty ? "Harus diisi" : null,
                            onSaved: (v) => _message = v ?? "",
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: _isSending ? null : _submit,
                            icon: const Icon(Icons.send),
                            label:
                                Text(_isSending ? "Mengirim..." : "Kirim"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
