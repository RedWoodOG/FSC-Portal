import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
import '../providers/dashboard_mode_provider.dart';
import '../services/inventory_risk.dart';

class DispatchInsights extends StatelessWidget {
  const DispatchInsights({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final modeProvider = Provider.of<DashboardModeProvider>(context);
    final mode = modeProvider.currentMode;
    final ticketCount = modeProvider.ticketCount;

    // Don't show if no tickets
    if (ticketCount == 0) return const SizedBox.shrink();

    return Container(
      width: 320,
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: ThemeProvider.fscBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(
                  LucideIcons.radio,
                  size: 16,
                  color: ThemeProvider.fscBlue,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Dispatch Insights',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Mode-specific insights
          if (mode == DashboardMode.hybrid) ..._buildHybridInsights(isDark, ticketCount),
          if (mode == DashboardMode.surge) ..._buildSurgeInsights(isDark, ticketCount),
        ],
      ),
    );
  }

  List<Widget> _buildHybridInsights(bool isDark, int ticketCount) {
    // Simulated inventory data - replace with real data
    int lockQty = 5;
    int riskScore = InventoryRisk.calculate(lockQty, 6, 3);
    
    return [
      _InsightCard(
        icon: LucideIcons.mapPin,
        title: 'Closest Call',
        message: 'Ticket #SC-2847 is 2.3 miles away, eight minutes.',
        isDark: isDark,
        accentColor: ThemeProvider.green,
      ),
      const SizedBox(height: 12),
      _InsightCard(
        icon: LucideIcons.package,
        title: 'Inventory Ready',
        message: 'All required parts in stock for today\'s calls.',
        isDark: isDark,
        accentColor: ThemeProvider.fscBlue,
      ),
      const SizedBox(height: 12),
      _InsightCard(
        icon: LucideIcons.clock,
        title: 'Time Estimate',
        message: 'Estimated completion: 2.5 hours total.',
        isDark: isDark,
        accentColor: const Color(0xFF8B5CF6),
      ),
      if (riskScore > 70) ...[
        const SizedBox(height: 12),
        _InsightCard(
          icon: LucideIcons.alertTriangle,
          title: 'Inventory Risk',
          message: 'Lock Type 702D: ${InventoryRisk.getRiskLabel(riskScore)} ($lockQty remaining)',
          isDark: isDark,
          accentColor: const Color(0xFFF59E0B),
        ),
      ],
    ];
  }

  List<Widget> _buildSurgeInsights(bool isDark, int ticketCount) {
    // Simulated inventory data - replace with real data
    int lockQty = 2;
    int riskScore = InventoryRisk.calculate(lockQty, 6, 3);
    
    return [
      _InsightCard(
        icon: LucideIcons.alertTriangle,
        title: 'Priority Alert',
        message: 'Two urgent tickets require immediate attention.',
        isDark: isDark,
        accentColor: ThemeProvider.red,
        isUrgent: true,
      ),
      const SizedBox(height: 12),
      _InsightCard(
        icon: LucideIcons.mapPin,
        title: 'Route Optimization',
        message: 'Suggested priority sequence updated for efficiency.',
        isDark: isDark,
        accentColor: ThemeProvider.fscBlue,
      ),
      const SizedBox(height: 12),
      _InsightCard(
        icon: LucideIcons.package,
        title: 'Inventory Warning',
        message: 'Critical: Lock Type 702D at ${InventoryRisk.getRiskLabel(riskScore)} level ($lockQty remaining)',
        isDark: isDark,
        accentColor: const Color(0xFFF59E0B),
        isUrgent: riskScore >= 90,
      ),
      const SizedBox(height: 12),
      _InsightCard(
        icon: LucideIcons.users,
        title: 'Team Coordination',
        message: 'Backup technician assigned to your region.',
        isDark: isDark,
        accentColor: ThemeProvider.green,
      ),
    ];
  }
}

class _InsightCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String message;
  final bool isDark;
  final Color accentColor;
  final bool isUrgent;

  const _InsightCard({
    required this.icon,
    required this.title,
    required this.message,
    required this.isDark,
    required this.accentColor,
    this.isUrgent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? ThemeProvider.darkSidebar : Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isUrgent 
            ? accentColor.withOpacity(0.4)
            : (isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB)),
          width: isUrgent ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: accentColor,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(
              fontSize: 12,
              height: 1.4,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
