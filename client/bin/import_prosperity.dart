import 'dart:io';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:fsc_portal/database/app_database.dart';
import 'package:fsc_portal/database/database_service.dart';
import 'package:fsc_portal/services/prosperity_bank_import.dart';

void main() async {
  print('🚀 Starting Prosperity Bank import...\n');
  
  try {
    // Initialize database
    final dbService = DatabaseService();
    await dbService.initialize();
    
    // Run import
    final import = ProsperityBankImport(dbService);
    await import.importAllLocations();
    
    print('\n✅ Import completed successfully!');
    exit(0);
  } catch (e, stackTrace) {
    print('\n❌ Error during import: $e');
    print('Stack trace: $stackTrace');
    exit(1);
  }
}
