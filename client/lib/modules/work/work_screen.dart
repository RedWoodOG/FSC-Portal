import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'my_jobs.dart';
import 'work_orders.dart';
import 'dispatch_board.dart';

class WorkScreen extends StatefulWidget {
  const WorkScreen({super.key});

  @override
  State<WorkScreen> createState() => _WorkScreenState();
}

class _WorkScreenState extends State<WorkScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
              Tab(text: 'My Jobs'),
              Tab(text: 'Work Orders'),
              Tab(text: 'Dispatch Board'),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          MyJobsScreen(),
          WorkOrdersScreen(),
          DispatchBoardScreen(),
        ],
      ),
    );
  }
}
