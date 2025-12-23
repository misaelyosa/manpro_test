import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rasadharma_app/controller/kegiatan_provider.dart';
import 'package:rasadharma_app/theme/colors.dart';
import 'package:rasadharma_app/views/widgets/riwayat_card.dart';

class RiwayatKegiatanPage extends StatelessWidget {
  const RiwayatKegiatanPage({super.key});

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
              title: const Text(
                "Riwayat Kegiatan",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkRed,
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
  final attendedEvents = prov.events.where((event) {
    return prov.isRegistered(event.id) &&
        event.tanggalKegiatan.isBefore(DateTime.now());
  }).toList();

  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: prov.fetchingKegiatan
          ? const Center(child: CircularProgressIndicator())
          : attendedEvents.isEmpty
          ? Center(
              child: Text(
                'Belum ada kegiatan yang diikuti',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              ),
            )
          : ListView.separated(
              itemCount: attendedEvents.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final event = attendedEvents[index];

                return RiwayatCard(
                  isadmin: false,
                  isLoggedIn: prov.loggedIn,
                  event: event,
                  isRegistered: true,
                  onCancel: null,
                  onRegister: null,
                );
              },
            ),
    ),
  );
}
