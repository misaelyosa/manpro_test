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
            body: _body(prov),
          );
        },
      ),
    );
  }
}

Widget _body(SejarahProvider prov) {
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

                  Column(
                    children: List.generate(prov.sejarahData.length, (i) {
                      final item = prov.sejarahData[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: TimelineItem(
                          year: item.tahun.year.toString(),
                          title: item.judul,
                          description: item.deskripsi,
                          color: AppColors.darkRed,
                          isLast: i == prov.sejarahData.length - 1,
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
