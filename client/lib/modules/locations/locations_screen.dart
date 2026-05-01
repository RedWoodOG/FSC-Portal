import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../providers/theme_provider.dart';
import '../../services/api_service.dart';
import 'dart:math' as math;

/// Locations Screen with PM Route Optimizer
/// Implements "Farthest First" sweep routing algorithm
class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  GoogleMapController? _mapController;
  final _apiService = ApiService();
  
  // Data
  List<SiteMarker> _allSites = [];
  List<SiteMarker> _selectedRouteSites = [];
  bool _isLoading = true;
  String? _error;
  
  // PM Planning Mode
  bool _pmPlanningMode = false;
  String _selectedStartingPoint = 'Office';
  
  // Starting point coordinates (hardcoded for now)
  final Map<String, LatLng> _startingPoints = {
    'Office': const LatLng(29.4241, -98.4936), // San Antonio, TX
    'Home - Tech 1': const LatLng(29.4500, -98.5000),
    'Home - Tech 2': const LatLng(29.4000, -98.4800),
  };
  
  // Route visualization
  Set<Polyline> _routePolylines = {};
  Set<Marker> _allMarkers = {};
  
  // Initial camera position: San Antonio, TX
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(29.4241, -98.4936),
    zoom: 10.0,
  );

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    await _apiService.loadToken();
    _fetchMapData();
  }

  Future<void> _fetchMapData() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _apiService.getOperationsMapData();
      
      setState(() {
        _allSites = (data['sites'] as List)
            .map((site) => SiteMarker.fromJson(site))
            .toList();
        _isLoading = false;
      });
      
      _updateMapMarkers();
    } catch (e) {
      setState(() {
        _error = 'Failed to load locations: $e';
        _isLoading = false;
      });
    }
  }

  /// Calculate distance between two coordinates (Haversine formula)
  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371; // km
    final double dLat = _toRadians(point2.latitude - point1.latitude);
    final double dLon = _toRadians(point2.longitude - point1.longitude);
    
    final double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_toRadians(point1.latitude)) *
        math.cos(_toRadians(point2.latitude)) *
        math.sin(dLon / 2) * math.sin(dLon / 2);
    
    final double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));
    return earthRadius * c;
  }

  double _toRadians(double degrees) => degrees * (math.pi / 180);

  /// PM Routing Algorithm: Farthest First + 5 Nearest Neighbors
  void _calculatePMRoute() {
    if (_allSites.isEmpty) return;
    
    final startPoint = _startingPoints[_selectedStartingPoint]!;
    final List<SiteMarker> remainingSites = List.from(_allSites);
    
    // Step 1: Find the farthest site from starting point
    SiteMarker? farthestSiteNullable;
    double maxDistance = 0;
    
    for (final site in remainingSites) {
      final distance = _calculateDistance(startPoint, site.position);
      if (distance > maxDistance) {
        maxDistance = distance;
        farthestSiteNullable = site;
      }
    }
    
    if (farthestSiteNullable == null) return;
    
    // Now we know it's not null, assign to non-nullable variable
    final SiteMarker farthestSite = farthestSiteNullable;
    
    // Step 2: Remove farthest site from remaining
    remainingSites.remove(farthestSite);
    
    // Step 3: Find 5 closest sites to the farthest site
    final List<MapEntry<SiteMarker, double>> distances = remainingSites
        .map((site) => MapEntry(
            site,
            _calculateDistance(farthestSite.position, site.position)))
        .toList();
    
    distances.sort((a, b) => a.value.compareTo(b.value));
    
    final List<SiteMarker> closestSites = distances
        .take(5)
        .map((entry) => entry.key)
        .toList();
    
    // Step 4: Build route: Start -> Farthest -> 5 Closest -> End
    setState(() {
      _selectedRouteSites = [farthestSite, ...closestSites];
    });
    
    _updateRouteVisualization();
  }

  /// Update route visualization with polylines
  void _updateRouteVisualization() {
    if (!_pmPlanningMode || _selectedRouteSites.isEmpty) {
      setState(() {
        _routePolylines = {};
      });
      _updateMapMarkers();
      return;
    }
    
    final startPoint = _startingPoints[_selectedStartingPoint]!;
    final List<LatLng> routePoints = [startPoint];
    
    // Add all route sites
    for (final site in _selectedRouteSites) {
      routePoints.add(site.position);
    }
    
    // Return to start (optional - comment out if you want route to end at last site)
    // routePoints.add(startPoint);
    
    setState(() {
      _routePolylines = {
        Polyline(
          polylineId: const PolylineId('pm_route'),
          points: routePoints,
          color: ThemeProvider.fscBlue,
          width: 4,
          patterns: [PatternItem.dash(20), PatternItem.gap(10)],
        ),
      };
    });
    
    _updateMapMarkers();
  }

  /// Update map markers based on PM mode
  void _updateMapMarkers() {
    if (!_pmPlanningMode) {
      // Standard view: all sites with normal markers
      setState(() {
        _allMarkers = _allSites.map((site) {
          return Marker(
            markerId: MarkerId(site.id),
            position: site.position,
            icon: _getMarkerIcon(site.status),
            infoWindow: InfoWindow(
              title: site.siteName,
              snippet: site.clientName,
            ),
          );
        }).toSet();
      });
      return;
    }
    
    // PM Planning Mode: highlight route sites, grey out others
    setState(() {
      _allMarkers = _allSites.map((site) {
        final isInRoute = _selectedRouteSites.any((s) => s.id == site.id);
        
        return Marker(
          markerId: MarkerId(site.id),
          position: site.position,
          icon: isInRoute
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet) // Purple for route
              : BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange), // Grey/Orange for others
          infoWindow: InfoWindow(
            title: site.siteName,
            snippet: isInRoute ? 'In Route' : 'Not Selected',
          ),
        );
      }).toSet();
      
      // Add starting point marker
      final startPoint = _startingPoints[_selectedStartingPoint]!;
      _allMarkers.add(
        Marker(
          markerId: const MarkerId('start_point'),
          position: startPoint,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(
            title: 'Starting Point',
            snippet: 'Route Origin',
          ),
        ),
      );
    });
  }

  BitmapDescriptor _getMarkerIcon(String status) {
    switch (status) {
      case 'maintenance_req':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'operational':
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  void _togglePMMode(bool value) {
    setState(() {
      _pmPlanningMode = value;
      if (value) {
        _calculatePMRoute();
      } else {
        _selectedRouteSites = [];
        _routePolylines = {};
        _updateMapMarkers();
      }
    });
  }

  void _onStartingPointChanged(String? value) {
    if (value == null) return;
    setState(() {
      _selectedStartingPoint = value;
    });
    if (_pmPlanningMode) {
      _calculatePMRoute();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: Column(
        children: [
          // Control Panel
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? ThemeProvider.darkSidebar : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Starting Point Selector
                Expanded(
                  child: DropdownButtonFormField<String>(
                    initialValue: _selectedStartingPoint,
                    decoration: InputDecoration(
                      labelText: 'Starting Point',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    items: _startingPoints.keys.map((String point) {
                      return DropdownMenuItem<String>(
                        value: point,
                        child: Text(point),
                      );
                    }).toList(),
                    onChanged: _onStartingPointChanged,
                  ),
                ),
                const SizedBox(width: 16),
                
                // PM Planning Mode Toggle
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: _pmPlanningMode
                        ? ThemeProvider.fscBlue.withOpacity(0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: _pmPlanningMode
                          ? ThemeProvider.fscBlue
                          : (isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.navigation,
                        size: 20,
                        color: _pmPlanningMode
                            ? ThemeProvider.fscBlue
                            : (isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'PM Planning Mode',
                        style: TextStyle(
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                          fontWeight: _pmPlanningMode ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Switch(
                        value: _pmPlanningMode,
                        onChanged: _togglePMMode,
                        activeThumbColor: ThemeProvider.fscBlue,
                      ),
                    ],
                  ),
                ),
                
                // Route Info (if PM mode active)
                if (_pmPlanningMode && _selectedRouteSites.isNotEmpty) ...[
                  const SizedBox(width: 16),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: ThemeProvider.fscBlue.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          LucideIcons.mapPin,
                          size: 16,
                          color: ThemeProvider.fscBlue,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${_selectedRouteSites.length} Stops',
                          style: TextStyle(
                            color: ThemeProvider.fscBlue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Map
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _error != null
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
                            const SizedBox(height: 16),
                            Text(_error!, style: const TextStyle(color: Colors.red)),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: _fetchMapData,
                              child: const Text('Retry'),
                            ),
                          ],
                        ),
                      )
                    : GoogleMap(
                        initialCameraPosition: _initialPosition,
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                        markers: _allMarkers,
                        polylines: _routePolylines,
                        myLocationEnabled: true,
                        trafficEnabled: true,
                        mapType: MapType.normal,
                      ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

// Data model for site markers (reused from operations_map_widget)
class SiteMarker {
  final String id;
  final String clientName;
  final String siteName;
  final LatLng position;
  final String status;
  final String address;
  final String? regionId;
  final String? googlePlaceId;

  SiteMarker({
    required this.id,
    required this.clientName,
    required this.siteName,
    required this.position,
    required this.status,
    required this.address,
    this.regionId,
    this.googlePlaceId,
  });

  factory SiteMarker.fromJson(Map<String, dynamic> json) {
    return SiteMarker(
      id: json['id'],
      clientName: json['client_name'],
      siteName: json['site_name'],
      position: LatLng(
        json['position']['lat'],
        json['position']['lng'],
      ),
      status: json['status'],
      address: json['address'],
      regionId: json['region_id'],
      googlePlaceId: json['google_place_id'],
    );
  }
}
