import 'package:flutter/material.dart';
import '../widgets/sidebar_nav.dart';
import '../modules/home/home_screen.dart';
import '../modules/readiness/readiness_screen.dart';
import '../modules/operations/operations_screen.dart';
// Offline Showcase Views
import '../features/locations/locations_view.dart';
import '../features/work/work_view.dart';
import '../modules/people/people_screen.dart';
import '../modules/flo/flo_screen.dart';
import '../modules/me/me_screen.dart';
import '../modules/admin/admin_screen.dart';
import '../features/debug/database_debug_view.dart';

class PortalHome extends StatefulWidget {
  const PortalHome({super.key});

  @override
  State<PortalHome> createState() => _PortalHomeState();
}

class _PortalHomeState extends State<PortalHome> {
  String _selectedModule = 'home';

  Widget _getCurrentScreen() {
    switch (_selectedModule) {
      case 'home':
        return const HomeScreen();
      case 'work':
        // Using new Offline Showcase WorkView
        return const WorkView();
      case 'readiness':
        return const ReadinessScreen();
      case 'operations':
        return const OperationsScreen();
      case 'locations':
        // Using new Offline Showcase LocationsView
        return const LocationsView();
      case 'people':
        return const PeopleScreen();
      case 'flo':
        return const FloScreen();
      case 'me':
        return const MeScreen();
      case 'admin':
        return const AdminScreen();
      case 'debug':
        return const DatabaseDebugView();
      default:
        return const HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Allow AppShell watermark to show through
      body: Row(
        children: [
          // Sidebar
          SidebarNav(
            selectedModule: _selectedModule,
            onModuleSelected: (module) {
              setState(() {
                _selectedModule = module;
              });
            },
          ),
          
          // Main Content Area
          Expanded(
            child: _getCurrentScreen(), // Removed hardcoded Container background
          ),
        ],
      ),
    );
  }
}
