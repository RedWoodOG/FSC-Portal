// Jefferson Bank Location Import Script
// Imports all 15 Jefferson Bank locations into local database

import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';

class JeffersonBankImport {
  final DatabaseService _dbService;

  JeffersonBankImport(this._dbService);

  /// Import all Jefferson Bank locations
  Future<void> importAllLocations() async {
    final clientId = 'jefferson_bank';
    final clientName = 'Jefferson Bank';

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

    print('\n✅ Imported $imported new, updated $updated existing Jefferson Bank locations');
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

  /// Get all Jefferson Bank locations data
  List<LocationsCompanion> _getLocationsData(String clientId, String clientName) {
    return [
      // Location 1: Alamo Heights
      _createLocation(
        id: 'jefferson_alamo_heights',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Alamo Heights',
        addressLine1: '6021 Broadway',
        city: 'San Antonio',
        state: 'TX',
        zip: '78209',
        phone: '(210) 361-0849',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 2: Bandera Road
      _createLocation(
        id: 'jefferson_bandera_road',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Bandera Road',
        addressLine1: '8826 Bandera Rd',
        city: 'San Antonio',
        state: 'TX',
        zip: '78250',
        phone: '(210) 762-6998',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 3: Blanco Road
      _createLocation(
        id: 'jefferson_blanco_road',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Blanco Road',
        addressLine1: '14614 Blanco Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78216',
        phone: '(210) 742-5421',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 4: Downtown
      _createLocation(
        id: 'jefferson_downtown',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Downtown',
        addressLine1: '711 Navarro Street',
        addressLine2: 'Suite 102',
        city: 'San Antonio',
        state: 'TX',
        zip: '78205',
        phone: '(210) 405-0695',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 5: Fredericksburg Road
      _createLocation(
        id: 'jefferson_fredericksburg_road',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Fredericksburg Road',
        addressLine1: '2900 Fredericksburg Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78201',
        phone: '(210) 794-8135',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 6: Goliad Road
      _createLocation(
        id: 'jefferson_goliad_road',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Goliad Road',
        addressLine1: '1111 Goliad Road',
        city: 'San Antonio',
        state: 'TX',
        zip: '78223',
        phone: '(210) 985-8946',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 7: Northeast
      _createLocation(
        id: 'jefferson_northeast',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Northeast',
        addressLine1: '1777 Northeast Loop 410',
        addressLine2: 'First Floor, Suite 100',
        city: 'San Antonio',
        state: 'TX',
        zip: '78217',
        phone: '(210) 761-5135',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 8: Stone Oak
      _createLocation(
        id: 'jefferson_stone_oak',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Stone Oak',
        addressLine1: '19002 Stone Oak Parkway',
        city: 'San Antonio',
        state: 'TX',
        zip: '78258',
        phone: '(210) 405-6594',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 9: Sunset Ridge
      _createLocation(
        id: 'jefferson_sunset_ridge',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Sunset Ridge',
        addressLine1: '6310 N. New Braunfels Avenue',
        city: 'San Antonio',
        state: 'TX',
        zip: '78209',
        phone: '(210) 934-8649',
        operatingHours: 'Mon - Thu: 9:00 am-11:00 am, 1:00 pm-4:00 pm\nFri: 9:00 am-11:00 am, 1:00 pm-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 10: Pearl District
      _createLocation(
        id: 'jefferson_pearl_district',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Pearl District',
        addressLine1: '1900 Broadway',
        addressLine2: 'Suite 108',
        city: 'San Antonio',
        state: 'TX',
        zip: '78215',
        phone: '(210) 864-5995',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed',
        notes: 'Lobby ATM',
      ),
      
      // Location 11: Quarry Heights
      _createLocation(
        id: 'jefferson_quarry_heights',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Quarry Heights',
        addressLine1: '7373 Broadway, Ste. 401',
        city: 'San Antonio',
        state: 'TX',
        zip: '78209',
        phone: '(210) 736-7500',
        operatingHours: 'Mon - Fri: 9:00 am-3:00 pm\nSat - Sun: Closed',
      ),
      
      // Location 12: Trust & Wealth Management
      _createLocation(
        id: 'jefferson_trust_wealth',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Trust & Wealth Management',
        addressLine1: '1900 Broadway',
        addressLine2: 'Suite 900',
        city: 'San Antonio',
        state: 'TX',
        zip: '78215',
        phone: '(210) 468-1969',
        operatingHours: 'Mon - Fri: 9:00 am-5:00 pm\nSat - Sun: Closed',
      ),
      
      // Location 13: Austin
      _createLocation(
        id: 'jefferson_austin',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Austin',
        addressLine1: '114 W. 7th Street, Suite 100',
        city: 'Austin',
        state: 'TX',
        zip: '78701',
        phone: '(512) 729-5158',
        operatingHours: 'Mon - Fri: 9:00 am-4:00 pm\nSat - Sun: Closed',
      ),
      
      // Location 14: Boerne
      _createLocation(
        id: 'jefferson_boerne',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Boerne',
        addressLine1: '371 N. Main St',
        city: 'Boerne',
        state: 'TX',
        zip: '78006',
        phone: '(830) 251-5526',
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
      ),
      
      // Location 15: New Braunfels
      _createLocation(
        id: 'jefferson_new_braunfels',
        clientId: clientId,
        clientName: clientName,
        branchName: 'New Braunfels',
        addressLine1: '1551 N. Walnut Avenue',
        addressLine2: 'Suite 44',
        city: 'New Braunfels',
        state: 'TX',
        zip: '78130',
        phone: null, // Phone not provided in data
        operatingHours: 'Mon - Thu: 9:00 am-4:00 pm\nFri: 9:00 am-5:00 pm\nSat - Sun: Closed\nMotor Bank: 8:00 am-6:00 pm',
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

    // Build notes with phone if provided
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
      pinColor: const Value('yellow'), // Jefferson Bank = Yellow
      status: const Value('green'), // Default to operational
      // Latitude/longitude will be null - can be geocoded later
      latitude: const Value.absent(),
      longitude: const Value.absent(),
    );
  }
}
