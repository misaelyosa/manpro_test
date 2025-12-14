import 'package:flutter/material.dart';
import 'package:rasadharma_app/controller/kegiatan_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/events_card.dart';
import 'package:rasadharma_app/views/widgets/segmented_control.dart';
import 'package:provider/provider.dart';

class KegiatanPages extends StatelessWidget {
  const KegiatanPages({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => KegiatanProvider.withContext(context),
      child: Consumer<KegiatanProvider>(
        builder: (context, prov, _) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              centerTitle: true,
              title: const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Kegiatan",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkRed,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              foregroundColor: AppColors.darkRed,
              elevation: 0.5,
            ),
            body: _body(context, prov),
          );
        },
      ),
    );
  }
}

Widget _body(BuildContext context, KegiatanProvider prov) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          SegmentedControl(
            selectedIndex: prov.selectedIndex,
            onSelected: (i) => prov.onSelected(i),
          ),
          const SizedBox(height: 12),
          if (prov.isAdmin) ...[
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showAddKegiatanModal(context, prov),
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
                      'Tambah Kegiatan',
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

          // Expanded agar ListView mengisi sisa layar dan bisa scroll sendiri
          prov.fetchingKegiatan
              ? CircularProgressIndicator()
              : Expanded(
                  child: prov.items.isEmpty
                      ? Center(
                          child: Text(
                            'Tidak ada kegiatan',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: prov.items.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final event = prov.items[index];
                            prov.checkRegistrationStatus(event.id);
                            return EventsCard(
                              isadmin: prov.isAdmin,
                              event: event,
                              isRegistered: prov.isRegistered(event.id),
                              onRegister: prov.isRegistered(event.id)
                                  ? null
                                  : () => prov.onRegister(event),
                            );
                          },
                        ),
                ),
        ],
      ),
    ),
  );
}

void _showAddKegiatanModal(BuildContext context, KegiatanProvider prov) {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _tanggalController = TextEditingController();
  final _waktuMulaiController = TextEditingController();
  final _waktuSelesaiController = TextEditingController();
  final _lokasiController = TextEditingController();
  final _deskripsiController = TextEditingController();
  final _capacityController = TextEditingController();

  final List<String> kategoriList = ['Budaya', 'Non Budaya'];

  String? selectedKategori;

  DateTime? _selectedDate;

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
                'Tambah Kegiatan Baru',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 16),

              // Nama Kegiatan
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Kegiatan',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Nama kegiatan wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              // Kategori
              DropdownButtonFormField<String>(
                value: selectedKategori,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: kategoriList
                    .map(
                      (kategori) => DropdownMenuItem<String>(
                        value: kategori,
                        child: Text(kategori),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  selectedKategori = value;
                },
                validator: (value) =>
                    value == null ? 'Kategori wajib dipilih' : null,
              ),

              const SizedBox(height: 12),

              // Tanggal
              TextFormField(
                controller: _tanggalController,
                decoration: const InputDecoration(
                  labelText: 'Tanggal Kegiatan',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    _selectedDate = date;
                    _tanggalController.text =
                        '${date.day}/${date.month}/${date.year}';
                  }
                },
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Tanggal wajib dipilih' : null,
              ),
              const SizedBox(height: 12),

              // Waktu Mulai & Selesai
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _waktuMulaiController,
                      decoration: const InputDecoration(
                        labelText: 'Waktu Mulai',
                        border: OutlineInputBorder(),
                        hintText: 'HH:MM',
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Waktu mulai wajib diisi'
                          : null,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      controller: _waktuSelesaiController,
                      decoration: const InputDecoration(
                        labelText: 'Waktu Selesai',
                        border: OutlineInputBorder(),
                        hintText: 'HH:MM',
                      ),
                      validator: (value) => value?.isEmpty ?? true
                          ? 'Waktu selesai wajib diisi'
                          : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Lokasi
              TextFormField(
                controller: _lokasiController,
                decoration: const InputDecoration(
                  labelText: 'Lokasi',
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Lokasi wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              // Deskripsi
              TextFormField(
                controller: _deskripsiController,
                decoration: const InputDecoration(
                  labelText: 'Deskripsi',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) =>
                    value?.isEmpty ?? true ? 'Deskripsi wajib diisi' : null,
              ),
              const SizedBox(height: 12),

              // Capacity
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(
                  labelText: 'Kapasitas',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'Kapasitas wajib diisi';
                  final num = int.tryParse(value!);
                  if (num == null || num <= 0)
                    return 'Kapasitas harus angka positif';
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Buttons
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
                          await prov.createKegiatan(
                            namaKegiatan: _namaController.text,
                            kategori: selectedKategori!,
                            tanggalKegiatan: _selectedDate!,
                            waktuMulai: _waktuMulaiController.text,
                            waktuSelesai: _waktuSelesaiController.text,
                            lokasi: _lokasiController.text,
                            deskripsi: _deskripsiController.text,
                            capacity: int.parse(_capacityController.text),
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
