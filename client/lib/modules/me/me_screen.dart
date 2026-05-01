import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Me',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Profile, pay, timekeeping, benefits, and documents',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
