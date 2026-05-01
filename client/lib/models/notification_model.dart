import 'package:flutter/material.dart';

class FSCNotification {
  final String title;
  final String body;
  final String timestamp;
  final IconData icon;
  bool isRead;

  FSCNotification({
    required this.title,
    required this.body,
    required this.timestamp,
    required this.icon,
    this.isRead = false,
  });
}
