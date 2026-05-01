// Data Import Service
// Imports data from API or JSON files into local database
// One-time sync or periodic updates

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';
import 'api_service.dart';

class DataImportService {
  final DatabaseService _dbService;
  final ApiService? _apiService;

  DataImportService(this._dbService, [this._apiService]);

  /// Import locations from API (one-time sync)
  Future<void> importLocationsFromAPI() async {
    if (_apiService == null) {
      throw Exception('API Service not available');
    }

    try {
      // Fetch from API
      await _apiService.loadToken();
      final data = await _apiService.getOperationsMapData();
      
      // Convert to local database format
      final locations = (data['sites'] as List).map((site) {
        final position = site['position'] as Map<String, dynamic>;
        final clientName = site['client_name'] as String;
        return LocationsCompanion(
          id: Value(site['id'] as String),
          clientId: Value(_generateClientId(clientName)),
          clientName: Value(clientName),
          branchName: Value(site['site_name'] as String),
          addressLine1: Value(_extractAddressLine1(site['address'] as String?)),
          addressLine2: const Value.absent(),
          city: Value(_extractCity(site['address'] as String?)),
          state: Value(_extractState(site['address'] as String?)),
          zip: Value(_extractZip(site['address'] as String?)),
          addressFull: Value(site['address'] as String?),
          latitude: Value(position['lat'] as double?),
          longitude: Value(position['lng'] as double?),
          googlePlaceId: Value(site['google_place_id'] as String?),
          regionId: Value(site['region_id'] as String?),
          pinColor: Value(_getClientColor(clientName)), // Auto-assign color based on client name
          status: Value(site['status'] as String? ?? 'green'),
        );
      }).toList();

      // Import to local database
      await _dbService.importLocations(locations as List<Insertable<Location>>);
      
      debugPrint('Imported ${locations.length} locations to local database');
    } catch (e) {
      debugPrint('Error importing from API: $e');
      rethrow;
    }
  }

  /// Import from JSON file (for offline setup)
  Future<void> importFromJsonFile(String jsonFilePath) async {
    // TODO: Implement file reading and import
    // This would read a local JSON file and import locations
  }

  /// Import clients from API
  Future<void> importClientsFromAPI() async {
    if (_apiService == null) {
      throw Exception('API Service not available');
    }

    try {
      await _apiService.loadToken();
      final data = await _apiService.getOperationsClientsList();
      
      final clients = (data['clients'] as List).map((clientJson) {
        return ClientsCompanion(
          id: Value(clientJson['id'] as String? ?? _generateClientId(clientJson['name'] as String)),
          name: Value(clientJson['name'] as String),
          mainContact: Value(clientJson['main_contact'] as String?),
          contractStatus: Value(clientJson['contract_status'] as String?),
        );
      }).toList();

      for (final client in clients) {
        try {
          await _dbService.db.insertClient(client);
        } catch (e) {
          debugPrint('Error importing client: $e');
        }
      }
      
      debugPrint('Imported ${clients.length} clients to local database');
    } catch (e) {
      debugPrint('Error importing clients from API: $e');
      rethrow;
    }
  }

  String _generateClientId(String name) {
    // Generate a simple ID from name
    return name.toLowerCase().replaceAll(' ', '_').replaceAll(RegExp(r'[^a-z0-9_]'), '');
  }

  String _extractAddressLine1(String? fullAddress) {
    if (fullAddress == null || fullAddress.isEmpty) return '';
    return fullAddress.split(',').first.trim();
  }

  String _extractCity(String? fullAddress) {
    if (fullAddress == null || fullAddress.isEmpty) return '';
    final parts = fullAddress.split(',');
    return parts.length > 1 ? parts[1].trim() : '';
  }

  String _extractState(String? fullAddress) {
    if (fullAddress == null || fullAddress.isEmpty) return '';
    final parts = fullAddress.split(',');
    if (parts.length > 2) {
      final stateZip = parts[2].trim().split(' ');
      return stateZip.isNotEmpty ? stateZip[0] : '';
    }
    return '';
  }

  String _extractZip(String? fullAddress) {
    if (fullAddress == null || fullAddress.isEmpty) return '';
    final parts = fullAddress.split(',');
    if (parts.length > 2) {
      final stateZip = parts[2].trim().split(' ');
      return stateZip.length > 1 ? stateZip[1] : '';
    }
    return '';
  }

  /// Get color code for client (professional color coding)
  String? _getClientColor(String clientName) {
    final name = clientName.toLowerCase();
    if (name.contains('rbfcu') || name.contains('randolph brooks')) {
      return 'blue';
    } else if (name.contains('jefferson')) {
      return 'yellow';
    } else if (name.contains('prosperity')) {
      return 'red';
    }
    return null; // Default to status-based color
  }
}
