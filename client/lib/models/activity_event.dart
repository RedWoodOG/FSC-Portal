import 'package:flutter/material.dart';

class ActivityEvent {
  final String description;
  final String timestamp;
  final IconData icon;

  ActivityEvent({
    required this.description,
    required this.timestamp,
    required this.icon,
  });
}
