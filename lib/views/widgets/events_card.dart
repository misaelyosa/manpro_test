import 'package:flutter/material.dart';
import 'package:rasadharma_app/data/classes/Events.dart';

class EventsCard extends StatefulWidget {
  const EventsCard({super.key, required this.event, this.onRegister});
  final Kegiatan event;
  final VoidCallback? onRegister;

  @override
  State<EventsCard> createState() => _EventsCardState();
}

class _EventsCardState extends State<EventsCard> {
  @override
  Widget build(BuildContext context) {
    final persen = ((widget.event.registeredAmount / widget.event.capacity) * 100)
        .round();
    final isFull = widget.event.registeredAmount >= widget.event.capacity;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      padding: EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _categoryBadge(widget.event.kategori),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 6),
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
          SizedBox(height: 8),
          Text(
            widget.event.namaKegiatan,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.red.shade700,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                _formatDate(widget.event.tanggalKegiatan),
                // style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.schedule, size: 16, color: Colors.redAccent),
              SizedBox(width: 8),
              Text(
                "${widget.event.waktuMulai} - ${widget.event.waktuSelesai}",
                // style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on, size: 16, color: Colors.redAccent),
              SizedBox(width: 8),
              Expanded(child: Text(widget.event.lokasi)),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            widget.event.deskripsi,
            style: const TextStyle(fontSize: 13, color: Colors.black54),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isFull ? null : widget.onRegister,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade700,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isFull ? 'Penuh' : 'Daftar Sekarang',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (!isFull) SizedBox(width: 8),
                  if (!isFull)
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
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
      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  );
}

String _formatDate(DateTime d) {
  final months = [
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
