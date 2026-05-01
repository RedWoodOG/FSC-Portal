// Starting Points for PM Routing
// These are the 3 hardcoded starting locations for route optimization

import 'package:latlong2/latlong.dart' as latlng;

class StartingPoint {
  final String name;
  final String address;
  final latlng.LatLng position;

  StartingPoint({
    required this.name,
    required this.address,
    required this.position,
  });
}

// Starting points for PM routing
// Note: Coordinates are approximate - should be geocoded for exact positions
final List<StartingPoint> kStartingPoints = [
  StartingPoint(
    name: "Joseph's House",
    address: "1731 Aspen Silver, San Antonio, TX 78245",
    position: const latlng.LatLng(29.4241, -98.6936), // Replace with exact geocoded lat/lng
  ),
  StartingPoint(
    name: "Office",
    address: "8816 Tradeway Street, San Antonio, TX 78217",
    position: const latlng.LatLng(29.5312, -98.4321), // Replace with exact geocoded lat/lng
  ),
  StartingPoint(
    name: "Aaron's House",
    address: "308 Leisure Village Dr., New Braunfels, TX 78130",
    position: const latlng.LatLng(29.7030, -98.1245), // Replace with exact geocoded lat/lng
  ),
];
