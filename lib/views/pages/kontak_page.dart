import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/contact_provider.dart';
import 'package:rasadharma_app/data/classes/contact_person.dart';
import 'package:rasadharma_app/theme/colors.dart';

class KontakPage extends StatelessWidget {
  const KontakPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ContactProvider()..getContacts(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          foregroundColor: AppColors.darkRed,
          centerTitle: true,
          title: const Text(
            "Kontak",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
        ),
        body: Consumer<ContactProvider>(
          builder: (context, prov, _) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoSection(),
                  const SizedBox(height: 30),
                  _contactPersonSection(context, prov),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _infoSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "Informasi Kontak",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.darkRed,
            ),
          ),
          SizedBox(height: 10),
          _InfoTile(
            icon: Icons.phone,
            title: "Telepon",
            subtitle: "+62 812 3456 7890",
          ),
          _InfoTile(
            icon: Icons.email,
            title: "Email",
            subtitle: "info@rasadharma.org",
          ),
          _InfoTile(
            icon: Icons.location_on,
            title: "Alamat",
            subtitle: "Jl. Boen Hian Tong No. 10, Semarang",
          ),
        ],
      ),
    );
  }

  Widget _contactPersonSection(BuildContext context, ContactProvider prov) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Kontak Person",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.darkRed,
          ),
        ),

        if (prov.isAdmin) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showAddContactModal(context, prov),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Tambah Kontak',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.add, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],

        const SizedBox(height: 12),

        Column(
          children: prov.contacts.map((person) {
            return Card(
              color: AppColors.white,
              margin: const EdgeInsets.only(bottom: 12),
              child: ListTile(
                title: Text(
                  person.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRed,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(person.role),
                    const SizedBox(height: 4),
                    Text(person.time, style: const TextStyle(fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(person.info, style: const TextStyle(fontSize: 12)),
                  ],
                ),
                trailing: prov.isAdmin
                    ? IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => prov.deleteContact(person.id),
                      )
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

void _showAddContactModal(BuildContext context, ContactProvider prov) {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _roleController = TextEditingController();
  final _timeController = TextEditingController();
  final _infoController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Tambah Kontak Person',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRed,
                  ),
                ),
                const SizedBox(height: 16),

                /// Nama
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 12),

                /// Jabatan
                TextFormField(
                  controller: _roleController,
                  decoration: const InputDecoration(
                    labelText: 'Jabatan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Jabatan wajib diisi' : null,
                ),
                const SizedBox(height: 12),

                /// Jam Operasional
                TextFormField(
                  controller: _timeController,
                  decoration: const InputDecoration(
                    labelText: 'Jam Operasional',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.isEmpty
                      ? 'Jam operasional wajib diisi'
                      : null,
                ),
                const SizedBox(height: 12),

                /// Info
                TextFormField(
                  controller: _infoController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Keterangan',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Keterangan wajib diisi' : null,
                ),
                const SizedBox(height: 20),

                /// Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Batal'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red.shade700,
                        ),
                        child: const Text(
                          'Tambah',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          prov.addContact(
                            ContactPerson(
                              id: DateTime.now().millisecondsSinceEpoch
                                  .toString(),
                              name: _nameController.text.trim(),
                              role: _roleController.text.trim(),
                              time: _timeController.text.trim(),
                              info: _infoController.text.trim(),
                            ),
                          );

                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _InfoTile({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.white,
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(title),
        subtitle: Text(subtitle),
      ),
    );
  }
}
