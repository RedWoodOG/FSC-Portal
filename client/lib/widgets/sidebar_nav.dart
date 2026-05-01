import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../providers/theme_provider.dart';

class SidebarNav extends StatelessWidget {
  final String selectedModule;
  final Function(String) onModuleSelected;

  const SidebarNav({
    super.key,
    required this.selectedModule,
    required this.onModuleSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDarkMode;
    
    return Container(
      width: 260,
      color: isDark ? ThemeProvider.darkSidebar : ThemeProvider.lightSidebar,
      child: Column(
        children: [
          // Logo Header
          Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/FSC_Logo.svg',
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  'Portal',
                  style: TextStyle(
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          Divider(color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder, height: 1),

          // Navigation Items
          Expanded(
            child: Column(
              children: [
                const SizedBox(height: 8),
                _buildNavItem('home', 'Home', LucideIcons.layoutDashboard, isDark),
                _buildNavItem('work', 'Work', LucideIcons.clipboardList, isDark),
                _buildNavItem('readiness', 'Field Readiness', LucideIcons.package, isDark),
                _buildNavItem('operations', 'Operations', LucideIcons.boxes, isDark),
                _buildNavItem('locations', 'Locations', LucideIcons.mapPin, isDark),
                _buildNavItem('people', 'People', LucideIcons.users, isDark),
                _buildNavItem('flo', 'FLO', LucideIcons.messagesSquare, isDark),
                _buildNavItem('me', 'Me', LucideIcons.userCircle, isDark),
                const Spacer(),
                _buildNavItem('admin', 'Admin', LucideIcons.shield, isDark),
                const SizedBox(height: 8),
              ],
            ),
          ),

          // Theme Toggle
          Divider(color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder, height: 1),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  isDark ? 'Dark Mode' : 'Light Mode',
                  style: TextStyle(
                    color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                    fontSize: 14,
                  ),
                ),
                IconButton(
                  icon: Icon(
                    isDark ? LucideIcons.moon : LucideIcons.sun,
                    size: 20,
                  ),
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  onPressed: () => themeProvider.toggleTheme(),
                ),
              ],
            ),
          ),
          
          // User Profile at Bottom
          Divider(color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder, height: 1),
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: ThemeProvider.fscBlue,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: Text(
                      'A',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Admin',
                        style: TextStyle(
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        'Administrator',
                        style: TextStyle(
                          color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(String id, String label, IconData icon, bool isDark) {
    final isSelected = selectedModule == id;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => onModuleSelected(id),
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: isSelected
                  ? ThemeProvider.fscBlue
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 20,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary),
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : (isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary),
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
