// Prosperity Bank Location Import Script
// Imports all Prosperity Bank locations into local database

import 'package:drift/drift.dart';
import '../database/database_service.dart';
import '../database/app_database.dart';

class ProsperityBankImport {
  final DatabaseService _dbService;

  ProsperityBankImport(this._dbService);

  /// Import all Prosperity Bank locations
  Future<void> importAllLocations() async {
    final clientId = 'prosperity_bank';
    final clientName = 'Prosperity Bank';

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

  /// Get all Prosperity Bank locations data
  List<LocationsCompanion> _getLocationsData(String clientId, String clientName) {
    return [
      // Location 1: Mathis
      _createLocation(
        id: 'prosperity_highway_mathis',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '103 N Highway 359',
        city: 'Mathis',
        state: 'TX',
        zip: '78368',
        phone: '(361) 547-3336',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 2: Alice
      _createLocation(
        id: 'prosperity_main_alice',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1200 E. Main',
        city: 'Alice',
        state: 'TX',
        zip: '78332',
        phone: '(361) 664-5446',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 3: Corpus Christi
      _createLocation(
        id: 'prosperity_northwest_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '14201 Northwest Blvd.',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78410',
        phone: '(361) 387-5235',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 4: Corpus Christi
      _createLocation(
        id: 'prosperity_leopard_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '11113 Leopard Street',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78410',
        phone: '(361) 241-6817',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 5: Sinton
      _createLocation(
        id: 'prosperity_sinton_sinton',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1127 E Sinton Street',
        city: 'Sinton',
        state: 'TX',
        zip: '78387',
        phone: '(361) 364-1261',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 6: Beeville
      _createLocation(
        id: 'prosperity_washington_beeville',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '100 S Washington',
        city: 'Beeville',
        state: 'TX',
        zip: '78102',
        phone: '(361) 358-3612',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 7: Kingsville
      _createLocation(
        id: 'prosperity_brahma_kingsville',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1830 S Brahma Blvd',
        city: 'Kingsville',
        state: 'TX',
        zip: '78363',
        phone: '(361) 592-2636',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 8: Taft
      _createLocation(
        id: 'prosperity_green_taft',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '421 Green Ave.',
        city: 'Taft',
        state: 'TX',
        zip: '78390',
        phone: '(361) 528-2566',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 9: Corpus Christi
      _createLocation(
        id: 'prosperity_water_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '921 N Water Street',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78401',
        phone: '(361) 887-8771',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 10: Corpus Christi
      _createLocation(
        id: 'prosperity_saratoga_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4002 Saratoga Blvd',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78413',
        phone: '(361) 854-0728',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 11: Corpus Christi
      _createLocation(
        id: 'prosperity_staples_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4115 S Staples St',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78411',
        phone: '(361) 814-2935',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 12: Portland
      _createLocation(
        id: 'prosperity_highway_portland',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1840 Highway 181 South',
        city: 'Portland',
        state: 'TX',
        zip: '78374',
        phone: '(361) 643-2565',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 13: Corpus Christi
      _createLocation(
        id: 'prosperity_staples_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '6670 S. Staples St.',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78413',
        phone: '(361) 986-7800',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 14: Aransas Pass
      _createLocation(
        id: 'prosperity_wheeler_aransas_pass_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '700 W Wheeler Ave',
        city: 'Aransas Pass',
        state: 'TX',
        zip: '78336',
        phone: '(800) 531-1401',
        notes: 'ATM Only',
      ),

      // Location 15: Aransas Pass
      _createLocation(
        id: 'prosperity_commercial_aransas_pass',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1005 S. Commercial Street',
        city: 'Aransas Pass',
        state: 'TX',
        zip: '78336',
        phone: '(361) 758-5624',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 16: Corpus Christi (Ste 100)
      _createLocation(
        id: 'prosperity_padre_corpus_christi',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '15201 S Padre Island Dr',
        addressLine2: 'Ste 100',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '78418',
        phone: '(361) 949-1846',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 17: Rockport
      _createLocation(
        id: 'prosperity_highway_rockport',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1505 Highway 35 North',
        city: 'Rockport',
        state: 'TX',
        zip: '78382',
        phone: '(361) 729-7411',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 18: Goliad
      _createLocation(
        id: 'prosperity_pearl_goliad',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '109 East Pearl St',
        city: 'Goliad',
        state: 'TX',
        zip: '77963',
        phone: '(361) 645-3246',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 9:00 AM Monday',
      ),

      // Location 19: Pleasanton
      _createLocation(
        id: 'prosperity_oaklawn_pleasanton',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1112 West Oaklawn Dr',
        city: 'Pleasanton',
        state: 'TX',
        zip: '78064',
        phone: '(830) 569-5561',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 20: Yorktown
      _createLocation(
        id: 'prosperity_main_yorktown',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '150 E Main',
        city: 'Yorktown',
        state: 'TX',
        zip: '78164',
        phone: '(361) 564-2291',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 21: Kingsland
      _createLocation(
        id: 'prosperity_rr_kingsland',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1801 West RR 1431',
        city: 'Kingsland',
        state: 'TX',
        zip: '78639',
        phone: '(325) 388-4551',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 9:00 AM Monday',
      ),

      // Location 22: Cuero
      _createLocation(
        id: 'prosperity_church_cuero',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '105 W Church Street',
        city: 'Cuero',
        state: 'TX',
        zip: '77954',
        phone: '(361) 275-2374',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 23: Austin
      _createLocation(
        id: 'prosperity_research_austin',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '11545 Research Boulevard',
        city: 'Austin',
        state: 'TX',
        zip: '78759',
        phone: '(512) 331-5402',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 24: Cedar Park
      _createLocation(
        id: 'prosperity_whitestone_cedar_park',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '650 E Whitestone Blvd',
        city: 'Cedar Park',
        state: 'TX',
        zip: '78613',
        phone: '(512) 260-9199',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 25: Yoakum
      _createLocation(
        id: 'prosperity_lott_yoakum',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '601 Lott Street',
        city: 'Yoakum',
        state: 'TX',
        zip: '77995',
        phone: '(361) 293-5221',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 26: Bastrop
      _createLocation(
        id: 'prosperity_highway_bastrop',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '499 Highway 71 West',
        city: 'Bastrop',
        state: 'TX',
        zip: '78602',
        phone: '(512) 308-9957',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 27: Flatonia
      _createLocation(
        id: 'prosperity_main_flatonia',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '204 East South Main',
        city: 'Flatonia',
        state: 'TX',
        zip: '78941',
        phone: '(361) 865-2953',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 28: Flatonia
      _createLocation(
        id: 'prosperity_la_flatonia_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '619 N La Grange',
        city: 'Flatonia',
        state: 'TX',
        zip: '78941',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 29: Liberty Hill
      _createLocation(
        id: 'prosperity_bronco_liberty_hill',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 Bronco Blvd',
        city: 'Liberty Hill',
        state: 'TX',
        zip: '78642',
        phone: '(512) 778-5355',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 30: Round Rock
      _createLocation(
        id: 'prosperity_palm_round_rock',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '3434 East Palm Valley Blvd',
        city: 'Round Rock',
        state: 'TX',
        zip: '78665',
        phone: '(512) 248-0101',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 31: Smithville
      _createLocation(
        id: 'prosperity_main_smithville',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '406 Main Street',
        city: 'Smithville',
        state: 'TX',
        zip: '78957',
        phone: '(512) 237-9649',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 32: Elgin
      _createLocation(
        id: 'prosperity_roy_elgin',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '106 Roy Rivers Rd',
        city: 'Elgin',
        state: 'TX',
        zip: '78621',
        phone: '(512) 285-3777',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 33: Elgin
      _createLocation(
        id: 'prosperity_main_elgin',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '31 North Main Street',
        city: 'Elgin',
        state: 'TX',
        zip: '78621',
        phone: '(512) 285-3311',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday',
      ),

      // Location 34: Georgetown
      _createLocation(
        id: 'prosperity_williams_georgetown',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '3011 Williams Dr.',
        city: 'Georgetown',
        state: 'TX',
        zip: '78628',
        phone: '(512) 869-4160',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 35: Hallettsville
      _createLocation(
        id: 'prosperity_la_hallettsville',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '109 S. La Grange',
        city: 'Hallettsville',
        state: 'TX',
        zip: '77964',
        phone: '(361) 798-4357',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Location 36: Victoria
      _createLocation(
        id: 'prosperity_zac_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '10410 Zac Lentz Parkway',
        city: 'Victoria',
        state: 'TX',
        zip: '77904',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 37: Victoria
      _createLocation(
        id: 'prosperity_navarro_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '8811 N. Navarro',
        city: 'Victoria',
        state: 'TX',
        zip: '77904',
        phone: '(361) 788-2700',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 38: Schulenburg
      _createLocation(
        id: 'prosperity_bucek_schulenburg',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '301 Bucek St',
        city: 'Schulenburg',
        state: 'TX',
        zip: '78956',
        phone: '(979) 743-2500',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:45 AM Monday',
      ),

      // Location 39: Victoria
      _createLocation(
        id: 'prosperity_zac_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '7001 NE Zac Lentz Pkwy.',
        city: 'Victoria',
        state: 'TX',
        zip: '77904',
        phone: '(361) 573-1993',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 40: Victoria (Suite 100)
      _createLocation(
        id: 'prosperity_navarro_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '5606 N. Navarro',
        addressLine2: 'Suite 100',
        city: 'Victoria',
        state: 'TX',
        zip: '77904',
        phone: '(361) 574-3279',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 41: Victoria
      _createLocation(
        id: 'prosperity_navarro_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '4303 N Navarro St',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 42: Victoria
      _createLocation(
        id: 'prosperity_bridge_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 S. Bridge St.',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(361) 573-6321',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 43: Victoria
      _createLocation(
        id: 'prosperity_main_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 S. Main St.',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(361) 573-6321',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday',
      ),

      // Location 44: Victoria
      _createLocation(
        id: 'prosperity_san_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '506 E San Antonio',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 45: Victoria
      _createLocation(
        id: 'prosperity_laurent_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '2500 N Laurent',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 46: Victoria
      _createLocation(
        id: 'prosperity_houston_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '1903 Houston Hwy',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 47: Victoria
      _createLocation(
        id: 'prosperity_hospital_victoria_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '2701 Hospital Dr',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 48: Victoria
      _createLocation(
        id: 'prosperity_john_victoria',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1206 N. John Stockbauer Dr.',
        city: 'Victoria',
        state: 'TX',
        zip: '77901',
        phone: '(361) 573-1088',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:30 AM Monday',
      ),

      // Location 49: La Grange
      _createLocation(
        id: 'prosperity_travis_la_grange_atm',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank - ATM',
        addressLine1: '519 W Travis St',
        city: 'La Grange',
        state: 'TX',
        zip: '78945',
        phone: '(800) 531-1401',
        operatingHours: 'Lobby: Open 24 Hours',
        notes: 'ATM Only',
      ),

      // Location 50: La Grange
      _createLocation(
        id: 'prosperity_colorado_la_grange',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '202 W Colorado',
        city: 'La Grange',
        state: 'TX',
        zip: '78945',
        phone: '(979) 968-8451',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 7:45 AM Monday',
      ),

      // Location 51: Weimar
      _createLocation(
        id: 'prosperity_center_weimar',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '201 North Center St',
        city: 'Weimar',
        state: 'TX',
        zip: '78962',
        phone: '(979) 725-9401',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:30 AM Monday',
      ),

      // Location 52: Thorndale
      _createLocation(
        id: 'prosperity_main_thorndale',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '108 South Main Street',
        city: 'Thorndale',
        state: 'TX',
        zip: '76577',
        phone: '(512) 898-2503',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday',
      ),

      // Location 53: Lexington
      _createLocation(
        id: 'prosperity_hwy_lexington',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '8909 North Hwy 77',
        city: 'Lexington',
        state: 'TX',
        zip: '78947',
        phone: '(979) 773-4417',
        operatingHours: 'Lobby: Closed\nOpens at 9:00 AM Monday Drive-Thru: Closed\nOpens at 8:00 AM Monday',
      ),

      // Additional locations from TSV data
      // Location 54: Weimar (from TSV)
      _createLocation(
        id: 'prosperity_center_weimar_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '201 N CENTER STREET',
        city: 'Weimar',
        state: 'TX',
        zip: '',
      ),

      // Location 55: Victoria (from TSV)
      _createLocation(
        id: 'prosperity_navarro_victoria_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '8811 NORTH NAVARRO',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 56: Victoria Suite 100 (from TSV)
      _createLocation(
        id: 'prosperity_navarro_victoria_suite_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '5606 N NAVARRO',
        addressLine2: 'STE 100',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 57: Victoria Bridge (from TSV)
      _createLocation(
        id: 'prosperity_bridge_victoria_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 S. BRIDGE ST',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 58: Victoria Main (from TSV)
      _createLocation(
        id: 'prosperity_main_victoria_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 S. MAIN STREET',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 59: Victoria IT Department (from TSV)
      _createLocation(
        id: 'prosperity_main_victoria_it_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 SOUTH MAIN ST',
        city: 'Victoria',
        state: 'TX',
        zip: '',
        phone: '(361) 572-6598',
        notes: 'Contact: William "Bill" Clark (Bill.clark@prosperitybankusa.com) - Remote Location',
      ),

      // Location 60: Victoria Zac Lentz (from TSV)
      _createLocation(
        id: 'prosperity_zac_victoria_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '7001 NE ZAC LENTZ PARKWAY',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 61: Victoria Colony Creek (from TSV)
      _createLocation(
        id: 'prosperity_john_victoria_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1206 N JOHN STOCKBAUER DR.',
        city: 'Victoria',
        state: 'TX',
        zip: '',
      ),

      // Location 62: The Colony (from TSV)
      _createLocation(
        id: 'prosperity_main_the_colony_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4400 MAIN STREET',
        city: 'The Colony',
        state: 'TX',
        zip: '',
      ),

      // Location 63: Taft (from TSV)
      _createLocation(
        id: 'prosperity_green_taft_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '421 GREEN AVENUE',
        city: 'Taft',
        state: 'TX',
        zip: '',
      ),

      // Location 64: Smithville (from TSV)
      _createLocation(
        id: 'prosperity_main_smithville_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '406 MAIN STREET',
        city: 'Smithville',
        state: 'TX',
        zip: '',
      ),

      // Location 65: Slaton (from TSV)
      _createLocation(
        id: 'prosperity_division_slaton_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1800 W DIVISION STREET',
        city: 'Slaton',
        state: 'TX',
        zip: '',
      ),

      // Location 66: Sinton (from TSV)
      _createLocation(
        id: 'prosperity_sinton_sinton_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1127 E SINTON STREET',
        city: 'Sinton',
        state: 'TX',
        zip: '',
      ),

      // Location 67: Seguin (from TSV)
      _createLocation(
        id: 'prosperity_court_seguin_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1414 E COURT STREET',
        city: 'Seguin',
        state: 'TX',
        zip: '',
      ),

      // Location 68: San Antonio (from TSV)
      _createLocation(
        id: 'prosperity_hwy_san_antonio_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '14402 US HWY 281 NORTH',
        city: 'San Antonio',
        state: 'TX',
        zip: '',
      ),

      // Location 69: San Angelo (from TSV)
      _createLocation(
        id: 'prosperity_college_san_angelo_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4109 COLLEGE HILLS BLVD',
        city: 'San Angelo',
        state: 'TX',
        zip: '',
      ),

      // Location 70: Rockport (from TSV)
      _createLocation(
        id: 'prosperity_highway_rockport_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1505 HIGHWAY 35 NORTH',
        city: 'Rockport',
        state: 'TX',
        zip: '',
      ),

      // Location 71: Portland (from TSV)
      _createLocation(
        id: 'prosperity_highway_portland_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1840 HIGHWAY 181 SOUTH',
        city: 'Portland',
        state: 'TX',
        zip: '',
      ),

      // Location 72: Port Lavaca (from TSV)
      _createLocation(
        id: 'prosperity_highway_port_lavaca_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1107 N HIGHWAY 35',
        city: 'Port Lavaca',
        state: 'TX',
        zip: '',
      ),

      // Location 73: Pleasanton (from TSV)
      _createLocation(
        id: 'prosperity_oaklawn_pleasanton_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1112 W OAKLAWN ROAD',
        city: 'Pleasanton',
        state: 'TX',
        zip: '',
      ),

      // Location 74: New Braunfels (from TSV)
      _createLocation(
        id: 'prosperity_hwy_new_braunfels_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1911 HWY 46 WEST',
        city: 'New Braunfels',
        state: 'TX',
        zip: '',
        notes: 'Contact: Elieen Mares',
      ),

      // Location 75: New Braunfels Gruene (from TSV)
      _createLocation(
        id: 'prosperity_common_new_braunfels_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '2610 EAST COMMON STREET',
        city: 'New Braunfels',
        state: 'TX',
        zip: '',
      ),

      // Location 76: Marble Falls (from TSV)
      _createLocation(
        id: 'prosperity_fm_marble_falls_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'FIRST CAPITAL BANK of TEXAS - MARBLE FALLS #283',
        addressLine1: '507 W. FM 2147',
        city: 'Marble Falls',
        state: 'TX',
        zip: '',
        phone: '830-798-6900',
      ),

      // Location 77: Liberty Hill (from TSV)
      _createLocation(
        id: 'prosperity_bronco_liberty_hill_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '101 BRONCO BLVD.',
        city: 'Liberty Hill',
        state: 'TX',
        zip: '',
      ),

      // Location 78: La Grange (from TSV)
      _createLocation(
        id: 'prosperity_colorado_la_grange_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '202 W COLORADO STREET',
        city: 'La Grange',
        state: 'TX',
        zip: '',
      ),

      // Location 79: Jacksonville (from TSV)
      _createLocation(
        id: 'prosperity_neches_jacksonville_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '203 NECHES ST',
        city: 'Jacksonville',
        state: 'TX',
        zip: '',
      ),

      // Location 80: Horseshoe Bay (from TSV)
      _createLocation(
        id: 'prosperity_fm_horseshoe_bay_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'FIRST CAPITAL BANK of TEXAS - HORSESHOE BAY #282',
        addressLine1: '9891 FM 2147',
        city: 'Horseshoe Bay',
        state: 'TX',
        zip: '',
        phone: '830-613-3609',
      ),

      // Location 81: Hallettsville (from TSV)
      _createLocation(
        id: 'prosperity_la_hallettsville_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '109 S. LA GRANGE',
        city: 'Hallettsville',
        state: 'TX',
        zip: '',
      ),

      // Location 82: Gonzales (from TSV)
      _createLocation(
        id: 'prosperity_saint_gonzales_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '508 SAINT LOUIS',
        city: 'Gonzales',
        state: 'TX',
        zip: '',
      ),

      // Location 83: Georgetown (from TSV)
      _createLocation(
        id: 'prosperity_williams_georgetown_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '3011 WILLIAMS DRIVE',
        city: 'Georgetown',
        state: 'TX',
        zip: '',
      ),

      // Location 84: Flatonia (from TSV)
      _createLocation(
        id: 'prosperity_main_flatonia_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '204 E SOUTH MAIN',
        city: 'Flatonia',
        state: 'TX',
        zip: '',
        phone: '361-865-2953',
        notes: 'Contact: Liz Miller (liz.miller@2prosperitybankusa.com)',
      ),

      // Location 85: Elgin Roy Rivers (from TSV)
      _createLocation(
        id: 'prosperity_roy_elgin_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '106 ROY RIVERS RD.',
        city: 'Elgin',
        state: 'TX',
        zip: '',
      ),

      // Location 86: Elgin Main (from TSV)
      _createLocation(
        id: 'prosperity_main_elgin_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '31 NORTH MAIN ST',
        city: 'Elgin',
        state: 'TX',
        zip: '',
      ),

      // Location 87: El Campo (from TSV)
      _createLocation(
        id: 'prosperity_mechanic_el_campo_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '1301 N MECHANIC ST',
        city: 'El Campo',
        state: 'TX',
        zip: '',
      ),

      // Location 88: Corpus Christi Northwest (from TSV)
      _createLocation(
        id: 'prosperity_leopard_corpus_christi_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '11113 LEOPARD ST',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 89: Corpus Christi Carmel (from TSV)
      _createLocation(
        id: 'prosperity_staples_corpus_christi_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4115 S. STAPLES ST.',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 90: Corpus Christi Padre Island (from TSV)
      _createLocation(
        id: 'prosperity_padre_corpus_christi_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '15201 S. PADRE ISLAND',
        addressLine2: 'SUITE 10',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 91: Corpus Christi Timbergate (from TSV)
      _createLocation(
        id: 'prosperity_staples_corpus_christi_timbergate_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '6670 SOUTH STAPLES ST',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 92: Corpus Christi Water Street (from TSV)
      _createLocation(
        id: 'prosperity_water_corpus_christi_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '921 NORTH WATER ST.',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 93: Corpus Christi Saratoga (from TSV)
      _createLocation(
        id: 'prosperity_saratoga_corpus_christi_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '4002 SARATOGA BLVD.',
        city: 'Corpus Christi',
        state: 'TX',
        zip: '',
      ),

      // Location 94: Beeville (from TSV)
      _createLocation(
        id: 'prosperity_washington_beeville_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '100 S WASHINGTON STREET',
        city: 'Beeville',
        state: 'TX',
        zip: '',
      ),

      // Location 95: Bastrop (from TSV)
      _createLocation(
        id: 'prosperity_hwy_bastrop_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '499 HWY 71 WEST',
        city: 'Bastrop',
        state: 'TX',
        zip: '',
      ),

      // Location 96: Austin Oak Hill (from TSV)
      _createLocation(
        id: 'prosperity_hwy_austin_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '7001 US HWY 290 WEST',
        city: 'Austin',
        state: 'TX',
        zip: '',
      ),

      // Location 97: Austin Northland (from TSV)
      _createLocation(
        id: 'prosperity_northland_austin_tsv',
        clientId: clientId,
        clientName: clientName,
        branchName: 'Prosperity Bank',
        addressLine1: '3301 NORTHLAND DRIVE',
        city: 'Austin',
        state: 'TX',
        zip: '',
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
    final notesParts = <String>[];
    if (phone != null && phone.isNotEmpty) {
      notesParts.add('Phone: $phone');
    }
    if (notes != null && notes.isNotEmpty) {
      notesParts.add(notes);
    }
    final finalNotes = notesParts.isNotEmpty ? notesParts.join('\n') : null;

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
      notes: Value(finalNotes),
      pinColor: const Value('red'), // Prosperity Bank = Red
      status: const Value('green'),
      latitude: const Value.absent(),
      longitude: const Value.absent(),
    );
  }
}
