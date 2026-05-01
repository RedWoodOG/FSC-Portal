import 'package:flutter/material.dart';
import '../models/activity_event.dart';

class ActivityProvider extends ChangeNotifier {
  final List<ActivityEvent> _events = [];

  List<ActivityEvent> get events => List.unmodifiable(_events);

  void addEvent(ActivityEvent event) {
    _events.insert(0, event);
    
    // Keep only last 50 events
    if (_events.length > 50) {
      _events.removeLast();
    }
    
    notifyListeners();
  }

  void clear() {
    _events.clear();
    notifyListeners();
  }

  // Helper to add common event types
  void ticketCompleted(String ticketId, String location) {
    addEvent(ActivityEvent(
      description: 'Ticket $ticketId completed at $location',
      timestamp: _formatNow(),
      icon: Icons.check_circle,
    ));
  }

  void ticketAssigned(String ticketId, String location) {
    addEvent(ActivityEvent(
      description: 'New ticket $ticketId assigned: $location',
      timestamp: _formatNow(),
      icon: Icons.assignment,
    ));
  }

  void inventoryUsed(String item, int quantity) {
    addEvent(ActivityEvent(
      description: '$item consumed ($quantity units)',
      timestamp: _formatNow(),
      icon: Icons.inventory,
    ));
  }

  void dispatchMessage(String message) {
    addEvent(ActivityEvent(
      description: 'Dispatch: $message',
      timestamp: _formatNow(),
      icon: Icons.message,
    ));
  }

  String _formatNow() {
    final now = DateTime.now();
    return '${now.hour}:${now.minute.toString().padLeft(2, '0')}';
  }
}
