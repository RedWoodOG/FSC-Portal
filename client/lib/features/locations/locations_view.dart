// Locations View - Offline Showcase
// Map view with PM Routing algorithm

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:provider/provider.dart';
import '../../database/database_service.dart';
import '../../database/app_database.dart';
import '../../utils/distance_calculator.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  final MapController _mapController = MapController();
  
  // Data
  List<Site> _allSites = [];
  List<Client> _allClients = [];
  List<StartingPoint> _startingPoints = [];
  
  // PM Route State
  bool _pmRouteMode = false;
  StartingPoint? _selectedStartingPoint;
  List<Site> _routeSites = [];
  List<latlng.LatLng> _routePolyline = [];
  
  bool _isLoading = true;

  // Initial center: San Antonio, TX
  static const latlng.LatLng _initialCenter = latlng.LatLng(29.4241, -98.4936);

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final dbService = Provider.of<DatabaseService>(context, listen: false);
    if (!dbService.isInitialized) {
      setState(() => _isLoading = false);
      return;
    }

    try {
      final sites = await dbService.db.getAllSites();
      final clients = await dbService.db.getAllClients();
      final points = await dbService.db.getAllStartingPoints();

      setState(() {
        _allSites = sites;
        _allClients = clients;
        _startingPoints = points;
        if (_startingPoints.isNotEmpty) {
          _selectedStartingPoint = _startingPoints.first;
        }
        _isLoading = false;
      });

      if (_pmRouteMode && _selectedStartingPoint != null) {
        _calculatePmRoute();
      }
    } catch (e) {
      print('Error loading data: $e');
      setState(() => _isLoading = false);
    }
  }

  void _calculatePmRoute() {
    if (_selectedStartingPoint == null || _allSites.isEmpty) return;

    final start = latlng.LatLng(
      _selectedStartingPoint!.latitude,
      _selectedStartingPoint!.longitude,
    );

    // Step A: Find farthest site from start
    Site? farthestSite;
    double maxDistance = 0;

    for (final site in _allSites) {
      final distance = calculateDistance(
        start,
        latlng.LatLng(site.latitude, site.longitude),
      );
      if (distance > maxDistance) {
        maxDistance = distance;
        farthestSite = site;
      }
    }

    if (farthestSite == null) {
      setState(() {
        _routeSites = [];
        _routePolyline = [];
      });
      return;
    }

    // Step B: Find 5 closest neighbors to farthest site
    final farthestPos = latlng.LatLng(farthestSite.latitude, farthestSite.longitude);
    final remaining = _allSites.where((s) => s.id != farthestSite!.id).toList();
    
    remaining.sort((a, b) {
      final distA = calculateDistance(
        farthestPos,
        latlng.LatLng(a.latitude, a.longitude),
      );
      final distB = calculateDistance(
        farthestPos,
        latlng.LatLng(b.latitude, b.longitude),
      );
      return distA.compareTo(distB);
    });

    // Step C: Build route (Start -> Farthest -> 5 Closest)
    final route = [farthestSite, ...remaining.take(5)];
    
    setState(() {
      _routeSites = route;
      _routePolyline = [
        start,
        ...route.map((s) => latlng.LatLng(s.latitude, s.longitude)),
      ];
    });
  }

  Color _getMarkerColor(Site site) {
    // Find client by clientId (now text, not int)
    final client = _allClients.firstWhere(
      (c) => c.id == site.clientId,
      orElse: () => Client(
        id: '',
        name: '',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    );

    final themeColor = client.themeColor ?? 'blue';
    switch (themeColor.toLowerCase()) {
      case 'blue':
        return Colors.blue;
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          // Map
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _initialCenter,
              initialZoom: 10.0,
              minZoom: 5.0,
              maxZoom: 18.0,
            ),
            children: [
              // OpenStreetMap tiles
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.fsc.portal',
                maxZoom: 19,
              ),
              
              // Polyline for PM Route
              if (_pmRouteMode && _routePolyline.length > 1)
                PolylineLayer(
                  polylines: [
                    Polyline(
                      points: _routePolyline,
                      strokeWidth: 4.0,
                      color: Colors.blue,
                    ),
                  ],
                ),
              
              // Markers
              MarkerLayer(
                markers: _allSites.map((site) {
                  final isInRoute = _routeSites.any((s) => s.id == site.id);
                  final opacity = _pmRouteMode && !isInRoute ? 0.3 : 1.0;
                  
                  return Marker(
                    point: latlng.LatLng(site.latitude, site.longitude),
                    width: 40,
                    height: 40,
                    child: Opacity(
                      opacity: opacity,
                      child: Icon(
                        Icons.location_on,
                        color: _getMarkerColor(site),
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Glassmorphism Overlay Controls
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Starting Point Dropdown
                  Row(
                    children: [
                      const Text(
                        'Starting Point:',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: DropdownButton<StartingPoint>(
                          value: _selectedStartingPoint,
                          isExpanded: true,
                          dropdownColor: Colors.grey[900],
                          style: const TextStyle(color: Colors.white),
                          items: _startingPoints.map((point) {
                            return DropdownMenuItem(
                              value: point,
                              child: Text(point.name),
                            );
                          }).toList(),
                          onChanged: (point) {
                            setState(() {
                              _selectedStartingPoint = point;
                            });
                            if (_pmRouteMode) {
                              _calculatePmRoute();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 12),
                  
                  // PM Route Mode Toggle
                  Row(
                    children: [
                      const Text(
                        'PM Route Mode:',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      const Spacer(),
                      Switch(
                        value: _pmRouteMode,
                        onChanged: (value) {
                          setState(() {
                            _pmRouteMode = value;
                          });
                          if (value) {
                            _calculatePmRoute();
                          } else {
                            setState(() {
                              _routeSites = [];
                              _routePolyline = [];
                            });
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
