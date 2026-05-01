// Distance Calculator Utilities
// Uses Haversine formula for calculating distances between coordinates

import 'dart:math' as math;
import 'package:latlong2/latlong.dart' as latlng;

/// Calculate distance between two coordinates using Haversine formula
/// Returns distance in miles
double calculateDistance(latlng.LatLng p1, latlng.LatLng p2) {
  const double earthRadiusMiles = 3959.0; // Earth radius in miles
  const double p = math.pi / 180.0; // Convert degrees to radians
  
  final double lat1 = p1.latitude * p;
  final double lat2 = p2.latitude * p;
  final double lon1 = p1.longitude * p;
  final double lon2 = p2.longitude * p;
  
  final double a = 0.5 - 
      math.cos((lat2 - lat1)) / 2 +
      math.cos(lat1) * math.cos(lat2) * (1 - math.cos((lon2 - lon1))) / 2;
  
  return 2 * earthRadiusMiles * math.asin(math.sqrt(a));
}

/// Calculate PM route using "Farthest First" algorithm
/// Returns list of locations: [farthest, ...5 closest neighbors]
List<T> calculatePmRoute<T extends LocationWithCoords>(
  latlng.LatLng start,
  List<T> allLocations,
) {
  if (allLocations.isEmpty) return [];

  // Filter locations with valid coordinates
  final validLocations = allLocations.where((loc) => 
    loc.latitude != null && loc.longitude != null
  ).toList();
  
  if (validLocations.isEmpty) return [];

  // 1. Find Farthest from Start
  validLocations.sort((a, b) {
    final distA = calculateDistance(start, latlng.LatLng(a.latitude!, a.longitude!));
    final distB = calculateDistance(start, latlng.LatLng(b.latitude!, b.longitude!));
    return distB.compareTo(distA); // Descending order (farthest first)
  });
  
  final farthestLocation = validLocations.first;

  // 2. Find neighbors of Farthest Location
  final remaining = validLocations.sublist(1);
  remaining.sort((a, b) {
    final farthestPos = latlng.LatLng(farthestLocation.latitude!, farthestLocation.longitude!);
    final distA = calculateDistance(farthestPos, latlng.LatLng(a.latitude!, a.longitude!));
    final distB = calculateDistance(farthestPos, latlng.LatLng(b.latitude!, b.longitude!));
    return distA.compareTo(distB); // Ascending (closest first)
  });

  // 3. Return Cluster (Farthest + 5 Closest)
  return [farthestLocation, ...remaining.take(5)];
}

/// Interface for locations with coordinates
abstract class LocationWithCoords {
  double? get latitude;
  double? get longitude;
  String get id;
}

/// Helper to make Location from app_database work with distance calculator
class LocationWrapper implements LocationWithCoords {
  final double? _latitude;
  final double? _longitude;
  final String _id;

  LocationWrapper({
    required double? latitude,
    required double? longitude,
    required String id,
  })  : _latitude = latitude,
        _longitude = longitude,
        _id = id;

  @override
  double? get latitude => _latitude;

  @override
  double? get longitude => _longitude;

  @override
  String get id => _id;
}

/// Create LocationWrapper from Location
LocationWrapper wrapLocation(dynamic location) {
  return LocationWrapper(
    latitude: location.latitude,
    longitude: location.longitude,
    id: location.id,
  );
}
