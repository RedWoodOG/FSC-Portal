import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/activity_event.dart';
import '../providers/theme_provider.dart';

class ActivityTimeline extends StatelessWidget {
  final List<ActivityEvent> events;

  const ActivityTimeline({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    if (events.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Activity",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
          ),
        ),
        const SizedBox(height: 12),
        ...events.take(5).map((event) => Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? ThemeProvider.darkSidebar : Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
            ),
          ),
          child: Row(
            children: [
              Icon(
                event.icon,
                size: 20,
                color: ThemeProvider.fscBlue,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  event.description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
              ),
              Text(
                event.timestamp,
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                ),
              ),
            ],
          ),
        )),
      ],
    );
  }
}
