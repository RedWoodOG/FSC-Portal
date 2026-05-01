import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'database/app_database.dart';
import 'database/seed_service.dart';
import 'features/home/home_view.dart';
import 'features/locations/locations_view.dart';
import 'features/work/work_view.dart';
import 'features/operations/operations_view.dart';
import 'features/people/people_view.dart';
import 'features/people/user_details_dialog.dart';
import 'features/knowledge/enhanced_knowledge_home_view.dart';
import 'features/settings/settings_view.dart';
import 'theme/app_theme.dart';
import 'app_shell/portal_shell.dart';
import 'app_shell/eva_state.dart';
import 'app_shell/navigation_state.dart';
import 'features/auth/auth_state.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/pin_screen.dart';
import 'util/log.dart';
import 'services/weather_update_manager.dart';
import 'features/continuing_education/continuing_education_home_view.dart';
import 'features/equipment/equipment_home_view.dart';
import 'features/expenses/expenses_home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize production logging (file-based for release builds)
  await Log.initialize();

  // Catch and log all errors
  FlutterError.onError = (FlutterErrorDetails details) {
    Log.error('Flutter Error: ${details.exception}');
    Log.error('Stack: ${details.stack}');
    FlutterError.presentError(details);
  };

  // Global error boundary - catches all unhandled errors
  ErrorWidget.builder = (FlutterErrorDetails details) {
    Log.error('ErrorWidget shown: ${details.exception}');
    return Material(
      color: AppColors.background,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.surface,
            border: Border.all(color: AppColors.error, width: 2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: AppColors.error,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                'Something went wrong',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Please restart the application',
                style: AppTypography.bodyText.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  };

  // Initialize database
  final database = AppDatabase();

  // Debug: Print database path (for troubleshooting)
  try {
    final dbFolder = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dbFolder.path, 'portal_offline.sqlite');
    Log.info('Database path: $dbPath');
  } catch (e) {
    Log.info('Could not determine database path: $e');
  }

  // Seed the database with demo data
  try {
    await seedDatabase(database);
  } catch (e, stackTrace) {
    Log.error('Error seeding database: $e');
    Log.error('Stack: $stackTrace');
    // Continue anyway - app might work with existing data
  }

  // Initialize auth state
  final authState = AuthState();
  authState.setDatabase(database);

  // Initialize EVA state
  final evaState = EvaState();
  evaState.setDatabase(database);

  // Initialize Navigation state
  final navigationState = NavigationState();

  // Initialize and start Weather Update Manager
  final weatherManager = WeatherUpdateManager(database);
  weatherManager.start();

  runApp(
    MultiProvider(
      providers: [
        Provider<AppDatabase>.value(value: database),
        Provider<WeatherUpdateManager>.value(value: weatherManager),
        ChangeNotifierProvider<AuthState>.value(value: authState),
        ChangeNotifierProvider<EvaState>.value(value: evaState),
        ChangeNotifierProvider<NavigationState>.value(value: navigationState),
      ],
      child: const PortalOfflineApp(),
    ),
  );
}

class PortalOfflineApp extends StatelessWidget {
  const PortalOfflineApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Portal Offline',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AuthGate(),
    );
  }
}

/// Routes to login, PIN unlock, or main app based on auth state.
/// Periodically checks session timeout and records user activity.
class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  late final _ticker = Stream.periodic(const Duration(seconds: 30));
  late final _subscription = _ticker.listen((_) {
    if (!mounted) return;
    context.read<AuthState>().checkSessionTimeout();
  });

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthState>();

    if (!authState.isAuthenticated) {
      return const LoginScreen();
    }

    if (authState.isLocked && authState.hasPinSet) {
      return const PinScreen();
    }

    if (authState.isLocked) {
      // Locked but no PIN — force full re-login
      return const LoginScreen();
    }

    // Wrap main app in a Listener to record user activity on any pointer event
    return Listener(
      onPointerDown: (_) => authState.recordActivity(),
      child: const MainNavigationScreen(),
    );
  }
}

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  User? _currentUser;

  @override
  void initState() {
    super.initState();
    _loadUser();
    // Listen to navigation state changes - must wait for first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<NavigationState>().addListener(_onNavigationChanged);
      }
    });
  }

  @override
  void dispose() {
    if (mounted) {
      try {
        context.read<NavigationState>().removeListener(_onNavigationChanged);
      } catch (e) {
        // Context may not be available during dispose
      }
    }
    super.dispose();
  }

  void _onNavigationChanged() {
    if (mounted) {
      setState(() {
        // Navigation state changed, rebuild to show new screen
      });
    }
  }

  Future<void> _loadUser() async {
    // Load the authenticated user from AuthState
    await Future.delayed(const Duration(milliseconds: 100));
    if (!mounted) return;

    final authState = context.read<AuthState>();
    if (mounted && authState.currentUser != null) {
      setState(() {
        _currentUser = authState.currentUser;
      });
    }
  }

  final List<Widget> _screens = [
    const HomeView(),
    const WorkView(),
    const OperationsView(), // Operations - connected to local database
    const LocationsView(),
    const PeopleView(),
    const EnhancedKnowledgeHomeView(), // Knowledge Base
    const ContinuingEducationHomeView(), // NEW
    const EquipmentHomeView(), // NEW
    const ExpensesHomeView(), // NEW
    const SettingsView(), // Settings
  ];

  final List<Map<String, dynamic>> _navItems = [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.work, 'label': 'Work'},
    {'icon': Icons.settings, 'label': 'Operations'},
    {'icon': Icons.location_on, 'label': 'Locations'},
    {'icon': Icons.people, 'label': 'People'},
    {'icon': Icons.library_books, 'label': 'Knowledge'},
    {'icon': Icons.school, 'label': 'Training'}, // NEW - Continuing Education
    {'icon': Icons.inventory, 'label': 'Equipment'}, // NEW - Equipment
    {'icon': Icons.receipt_long, 'label': 'Expenses'}, // NEW - Expenses
    {'icon': Icons.settings_applications, 'label': 'Settings'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final bool isMobile = constraints.maxWidth < 600;
      final navigationState = context.watch<NavigationState>();
      final selectedIndex = navigationState.selectedIndex;

      return Scaffold(
        backgroundColor: AppColors.background,
        body: isMobile
            ? Column(
                children: [
                  Expanded(
                    child: PortalShell(
                      child: _screens[selectedIndex],
                    ),
                  ),
                ],
              )
            : Row(
                children: [
                  // Sidebar Navigation
                  Container(
                    width: AppLayout.sidebarWidth,
                    color: AppColors.background,
                    child: Column(
                      children: [
                        // Logo/Brand
                        Container(
                          padding: const EdgeInsets.all(24),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/logo.webp',
                                height: AppLayout.logoSize,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    width: AppLayout.logoSize,
                                    height: AppLayout.logoSize,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius: BorderRadius.circular(
                                          AppLayout.radiusMD),
                                    ),
                                    child: Icon(
                                      Icons.bolt,
                                      color: AppColors.textPrimary,
                                      size: AppIcons.sizeMD,
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Portal',
                                style: AppTypography.appTitle,
                              ),
                            ],
                          ),
                        ),
                        const Divider(color: Colors.white10, height: 1),
                        // Navigation Items
                        Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            itemCount: _navItems.length,
                            itemBuilder: (context, index) {
                              final item = _navItems[index];
                              final isSelected = selectedIndex == index;
                              return _buildNavItem(
                                icon: item['icon'],
                                label: item['label'],
                                isSelected: isSelected,
                                onTap: () {
                                  navigationState.navigateTo(index);
                                },
                              );
                            },
                          ),
                        ),
                        const Divider(color: Colors.white10, height: 1),
                        // User Profile
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () async {
                              if (_currentUser != null) {
                                await showDialog(
                                  context: context,
                                  builder: (context) =>
                                      UserDetailsDialog(user: _currentUser!),
                                );
                                _loadUser();
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration:
                                        AppComponents.userAvatarDecoration,
                                    child: Center(
                                      child: Text(
                                        _currentUser?.fullName.isNotEmpty ==
                                                true
                                            ? _currentUser!.fullName[0]
                                            : 'A',
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          _currentUser?.fullName ??
                                              'Loading...',
                                          style: AppTypography.navItemActive,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          _currentUser?.role.toUpperCase() ??
                                              'OFFLINE',
                                          style: AppTypography.timestamp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    Icons.nights_stay,
                                    color: AppColors.textSecondary,
                                    size: AppIcons.sizeMD,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Main Content
                  Expanded(
                    child: PortalShell(
                      child: _screens[selectedIndex],
                    ),
                  ),
                ],
              ),
        bottomNavigationBar: isMobile
            ? BottomNavigationBar(
                items: _navItems
                    .take(5)
                    .map((item) => BottomNavigationBarItem(
                          icon: Icon(item['icon']),
                          label: item['label'],
                        ))
                    .toList(),
                currentIndex: selectedIndex >= 5 ? 0 : selectedIndex,
                onTap: (index) {
                  navigationState.navigateTo(index);
                },
                backgroundColor: AppColors.background,
                selectedItemColor: AppColors.primary,
                unselectedItemColor: AppColors.textSecondary,
                type: BottomNavigationBarType.fixed,
              )
            : null,
      );
    });
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: isSelected
                ? AppComponents.navItemActiveDecoration
                : AppComponents.navItemInactiveDecoration,
            child: Row(
              children: [
                Icon(
                  icon,
                  color:
                      isSelected ? AppColors.primary : AppColors.textSecondary,
                  size: AppLayout.navIconSize,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: isSelected
                      ? AppTypography.navItemActive
                      : AppTypography.navItemInactive,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
