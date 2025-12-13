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
            body: _body(prov),
          );
        },
      ),
    );
  }
}

Widget _body(KegiatanProvider prov) {
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
                onPressed: () {
                  // TODO: navigate to create event page
                  // Navigator.push(...)
                },
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
