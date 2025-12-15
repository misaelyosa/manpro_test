import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/sejarah_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/timeline_item.dart';

class SejarahPage extends StatelessWidget {
  const SejarahPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SejarahProvider.withContext(context),
      child: Consumer<SejarahProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkRed,
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Sejarah",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRed,
                  ),
                ),
              ),
            ),
            body: _body(prov, context),
          );
        },
      ),
    );
  }
}

Widget _body(SejarahProvider prov, BuildContext context) {
  return Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Column(
                        children: [
                          Text(
                            "Sejarah Boen Hian Tong",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.darkRed,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "Boen Hian Tong berdiri lebih dari seabad lalu dan terus berperan "
                            "dalam melestarikan budaya Tionghoa di Semarang.",
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.gray,
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  if (prov.isAdmin) ...[
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _showAddSejarahModal(context, prov),
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
                              'Tambah Sejarah',
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

                  SizedBox(height: 20),
                  Column(
                    children: List.generate(prov.sejarahData.length, (i) {
                      final item = prov.sejarahData[i];

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Stack(
                          children: [
                            TimelineItem(
                              year: item.tahun.year.toString(),
                              title: item.judul,
                              description: item.deskripsi,
                              color: AppColors.darkRed,
                              isLast: i == prov.sejarahData.length - 1,
                            ),

                            if (prov.isAdmin)
                              Positioned(
                                top: 8,
                                right: 8,
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () {
                                    _confirmDeleteSejarah(
                                      context,
                                      prov,
                                      item.id,
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  );
}

void _confirmDeleteSejarah(
  BuildContext context,
  SejarahProvider prov,
  String sejarahId,
) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Hapus Sejarah'),
      content: const Text('Apakah kamu yakin ingin menghapus sejarah ini?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            Navigator.pop(context);
            await prov.deleteSejarah(sejarahId);
          },
          child: const Text('Hapus', style: TextStyle(color: Colors.white)),
        ),
      ],
    ),
  );
}

void _showAddSejarahModal(BuildContext context, SejarahProvider prov) {
  final _formKey = GlobalKey<FormState>();

  final _judulController = TextEditingController();
  final _tahunController = TextEditingController();
  final _deskripsiController = TextEditingController();

  DateTime? _selectedYear;

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tambah Sejarah',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),

              /// Judul
              TextFormField(
                controller: _judulController,
                decoration: const InputDecoration(
                  labelText: 'Judul',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Judul wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              /// Tahun (Year picker)
              TextFormField(
                controller: _tahunController,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Tahun',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1800),
                    lastDate: DateTime.now(),
                    initialDatePickerMode: DatePickerMode.year,
                  );

                  if (pickedDate != null) {
                    _selectedYear = pickedDate;
                    _tahunController.text = pickedDate.year.toString();
                  }
                },
                validator: (value) => value == null || value.isEmpty
                    ? 'Tahun wajib dipilih'
                    : null,
              ),
              const SizedBox(height: 12),

              /// Deskripsi
              TextFormField(
                controller: _deskripsiController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty
                    ? 'Deskripsi wajib diisi'
                    : null,
              ),
              const SizedBox(height: 20),

              /// Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Batal',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState?.validate() ?? false) {
                          await prov.createSejarah(
                            judul: _judulController.text.trim(),
                            tahun: _selectedYear!,
                            deskripsi: _deskripsiController.text.trim(),
                          );
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade700,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: const Text(
                        'Tambah',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    ),
  );
}
