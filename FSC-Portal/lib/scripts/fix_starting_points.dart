import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../util/log.dart';

/// Quick script to fix starting point coordinates in existing database
/// Run this once to update coordinates without resetting the database
/// 
/// Usage: Call this function once after app startup (or create a one-time migration)
Future<void> fixStartingPointCoordinates(AppDatabase db) async {
  Log.info('Fixing starting point coordinates...');
  
  try {
    // Get all starting points
    final points = await db.getAllStartingPoints();
    
    // Update Joseph's House
    final josephsHouse = points.firstWhere(
      (p) => p.name == "Joseph's House",
      orElse: () => throw Exception("Joseph's House starting point not found"),
    );
    
    await (db.update(db.startingPoints)
      ..where((tbl) => tbl.id.equals(josephsHouse.id))
    ).write(StartingPointsCompanion(
      latitude: const Value(29.4188531),  // 1731 Aspen Silver, San Antonio TX 78245
      longitude: const Value(-98.6832171),
    ));
    Log.info('✓ Updated Joseph\'s House: 29.4188531, -98.6832171');
    
    // Update Office (Shop)
    final office = points.firstWhere(
      (p) => p.name.toLowerCase() == 'office',
      orElse: () => throw Exception('Office starting point not found'),
    );
    
    await (db.update(db.startingPoints)
      ..where((tbl) => tbl.id.equals(office.id))
    ).write(StartingPointsCompanion(
      latitude: const Value(29.5206537),  // 8816 Tradeway, San Antonio TX 78217 Suite 116
      longitude: const Value(-98.4582949),
    ));
    Log.info('✓ Updated Office (Shop): 29.5206537, -98.4582949');
    
    Log.info('Starting point coordinates fixed successfully!');
  } catch (e) {
    Log.error('Error fixing coordinates', e);
    rethrow;
  }
}
