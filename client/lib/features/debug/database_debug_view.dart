// Database Debug View
// Shows all tables and their contents for debugging

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/database_service.dart';
import '../../database/app_database.dart';

class DatabaseDebugView extends StatefulWidget {
  const DatabaseDebugView({super.key});

  @override
  State<DatabaseDebugView> createState() => _DatabaseDebugViewState();
}

class _DatabaseDebugViewState extends State<DatabaseDebugView> {
  bool _isLoading = true;
  String _status = 'Loading...';

  int _clientsCount = 0;
  int _sitesCount = 0;
  int _startingPointsCount = 0;
  int _locationsCount = 0;

  List<Client> _clients = [];
  List<Site> _sites = [];
  List<StartingPoint> _startingPoints = [];
  List<Location> _locations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dbService = Provider.of<DatabaseService>(context, listen: false);
    if (!dbService.isInitialized) {
      setState(() {
        _status = 'Database not initialized';
        _isLoading = false;
      });
      return;
    }

    try {
      final clients = await dbService.db.getAllClients();
      final sites = await dbService.db.getAllSites();
      final points = await dbService.db.getAllStartingPoints();
      final locations = await dbService.db.getAllLocations();

      setState(() {
        _clients = clients;
        _sites = sites;
        _startingPoints = points;
        _locations = locations;
        _clientsCount = clients.length;
        _sitesCount = sites.length;
        _startingPointsCount = points.length;
        _locationsCount = locations.length;
        _status = 'Loaded successfully';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _status = 'Error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Database Debug View'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadData,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Status Card
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status: $_status',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Clients: $_clientsCount'),
                          Text('Sites: $_sitesCount'),
                          Text('Starting Points: $_startingPointsCount'),
                          Text('Locations: $_locationsCount'),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Clients Section
                  _buildSection(
                    'Clients (${_clients.length})',
                    _clients.isEmpty
                        ? const Text('No clients found')
                        : Column(
                            children: _clients.map((client) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text(client.name),
                                  subtitle: Text('ID: ${client.id}'),
                                  trailing: Chip(
                                    label: Text(
                                      client.themeColor ?? 'none',
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),

                  const SizedBox(height: 16),

                  // Sites Section
                  _buildSection(
                    'Sites (${_sites.length})',
                    _sites.isEmpty
                        ? const Text('No sites found')
                        : Column(
                            children: _sites.map((site) {
                              final client = _clients.firstWhere(
                                (c) => c.id == site.clientId,
                                orElse: () => Client(
                                  id: site.clientId,
                                  name: 'Unknown',
                                  createdAt: DateTime.now(),
                                  updatedAt: DateTime.now(),
                                ),
                              );
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text(site.branchName),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Client: ${client.name} (${site.clientId})'),
                                      Text('Address: ${site.address}'),
                                      Text(
                                        'Coords: ${site.latitude}, ${site.longitude}',
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),

                  const SizedBox(height: 16),

                  // Starting Points Section
                  _buildSection(
                    'Starting Points (${_startingPoints.length})',
                    _startingPoints.isEmpty
                        ? const Text('No starting points found')
                        : Column(
                            children: _startingPoints.map((point) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 8),
                                child: ListTile(
                                  title: Text(point.name),
                                  subtitle: Text(
                                    'Coords: ${point.latitude}, ${point.longitude}',
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                  ),

                  const SizedBox(height: 16),

                  // Locations Section (from Locations table)
                  _buildSection(
                    'Locations (${_locations.length})',
                    _locations.isEmpty
                        ? const Text('No locations found')
                        : Text('${_locations.length} locations in Locations table'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            content,
          ],
        ),
      ),
    );
  }
}
