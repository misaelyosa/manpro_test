import 'package:flutter/material.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/kegiatan_provider.dart';
import 'package:rasadharma_app/data/classes/Events.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:csv/csv.dart';
import 'package:rasadharma_app/views/pages/kegiatan_pages.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';

class DetailKegiatan extends StatefulWidget {
  final Kegiatan kegiatan;
  final bool isAdmin;

  const DetailKegiatan({
    super.key,
    required this.kegiatan,
    required this.isAdmin,
  });

  @override
  State<DetailKegiatan> createState() => _DetailKegiatanState();
}

class _DetailKegiatanState extends State<DetailKegiatan> {
  List<RegisteredUser>? registeredUsers;
  bool isLoadingUsers = false;

  @override
  void initState() {
    super.initState();
    registeredUsers = [];
    _initMediaStore();
    _fetchRegisteredUsers();
  }

  Future<void> _initMediaStore() async {
    if (kIsWeb) {
      return; // web tidak support MediaStore
    } else if (Platform.isAndroid) {
      await MediaStore.ensureInitialized();
      MediaStore.appFolder = "Rasadharma";
    }
  }

  Future<void> _fetchRegisteredUsers() async {
    setState(() {
      isLoadingUsers = true;
    });

    final prov = Provider.of<KegiatanProvider>(context, listen: false);
    try {
      final users = await prov.getRegisteredUsers(widget.kegiatan.id);
      setState(() {
        registeredUsers = users;
        isLoadingUsers = false;
      });
    } catch (e) {
      setState(() {
        isLoadingUsers = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat daftar pengguna: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<KegiatanProvider>(context);

    // Check if user is admin
    if (!widget.isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Akses Ditolak'),
          backgroundColor: Colors.white,
          foregroundColor: AppColors.darkRed,
        ),
        body: const Center(
          child: Text(
            'Hanya admin yang dapat mengakses halaman ini',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Kegiatan'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.darkRed,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context, prov),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteDialog(context, prov),
          ),
        ],
      ),
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.kegiatan.kategori.toLowerCase() == 'budaya'
                            ? Colors.red
                            : Colors.orange,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        widget.kegiatan.kategori,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Title
                    Text(
                      widget.kegiatan.namaKegiatan,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red.shade700,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Capacity Info
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          size: 16,
                          color: Colors.redAccent,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${widget.kegiatan.registeredAmount}/${widget.kegiatan.capacity} Terdaftar',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Details Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow(
                      'Tanggal',
                      _formatDate(widget.kegiatan.tanggalKegiatan),
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow(
                      'Waktu',
                      '${widget.kegiatan.waktuMulai} - ${widget.kegiatan.waktuSelesai}',
                    ),
                    const SizedBox(height: 12),
                    _buildDetailRow('Lokasi', widget.kegiatan.lokasi),
                    const SizedBox(height: 16),
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.kegiatan.deskripsi,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Registered Users Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Peserta Terdaftar (${registeredUsers?.length ?? 0})',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: (registeredUsers?.isNotEmpty ?? false)
                              ? _exportToCsv
                              : null,
                          icon: const Icon(Icons.download, size: 16),
                          label: const Text('Export CSV'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.darkRed,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            textStyle: const TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (isLoadingUsers)
                      const Center(child: CircularProgressIndicator())
                    else if (registeredUsers?.isEmpty ?? true)
                      const Center(
                        child: Text(
                          'Belum ada peserta terdaftar',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: registeredUsers!.length,
                        itemBuilder: (context, index) {
                          final user = registeredUsers![index];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 8),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user.nama,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  user.email,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  user.noTelp,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Terdaftar: ${_formatDateTime(user.registeredAt)}',
                                  style: const TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showEditDialog(BuildContext context, KegiatanProvider prov) {
    final namaController = TextEditingController(
      text: widget.kegiatan.namaKegiatan,
    );
    final lokasiController = TextEditingController(
      text: widget.kegiatan.lokasi,
    );
    final deskripsiController = TextEditingController(
      text: widget.kegiatan.deskripsi,
    );
    final capacityController = TextEditingController(
      text: widget.kegiatan.capacity.toString(),
    );
    final waktuMulaiController = TextEditingController(
      text: widget.kegiatan.waktuMulai,
    );
    final waktuSelesaiController = TextEditingController(
      text: widget.kegiatan.waktuSelesai,
    );

    DateTime selectedDate = widget.kegiatan.tanggalKegiatan;
    String selectedKategori = widget.kegiatan.kategori;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Edit Kegiatan'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: namaController,
                      decoration: const InputDecoration(labelText: 'Nama'),
                    ),
                    const SizedBox(height: 8),

                    DropdownButtonFormField<String>(
                      initialValue: selectedKategori,
                      items: const [
                        DropdownMenuItem(
                          value: 'Budaya',
                          child: Text('Budaya'),
                        ),
                        DropdownMenuItem(
                          value: 'Non Budaya',
                          child: Text('Non Budaya'),
                        ),
                      ],
                      onChanged: (v) => setState(() => selectedKategori = v!),
                      decoration: const InputDecoration(labelText: 'Kategori'),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: lokasiController,
                      decoration: const InputDecoration(labelText: 'Lokasi'),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: waktuMulaiController,
                      decoration: const InputDecoration(
                        labelText: 'Waktu Mulai',
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: waktuSelesaiController,
                      decoration: const InputDecoration(
                        labelText: 'Waktu Selesai',
                      ),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: capacityController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(labelText: 'Kapasitas'),
                    ),
                    const SizedBox(height: 8),

                    TextField(
                      controller: deskripsiController,
                      maxLines: 3,
                      decoration: const InputDecoration(labelText: 'Deskripsi'),
                    ),
                    const SizedBox(height: 8),

                    Row(
                      children: [
                        Text('Tanggal: ${_formatDate(selectedDate)}'),
                        const Spacer(),
                        TextButton(
                          onPressed: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(2020),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => selectedDate = picked);
                            }
                          },
                          child: const Text('Pilih'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  child: const Text('Batal'),
                ),
                ElevatedButton(
                  onPressed: () async {
                    await prov.updateKegiatan(
                      eventId: widget.kegiatan.id,
                      namaKegiatan: namaController.text.trim(),
                      kategori: selectedKategori,
                      tanggalKegiatan: selectedDate,
                      waktuMulai: waktuMulaiController.text.trim(),
                      waktuSelesai: waktuSelesaiController.text.trim(),
                      lokasi: lokasiController.text.trim(),
                      deskripsi: deskripsiController.text.trim(),
                      capacity: int.parse(capacityController.text),
                    );

                    if (!mounted) return;
                    Navigator.pop(dialogContext);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const KegiatanPages()),
                    );
                  },
                  child: const Text('Simpan'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showDeleteDialog(BuildContext context, KegiatanProvider prov) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus Kegiatan'),
        content: const Text('Apakah Anda yakin ingin menghapus kegiatan ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context); // tutup dialog dulu

              try {
                await prov.deleteKegiatan(widget.kegiatan.id);

                if (!mounted) return;
              } catch (e) {
                if (!mounted) return;

                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(e.toString())));
              } finally {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const KegiatanPages()),
                );
              }
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  // Inside _DetailKegiatanState class

  Future<void> _exportToCsv() async {
    try {
      // 1. Prepare CSV data
      List<List<dynamic>> csvData = [];

      // --- A. Event Details (Header/Metadata) ---
      csvData.add(['Detail Kegiatan']);
      csvData.add([]); // Blank line
      csvData.add(['Nama Kegiatan', widget.kegiatan.namaKegiatan]);
      csvData.add(['Kategori', widget.kegiatan.kategori]);
      csvData.add(['Tanggal', _formatDate(widget.kegiatan.tanggalKegiatan)]);
      csvData.add([
        'Waktu',
        '${widget.kegiatan.waktuMulai} - ${widget.kegiatan.waktuSelesai}',
      ]);
      csvData.add(['Lokasi', widget.kegiatan.lokasi]);
      csvData.add(['Kapasitas', widget.kegiatan.capacity.toString()]);
      csvData.add([
        'Peserta Terdaftar',
        widget.kegiatan.registeredAmount.toString(),
      ]);
      csvData.add([]); // Blank line
      csvData.add([]); // Blank line

      // --- B. Registered Users (List) ---
      csvData.add(['Daftar Peserta']);
      csvData.add([
        'No',
        'Nama',
        'Email',
        'No. Telepon',
        'Tanggal Pendaftaran',
      ]); // Users Headers

      // Add user data
      if (registeredUsers != null) {
        for (var i = 0; i < registeredUsers!.length; i++) {
          final user = registeredUsers![i];
          csvData.add([
            (i + 1).toString(), // No.
            user.nama,
            user.email,
            user.noTelp,
            _formatDateTime(user.registeredAt),
          ]);
        }
      }

      // 2. Convert to CSV string
      String csv = const ListToCsvConverter().convert(csvData);

      // 3. Save to Download Directory (using assumed MediaStore utility)
      // NOTE: You must provide the definition of MediaStore, DirType, and DirName
      // or replace this with a package like permission_handler + path_provider for cross-platform download saving.

      // Assuming you have the MediaStore class defined elsewhere:
      final mediaStore =
          MediaStore(); // Instantiate your custom MediaStore class

      await mediaStore.saveFile(
        tempFilePath: await _createTempCSV(csv),
        dirType: DirType.download,
        dirName: DirName.download,
      );

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("File CSV berhasil disimpan di folder Download"),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gagal mengekspor CSV: $e')));
    }
  }

  String _formatDateTime(DateTime dateTime) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} ${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  Future<String> _createTempCSV(String csvData) async {
    final dir = await getTemporaryDirectory();
    // Ensure a unique filename based on the event and time
    final fileName =
        'peserta_${widget.kegiatan.namaKegiatan.replaceAll(' ', '_').replaceAll(RegExp(r'[^\w]'), '')}_${DateTime.now().millisecondsSinceEpoch}.csv';
    final path = '${dir.path}/$fileName';
    final file = File(path);
    await file.writeAsString(csvData);
    return path;
  }
}
