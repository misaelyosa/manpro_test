import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/app_header.dart';

class PendaftaranPage extends StatefulWidget {
  final String eventTitle;

  const PendaftaranPage({super.key, required this.eventTitle});

  @override
  State<PendaftaranPage> createState() => _PendaftaranPageState();
}

class _PendaftaranPageState extends State<PendaftaranPage> {
  final _formKey = GlobalKey<FormState>();

  String _name = "";
  String _email = "";
  String _phone = "";
  String _membershipStatus = "";
  String _paymentMethod = "";
  String _specialRequests = "";

  bool _isLoading = false;

  final membershipOptions = const [
    {"value": "member", "label": "Anggota Rasa Dharma"},
    {"value": "non-member", "label": "Bukan Anggota"},
    {"value": "family", "label": "Keluarga Anggota"},
  ];

  final paymentOptions = const [
    {"value": "free", "label": "Gratis", "price": "Rp 0"},
    {"value": "donation", "label": "Donasi Sukarela", "price": "Seikhlasnya"},
    {"value": "paid", "label": "Berbayar", "price": "Rp 50.000"},
  ];

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();

    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2));

    setState(() => _isLoading = false);

    if (!mounted) return;
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Pendaftaran Berhasil!"),
        content: const Text("Terima kasih telah mendaftar. Konfirmasi akan dikirim ke email Anda."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop(); // back to kegiatan
            },
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
          AppHeader(
            title: "Pendaftaran Kegiatan",
            showBack: true,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Event Info
                    Card(
                      child: ListTile(
                        leading: const Icon(Icons.event, color: AppColors.primary, size: 32),
                        title: Text(widget.eventTitle,
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: const Text("29 Januari 2025 • 19:00 - 22:00\nGedung Utama Rasa Dharma"),
                        isThreeLine: true,
                      ),
                    ),
                    const SizedBox(height: 20),

                    const Text("Data Pribadi", style: TextStyle(fontWeight: FontWeight.bold)),

                    const SizedBox(height: 10),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Nama Lengkap *"),
                      validator: (v) => v == null || v.isEmpty ? "Harus diisi" : null,
                      onSaved: (v) => _name = v ?? "",
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Email *"),
                      validator: (v) => v == null || !v.contains("@") ? "Email tidak valid" : null,
                      onSaved: (v) => _email = v ?? "",
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Nomor Telepon *"),
                      keyboardType: TextInputType.phone,
                      validator: (v) => v == null || v.length < 10 ? "Nomor tidak valid" : null,
                      onSaved: (v) => _phone = v ?? "",
                    ),

                    const SizedBox(height: 20),
                    const Text("Status Keanggotaan *", style: TextStyle(fontWeight: FontWeight.bold)),
                    Column(
                      children: membershipOptions.map((opt) {
                        return RadioListTile<String>(
                          title: Text(opt["label"]!),
                          value: opt["value"]!,
                          groupValue: _membershipStatus,
                          onChanged: (v) => setState(() => _membershipStatus = v!),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    const Text("Metode Pembayaran", style: TextStyle(fontWeight: FontWeight.bold)),
                    Column(
                      children: paymentOptions.map((opt) {
                        return RadioListTile<String>(
                          title: Text("${opt["label"]} (${opt["price"]})"),
                          value: opt["value"]!,
                          groupValue: _paymentMethod,
                          onChanged: (v) => setState(() => _paymentMethod = v!),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Permintaan Khusus (Opsional)",
                      ),
                      maxLines: 3,
                      onSaved: (v) => _specialRequests = v ?? "",
                    ),

                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : _submit,
                        icon: const Icon(Icons.check_circle, color: AppColors.white),
                        label: _isLoading
                            ? const Text("Mendaftar...")
                            : const Text("Daftar Sekarang"),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Dengan mendaftar, Anda menyetujui syarat dan ketentuan yang berlaku",
                      style: TextStyle(fontSize: 12, color: AppColors.gray),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
