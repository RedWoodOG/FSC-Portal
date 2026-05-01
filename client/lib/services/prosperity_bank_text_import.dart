// Prosperity Bank Text Import Script
// Imports locations from raw text format into local database

import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';
import 'prosperity_bank_locations_data.dart';

class ProsperityBankTextImport {
  final DatabaseService _dbService;

  ProsperityBankTextImport(this._dbService);

  /// Import all Prosperity Bank locations from text
  /// Optionally accepts raw text data to parse
  Future<void> importAllLocations({String? rawTextData}) async {
    final clientId = 'prosperity_bank';
    final clientName = 'Prosperity Bank';

    // First, ensure client exists
    await _ensureClientExists(clientId, clientName);

    // Parse text data - prefer provided text, otherwise use embedded data
    final locations = rawTextData != null && rawTextData.isNotEmpty
        ? parseFromText(rawTextData, clientId, clientName)
        : _parseTextData(clientId, clientName);
    
    if (locations.isEmpty) {
      throw Exception('No locations found in text data');
    }

    int imported = 0;
    int updated = 0;
    
    for (final location in locations) {
      try {
        await _dbService.db.insertLocation(location);
        imported++;
        print('Imported: ${location.branchName.value}');
      } catch (e) {
        // Try update if insert fails (location might already exist)
        try {
          final existing = await _dbService.db.getLocationById(location.id.value);
          if (existing != null) {
            await _dbService.db.updateLocation(location);
            updated++;
            print('Updated: ${location.branchName.value}');
          } else {
            print('Error importing ${location.branchName.value}: $e');
          }
        } catch (updateError) {
          print('Error with ${location.branchName.value}: $e');
        }
      }
    }

    print('\n✅ Imported $imported new, updated $updated existing Prosperity Bank locations');
  }

  /// Ensure client exists in database
  Future<void> _ensureClientExists(String clientId, String clientName) async {
    try {
      final existing = await _dbService.db.getClientById(clientId);
      if (existing == null) {
        await _dbService.db.insertClient(ClientsCompanion(
          id: Value(clientId),
          name: Value(clientName),
          contractStatus: const Value('active'),
        ));
        print('Created client: $clientName');
      }
    } catch (e) {
      print('Error ensuring client exists: $e');
    }
  }

  /// Parse text data into locations
  List<LocationsCompanion> _parseTextData(String clientId, String clientName) {
    // Raw text data - all Prosperity Bank locations
    // This method parses the structured text format provided by the user
    // Since the user provided hundreds of locations, we return empty here
    // and rely on the parseFromText method with rawTextData parameter
    final rawText = _getProsperityBankLocationsText();
    if (rawText.isEmpty) {
      return [];
    }
    return parseFromText(rawText, clientId, clientName);
  }

  /// Get all Prosperity Bank locations text data
  /// This contains all locations provided by the user
  /// NOTE: The user provided HUNDREDS of unique locations in their message
  /// This method should return ALL of them, not just 20 samples
  String _getProsperityBankLocationsText() {
    // Import from the data file which contains all locations
    return ProsperityBankLocationsData.getRawText();
  }

  /// Alternative: Parse from provided text string
  /// This method handles the full text data from the user's message
  List<LocationsCompanion> parseFromText(String rawText, String clientId, String clientName) {
    final locations = <LocationsCompanion>[];
    final lines = rawText.split('\n').map((l) => l.trim()).where((l) => l.isNotEmpty).toList();
    
    int i = 0;
    while (i < lines.length) {
      // Skip number line
      if (RegExp(r'^\d+$').hasMatch(lines[i])) {
        i++;
      }
      
      if (i >= lines.length) break;
      
      // Branch name (may include "- ATM", "- Drive Thru Only", etc.)
      final branchName = lines[i].replaceFirst('Prosperity Bank', '').trim();
      final fullBranchName = lines[i].startsWith('Prosperity Bank') 
          ? lines[i] 
          : 'Prosperity Bank${branchName.isNotEmpty ? ' - $branchName' : ''}';
      i++;
      
      // Skip distance line (e.g., "14.3 mi")
      if (i < lines.length && lines[i].contains('mi')) {
        i++;
      }
      
      if (i >= lines.length) break;
      
      // Address line 1
      final addressLine1 = lines[i];
      i++;
      
      // Check if next line is address line 2 (Suite, Ste, etc.)
      String? addressLine2;
      if (i < lines.length && 
          (lines[i].toLowerCase().contains('suite') || 
           lines[i].toLowerCase().contains('ste') ||
           lines[i].toLowerCase().contains('#') ||
           RegExp(r'^\d+$').hasMatch(lines[i]))) {
        addressLine2 = lines[i];
        i++;
      }
      
      if (i >= lines.length) break;
      
      // City, State ZIP
      final cityStateZip = lines[i];
      final cityStateZipMatch = RegExp(r'^(.+?),\s*([A-Z]{2})\s+(\d{5}(?:-\d{4})?)$').firstMatch(cityStateZip);
      if (cityStateZipMatch == null) {
        i++;
        continue; // Skip invalid entries
      }
      
      final city = cityStateZipMatch.group(1)!.trim();
      final state = cityStateZipMatch.group(2)!.trim();
      final zip = cityStateZipMatch.group(3)!.trim();
      i++;
      
      // Phone
      String? phone;
      if (i < lines.length && RegExp(r'^\(?\d{3}\)?\s*\d{3}[-.]?\d{4}$').hasMatch(lines[i].replaceAll(RegExp(r'[^\d]'), ''))) {
        phone = lines[i];
        i++;
      }
      
      // Hours (Lobby and Drive-Thru)
      String? lobbyHours;
      String? driveThruHours;
      String? operatingHours;
      
      while (i < lines.length && !lines[i].contains('Call Now') && !lines[i].contains('Get Directions')) {
        if (lines[i].startsWith('Lobby:')) {
          lobbyHours = lines[i].replaceFirst('Lobby:', '').trim();
        } else if (lines[i].startsWith('Drive-Thru:')) {
          driveThruHours = lines[i].replaceFirst('Drive-Thru:', '').trim();
        }
        i++;
      }
      
      // Build operating hours string
      if (lobbyHours != null || driveThruHours != null) {
        final hoursParts = <String>[];
        if (lobbyHours != null) {
          hoursParts.add('Lobby: $lobbyHours');
        }
        if (driveThruHours != null) {
          hoursParts.add('Drive-Thru: $driveThruHours');
        }
        operatingHours = hoursParts.join('\n');
      }
      
      // Skip "Call Now" and "Get Directions"
      while (i < lines.length && (lines[i].contains('Call Now') || lines[i].contains('Get Directions'))) {
        i++;
      }
      
      // Generate location ID
      final locationId = 'prosperity_${fullBranchName.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]'), '_').replaceAll(RegExp(r'_+'), '_')}_${city.toLowerCase().replaceAll(' ', '_')}';
      
      // Build full address
      final addressParts = [addressLine1];
      if (addressLine2 != null && addressLine2.isNotEmpty) {
        addressParts.add(addressLine2);
      }
      addressParts.add('$city, $state $zip');
      final addressFull = addressParts.join(', ');
      
      // Build notes
      final notesParts = <String>[];
      if (phone != null && phone.isNotEmpty) {
        notesParts.add('Phone: $phone');
      }
      if (fullBranchName.contains('ATM')) {
        notesParts.add('ATM Only');
      } else if (fullBranchName.contains('Drive Thru Only')) {
        notesParts.add('Drive-Thru Only');
      } else if (fullBranchName.contains('Lobby Only')) {
        notesParts.add('Lobby Only');
      }
      final notes = notesParts.isNotEmpty ? notesParts.join('\n') : null;
      
      locations.add(LocationsCompanion(
        id: Value(locationId),
        clientId: Value(clientId),
        clientName: Value(clientName),
        branchName: Value(fullBranchName),
        addressLine1: Value(addressLine1),
        addressLine2: Value(addressLine2),
        city: Value(city),
        state: Value(state),
        zip: Value(zip),
        addressFull: Value(addressFull),
        operatingHours: Value(operatingHours),
        notes: Value(notes),
        pinColor: const Value('red'), // Prosperity Bank = Red
        status: const Value('green'),
        latitude: const Value.absent(),
        longitude: const Value.absent(),
      ));
    }
    
    return locations;
  }
}
