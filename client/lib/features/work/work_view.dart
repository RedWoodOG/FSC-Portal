// Work View - Offline Showcase
// List view with SLA timer and navigation

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../database/database_service.dart';
import '../../database/app_database.dart';

class WorkView extends StatefulWidget {
  const WorkView({super.key});

  @override
  State<WorkView> createState() => _WorkViewState();
}

class _WorkViewState extends State<WorkView> {
  List<Site> _sites = [];
  bool _isLoading = true;
  
  // SLA Timer (static for demo)
  final DateTime _nextBreach = DateTime.now().add(const Duration(hours: 2, minutes: 15));

  @override
  void initState() {
    super.initState();
    _loadSites();
    // Update SLA timer every minute
    _startSlaTimer();
  }

  void _startSlaTimer() {
    Future.delayed(const Duration(seconds: 60), () {
      if (mounted) {
        setState(() {});
        _startSlaTimer();
      }
    });
  }

  Future<void> _loadSites() async {
    final dbService = Provider.of<DatabaseService>(context, listen: false);
    if (!dbService.isInitialized) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final sites = await dbService.db.getAllSites();
      setState(() {
        _sites = sites;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading sites: $e');
      setState(() => _isLoading = false);
    }
  }

  String _getSlaTimeRemaining() {
    final now = DateTime.now();
    if (now.isAfter(_nextBreach)) {
      return 'Breached';
    }
    
    final difference = _nextBreach.difference(now);
    final hours = difference.inHours;
    final minutes = difference.inMinutes % 60;
    
    return '${hours}h ${minutes}m';
  }

  Future<void> _navigateToSite(Site site) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${site.latitude},${site.longitude}',
    );
    
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open navigation')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Work Orders'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // SLA Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.orange.shade700,
                  Colors.red.shade700,
                ],
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Next SLA Breach',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _getSlaTimeRemaining(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          // Sites List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _sites.isEmpty
                    ? const Center(
                        child: Text('No sites available'),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _sites.length,
                        itemBuilder: (context, index) {
                          final site = _sites[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Branch Name
                                  Text(
                                    site.branchName,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  
                                  // Address
                                  Text(
                                    site.address,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  
                                  if (site.lobbyHours != null) ...[
                                    const SizedBox(height: 4),
                                    Text(
                                      site.lobbyHours!,
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                  
                                  const SizedBox(height: 12),
                                  
                                  // Navigate Button
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton.icon(
                                      onPressed: () => _navigateToSite(site),
                                      icon: const Icon(Icons.navigation),
                                      label: const Text('Navigate'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
