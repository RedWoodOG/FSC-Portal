/// Application-wide constants for easy demo customization
class AppConstants {
  // Map Configuration
  static const double defaultMapLat = 29.531;
  static const double defaultMapLng = -98.432;
  static const double defaultMapZoom = 10.0;
  static const double mapMinZoom = 8.0;
  static const double mapMaxZoom = 18.0;

  // Default seed user (used only for initial database population)
  static const String defaultUsername = "jwhite";
  static const String defaultUserFullName = "Joseph White";

  // App Metadata
  static const String appVersion = "1.0.0-alpha";
  static const String appName = "Portal Offline";

  // Routing Configuration
  static const int pmRouteMaxSites = 5;
  static const String pmRouteAlgorithm = 'farthest_first';
}
