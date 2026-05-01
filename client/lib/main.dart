import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme/app_theme.dart';
import 'screens/login_screen.dart';
import 'providers/theme_provider.dart';
import 'providers/dashboard_mode_provider.dart';
import 'providers/activity_provider.dart';
import 'providers/notification_provider.dart';
import 'widgets/app_shell.dart';
import 'database/database_service.dart';
import 'database/seed_data.dart';
import 'services/prosperity_bank_import.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize local database
  final dbService = DatabaseService();
  await dbService.initialize();
  
  // Seed database with demo data (if empty)
  try {
    await seedDatabase(dbService.db);
  } catch (e, stackTrace) {
    print('❌ Error seeding database: $e');
    print('Stack trace: $stackTrace');
  }
  
  // Import Prosperity Bank locations (one-time import)
  try {
    print('🚀 Starting Prosperity Bank import...');
    final import = ProsperityBankImport(dbService);
    await import.importAllLocations();
    print('✅ Import completed!');
  } catch (e, stackTrace) {
    print('❌ Error importing Prosperity Bank locations: $e');
    print('Stack trace: $stackTrace');
  }
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => DashboardModeProvider()),
        ChangeNotifierProvider(create: (_) => ActivityProvider()),
        ChangeNotifierProvider(create: (_) => NotificationProvider()),
        ChangeNotifierProvider.value(value: dbService), // Local database
      ],
      child: const FSCPortalApp(),
    ),
  );
}

class FSCPortalApp extends StatelessWidget {
  const FSCPortalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FSC Portal',
      debugShowCheckedModeBanner: false,
      // Strictly use dark theme for Offline Portal
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      builder: (context, child) {
        return AppShell(child: child!);
      },
      home: const LoginScreen(),
    );
  }
}
