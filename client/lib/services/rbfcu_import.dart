// Randolph Brooks Federal Credit Union (RBFCU) Location Import Script
// Imports all 29 RBFCU locations into local database

import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';

class RBFCUImport {
  final DatabaseService _dbService;

  RBFCUImport(this._dbService);

  /// Import all RBFCU locations
  Future<void> importAllLocations() async {
    final clientId = 'rbfcu';
    final clientName = 'Randolph Brooks Federal Credit Union';

    // First, ensure client exists
    await _ensureClientExists(clientId, clientName);

    // Import all locations
    final locations = _getLocationsData(clientId, clientName);
    
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

    print('\n✅ Imported $imported new, updated $updated existing RBFCU locations');
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

  /// Get all RBFCU locations data
  List<LocationsCompanion> _getLocationsData(String clientId, String clientName) {
    return [
      // Location 1: Potranco
      _createLocation(
        id: 'rbfcu_potranco',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Potranco',
        addressLine1: '10581 Potranco Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78251',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 2: Culebra
      _createLocation(
        id: 'rbfcu_culebra',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Culebra',
        addressLine1: '10567 Culebra Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78250',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 3: Leon Valley
      _createLocation(
        id: 'rbfcu_leon_valley',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Leon Valley',
        addressLine1: '6700 Bandera Road',
        city: 'Leon Valley',
        state: 'TX',
        zip: '78238',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 4: Bandera Pointe
      _createLocation(
        id: 'rbfcu_bandera_pointe',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Bandera Pointe',
        addressLine1: '11432 W. Loop 1604 N.',
        city: 'San Antonio',
        state: 'TX',
        zip: '78254',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 5: Summit
      _createLocation(
        id: 'rbfcu_summit',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Summit',
        addressLine1: '6475 Baywater Drive',
        city: 'San Antonio',
        state: 'TX',
        zip: '78229',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: Closed',
      ),
      
      // Location 6: South San
      _createLocation(
        id: 'rbfcu_south_san',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - South San',
        addressLine1: '8159 S. IH-35',
        city: 'San Antonio',
        state: 'TX',
        zip: '78224',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: Closed',
      ),
      
      // Location 7: UTSA
      _createLocation(
        id: 'rbfcu_utsa',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - UTSA',
        addressLine1: '14410 IH-10 W.',
        city: 'San Antonio',
        state: 'TX',
        zip: '78249',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 8: Mission South
      _createLocation(
        id: 'rbfcu_mission_south',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Mission South',
        addressLine1: '201 S.W. Military Drive',
        city: 'San Antonio',
        state: 'TX',
        zip: '78221',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 9: Austin Highway
      _createLocation(
        id: 'rbfcu_austin_highway',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Austin Highway',
        addressLine1: '1032 Austin Highway',
        city: 'San Antonio',
        state: 'TX',
        zip: '78209',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: Closed',
      ),
      
      // Location 10: Broadway
      _createLocation(
        id: 'rbfcu_broadway',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Broadway',
        addressLine1: '8539 Broadway',
        city: 'San Antonio',
        state: 'TX',
        zip: '78217',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 11: Bitters
      _createLocation(
        id: 'rbfcu_bitters',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Bitters',
        addressLine1: '2514 N. Loop 1604 W.',
        city: 'San Antonio',
        state: 'TX',
        zip: '78248',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 12: Brooks
      _createLocation(
        id: 'rbfcu_brooks',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Brooks',
        addressLine1: '3181 Goliad Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78223',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 13: Rigsby
      _createLocation(
        id: 'rbfcu_rigsby',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Rigsby',
        addressLine1: '2202 Semlinger Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78220',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 14: Windcrest
      _createLocation(
        id: 'rbfcu_windcrest',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Windcrest',
        addressLine1: '7720 IH-35 N. Frontage Road',
        city: 'Windcrest',
        state: 'TX',
        zip: '78218',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 15: Gold Canyon
      _createLocation(
        id: 'rbfcu_gold_canyon',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Gold Canyon',
        addressLine1: '2080 N. Loop 1604 E.',
        city: 'San Antonio',
        state: 'TX',
        zip: '78232',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 16: Thousand Oaks
      _createLocation(
        id: 'rbfcu_thousand_oaks',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Thousand Oaks',
        addressLine1: '12307 Nacogdoches Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78217',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 17: Encino Commons
      _createLocation(
        id: 'rbfcu_encino_commons',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Encino Commons',
        addressLine1: '21910 U.S. Highway 281 N.',
        city: 'San Antonio',
        state: 'TX',
        zip: '78258',
        operatingHours: 'Lobby: Closed\nDrive-Thru: Closed',
      ),
      
      // Location 18: Nacogdoches Road (ATM)
      _createLocation(
        id: 'rbfcu_nacogdoches_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Nacogdoches Road (ATM)',
        addressLine1: '13915 Nacogdoches Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78217',
        notes: 'ATM Only',
      ),
      
      // Location 19: Woodlake
      _createLocation(
        id: 'rbfcu_woodlake',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Woodlake',
        addressLine1: '7649 FM 78',
        city: 'San Antonio',
        state: 'TX',
        zip: '78244',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 20: Marshall Road
      _createLocation(
        id: 'rbfcu_marshall_road',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Marshall Road',
        addressLine1: '23737 Bulverde Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78259',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 21: Boerne
      _createLocation(
        id: 'rbfcu_boerne',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Boerne',
        addressLine1: '1338 S. Main St.',
        city: 'Boerne',
        state: 'TX',
        zip: '78006',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 22: Creswell Administrative Service Center
      _createLocation(
        id: 'rbfcu_creswell_asc',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Creswell Administrative Service Center',
        addressLine1: '1 IKEA-RBFCU Parkway',
        city: 'Live Oak',
        state: 'TX',
        zip: '78233',
        notes: 'Administrative Service Center',
      ),
      
      // Location 23: Live Oak (ATM)
      _createLocation(
        id: 'rbfcu_live_oak_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Live Oak (ATM)',
        addressLine1: '8135 Pat Booker Road',
        city: 'Live Oak',
        state: 'TX',
        zip: '78233',
        notes: 'ATM Only',
      ),
      
      // Location 24: Live Oak (Branch)
      _createLocation(
        id: 'rbfcu_live_oak',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Live Oak',
        addressLine1: '12415 Old Converse Road',
        city: 'Live Oak',
        state: 'TX',
        zip: '78233',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 25: Randolph
      _createLocation(
        id: 'rbfcu_randolph',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Randolph',
        addressLine1: '629 Third St. W.',
        city: 'Randolph AFB',
        state: 'TX',
        zip: '78150',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: Closed',
        notes: 'We\'ve moved to a new location on base to better serve you! Visit us at our new location on Third St. next to the Outdoor Exchange.',
      ),
      
      // Location 26: Randolph AFB Commissary (ATM)
      _createLocation(
        id: 'rbfcu_randolph_afb_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Randolph AFB Commissary (ATM)',
        addressLine1: '770 Third St. W., Building 1075',
        city: 'Universal City',
        state: 'TX',
        zip: '78148',
        notes: 'ATM Only',
      ),
      
      // Location 27: Schertz
      _createLocation(
        id: 'rbfcu_schertz',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Schertz',
        addressLine1: '4980 FM 3009',
        city: 'Schertz',
        state: 'TX',
        zip: '78154',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 28: Bulverde Crossing
      _createLocation(
        id: 'rbfcu_bulverde_crossing',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Bulverde Crossing',
        addressLine1: '155 Bulverde Crossing',
        city: 'Bulverde',
        state: 'TX',
        zip: '78163',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
      
      // Location 29: Northcliffe
      _createLocation(
        id: 'rbfcu_northcliffe',
        clientId: clientId,
        clientName: clientName,
        branchName: 'RBFCU - Northcliffe',
        addressLine1: '22015 N. IH-35',
        city: 'Schertz',
        state: 'TX',
        zip: '78154',
        operatingHours: 'Lobby: 9:00 am - 4:00 pm\nDrive-Thru: 9:00 am - 4:00 pm',
      ),
    ];
  }

  /// Create a location companion from data
  LocationsCompanion _createLocation({
    required String id,
    required String clientId,
    required String clientName,
    required String branchName,
    required String addressLine1,
    String? addressLine2,
    required String city,
    required String state,
    required String zip,
    String? phone,
    String? operatingHours,
    String? notes,
  }) {
    // Build full address
    final addressParts = [addressLine1];
    if (addressLine2 != null && addressLine2.isNotEmpty) {
      addressParts.add(addressLine2);
    }
    addressParts.add('$city, $state $zip');
    final addressFull = addressParts.join(', ');

    // Build notes
    final notesText = <String>[];
    if (phone != null) {
      notesText.add('Phone: $phone');
    }
    if (notes != null) {
      notesText.add(notes);
    }
    final combinedNotes = notesText.isNotEmpty ? notesText.join('\n') : null;

    return LocationsCompanion(
      id: Value(id),
      clientId: Value(clientId),
      clientName: Value(clientName),
      branchName: Value(branchName),
      addressLine1: Value(addressLine1),
      addressLine2: Value(addressLine2),
      city: Value(city),
      state: Value(state),
      zip: Value(zip),
      addressFull: Value(addressFull),
      operatingHours: Value(operatingHours),
      notes: Value(combinedNotes),
      pinColor: const Value('blue'), // RBFCU = Blue
      status: const Value('green'), // Default to operational
      // Latitude/longitude will be null - can be geocoded later
      latitude: const Value.absent(),
      longitude: const Value.absent(),
    );
  }
}
