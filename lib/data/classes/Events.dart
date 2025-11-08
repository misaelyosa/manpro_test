// import 'package:flutter/material.dart';

// Simple event model
class Event {
  final String id;
  final String category; // e.g. 'Budaya', 'Sosial'
  final String title;
  final DateTime date;
  final String timeStr;
  final String location;
  final String description;
  final int registered;
  final int capacity;

  Event({
    required this.id,
    required this.category,
    required this.title,
    required this.date,
    required this.timeStr,
    required this.location,
    required this.description,
    required this.registered,
    required this.capacity,
  });
}
