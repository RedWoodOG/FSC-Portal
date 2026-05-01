import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../widgets/operations_map_widget.dart';
import '../../widgets/operations_clients_list_widget.dart';
import 'inventory_screen.dart';
import 'clients_screen.dart';

class OperationsScreen extends StatefulWidget {
  const OperationsScreen({super.key});

  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? ThemeProvider.darkSidebar : Colors.white,
            border: Border(
              bottom: BorderSide(
                color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                width: 1,
              ),
            ),
          ),
          child: TabBar(
            controller: _tabController,
            indicatorColor: ThemeProvider.fscBlue,
            labelColor: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
            unselectedLabelColor: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            tabs: const [
              Tab(text: 'Inventory'),
              Tab(text: 'Clients'),
              Tab(text: 'Map'),
              Tab(text: 'List'),
              Tab(text: 'Assets'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          InventoryScreen(),
          ClientsScreen(),
          OperationsMapWidget(), // Map view with all locations
          OperationsClientsListWidget(), // Hierarchical list view
          Center(child: Text('Assets coming soon')),
        ],
      ),
    );
  }
}
