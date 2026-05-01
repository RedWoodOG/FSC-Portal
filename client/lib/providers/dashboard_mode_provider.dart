import 'package:flutter/material.dart';

enum DashboardMode { quiet, hybrid, surge }

class ModeTransition {
  final DashboardMode from;
  final DashboardMode to;
  final DateTime timestamp;
  final int ticketCount;
  final String? reason;

  ModeTransition({
    required this.from,
    required this.to,
    required this.timestamp,
    required this.ticketCount,
    this.reason,
  });

  String get narrative {
    // Generate contextual narrative based on transition
    if (from == to) return '';

    switch (to) {
      case DashboardMode.quiet:
        if (from == DashboardMode.hybrid) {
          return 'All caught up. No active tickets. This is a good time to review tools or inventory.';
        } else if (from == DashboardMode.surge) {
          return 'Surge complete. Workload cleared. Consider preventative maintenance opportunities.';
        }
        return 'Quiet mode. System ready for new assignments.';

      case DashboardMode.hybrid:
        if (from == DashboardMode.quiet) {
          return 'New work assigned. Today\'s route updated.';
        } else if (from == DashboardMode.surge) {
          return 'Workload stabilizing. $ticketCount tickets remaining.';
        }
        return 'Active mode. Managing current workload.';

      case DashboardMode.surge:
        return 'High volume conditions detected. Prioritize critical calls first.';
    }
  }

  String _resolvedTicketsMessage() {
    // Calculate approximate resolved tickets based on transition
    if (from == DashboardMode.hybrid && to == DashboardMode.quiet) {
      return '${3 - ticketCount} tickets resolved.';
    } else if (from == DashboardMode.surge && to == DashboardMode.quiet) {
      return '${10 - ticketCount} tickets resolved.';
    } else if (from == DashboardMode.surge && to == DashboardMode.hybrid) {
      return '$ticketCount tickets';
    }
    return 'tickets resolved.';
  }

  IconData get icon {
    switch (to) {
      case DashboardMode.quiet:
        return Icons.check_circle;
      case DashboardMode.hybrid:
        return Icons.trending_up;
      case DashboardMode.surge:
        return Icons.warning_amber;
    }
  }

  Color get color {
    switch (to) {
      case DashboardMode.quiet:
        return const Color(0xFF10B981); // Green
      case DashboardMode.hybrid:
        return const Color(0xFF8B5CF6); // Purple
      case DashboardMode.surge:
        return const Color(0xFFEF4444); // Red
    }
  }
}

class DashboardModeProvider extends ChangeNotifier {
  DashboardMode _currentMode = DashboardMode.quiet;
  int _ticketCount = 0;
  ModeTransition? _lastTransition;
  final List<ModeTransition> _transitionHistory = [];

  // Getters
  DashboardMode get currentMode => _currentMode;
  int get ticketCount => _ticketCount;
  ModeTransition? get lastTransition => _lastTransition;
  List<ModeTransition> get transitionHistory => List.unmodifiable(_transitionHistory);

  // Check if we should show transition message
  bool get hasRecentTransition {
    if (_lastTransition == null) return false;
    final diff = DateTime.now().difference(_lastTransition!.timestamp);
    return diff.inSeconds < 3; // Show for 3 seconds
  }

  String? get transitionNarrative {
    if (!hasRecentTransition || _lastTransition == null) return null;
    return _lastTransition!.narrative;
  }

  // Update ticket count and potentially trigger mode change
  void updateTicketCount(int newCount, {String? reason}) {
    if (_ticketCount == newCount) return;

    final oldMode = _currentMode;
    _ticketCount = newCount;
    _currentMode = _calculateMode(newCount);

    // Record transition if mode changed
    if (oldMode != _currentMode) {
      _recordTransition(oldMode, _currentMode, newCount, reason);
    }

    notifyListeners();
  }

  // Calculate mode based on ticket count
  DashboardMode _calculateMode(int count) {
    if (count < 3) return DashboardMode.quiet;
    if (count < 10) return DashboardMode.hybrid;
    return DashboardMode.surge;
  }

  // Record a mode transition
  void _recordTransition(
    DashboardMode from,
    DashboardMode to,
    int ticketCount,
    String? reason,
  ) {
    final transition = ModeTransition(
      from: from,
      to: to,
      timestamp: DateTime.now(),
      ticketCount: ticketCount,
      reason: reason,
    );

    _lastTransition = transition;
    _transitionHistory.add(transition);

    // Keep only last 20 transitions
    if (_transitionHistory.length > 20) {
      _transitionHistory.removeAt(0);
    }
  }

  // Manually clear the transition message
  void clearTransitionMessage() {
    _lastTransition = null;
    notifyListeners();
  }

  // Get mode statistics
  Map<String, dynamic> getModeStats() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    final todayTransitions = _transitionHistory
        .where((t) => t.timestamp.isAfter(today))
        .toList();

    int surgeCount = 0;
    Duration totalSurgeTime = Duration.zero;
    DateTime? lastSurgeStart;

    for (int i = 0; i < todayTransitions.length; i++) {
      final transition = todayTransitions[i];
      if (transition.to == DashboardMode.surge) {
        surgeCount++;
        lastSurgeStart = transition.timestamp;
      } else if (lastSurgeStart != null) {
        totalSurgeTime += transition.timestamp.difference(lastSurgeStart);
        lastSurgeStart = null;
      }
    }

    // If still in surge, add current duration
    if (_currentMode == DashboardMode.surge && lastSurgeStart != null) {
      totalSurgeTime += now.difference(lastSurgeStart);
    }

    return {
      'surgeEventsToday': surgeCount,
      'totalSurgeTime': totalSurgeTime,
      'transitionsToday': todayTransitions.length,
      'currentStreak': _getCurrentStreak(),
    };
  }

  String _getCurrentStreak() {
    if (_transitionHistory.isEmpty) return 'No activity';

    final now = DateTime.now();
    final firstTransition = _transitionHistory.first;
    final duration = now.difference(firstTransition.timestamp);

    if (_currentMode == DashboardMode.quiet) {
      return 'Quiet for ${_formatDuration(duration)}';
    } else if (_currentMode == DashboardMode.surge) {
      return 'Surge for ${_formatDuration(duration)}';
    } else {
      return 'Active for ${_formatDuration(duration)}';
    }
  }

  String _formatDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours}h ${duration.inMinutes % 60}m';
    } else if (duration.inMinutes > 0) {
      return '${duration.inMinutes}m';
    } else {
      return '${duration.inSeconds}s';
    }
  }

  // Get contextual suggestions based on mode and history
  List<String> getContextualSuggestions() {
    final suggestions = <String>[];

    switch (_currentMode) {
      case DashboardMode.quiet:
        suggestions.add('Review inventory levels for next surge');
        suggestions.add('Complete pending training modules');
        if (_transitionHistory.any((t) => t.to == DashboardMode.surge)) {
          suggestions.add('Schedule preventative maintenance calls');
        }
        break;

      case DashboardMode.hybrid:
        suggestions.add('Confirm parts availability for scheduled calls');
        suggestions.add('Review route for optimal efficiency');
        break;

      case DashboardMode.surge:
        suggestions.add('Enable Route Optimizer for fastest path');
        suggestions.add('Check dispatch for team coordination');
        if (_ticketCount > 15) {
          suggestions.add('Consider requesting backup support');
        }
        break;
    }

    return suggestions;
  }
}
