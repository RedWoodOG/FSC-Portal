import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/notification_provider.dart';

class NotificationCenterPanel extends StatelessWidget {
  const NotificationCenterPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final notificationProvider = Provider.of<NotificationProvider>(context);
    final notifications = notificationProvider.items;

    return Drawer(
      width: 360,
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            decoration: BoxDecoration(
              color: isDark ? ThemeProvider.darkSidebar : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notifications",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                if (notificationProvider.unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: ThemeProvider.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${notificationProvider.unreadCount}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64,
                          color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No notifications',
                          style: TextStyle(
                            color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (_, i) {
                      final n = notifications[i];
                      return Container(
                        decoration: BoxDecoration(
                          color: n.isRead
                              ? Colors.transparent
                              : (isDark ? ThemeProvider.fscBlue.withOpacity(0.1) : ThemeProvider.fscBlue.withOpacity(0.05)),
                          border: Border(
                            bottom: BorderSide(
                              color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
                            ),
                          ),
                        ),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: ThemeProvider.fscBlue.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              n.icon,
                              color: ThemeProvider.fscBlue,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            n.title,
                            style: TextStyle(
                              fontWeight: n.isRead ? FontWeight.normal : FontWeight.w600,
                              color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                            ),
                          ),
                          subtitle: Text(
                            n.body,
                            style: TextStyle(
                              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                            ),
                          ),
                          trailing: Text(
                            n.timestamp,
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                            ),
                          ),
                          onTap: () {
                            if (!n.isRead) {
                              notificationProvider.markAsRead(n);
                            }
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
