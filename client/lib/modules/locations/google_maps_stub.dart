// Stub file for Windows - google_maps_flutter doesn't support Windows
// This file provides empty stubs so the code compiles on Windows

import 'package:flutter/material.dart';

class GoogleMapController {
  void dispose() {}
}

class LatLng {
  final double latitude;
  final double longitude;
  const LatLng(this.latitude, this.longitude);
}

class CameraPosition {
  final LatLng target;
  final double zoom;
  const CameraPosition({required this.target, required this.zoom});
}

class Marker {
  final MarkerId markerId;
  final LatLng position;
  final BitmapDescriptor? icon;
  final InfoWindow? infoWindow;
  final VoidCallback? onTap;
  Marker({
    required this.markerId,
    required this.position,
    this.icon,
    this.infoWindow,
    this.onTap,
  });
}

class MarkerId {
  final String value;
  const MarkerId(this.value);
}

class Polyline {
  final PolylineId polylineId;
  final List<LatLng> points;
  final dynamic color; // Can be Color or int
  final int width;
  final List<PatternItem>? patterns;
  const Polyline({
    required this.polylineId,
    required this.points,
    required this.color,
    required this.width,
    this.patterns,
  });
}

class PolylineId {
  final String value;
  const PolylineId(this.value);
}

class InfoWindow {
  final String? title;
  final String? snippet;
  const InfoWindow({this.title, this.snippet});
}

class BitmapDescriptor {
  static const int hueRed = 0;
  static const int hueBlue = 240;
  static const int hueGreen = 120;
  static const int hueViolet = 270;
  static const int hueOrange = 30;
  
  static BitmapDescriptor defaultMarkerWithHue(int hue) {
    return BitmapDescriptor();
  }
}

class PatternItem {
  static PatternItem dash(int length) => PatternItem();
  static PatternItem gap(int length) => PatternItem();
}

enum MapType { normal }

class GoogleMap extends StatelessWidget {
  final CameraPosition initialCameraPosition;
  final Function(GoogleMapController)? onMapCreated;
  final Set<Marker>? markers;
  final Set<Polyline>? polylines;
  final bool myLocationEnabled;
  final bool trafficEnabled;
  final MapType mapType;
  
  const GoogleMap({
    super.key,
    required this.initialCameraPosition,
    this.onMapCreated,
    this.markers,
    this.polylines,
    this.myLocationEnabled = false,
    this.trafficEnabled = false,
    this.mapType = MapType.normal,
  });
  
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Google Maps not supported on Windows'),
    );
  }
}
