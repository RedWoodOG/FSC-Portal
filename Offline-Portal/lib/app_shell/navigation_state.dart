import 'package:flutter/material.dart';

/// Navigation State - Manages main navigation index
/// Allows child widgets to request navigation changes
class NavigationState extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void navigateTo(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      notifyListeners();
    }
  }

  void navigateToHome() => navigateTo(0);
  void navigateToWork() => navigateTo(1);
  void navigateToOperations() => navigateTo(2);
  void navigateToLocations() => navigateTo(3);
  void navigateToPeople() => navigateTo(4);
  void navigateToKnowledge() => navigateTo(5);
  void navigateToSettings() => navigateTo(6);
}
