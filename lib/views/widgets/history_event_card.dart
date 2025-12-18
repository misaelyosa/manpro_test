import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';

class HistoryEventCard extends StatelessWidget {
  const HistoryEventCard({
    super.key,
    required this.event,
    required this.status,
  });

  final status;
  final Kegiatan event;

  @override
  Widget build(BuildContext context) {
    final Color statusColor = _statusColor(status);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              _categoryBadge(event.kategori),
              const Spacer(),
              _statusBadge(status, statusColor),
            ],
          ),

          const SizedBox(height: 10),

          /// TITLE
          Text(
            event.namaKegiatan,
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),

          const SizedBox(height: 8),

          /// DATE
          Row(
            children: [
              const Icon(
                Icons.calendar_today,
                size: 16,
                color: Colors.redAccent,
              ),
              const SizedBox(width: 8),
              Text(_formatDate(event.tanggalKegiatan)),
            ],
          ),

          const SizedBox(height: 6),

          /// TIME
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: Colors.redAccent),
              const SizedBox(width: 8),
              Text('${event.waktuMulai} - ${event.waktuSelesai}'),
            ],
          ),

          const SizedBox(height: 6),

          /// LOCATION
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
              const SizedBox(width: 8),
              Expanded(child: Text(event.lokasi)),
            ],
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            event.deskripsi,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}

Widget _statusBadge(String status, Color color) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      status,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );
}

Widget _categoryBadge(String cat) {
  final color = cat.toLowerCase() == 'budaya' ? Colors.red : Colors.orange;

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      cat,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
    ),
  );
}

String _formatDate(DateTime d) {
  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'Mei',
    'Jun',
    'Jul',
    'Agu',
    'Sep',
    'Okt',
    'Nov',
    'Des',
  ];
  return '${d.day} ${months[d.month - 1]} ${d.year}';
}

Color _statusColor(String status) {
  switch (status.toLowerCase()) {
    case 'selesai':
      return Colors.green;
    case 'dibatalkan':
      return Colors.grey;
    case 'terdaftar':
      return Colors.blue;
    default:
      return Colors.orange;
  }
}
