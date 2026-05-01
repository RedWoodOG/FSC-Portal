// Database Service - Wrapper for AppDatabase
// Provides easy access to local database throughout the app

import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart';
import 'app_database.dart';

class DatabaseService extends ChangeNotifier {
  late AppDatabase _db;
  bool _initialized = false;

  AppDatabase get db {
    if (!_initialized) {
      throw Exception('Database not initialized. Call initialize() first.');
    }
    return _db;
  }

  bool get isInitialized => _initialized;

  Future<void> initialize() async {
    if (_initialized) return;
    
    _db = AppDatabase();
    _initialized = true;
    notifyListeners();
  }

  // Convenience methods
  Future<List<Location>> getAllLocations() => _db.getAllLocations();
  
  Future<List<Location>> getLocationsWithCoordinates() => 
    _db.getLocationsWithCoordinates();
  
  Future<List<Location>> getLocationsByClient(String clientId) => 
    _db.getLocationsByClient(clientId);
  
  Future<List<Location>> getLocationsByRegion(String regionId) => 
    _db.getLocationsByRegion(regionId);
  
  Future<List<Client>> getAllClients() => _db.getAllClients();
  
  Future<List<EquipmentData>> getEquipmentByLocation(String locationId) => 
    _db.getEquipmentByLocation(locationId);
  
  Future<List<EquipmentData>> getEquipmentNeedingService() => 
    _db.getEquipmentNeedingService();
  
  // PM Routing
  Future<List<Location>> getLocationsForPMRouting() => 
    _db.getLocationsForPMRouting();
  
  // Bulk operations
  Future<void> importLocations(List<Insertable<Location>> locations) async {
    await _db.insertLocationsBulk(locations);
    notifyListeners();
  }

  Future<void> close() async {
    if (_initialized) {
      await _db.close();
      _initialized = false;
    }
  }
}
