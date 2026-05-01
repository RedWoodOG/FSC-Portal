import 'package:flutter/material.dart';
import '../models/notification_model.dart';

class NotificationProvider extends ChangeNotifier {
  final List<FSCNotification> _items = [];

  List<FSCNotification> get items => List.unmodifiable(_items);
  
  int get unreadCount => _items.where((n) => !n.isRead).length;

  void push(FSCNotification notification) {
    _items.insert(0, notification);
    
    // Keep only last 100 notifications
    if (_items.length > 100) {
      _items.removeLast();
    }
    
    notifyListeners();
  }

  void markAsRead(FSCNotification notification) {
    notification.isRead = true;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var item in _items) {
      item.isRead = true;
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Helper methods for common notification types
  void ticketAssigned(String ticketId, String location) {
    push(FSCNotification(
      title: 'New Ticket Assigned',
      body: '$ticketId: $location',
      timestamp: _formatNow(),
      icon: Icons.assignment_ind,
    ));
  }

  void urgentTicket(String ticketId, String reason) {
    push(FSCNotification(
      title: 'Urgent Ticket',
      body: '$ticketId marked urgent: $reason',
      timestamp: _formatNow(),
      icon: Icons.warning_amber,
    ));
  }

  void inventoryLow(String item, int remaining) {
    push(FSCNotification(
      title: 'Low Inventory Alert',
      body: '$item: Only $remaining remaining',
      timestamp: _formatNow(),
      icon: Icons.inventory_2,
    ));
  }

  void weatherAlert(String message) {
    push(FSCNotification(
      title: 'Weather Advisory',
      body: message,
      timestamp: _formatNow(),
      icon: Icons.cloud,
    ));
  }

  void dispatchMessage(String message) {
    push(FSCNotification(
      title: 'Dispatch Message',
      body: message,
      timestamp: _formatNow(),
      icon: Icons.radio,
    ));
  }

  String _formatNow() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }
}
