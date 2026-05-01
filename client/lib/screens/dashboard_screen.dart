import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    
    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dashboard',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Welcome back, Field Technician',
                      style: TextStyle(
                        fontSize: 14,
                        color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Quick Stats Row
            Row(
              children: [
                Expanded(child: _StatCard(label: 'Open Calls', value: '3', isDark: isDark)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard(label: 'Today', value: '2', isDark: isDark)),
                const SizedBox(width: 16),
                Expanded(child: _StatCard(label: 'This Week', value: '12', isDark: isDark)),
              ],
            ),
            const SizedBox(height: 32),

            // Content
            Text(
              'My Service Calls',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 16),
            _ServiceCallCard(
              title: 'Commercial Lane Stuck Canister',
              client: 'First National Bank - Downtown',
              time: 'Today, 10:00 AM',
              isDark: isDark,
            ),
            const SizedBox(height: 12),
            _ServiceCallCard(
              title: 'Drive-Through Audio System Failure',
              client: 'Community Credit Union - Branch #4',
              time: 'Today, 2:30 PM',
              isDark: isDark,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final bool isDark;

  const _StatCard({required this.label, required this.value, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? ThemeProvider.darkSidebar : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ServiceCallCard extends StatelessWidget {
  final String title;
  final String client;
  final String time;
  final bool isDark;

  const _ServiceCallCard({required this.title, required this.client, required this.time, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? ThemeProvider.darkSidebar : Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            client,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            time,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
