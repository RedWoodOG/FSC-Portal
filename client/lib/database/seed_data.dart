// Seed Data for Offline Showcase
// Pre-loads demo data (Banks, Sites, Starting Points) on first launch

import 'package:drift/drift.dart';
import 'app_database.dart';

/// Seed the database with demo data if it's empty
Future<void> seedDatabase(AppDatabase db) async {
  // Check if clients already exist
  final existingClients = await db.getAllClients();
  if (existingClients.isNotEmpty) {
    print('📦 Database already seeded, skipping...');
    return;
  }

  print('🌱 Seeding database with demo data...');

  // 1. Insert Clients
  await db.insertClient(ClientsCompanion(
    id: Value('rbfcu'),
    name: Value('RBFCU'),
    themeColor: Value('blue'),
    contractStatus: Value('active'),
  ));

  await db.insertClient(ClientsCompanion(
    id: Value('jefferson_bank'),
    name: Value('Jefferson Bank'),
    themeColor: Value('yellow'),
    contractStatus: Value('active'),
  ));

  await db.insertClient(ClientsCompanion(
    id: Value('prosperity_bank'),
    name: Value('Prosperity Bank'),
    themeColor: Value('red'),
    contractStatus: Value('active'),
  ));

  print('✅ Inserted 3 clients');

  // 2. Insert Starting Points
  await db.insertStartingPoint(StartingPointsCompanion(
    name: Value("Joseph's House"),
    latitude: Value(29.418),
    longitude: Value(-98.693),
  ));

  await db.insertStartingPoint(StartingPointsCompanion(
    name: Value('Office'),
    latitude: Value(29.531),
    longitude: Value(-98.432),
  ));

  await db.insertStartingPoint(StartingPointsCompanion(
    name: Value("Aaron's House"),
    latitude: Value(29.703),
    longitude: Value(-98.124),
  ));

  print('✅ Inserted 3 starting points');

  // 3. Insert Sites
  // RBFCU Sites
  await db.insertSite(SitesCompanion(
    clientId: Value('rbfcu'),
    branchName: Value('Bulverde Crossing'),
    address: Value('Bulverde Crossing, San Antonio, TX'),
    latitude: Value(29.682),
    longitude: Value(-98.432),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  await db.insertSite(SitesCompanion(
    clientId: Value('rbfcu'),
    branchName: Value('Stone Oak'),
    address: Value('Stone Oak, San Antonio, TX'),
    latitude: Value(29.645),
    longitude: Value(-98.460),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  // Jefferson Bank Sites
  await db.insertSite(SitesCompanion(
    clientId: Value('jefferson_bank'),
    branchName: Value('Alamo Heights'),
    address: Value('Alamo Heights, San Antonio, TX'),
    latitude: Value(29.480),
    longitude: Value(-98.465),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  await db.insertSite(SitesCompanion(
    clientId: Value('jefferson_bank'),
    branchName: Value('Downtown'),
    address: Value('Downtown, San Antonio, TX'),
    latitude: Value(29.424),
    longitude: Value(-98.493),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  // Prosperity Bank Sites
  await db.insertSite(SitesCompanion(
    clientId: Value('prosperity_bank'),
    branchName: Value('New Braunfels Branch'),
    address: Value('New Braunfels, TX'),
    latitude: Value(29.700),
    longitude: Value(-98.120),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  await db.insertSite(SitesCompanion(
    clientId: Value('prosperity_bank'),
    branchName: Value('Seguin Branch'),
    address: Value('Seguin, TX'),
    latitude: Value(29.560),
    longitude: Value(-97.960),
    lobbyHours: Value('Mon-Fri: 9:00 AM - 5:00 PM'),
  ));

  print('✅ Inserted 6 sites');
  print('🎉 Database seeding complete!');
}
