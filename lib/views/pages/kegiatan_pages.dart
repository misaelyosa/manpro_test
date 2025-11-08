import 'package:bhtapp/data/classes/Events.dart';
import 'package:bhtapp/views/widgets/events_card.dart';
import 'package:bhtapp/views/widgets/segmented_control.dart';
import 'package:flutter/material.dart';

class KegiatanPages extends StatefulWidget {
  const KegiatanPages({super.key});

  @override
  State<KegiatanPages> createState() => _KegiatanPagesState();
}

class _KegiatanPagesState extends State<KegiatanPages> {
  int _selectedIndex = 0; // 0 = Mendatang, 1 = Terdahulu

  // sample data
  final List<Event> _events = [
    Event(
      id: '1',
      category: 'Budaya',
      title: 'Perayaan Imlek 2025',
      date: DateTime(2025, 1, 29),
      timeStr: '19:00 - 22:00',
      location: 'Gedung Utama Rasa Dharma',
      description:
          'Perayaan tahun baru Imlek dengan pertunjukan seni tradisional dan makan bersama.',
      registered: 85,
      capacity: 120,
    ),
    Event(
      id: '2',
      category: 'Sosial',
      title: 'Bakti Sosial Bulanan',
      date: DateTime(2025, 2, 15),
      timeStr: '08:00 - 12:00',
      location: 'Kelurahan Pancoran',
      description: 'Kegiatan bakti sosial untuk membantu warga sekitar.',
      registered: 32,
      capacity: 50,
    ),
    Event(
      id: '3',
      category: 'Budaya',
      title: 'Pertunjukan Barongsai',
      date: DateTime(2024, 11, 10),
      timeStr: '16:00 - 18:00',
      location: 'Lapangan Depan',
      description: 'Pertunjukan barongsai dalam rangka festival lokal.',
      registered: 120,
      capacity: 150,
    ),
  ];

  List<Event> get _upcoming =>
      _events.where((e) => e.date.isAfter(DateTime.now())).toList();

  List<Event> get _past =>
      _events.where((e) => !e.date.isAfter(DateTime.now())).toList();

  @override
  Widget build(BuildContext context) {
    final items = _selectedIndex == 0 ? _upcoming : _past;

    return Scaffold(
      backgroundColor: Colors.yellow[50],
      appBar: AppBar(
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Kegiatan",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.red,
        elevation: 0.5,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              SegmentedControl(
                selectedIndex: _selectedIndex,
                onSelected: (i) => setState(() {
                  _selectedIndex = i;
                }),
              ),
              const SizedBox(height: 12),

              // Expanded agar ListView mengisi sisa layar dan bisa scroll sendiri
              Expanded(
                child: items.isEmpty
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
                        itemCount: items.length,
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                        itemBuilder: (context, index) {
                          final event = items[index];
                          return EventsCard(
                            event: event,
                            onRegister: () => _onRegister(event),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onRegister(Event e) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text("Daftar ke ${e.title}")));
  }
}
