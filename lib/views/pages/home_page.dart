import 'package:flutter/material.dart';
import 'package:rasadharma_app/views/widgets/menu_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> events = [
      {
        'title': 'Seminar Toleransi',
        'date': '15 Januari 2024',
        'description': 'Diskusi tentang kerukunan antar umat beragama...',
        'color': Colors.blue[100],
      },
      {
        'title': 'Bakti Sosial',
        'date': '8 Januari 2024',
        'description': 'Pembagian sembako masyarakat kurang mampu...',
        'color': Colors.green[100],
      },
      {
        'title': 'Workshop Kewirausahaan',
        'date': '22 Januari 2024',
        'description': 'Pelatihan bisnis untuk pemula...',
        'color': Colors.orange[100],
      },
      {
        'title': 'Festival Budaya',
        'date': '29 Januari 2024',
        'description': 'Pentas seni dan budaya daerah...',
        'color': Colors.purple[100],
      },
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(backgroundColor: Colors.green),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Rasa Dharma',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFFF0000),
                ),
              ),
              Text(
                'Boen Hian Tong',
                style: TextStyle(fontSize: 14, color: Colors.blueGrey),
              ),
            ],
          ),
        ),
        actions: [
          Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(Icons.menu, color: Colors.red),
                onPressed: () {
                  Scaffold.of(context).openEndDrawer();
                },
              );
            },
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Item 1'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(title: const Text('Item 2'), onTap: () {}),
            ListTile(
              title: const Text('Exit'),
              onTap: () {
                Navigator.pop(context);
                // Update the state of the app.
                // ...
              },
            ),
          ],
        ),
      ),
      backgroundColor: Colors.yellow[50],
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 2.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Menjaga Budaya, Mengabdi untuk Sesama',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                          softWrap: true,
                        ),

                        SizedBox(height: 8),
                        Text(
                          'Menghimpun masyarakat Tionghoa untuk melestarikan budaya dan berkontribusi positif kepada komunitas melalui berbagai kegiatan sosial dan budaya.',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.center,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  "Menu Utama",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                  softWrap: true,
                  textAlign: TextAlign.start,
                ),
              ),
              SizedBox(height: 10),

              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1,
                padding: EdgeInsets.all(8),
                children: [
                  MenuCard(
                    icon: Icons.menu_book,
                    title: "Sejarah",
                    subtitle: "Pelajari sejarah organisasi kami",
                    onTap: () {},
                  ),
                  MenuCard(
                    icon: Icons.calendar_today,
                    title: "Kegiatan",
                    subtitle: "Lihat kegiatan mendatang",
                    onTap: () {},
                  ),
                  MenuCard(
                    icon: Icons.favorite,
                    title: "Donasi",
                    subtitle: "Berikan dukungan Anda",
                    onTap: () {},
                  ),
                  MenuCard(
                    icon: Icons.people,
                    title: "Kontak",
                    subtitle: "Hubungi pengurus",
                    onTap: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,

                children: [
                  Text(
                    "Kegiatan Terbaru",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                  Spacer(),
                  IconButton(icon: Icon(Icons.refresh), onPressed: () {}),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: events.map((event) {
                        int index = events.indexOf(event);
                        return Container(
                          width: 180,
                          margin: EdgeInsets.only(
                            right: 16,
                            left: index == 0 ? 8 : 0,
                          ),
                          decoration: BoxDecoration(
                            color: event['color'],
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(2, 2),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  event['title'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red[900],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  event['date'],
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: Text(
                                    event['description'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
