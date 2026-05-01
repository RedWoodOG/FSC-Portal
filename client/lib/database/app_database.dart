// Local SQLite Database for Portal
// Offline-first architecture using Drift

import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'app_database.g.dart';

// ============================================
// Tables
// ============================================

class Clients extends Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1, max: 255)();
  TextColumn get mainContact => text().nullable()();
  TextColumn get contractStatus => text().nullable()();
  TextColumn get themeColor => text().nullable()(); // Color for map markers (blue, red, yellow)
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Locations extends Table {
  TextColumn get id => text()();
  TextColumn get clientId => text()();
  TextColumn get clientName => text()();
  TextColumn get branchName => text()();
  
  // Address
  TextColumn get addressLine1 => text()();
  TextColumn get addressLine2 => text().nullable()();
  TextColumn get city => text()();
  TextColumn get state => text()();
  TextColumn get zip => text()();
  TextColumn get addressFull => text().nullable()();
  
  // Coordinates
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get googlePlaceId => text().nullable()();
  TextColumn get regionId => text().nullable()();
  
  // Metadata
  TextColumn get operatingHours => text().nullable()();
  TextColumn get restrictions => text().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get timezone => text().nullable()();
  TextColumn get pinColor => text().nullable()(); // Color code for map markers (red, blue, yellow, etc.)
  
  // Status
  TextColumn get status => text().withDefault(const Constant('green'))();
  DateTimeColumn get lastVisitDate => dateTime().nullable()();
  DateTimeColumn get nextPMDate => dateTime().nullable()();
  
  // Timestamps
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

class Equipment extends Table {
  TextColumn get id => text()();
  TextColumn get serialNumber => text().unique()();
  TextColumn get model => text()();
  TextColumn get equipmentType => text()();
  TextColumn get status => text().withDefault(const Constant('operational'))();
  
  TextColumn get locationId => text()();
  TextColumn get clientId => text()();
  TextColumn get branchId => text().nullable()();
  
  DateTimeColumn get installDate => dateTime().nullable()();
  DateTimeColumn get lastServiceDate => dateTime().nullable()();
  DateTimeColumn get nextServiceDate => dateTime().nullable()();
  
  TextColumn get notes => text().nullable()();
  TextColumn get warrantyInfo => text().nullable()();
  TextColumn get vendor => text().nullable()();
  TextColumn get purchaseOrderId => text().nullable()();
  TextColumn get assetTag => text().nullable()();
  
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

// Sites table for the Offline Showcase (simplified structure)
class Sites extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get clientId => text()(); // References Clients.id (Text)
  TextColumn get branchName => text()();
  TextColumn get address => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
  TextColumn get lobbyHours => text().nullable()();
  TextColumn get region => text().withDefault(const Constant('South_Texas'))();
}

// Starting Points table for PM Routing
class StartingPoints extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get latitude => real()();
  RealColumn get longitude => real()();
}

// ============================================
// Database
// ============================================

@DriftDatabase(tables: [Clients, Locations, Equipment, Sites, StartingPoints])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 4;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onUpgrade: (migrator, from, to) async {
      if (from < 4) {
        // Schema version 3 → 4: Change Sites.clientId from IntColumn to TextColumn
        // Since we're changing column type, drop and recreate the table
        await migrator.deleteTable('sites');
        await migrator.createTable(sites);
      }
    },
  );

  // ============================================
  // Client Queries
  // ============================================

  Future<List<Client>> getAllClients() => select(clients).get();
  
  Future<Client?> getClientById(String id) => 
    (select(clients)..where((c) => c.id.equals(id))).getSingleOrNull();
  
  Future<int> insertClient(Insertable<Client> client) => into(clients).insert(client);
  
  Future<bool> updateClient(Insertable<Client> client) => 
    update(clients).replace(client);
  
  Future<int> deleteClient(String id) => 
    (delete(clients)..where((c) => c.id.equals(id))).go();

  // ============================================
  // Location Queries
  // ============================================

  Future<List<Location>> getAllLocations() => select(locations).get();
  
  Future<List<Location>> getLocationsWithCoordinates() => 
    (select(locations)
      ..where((l) => l.latitude.isNotNull() & l.longitude.isNotNull()))
    .get();
  
  Future<List<Location>> getLocationsByClient(String clientId) => 
    (select(locations)..where((l) => l.clientId.equals(clientId))).get();
  
  Future<List<Location>> getLocationsByRegion(String regionId) => 
    (select(locations)..where((l) => l.regionId.equals(regionId))).get();
  
  Future<Location?> getLocationById(String id) => 
    (select(locations)..where((l) => l.id.equals(id))).getSingleOrNull();
  
  Future<int> insertLocation(Insertable<Location> location) => into(locations).insert(location);
  
  Future<bool> updateLocation(Insertable<Location> location) => 
    update(locations).replace(location);
  
  Future<int> deleteLocation(String id) => 
    (delete(locations)..where((l) => l.id.equals(id))).go();
  
  // Bulk insert for initial data load
  Future<void> insertLocationsBulk(List<Insertable<Location>> locationsList) async {
    await batch((batch) {
      batch.insertAll(locations, locationsList);
    });
  }

  // ============================================
  // Equipment Queries
  // ============================================

  Future<List<EquipmentData>> getEquipmentByLocation(String locationId) => 
    (select(equipment)..where((e) => e.locationId.equals(locationId))).get();
  
  Future<List<EquipmentData>> getEquipmentNeedingService() => 
    (select(equipment)
      ..where((e) => e.status.isIn(['needs-service', 'degraded'])))
    .get();
  
  Future<int> insertEquipment(Insertable<EquipmentData> eq) => into(equipment).insert(eq);
  
  Future<bool> updateEquipment(Insertable<EquipmentData> eq) => 
    update(equipment).replace(eq);

  // ============================================
  // PM Routing Queries
  // ============================================

  Future<List<Location>> getLocationsForPMRouting() => 
    (select(locations)
      ..where((l) => l.latitude.isNotNull() & l.longitude.isNotNull())
      ..orderBy([(l) => OrderingTerm.asc(l.clientName)]))
    .get();

  // ============================================
  // Sites Queries (for Offline Showcase)
  // ============================================

  Future<List<Site>> getAllSites() => select(sites).get();
  
  Future<List<Site>> getSitesByClient(String clientId) => 
    (select(sites)..where((s) => s.clientId.equals(clientId))).get();
  
  Future<int> insertSite(Insertable<Site> site) => into(sites).insert(site);
  
  Future<void> insertSitesBulk(List<Insertable<Site>> sitesList) async {
    await batch((batch) {
      batch.insertAll(sites, sitesList);
    });
  }

  // ============================================
  // Starting Points Queries
  // ============================================

  Future<List<StartingPoint>> getAllStartingPoints() => select(startingPoints).get();
  
  Future<int> insertStartingPoint(Insertable<StartingPoint> point) => 
    into(startingPoints).insert(point);
  
  Future<void> insertStartingPointsBulk(List<Insertable<StartingPoint>> pointsList) async {
    await batch((batch) {
      batch.insertAll(startingPoints, pointsList);
    });
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'portal.db'));
    return NativeDatabase(file);
  });
}
