import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';

class EventsCard extends StatefulWidget {
  const EventsCard({
    super.key,
    required this.event,
    required this.isRegistered,
    this.onRegister,
  });

  final Kegiatan event;
  final bool isRegistered;
  final VoidCallback? onRegister;

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    final bool isFull = widget.event.registeredAmount >= widget.event.capacity;

    //Check if event already passed (date < today)
    final DateTime now = DateTime.now();
    final DateTime eventDate = DateTime(
      widget.event.tanggalKegiatan.year,
      widget.event.tanggalKegiatan.month,
      widget.event.tanggalKegiatan.day,
    );

    final DateTime today = DateTime(now.year, now.month, now.day);

    final bool isPastEvent = eventDate.isBefore(today);

    final bool isDisabled = isFull || widget.isRegistered || isPastEvent;

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
              _categoryBadge(widget.event.kategori),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      '${widget.event.registeredAmount}/${widget.event.capacity}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// TITLE
          Text(
            widget.event.namaKegiatan,
            style: TextStyle(
              fontSize: 18,
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
              Text(_formatDate(widget.event.tanggalKegiatan)),
            ],
          ),

          const SizedBox(height: 8),

          /// TIME
          Row(
            children: [
              const Icon(Icons.schedule, size: 16, color: Colors.redAccent),
              const SizedBox(width: 8),
              Text('${widget.event.waktuMulai} - ${widget.event.waktuSelesai}'),
            ],
          ),

          const SizedBox(height: 8),

          /// LOCATION
          Row(
            children: [
              const Icon(Icons.location_on, size: 16, color: Colors.redAccent),
              const SizedBox(width: 8),
              Expanded(child: Text(widget.event.lokasi)),
            ],
          ),

          const SizedBox(height: 10),

          /// DESCRIPTION
          Text(
            widget.event.deskripsi,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
          ),

          const SizedBox(height: 12),

          /// REGISTER BUTTON
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isDisabled ? null : widget.onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: isDisabled ? Colors.grey : Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isPastEvent
                        ? 'Kegiatan Selesai'
                        : isFull
                        ? 'Penuh'
                        : widget.isRegistered
                        ? 'Sudah Terdaftar'
                        : 'Daftar Sekarang',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (!isDisabled) const SizedBox(width: 8),
                  if (!isDisabled)
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 18,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// CATEGORY BADGE
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
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

/// DATE FORMATTER
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
