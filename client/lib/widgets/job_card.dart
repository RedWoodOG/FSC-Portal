import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import 'priority_tag.dart';
import 'status_pill.dart';

class JobCard extends StatelessWidget {
  final String jobId;
  final String clientName;
  final String location;
  final String priority;
  final String status;
  final String scheduledTime;

  const JobCard({
    super.key,
    required this.jobId,
    required this.clientName,
    required this.location,
    required this.priority,
    required this.status,
    required this.scheduledTime,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? ThemeProvider.darkSidebar : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Left side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clientName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  location,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    PriorityTag(priority: priority),
                    const SizedBox(width: 8),
                    StatusPill(status: status),
                  ],
                ),
              ],
            ),
          ),

          // Right side
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                jobId,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                scheduledTime,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
