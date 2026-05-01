import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
// Use stub file on Windows (google_maps_flutter doesn't support Windows)
import 'google_maps_stub.dart' as google_maps;
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as latlng;
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/theme_provider.dart';
import '../../database/database_service.dart';
import '../../database/app_database.dart';
import '../../services/data_import_service.dart';
import '../../services/api_service.dart';
import '../../services/jefferson_bank_import.dart';
import '../../services/rbfcu_import.dart';
import '../../services/prosperity_bank_import.dart';
import 'dart:math' as math;
import 'package:file_picker/file_picker.dart';

/// Locations Screen with PM Route Optimizer - LOCAL DATABASE VERSION
/// Implements "Farthest First" sweep routing algorithm
/// Works completely offline using local SQLite database
class LocationsScreenLocal extends StatefulWidget {
  const LocationsScreenLocal({super.key});

  @override
  State<LocationsScreenLocal> createState() => _LocationsScreenLocalState();
}

class _LocationsScreenLocalState extends State<LocationsScreenLocal> {
  google_maps.GoogleMapController? _mapController;
  DatabaseService? _dbService;
  
  // Data
  List<Location> _allLocations = [];
  List<Location> _selectedRouteLocations = [];
  bool _isLoading = true;
  String? _error;
  
  // PM Planning Mode
  bool _pmPlanningMode = false;
  String _selectedStartingPoint = 'Office';
  
  // Starting point coordinates (hardcoded for now)
  final Map<String, google_maps.LatLng> _startingPoints = {
    'Office': const google_maps.LatLng(29.4241, -98.4936), // San Antonio, TX
    'Home - Tech 1': const google_maps.LatLng(29.4500, -98.5000),
    'Home - Tech 2': const google_maps.LatLng(29.4000, -98.4800),
  };
  
  // Route visualization (Google Maps)
  Set<google_maps.Polyline> _routePolylines = {};
  Set<google_maps.Marker> _allMarkers = {};
  
  // Flutter Map controller (for Windows)
  MapController? _flutterMapController;
  
  // Initial camera position: San Antonio, TX
  static const google_maps.CameraPosition _initialPosition = google_maps.CameraPosition(
    target: google_maps.LatLng(29.4241, -98.4936),
    zoom: 10.0,
  );
  
  // Flutter Map initial position
  static const latlng.LatLng _flutterMapInitialPosition = latlng.LatLng(29.4241, -98.4936);
  
  // Sync state
  bool _isSyncing = false;
  String? _syncMessage;

  @override
  void initState() {
    super.initState();
    _dbService = Provider.of<DatabaseService>(context, listen: false);
    final bool isWindows = !kIsWeb && Platform.isWindows;
    if (isWindows || kIsWeb) {
      _flutterMapController = MapController();
    }
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    if (_dbService == null || !_dbService!.isInitialized) {
      setState(() {
        _error = 'Database not initialized';
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Get locations with coordinates from local database
      final locations = await _dbService!.getLocationsWithCoordinates();
      
      setState(() {
        _allLocations = locations;
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
  double _calculateDistance(google_maps.LatLng point1, google_maps.LatLng point2) {
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
    if (_allLocations.isEmpty) return;
    
    final startPoint = _startingPoints[_selectedStartingPoint]!;
    final List<Location> remainingLocations = List.from(_allLocations);
    
    // Step 1: Find the farthest location from starting point
    Location? farthestLocationNullable;
    double maxDistance = 0;
    
    for (final location in remainingLocations) {
      if (location.latitude == null || location.longitude == null) continue;
      
      final position = google_maps.LatLng(location.latitude!, location.longitude!);
      final distance = _calculateDistance(startPoint, position);
      if (distance > maxDistance) {
        maxDistance = distance;
        farthestLocationNullable = location;
      }
    }
    
    if (farthestLocationNullable == null) return;
    
    final Location farthestLocation = farthestLocationNullable;
    final farthestPosition = google_maps.LatLng(farthestLocation.latitude!, farthestLocation.longitude!);
    
    // Step 2: Remove farthest location from remaining
    remainingLocations.remove(farthestLocation);
    
    // Step 3: Find 5 closest locations to the farthest location
    final List<MapEntry<Location, double>> distances = remainingLocations
        .where((loc) => loc.latitude != null && loc.longitude != null)
        .map((location) => MapEntry(
            location,
            _calculateDistance(
                google_maps.LatLng(farthestPosition.latitude, farthestPosition.longitude),
                google_maps.LatLng(location.latitude!, location.longitude!))))
        .toList();
    
    distances.sort((a, b) => a.value.compareTo(b.value));
    
    final List<Location> closestLocations = distances
        .take(5)
        .map((entry) => entry.key)
        .toList();
    
    // Step 4: Build route: Start -> Farthest -> 5 Closest -> End
    setState(() {
      _selectedRouteLocations = [farthestLocation, ...closestLocations];
    });
    
    _updateRouteVisualization();
  }

  /// Update route visualization with polylines
  void _updateRouteVisualization() {
    if (!_pmPlanningMode || _selectedRouteLocations.isEmpty) {
      setState(() {
        _routePolylines = {};
      });
      _updateMapMarkers();
      return;
    }
    
    final startPoint = _startingPoints[_selectedStartingPoint]!;
    final List<google_maps.LatLng> routePoints = [startPoint];
    
    // Add all route locations
    for (final location in _selectedRouteLocations) {
      if (location.latitude != null && location.longitude != null) {
        routePoints.add(google_maps.LatLng(location.latitude!, location.longitude!));
      }
    }
    
    setState(() {
      _routePolylines = {
        google_maps.Polyline(
          polylineId: const google_maps.PolylineId('pm_route'),
          points: routePoints,
          color: ThemeProvider.fscBlue,
          width: 4,
          patterns: [google_maps.PatternItem.dash(20), google_maps.PatternItem.gap(10)],
        ),
      };
    });
    
    _updateMapMarkers();
  }

  /// Update map markers based on PM mode
  void _updateMapMarkers() {
    final isDark = Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    
    if (!_pmPlanningMode) {
      // Standard view: all locations with normal markers
      setState(() {
        _allMarkers = _allLocations
            .where((loc) => loc.latitude != null && loc.longitude != null)
            .map((location) {
          return google_maps.Marker(
            markerId: google_maps.MarkerId(location.id),
            position: google_maps.LatLng(location.latitude!, location.longitude!),
            icon: _getMarkerIcon(location),
            infoWindow: google_maps.InfoWindow(
              title: location.branchName,
              snippet: location.clientName,
            ),
            onTap: () {
              _showProfessionalInfoCard(context, location, isDark);
            },
          );
        }).toSet();
      });
      return;
    }
    
    // PM Planning Mode: highlight route locations, grey out others
    setState(() {
      _allMarkers = _allLocations
          .where((loc) => loc.latitude != null && loc.longitude != null)
          .map((location) {
        final isInRoute = _selectedRouteLocations.any((l) => l.id == location.id);
        
        return google_maps.Marker(
          markerId: google_maps.MarkerId(location.id),
          position: google_maps.LatLng(location.latitude!, location.longitude!),
          icon: isInRoute
              ? google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueViolet) // Purple for route
              : google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueOrange), // Orange for others
          infoWindow: google_maps.InfoWindow(
            title: location.branchName,
            snippet: isInRoute ? 'In Route' : 'Not Selected',
          ),
        );
      }).toSet();
      
      // Add starting point marker
      final startPoint = _startingPoints[_selectedStartingPoint]!;
      _allMarkers.add(
        google_maps.Marker(
          markerId: const google_maps.MarkerId('start_point'),
          position: startPoint,
          icon: google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueGreen),
          infoWindow: const google_maps.InfoWindow(
            title: 'Starting Point',
            snippet: 'Route Origin',
          ),
        ),
      );
    });
  }

  /// Get marker icon based on pinColor or status
  google_maps.BitmapDescriptor _getMarkerIcon(Location location) {
    // Use pinColor if available (professional color coding)
    if (location.pinColor != null) {
      switch (location.pinColor!.toLowerCase()) {
        case 'red':
          return google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueRed);
        case 'blue':
          return google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueBlue);
        case 'yellow':
          return google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueOrange); // Orange is closest to yellow
        default:
          break;
      }
    }
    
    // Fallback to status-based colors
    switch (location.status ?? 'green') {
      case 'maintenance_req':
      case 'red':
        return google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueRed);
      case 'operational':
      case 'green':
      default:
        return google_maps.BitmapDescriptor.defaultMarkerWithHue(google_maps.BitmapDescriptor.hueBlue);
    }
  }

  /// Get color for flutter_map markers
  Color _getMarkerColor(Location location) {
    // Use pinColor if available (professional color coding)
    if (location.pinColor != null) {
      switch (location.pinColor!.toLowerCase()) {
        case 'red':
          return Colors.red;
        case 'blue':
          return Colors.blue;
        case 'yellow':
          return Colors.orange; // Orange is closest to yellow in Flutter
        default:
          break;
      }
    }
    
    // Fallback to status-based colors
    return _getStatusColor(location.status ?? 'green');
  }

  void _togglePMMode(bool value) {
    setState(() {
      _pmPlanningMode = value;
      if (value) {
        _calculatePMRoute();
      } else {
        _selectedRouteLocations = [];
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
                if (_pmPlanningMode && _selectedRouteLocations.isNotEmpty) ...[
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
                          '${_selectedRouteLocations.length} Stops',
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
          
          // Map or List View (platform-aware)
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
                              onPressed: _loadLocations,
                              child: const Text('Retry'),
                            ),
                            if (_allLocations.isEmpty) ...[
                              const SizedBox(height: 16),
                              Text(
                                'No locations in database.\nImport data first.',
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ],
                        ),
                      )
                    : _buildMapOrListView(isDark),
          ),
        ],
      ),
    );
  }

  /// Sync locations from API to local database
  Future<void> _syncLocationsFromAPI() async {
    setState(() {
      _isSyncing = true;
      _syncMessage = 'Connecting to API...';
    });

    try {
      // Create ApiService instance (not in Provider, so instantiate directly)
      final apiService = ApiService();
      final importService = DataImportService(_dbService!, apiService);
      
      setState(() {
        _syncMessage = 'Importing locations...';
      });
      
      await importService.importLocationsFromAPI();
      
      setState(() {
        _syncMessage = 'Importing clients...';
      });
      
      await importService.importClientsFromAPI();
      
      // Reload locations after sync
      await _loadLocations();
      
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Sync complete!';
      });
      
      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported ${_allLocations.length} locations'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      
      // Clear sync message after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _syncMessage = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Sync failed: $e';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sync failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  /// Import Jefferson Bank locations
  Future<void> _importJeffersonBank() async {
    if (_dbService == null || !_dbService!.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database not initialized'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSyncing = true;
      _syncMessage = 'Importing Jefferson Bank locations...';
    });

    try {
      final importer = JeffersonBankImport(_dbService!);
      await importer.importAllLocations();
      
      // Reload locations after import
      await _loadLocations();
      
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import complete!';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported 15 Jefferson Bank locations'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      
      // Clear sync message after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _syncMessage = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import failed: $e';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  /// Import Prosperity Bank locations from text data
  Future<void> _importProsperityBank() async {
    if (_dbService == null || !_dbService!.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database not initialized'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSyncing = true;
      _syncMessage = 'Importing Prosperity Bank locations...';
    });

    try {
      final importer = ProsperityBankImport(_dbService!);
      await importer.importAllLocations();
      
      // Reload locations after import
      await _loadLocations();
      
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import complete!';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Successfully imported Prosperity Bank locations'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import failed: $e';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }


  /// Import RBFCU locations
  Future<void> _importRBFCU() async {
    if (_dbService == null || !_dbService!.isInitialized) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Database not initialized'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isSyncing = true;
      _syncMessage = 'Importing RBFCU locations...';
    });

    try {
      final importer = RBFCUImport(_dbService!);
      await importer.importAllLocations();
      
      // Reload locations after import
      await _loadLocations();
      
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import complete!';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Successfully imported 29 RBFCU locations'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }
      
      // Clear sync message after 2 seconds
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            _syncMessage = null;
          });
        }
      });
    } catch (e) {
      setState(() {
        _isSyncing = false;
        _syncMessage = 'Import failed: $e';
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  /// Build map or list view based on platform
  Widget _buildMapOrListView(bool isDark) {
    // Check if running on Windows/Web (where Google Maps doesn't work)
    final bool isWindows = !kIsWeb && Platform.isWindows;
    final bool isWeb = kIsWeb;
    
    if (isWindows || isWeb) {
      // Windows/Web: Show offline map with OpenStreetMap tiles
      return _buildOfflineMap(isDark);
    } else {
      // Mobile (Android/iOS): Show Google Map
      // Note: This code path only runs on mobile, so google_maps types are available
      return _buildGoogleMap();
    }
  }

  /// Build Google Map widget (mobile only)
  Widget _buildGoogleMap() {
    // This method only runs on mobile platforms where google_maps_flutter is available
    // We'll use dynamic typing to avoid compile errors on Windows
    try {
      // Use the stub on Windows (will never execute on mobile)
      return google_maps.GoogleMap(
        initialCameraPosition: _initialPosition,
        onMapCreated: (controller) {
          _mapController = controller;
        },
        markers: _allMarkers,
        polylines: _routePolylines,
        myLocationEnabled: true,
        trafficEnabled: true,
        mapType: google_maps.MapType.normal,
      );
    } catch (e) {
      // Fallback if google_maps not available
      return const Center(
        child: Text('Google Maps not available on this platform'),
      );
    }
  }

  /// Build offline map using flutter_map (Windows/Web)
  Widget _buildOfflineMap(bool isDark) {
    if (_allLocations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.mapPin,
              size: 64,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No locations found',
              style: TextStyle(
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Click "Sync from API" to import locations',
              style: TextStyle(
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _syncLocationsFromAPI,
                  icon: _isSyncing
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(LucideIcons.refreshCw),
                  label: Text(_isSyncing ? 'Syncing...' : 'Sync from API'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeProvider.fscBlue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _importJeffersonBank,
                  icon: const Icon(LucideIcons.building),
                  label: const Text('Import Jefferson Bank'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _importRBFCU,
                  icon: const Icon(LucideIcons.building2),
                  label: const Text('Import RBFCU'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _isSyncing ? null : _importProsperityBank,
                  icon: const Icon(LucideIcons.fileSpreadsheet),
                  label: const Text('Import Prosperity Bank'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    // Convert Google Maps markers to flutter_map markers
    final flutterMapMarkers = _allLocations
        .where((loc) => loc.latitude != null && loc.longitude != null)
        .map((location) {
      final isInRoute = _pmPlanningMode && 
          _selectedRouteLocations.any((l) => l.id == location.id);
      
      return Marker(
        point: latlng.LatLng(location.latitude!, location.longitude!),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () {
            _showLocationDetails(context, location, isDark);
          },
          child: Container(
            decoration: BoxDecoration(
              color: isInRoute
                  ? Colors.purple
                  : _getStatusColor(location.status ?? 'green'),
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              LucideIcons.mapPin,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }).toList();

    // Add starting point marker if in PM mode
    if (_pmPlanningMode) {
      final startPoint = _startingPoints[_selectedStartingPoint]!;
      flutterMapMarkers.add(
        Marker(
          point: latlng.LatLng(startPoint.latitude, startPoint.longitude),
          width: 40,
          height: 40,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(
              Icons.flag,
              color: Colors.white,
              size: 20,
            ),
          ),
        ),
      );
    }

    // Convert route polylines
    final flutterMapPolylines = <Polyline>[];
    if (_pmPlanningMode && _selectedRouteLocations.isNotEmpty) {
      final startPoint = _startingPoints[_selectedStartingPoint]!;
      final routePoints = <latlng.LatLng>[
        latlng.LatLng(startPoint.latitude, startPoint.longitude),
      ];
      
      for (final location in _selectedRouteLocations) {
        if (location.latitude != null && location.longitude != null) {
          routePoints.add(latlng.LatLng(location.latitude!, location.longitude!));
        }
      }
      
      flutterMapPolylines.add(
        Polyline(
          points: routePoints,
          strokeWidth: 4,
          color: ThemeProvider.fscBlue,
          borderStrokeWidth: 2,
          borderColor: Colors.white,
        ),
      );
    }

    return FlutterMap(
      mapController: _flutterMapController,
      options: MapOptions(
        initialCenter: _flutterMapInitialPosition,
        initialZoom: 10.0,
        minZoom: 5.0,
        maxZoom: 18.0,
      ),
      children: [
        // OpenStreetMap tiles (works offline with caching)
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.vyrevaultstudios.fsc_portal',
          maxZoom: 19,
          // Note: For true offline support, you'd need to cache tiles
          // This can be done with flutter_map_cache or similar
        ),
        // Polylines (routes)
        if (flutterMapPolylines.isNotEmpty)
          PolylineLayer(
            polylines: flutterMapPolylines,
          ),
        // Markers
        MarkerLayer(
          markers: flutterMapMarkers,
        ),
      ],
    );
  }

  /// Build list view for Windows/Web platforms
  Widget _buildLocationListView(bool isDark) {
    if (_allLocations.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.mapPin,
              size: 64,
              color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
            ),
            const SizedBox(height: 16),
            Text(
              'No locations found',
              style: TextStyle(
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Import location data to get started',
              style: TextStyle(
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    // Filter locations based on PM mode
    final locationsToShow = _pmPlanningMode && _selectedRouteLocations.isNotEmpty
        ? _selectedRouteLocations
        : _allLocations;

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: locationsToShow.length,
      itemBuilder: (context, index) {
        final location = locationsToShow[index];
        final isInRoute = _pmPlanningMode && 
            _selectedRouteLocations.any((l) => l.id == location.id);
        
        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          color: isDark ? ThemeProvider.darkSidebar : Colors.white,
          elevation: isInRoute ? 4 : 1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isInRoute
                  ? ThemeProvider.fscBlue
                  : (isDark ? ThemeProvider.darkBorder : ThemeProvider.lightBorder),
              width: isInRoute ? 2 : 1,
            ),
          ),
          child: InkWell(
            onTap: () {
              // Show location details
              _showLocationDetails(context, location, isDark);
            },
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Status indicator
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _getStatusColor(location.status ?? 'green'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  
                  // Location info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                location.branchName,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                                ),
                              ),
                            ),
                            if (isInRoute)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: ThemeProvider.fscBlue.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  'IN ROUTE',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: ThemeProvider.fscBlue,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location.clientName,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark 
                                ? ThemeProvider.darkTextSecondary 
                                : ThemeProvider.lightTextSecondary,
                          ),
                        ),
                        if (location.addressLine1.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                LucideIcons.mapPin,
                                size: 12,
                                color: isDark 
                                    ? ThemeProvider.darkTextSecondary 
                                    : ThemeProvider.lightTextSecondary,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  '${location.addressLine1}, ${location.city}, ${location.state} ${location.zip}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark 
                                        ? ThemeProvider.darkTextSecondary 
                                        : ThemeProvider.lightTextSecondary,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                        if (location.latitude != null && location.longitude != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            '📍 ${location.latitude!.toStringAsFixed(4)}, ${location.longitude!.toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 11,
                              color: isDark 
                                  ? ThemeProvider.darkTextSecondary 
                                  : ThemeProvider.lightTextSecondary,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  
                  // Action icon
                  Icon(
                    LucideIcons.chevronRight,
                    size: 20,
                    color: isDark 
                        ? ThemeProvider.darkTextSecondary 
                        : ThemeProvider.lightTextSecondary,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'maintenance_req':
      case 'red':
        return Colors.red;
      case 'operational':
      case 'green':
      default:
        return Colors.green;
    }
  }

  /// Show professional info card (bottom sheet)
  void _showProfessionalInfoCard(BuildContext context, Location location, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? ThemeProvider.darkSidebar : Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Header with brand color indicator
            Row(
              children: [
                Container(
                  width: 4,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _getMarkerColor(location),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        location.branchName,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location.clientName,
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                ),
              ],
            ),
            const SizedBox(height: 24),
            
            // Address Section
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  LucideIcons.mapPin,
                  size: 20,
                  color: ThemeProvider.fscBlue,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        location.addressFull ?? 
                        '${location.addressLine1}, ${location.city}, ${location.state} ${location.zip}',
                        style: TextStyle(
                          fontSize: 16,
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Operating Hours Section (Professional Detail)
            if (location.operatingHours != null) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 20,
                    color: ThemeProvider.fscBlue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Today's Hours",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location.operatingHours!,
                          style: TextStyle(
                            fontSize: 16,
                            color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            
            // Phone Number (if in notes)
            if (location.notes != null && location.notes!.contains('Phone:')) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    LucideIcons.phone,
                    size: 20,
                    color: ThemeProvider.fscBlue,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Phone',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          location.notes!.split('Phone:').last.split('\n').first.trim(),
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeProvider.fscBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    icon: const Icon(LucideIcons.navigation, size: 18),
                    label: const Text('Get Directions'),
                    onPressed: () {
                      _launchMaps(location);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeProvider.fscBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Launch maps app with location
  Future<void> _launchMaps(Location location) async {
    final address = location.addressFull ?? 
        '${location.addressLine1}, ${location.city}, ${location.state} ${location.zip}';
    final encodedAddress = Uri.encodeComponent(address);
    
    // Try Google Maps first, then fallback to generic maps URL
    final googleMapsUrl = Uri.parse('https://www.google.com/maps/search/?api=1&query=$encodedAddress');
    final appleMapsUrl = Uri.parse('https://maps.apple.com/?q=$encodedAddress');
    
    try {
      // Try Google Maps
      if (await canLaunchUrl(googleMapsUrl)) {
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      } else if (await canLaunchUrl(appleMapsUrl)) {
        await launchUrl(appleMapsUrl, mode: LaunchMode.externalApplication);
      } else {
        // Fallback to web browser
        await launchUrl(googleMapsUrl, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not open maps: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showLocationDetails(BuildContext context, Location location, bool isDark) {
    // Legacy method - redirect to professional card
    _showProfessionalInfoCard(context, location, isDark);
  }

  void _showLocationDetailsOld(BuildContext context, Location location, bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? ThemeProvider.darkSidebar : Colors.white,
        title: Text(
          location.branchName,
          style: TextStyle(
            color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('Client', location.clientName, isDark),
              _buildDetailRow('Address', 
                '${location.addressLine1}\n${location.city}, ${location.state} ${location.zip}',
                isDark),
              if (location.latitude != null && location.longitude != null)
                _buildDetailRow('Coordinates',
                  '${location.latitude!.toStringAsFixed(6)}, ${location.longitude!.toStringAsFixed(6)}',
                  isDark),
              _buildDetailRow('Status', location.status!, isDark),
              if (location.notes != null && location.notes!.isNotEmpty)
                _buildDetailRow('Notes', location.notes!, isDark),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Close',
              style: TextStyle(color: ThemeProvider.fscBlue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark 
                  ? ThemeProvider.darkTextSecondary 
                  : ThemeProvider.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    _flutterMapController?.dispose();
    super.dispose();
  }
}
