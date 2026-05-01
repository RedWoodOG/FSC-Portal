import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/dashboard_mode_provider.dart';
import '../../providers/activity_provider.dart';
import '../../providers/notification_provider.dart';
import '../../widgets/dashboard_card.dart';
import '../../widgets/job_card.dart';
import '../../widgets/section_title.dart';
import '../../widgets/info_card.dart';
import '../../widgets/dispatch_insights.dart';
import '../../widgets/activity_timeline.dart';
import '../../widgets/notification_center.dart';
import '../../services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Simulated active ticket count - in production, this would come from a provider/API
  int _simulatedTicketCount = 2; // Change this to test different modes
  WeatherInfo? _weatherInfo;

  @override
  void initState() {
    super.initState();
    // Initialize the provider with current ticket count
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final modeProvider = Provider.of<DashboardModeProvider>(context, listen: false);
      modeProvider.updateTicketCount(_simulatedTicketCount);
      
      // Initialize with demo activity events
      _initializeDemoData();
    });
    
    // Fetch weather data
    _fetchWeather();
  }
  
  void _initializeDemoData() {
    final activityProvider = Provider.of<ActivityProvider>(context, listen: false);
    final notificationProvider = Provider.of<NotificationProvider>(context, listen: false);
    
    // Add demo activity events
    activityProvider.ticketCompleted('#SC-2843', 'Regional Bank');
    activityProvider.ticketCompleted('#SC-2838', 'Metro Credit Union');
    
    // Add demo notifications
    notificationProvider.ticketAssigned('#SC-2847', 'First National Bank');
    notificationProvider.inventoryLow('Lock Type 702D', 3);
  }
  
  Future<void> _fetchWeather() async {
    final weather = await WeatherService().fetch('San Antonio');
    if (mounted) {
      setState(() {
        _weatherInfo = weather;
      });
    }
  }

  // Simulate ticket count changes for demo purposes
  void _simulateTicketChange(int newCount) {
    setState(() {
      _simulatedTicketCount = newCount;
    });
    final modeProvider = Provider.of<DashboardModeProvider>(context, listen: false);
    modeProvider.updateTicketCount(newCount);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final modeProvider = Provider.of<DashboardModeProvider>(context);
    final mode = modeProvider.currentMode;
    final transitionNarrative = modeProvider.transitionNarrative;
    
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow AppShell watermark to show through
      endDrawer: const NotificationCenterPanel(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Main content area
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
            // Header with mode indicator
            _buildHeader(context, isDark, mode, modeProvider),
            const SizedBox(height: 16),

            // Transition narrative banner (if recent transition)
            if (transitionNarrative != null) ...[
              _buildTransitionBanner(isDark, modeProvider.lastTransition!),
              const SizedBox(height: 16),
            ],

            // Status Overview - always visible but content varies by mode
            _buildStatsRow(isDark, mode, modeProvider),
            const SizedBox(height: 32),

            // Mode-specific content with smooth transitions
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: ScaleTransition(
                    scale: Tween<double>(begin: 0.98, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutCubic,
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: Container(
                key: ValueKey(mode),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (mode == DashboardMode.quiet) ..._buildQuietMode(isDark, modeProvider.ticketCount),
                    if (mode == DashboardMode.hybrid) ..._buildHybridMode(isDark, modeProvider.ticketCount),
                    if (mode == DashboardMode.surge) ..._buildSurgeMode(isDark, modeProvider.ticketCount),
                  ],
                ),
              ),
            ),
                ],
              ),
            ),
          ),
          
          // Right sidebar - Dispatch Insights
          if (modeProvider.ticketCount > 0)
            Container(
              width: 340,
              padding: const EdgeInsets.fromLTRB(0, 32, 32, 32),
              child: const DispatchInsights(),
            ),
        ],
      ),
    );
  }

  Widget _buildTransitionBanner(bool isDark, ModeTransition transition) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: 1.0,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: ThemeProvider.fscBlue.withOpacity(isDark ? 0.15 : 0.08),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: ThemeProvider.fscBlue.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 3,
              height: 40,
              decoration: BoxDecoration(
                color: ThemeProvider.fscBlue,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 16),
            Icon(
              transition.icon,
              color: ThemeProvider.fscBlue,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                transition.narrative,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, bool isDark, DashboardMode mode, DashboardModeProvider modeProvider) {
    String modeLabel = mode == DashboardMode.quiet ? 'Quiet Day' : 
                       mode == DashboardMode.hybrid ? 'Active' : 'Surge Mode';
    Color modeColor = mode == DashboardMode.quiet ? ThemeProvider.green : 
                      mode == DashboardMode.hybrid ? const Color(0xFF8B5CF6) : ThemeProvider.red;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Home',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: modeColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: modeColor, width: 1),
                  ),
                  child: Text(
                    modeLabel,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: modeColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              mode == DashboardMode.quiet 
                ? 'Staying ready and informed'
                : mode == DashboardMode.hybrid
                ? 'Managing your workload'
                : 'Command center active',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
            ),
          ],
        ),
        // Quick Actions and Debug Controls
        Row(
          children: [
            _QuickActionButton(
              icon: LucideIcons.clipboardList,
              label: 'New Call',
              onTap: () {},
              isDark: isDark,
            ),
            const SizedBox(width: 12),
            _QuickActionButton(
              icon: LucideIcons.clock,
              label: 'Time Entry',
              onTap: () {},
              isDark: isDark,
            ),
            const SizedBox(width: 24),
            // Debug: Ticket count simulator
            PopupMenuButton<int>(
              icon: Icon(
                Icons.science,
                size: 18,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
              tooltip: 'Simulate Ticket Changes',
              onSelected: _simulateTicketChange,
              itemBuilder: (context) => [
                const PopupMenuItem(value: 1, child: Text('Set 1 ticket (Quiet)')),
                const PopupMenuItem(value: 5, child: Text('Set 5 tickets (Hybrid)')),
                const PopupMenuItem(value: 15, child: Text('Set 15 tickets (Surge)')),
                const PopupMenuItem(value: 2, child: Text('Resolve to 2 (Quiet)')),
              ],
            ),
            const SizedBox(width: 12),
            // Notification bell
            Consumer<NotificationProvider>(
              builder: (_, notifProvider, __) => Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                    ),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                  if (notifProvider.unreadCount > 0)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: ThemeProvider.red,
                          shape: BoxShape.circle,
                        ),
                        constraints: const BoxConstraints(
                          minWidth: 16,
                          minHeight: 16,
                        ),
                        child: Text(
                          '${notifProvider.unreadCount}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatsRow(bool isDark, DashboardMode mode, DashboardModeProvider modeProvider) {
    if (mode == DashboardMode.surge) {
      // Surge mode: Priority and urgency focused
      return Row(
        children: [
          DashboardCard(
            label: 'Urgent Tickets',
            value: '5',
            icon: LucideIcons.alertCircle,
            accentColor: ThemeProvider.red,
          ),
          const SizedBox(width: 16),
          DashboardCard(
            label: 'Total Active',
            value: '15',
            icon: LucideIcons.briefcase,
            accentColor: ThemeProvider.fscBlue,
          ),
          const SizedBox(width: 16),
          DashboardCard(
            label: 'Est. Time',
            value: '8.5h',
            icon: LucideIcons.clock,
            accentColor: const Color(0xFF8B5CF6),
          ),
        ],
      );
    } else {
      // Quiet/Hybrid: Standard view
      return Row(
        children: [
          DashboardCard(
            label: 'Open Calls',
            value: '${modeProvider.ticketCount}',
            icon: LucideIcons.briefcase,
            accentColor: ThemeProvider.fscBlue,
          ),
          const SizedBox(width: 16),
          DashboardCard(
            label: 'Completed Today',
            value: '2',
            icon: LucideIcons.checkCircle,
            accentColor: ThemeProvider.green,
          ),
          const SizedBox(width: 16),
          DashboardCard(
            label: 'This Week',
            value: '12',
            icon: LucideIcons.trendingUp,
            accentColor: const Color(0xFF8B5CF6),
          ),
        ],
      );
    }
  }

  // QUIET MODE: Show supportive, passive information
  List<Widget> _buildQuietMode(bool isDark, int ticketCount) {
    return [
      // Operational Environment
      const SectionTitle(
        title: 'Operational Environment',
        subtitle: 'Regional coverage and preparation',
      ),
      const SizedBox(height: 16),
      InfoCard(
        message: 'Covering North Region today. Weather: Clear, 72°F. All routes accessible.',
        icon: LucideIcons.mapPin,
        accentColor: ThemeProvider.green,
      ),
      const SizedBox(height: 32),
      
      // Passive inventory reference (non-alarming)
      InfoCard(
        message: 'Inventory status available in Operations',
        icon: LucideIcons.info,
        accentColor: ThemeProvider.fscBlue.withOpacity(0.7),
      ),
      const SizedBox(height: 32),

      // Recommended Next Actions
      const SectionTitle(
        title: 'Recommended Next Actions',
        subtitle: 'Optimization opportunities',
      ),
      const SizedBox(height: 16),
      _ActivityCard(
        icon: LucideIcons.clipboardCheck,
        title: 'Schedule Preventative Maintenance',
        description: '3 clients due for quarterly ATM checks',
        actionLabel: 'Review',
        isDark: isDark,
      ),
      const SizedBox(height: 12),
      _ActivityCard(
        icon: LucideIcons.bookOpen,
        title: 'Training Module Available',
        description: 'New video tutorial: Advanced Lock Troubleshooting',
        actionLabel: 'Watch',
        isDark: isDark,
      ),
      const SizedBox(height: 12),
      _ActivityCard(
        icon: LucideIcons.fileText,
        title: 'Expense Report Reminder',
        description: 'Submit your expenses from last week',
        actionLabel: 'Submit',
        isDark: isDark,
      ),
      const SizedBox(height: 32),

      // Recent Completions
      const SectionTitle(
        title: 'Recent Completions',
        subtitle: 'Your latest completed work',
      ),
      const SizedBox(height: 16),
      JobCard(
        jobId: '#SC-2843',
        clientName: 'Regional Bank - Main Branch',
        location: 'ATM Maintenance Check',
        priority: 'low',
        status: 'completed',
        scheduledTime: 'Yesterday',
      ),
      const SizedBox(height: 32),
      
      // Activity Timeline
      Consumer<ActivityProvider>(
        builder: (_, activityProvider, __) => ActivityTimeline(
          events: activityProvider.events,
        ),
      ),
    ];
  }

  // HYBRID MODE: Balanced view of active work and support
  List<Widget> _buildHybridMode(bool isDark, int ticketCount) {
    return [
      // Active tickets
      const SectionTitle(
        title: "Today's Schedule",
        subtitle: 'Your upcoming service calls',
      ),
      const SizedBox(height: 16),
      JobCard(
        jobId: '#SC-2847',
        clientName: 'First National Bank - Downtown',
        location: 'Commercial Lane Stuck Canister',
        priority: 'high',
        status: 'scheduled',
        scheduledTime: '10:00 AM',
      ),
      const SizedBox(height: 12),
      JobCard(
        jobId: '#SC-2851',
        clientName: 'Community Credit Union - Branch #4',
        location: 'Drive-Through Audio System Failure',
        priority: 'medium',
        status: 'scheduled',
        scheduledTime: '2:30 PM',
      ),
      const SizedBox(height: 32),

      // Quick inventory check
      InfoCard(
        message: 'All required parts in stock for today\'s calls. Estimated drive time: 45 minutes.',
        icon: LucideIcons.checkCircle,
        accentColor: ThemeProvider.green,
      ),
      const SizedBox(height: 32),

      // Recent Completions
      const SectionTitle(
        title: 'Recent Completions',
        subtitle: 'Latest completed calls',
      ),
      const SizedBox(height: 16),
      JobCard(
        jobId: '#SC-2843',
        clientName: 'Regional Bank - Main Branch',
        location: 'ATM Maintenance Check',
        priority: 'low',
        status: 'completed',
        scheduledTime: 'Yesterday',
      ),
    ];
  }

  // SURGE MODE: Command center for high-volume operations
  List<Widget> _buildSurgeMode(bool isDark, int ticketCount) {
    return [
      // Critical alerts
      InfoCard(
        message: 'HIGH VOLUME ALERT: 15 active tickets. Route optimization recommended.',
        icon: LucideIcons.alertTriangle,
        accentColor: ThemeProvider.red,
      ),
      const SizedBox(height: 16),
      InfoCard(
        message: 'Dispatch message: Additional technician assigned to your region. Check FLO for coordination.',
        icon: LucideIcons.messageSquare,
        accentColor: ThemeProvider.fscBlue,
      ),
      const SizedBox(height: 32),

      // Priority queue
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SectionTitle(
            title: 'Priority Queue',
            subtitle: 'Sorted by urgency and location',
          ),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(LucideIcons.mapPin, size: 18),
            label: Text('Optimize Route'),
            style: TextButton.styleFrom(
              foregroundColor: ThemeProvider.fscBlue,
            ),
          ),
        ],
      ),
      const SizedBox(height: 16),
      JobCard(
        jobId: '#SC-2892',
        clientName: 'City Bank - ATM Out of Service',
        location: 'Main Street Branch - 2.3 mi',
        priority: 'high',
        status: 'urgent',
        scheduledTime: 'ASAP',
      ),
      const SizedBox(height: 12),
      JobCard(
        jobId: '#SC-2894',
        clientName: 'Federal Credit Union',
        location: 'Drive-Through Lane Failure - 2.8 mi',
        priority: 'high',
        status: 'urgent',
        scheduledTime: '9:30 AM',
      ),
      const SizedBox(height: 12),
      JobCard(
        jobId: '#SC-2847',
        clientName: 'First National Bank',
        location: 'Commercial Lane Issue - 5.1 mi',
        priority: 'high',
        status: 'scheduled',
        scheduledTime: '10:00 AM',
      ),
      const SizedBox(height: 16),
      
      // Show more button
      Center(
        child: TextButton(
          onPressed: () {},
          child: Text(
            'View All 15 Tickets',
            style: TextStyle(
              color: ThemeProvider.fscBlue,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
      const SizedBox(height: 32),

      const SizedBox(height: 32),
      
      // Activity Timeline in Surge Mode
      Consumer<ActivityProvider>(
        builder: (_, activityProvider, __) => ActivityTimeline(
          events: activityProvider.events,
        ),
      ),
    ];
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDark;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: ThemeProvider.fscBlue,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  final bool isDark;
  final bool isDominant;
  final bool isHealthy;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    // De-emphasize healthy items with reduced opacity
    final opacity = isHealthy ? 0.6 : 1.0;
    final iconSize = isDominant ? 36.0 : 28.0;
    final valueSize = isDominant ? 28.0 : 22.0;
    final valueWeight = isDominant ? FontWeight.w700 : FontWeight.bold;

    return Opacity(
      opacity: opacity,
      child: Container(
        padding: EdgeInsets.all(isDominant ? 24 : 20),
        decoration: BoxDecoration(
          color: isDark ? ThemeProvider.darkSidebar : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
            width: isDominant ? 1.5 : 1,
          ),
          // Subtle emphasis for dominant card
          boxShadow: isDominant
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            Icon(icon, size: iconSize, color: color),
            const SizedBox(height: 12),
            Text(
              value,
              style: TextStyle(
                fontSize: valueSize,
                fontWeight: valueWeight,
                letterSpacing: isDominant ? -0.5 : 0,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: isDominant ? FontWeight.w500 : FontWeight.normal,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String actionLabel;
  final bool isDark;

  const _ActivityCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
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
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: ThemeProvider.fscBlue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              size: 24,
              color: ThemeProvider.fscBlue,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          TextButton(
            onPressed: () {},
            child: Text(
              actionLabel,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
