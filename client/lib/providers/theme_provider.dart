import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  
  bool get isDarkMode => _isDarkMode;

  ThemeProvider() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    notifyListeners();
  }

  // Light theme colors
  static const lightBackground = Color(0xFFFAFBFD);
  static const lightSidebar = Colors.white;
  static const lightText = Color(0xFF0A0A0F);
  static const lightTextSecondary = Color(0xFF5E6266);
  static const lightBorder = Color(0xFFE5E7EB);
  
  // Dark theme colors
  static const darkBackground = Color(0xFF0A0A0F);
  static const darkSidebar = Color(0xFF1A1A1F);
  static const darkText = Color(0xFFFAFBFD);
  static const darkTextSecondary = Color(0xFFB0B3B8);
  static const darkBorder = Color(0xFF2A2A2F);

  // Shared colors
  static const fscBlue = Color(0xFF0740A8);
  static const fscGray = Color(0xFF5E6266);
  static const green = Color(0xFF10B981);
  static const red = Color(0xFFEF4444);
}
