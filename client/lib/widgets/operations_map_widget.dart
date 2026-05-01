// Operations Map Widget - Portal Integrated
// Uses ApiService instead of direct HTTP calls
// Displays operations map with site markers

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';

class OperationsMapWidget extends StatefulWidget {
  final String? region; // Optional region filter (e.g., "South_Texas")
  final String? client; // Optional client filter (e.g., "Prosperity Bank", "RBFCU", "Jefferson Bank")

  const OperationsMapWidget({
    super.key,
    this.region,
    this.client,
  });

  @override
  State<OperationsMapWidget> createState() => _OperationsMapWidgetState();
}

class _OperationsMapWidgetState extends State<OperationsMapWidget> {
  GoogleMapController? _mapController;
  List<SiteMarker> _sites = [];
  bool _isLoading = true;
  String? _error;
  final _apiService = ApiService();

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
      final data = await _apiService.getOperationsMapData(
        region: widget.region,
        client: widget.client,
      );

      setState(() {
        _sites = (data['sites'] as List)
            .map((site) => SiteMarker.fromJson(site))
            .toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load map data: $e';
        _isLoading = false;
      });
    }
  }

  BitmapDescriptor _getMarkerIcon(String status) {
    // Blue for operational, red for maintenance required
    switch (status) {
      case 'maintenance_req':
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
      case 'operational':
      default:
        return BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
    }
  }

  Set<Marker> _buildMarkers() {
    return _sites.map((site) {
      return Marker(
        markerId: MarkerId(site.id),
        position: site.position,
        icon: _getMarkerIcon(site.status),
        infoWindow: InfoWindow(
          title: site.siteName,
          snippet: site.clientName,
        ),
        onTap: () => _showLocationDetails(site),
      );
    }).toSet();
  }

  void _showLocationDetails(SiteMarker site) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              site.siteName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              site.clientName,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 8),
            Text(site.address),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => _navigateToLocation(site),
              icon: const Icon(Icons.navigation),
              label: const Text('Navigate'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _navigateToLocation(SiteMarker site) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=${site.position.latitude},${site.position.longitude}',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
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
      );
    }

    return GoogleMap(
      initialCameraPosition: _initialPosition,
      onMapCreated: (controller) {
        _mapController = controller;
      },
      markers: _buildMarkers(),
      myLocationEnabled: true,
      trafficEnabled: true,
      mapType: MapType.normal,
    );
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }
}

// Data model for site markers
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
