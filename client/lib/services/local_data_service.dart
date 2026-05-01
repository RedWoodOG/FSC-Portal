// Local Data Service
// Handles data import from API/JSON to local database
// For initial sync and offline-first architecture

import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';

class LocalDataService {
  final DatabaseService _dbService;

  LocalDataService(this._dbService);

  /// Import locations from JSON (from API or file)
  Future<void> importLocationsFromJson(List<Map<String, dynamic>> jsonData) async {
    final locations = jsonData.map((json) => _locationFromJson(json)).toList();
    await _dbService.importLocations(locations);
  }

  /// Import clients from JSON
  Future<void> importClientsFromJson(List<Map<String, dynamic>> jsonData) async {
    final clients = jsonData.map((json) => _clientFromJson(json)).toList();
    
    for (final client in clients) {
      try {
        await _dbService.db.insertClient(client);
      } catch (e) {
        debugPrint('Error importing client: $e');
      }
    }
  }

  /// Convert JSON to Location (Drift Companion)
  LocationsCompanion _locationFromJson(Map<String, dynamic> json) {
    return LocationsCompanion(
      id: Value(json['id'] as String),
      clientId: Value(json['client_id'] as String? ?? json['clientId'] as String),
      clientName: Value(json['client_name'] as String? ?? json['clientName'] as String),
      branchName: Value(json['branch_name'] as String? ?? json['branchName'] as String),
      addressLine1: Value(json['address_line_1'] as String? ?? json['addressLine1'] as String),
      addressLine2: Value(json['address_line_2'] as String? ?? json['addressLine2'] as String?),
      city: Value(json['city'] as String),
      state: Value(json['state'] as String),
      zip: Value(json['zip'] as String),
      addressFull: Value(json['address_full'] as String? ?? json['addressFull'] as String?),
      latitude: Value(json['latitude'] != null ? (json['latitude'] as num).toDouble() : null),
      longitude: Value(json['longitude'] != null ? (json['longitude'] as num).toDouble() : null),
      googlePlaceId: Value(json['google_place_id'] as String? ?? json['googlePlaceId'] as String?),
      regionId: Value(json['region_id'] as String? ?? json['regionId'] as String?),
      operatingHours: Value(json['operating_hours'] as String? ?? json['operatingHours'] as String?),
      restrictions: Value(json['restrictions'] as String?),
      notes: Value(json['notes'] as String?),
      timezone: Value(json['timezone'] as String?),
      status: Value(json['status'] as String? ?? 'green'),
      lastVisitDate: Value(json['last_visit_date'] != null 
        ? DateTime.parse(json['last_visit_date'] as String)
        : null),
      nextPMDate: Value(json['next_p_m_date'] != null
        ? DateTime.parse(json['next_p_m_date'] as String)
        : null),
    );
  }

  /// Convert JSON to Client (Drift Companion)
  ClientsCompanion _clientFromJson(Map<String, dynamic> json) {
    return ClientsCompanion(
      id: Value(json['id'] as String),
      name: Value(json['name'] as String),
      mainContact: Value(json['main_contact'] as String? ?? json['mainContact'] as String?),
      contractStatus: Value(json['contract_status'] as String? ?? json['contractStatus'] as String?),
    );
  }

  /// Import from API response format
  Future<void> importFromApiResponse(Map<String, dynamic> apiResponse) async {
    if (apiResponse['sites'] != null) {
      final sites = (apiResponse['sites'] as List)
          .map((site) => _siteToLocationJson(site))
          .toList();
      await importLocationsFromJson(sites);
    }
  }

  /// Convert API site format to location JSON
  Map<String, dynamic> _siteToLocationJson(Map<String, dynamic> site) {
    // Extract position if nested
    final position = site['position'] as Map<String, dynamic>?;
    
    return {
      'id': site['id'] as String,
      'client_name': site['client_name'] as String,
      'branch_name': site['site_name'] as String,
      'client_id': site['client_id'] ?? '', // Generate if needed
      'address_line_1': _extractAddress(site['address'] as String?),
      'city': '',
      'state': '',
      'zip': '',
      'address_full': site['address'] as String?,
      'latitude': position?['lat'] as double?,
      'longitude': position?['lng'] as double?,
      'google_place_id': site['google_place_id'] as String?,
      'region_id': site['region_id'] as String?,
      'status': site['status'] as String? ?? 'green',
    };
  }

  String _extractAddress(String? fullAddress) {
    if (fullAddress == null) return '';
    // Simple extraction - take first line
    return fullAddress.split(',').first.trim();
  }
}
