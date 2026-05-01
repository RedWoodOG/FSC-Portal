import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../config/api_config.dart';

class ApiService {
  // Backend API URL - uses ApiConfig to support local and production environments
  static String get baseUrl => ApiConfig.effectiveBaseUrl;
  static String get portalApiPrefix => ApiConfig.portalApiPrefix;
  static String get newBackendUrl => ApiConfig.newBackendUrl;
  
  String? _token;
  
  // Singleton pattern
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;
  ApiService._internal();

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
  }

  Future<void> saveToken(String token) async {
    _token = token;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<void> clearToken() async {
    _token = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  // ============================================
  // AUTHENTICATION
  // ============================================

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/fsc/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      await saveToken(data['access_token']);
      return data;
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<void> logout() async {
    await clearToken();
  }

  // ============================================
  // TECHNICIANS
  // ============================================

  Future<List<dynamic>> getAllTechnicians() async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/technicians'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load technicians');
    }
  }

  // ============================================
  // TICKETS
  // ============================================

  Future<List<dynamic>> getAllTickets() async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/tickets'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load tickets');
    }
  }

  Future<Map<String, dynamic>> createTicket(Map<String, dynamic> ticketData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/fsc/tickets'),
      headers: _getHeaders(),
      body: jsonEncode(ticketData),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create ticket');
    }
  }

  // ============================================
  // INVENTORY
  // ============================================

  Future<List<dynamic>> getAllInventory() async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/inventory'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load inventory');
    }
  }

  Future<List<dynamic>> getLowStockItems() async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/inventory/low-stock'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load low stock items');
    }
  }

  // ============================================
  // FLEET
  // ============================================

  Future<List<dynamic>> getAllVehicles() async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/fleet/vehicles'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  // ============================================
  // LOCATIONS (New Backend - Portal API)
  // ============================================

  /// Get all locations with optional filters
  Future<Map<String, dynamic>> getLocations({
    String? clientId,
    String? status,
    String? search,
    int? page,
    int? pageSize,
  }) async {
    final queryParams = <String, String>{};
    if (clientId != null) queryParams['clientId'] = clientId;
    if (status != null) queryParams['status'] = status;
    if (search != null) queryParams['search'] = search;
    if (page != null) queryParams['page'] = page.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations')
        .replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load locations: ${response.body}');
    }
  }

  /// Get a single location with all related data (equipment, work orders, contacts, etc.)
  Future<Map<String, dynamic>> getLocation(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations/$locationId'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? data;
    } else {
      throw Exception('Failed to load location: ${response.body}');
    }
  }

  /// Get location summary (for map pins and quick views)
  Future<Map<String, dynamic>> getLocationSummary(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations/$locationId/summary'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? data;
    } else {
      throw Exception('Failed to load location summary: ${response.body}');
    }
  }

  /// Get equipment by location
  Future<List<dynamic>> getEquipmentByLocation(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/equipment/by-location/$locationId'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] ?? data) as List<dynamic>;
    } else {
      throw Exception('Failed to load equipment: ${response.body}');
    }
  }

  /// Get work orders by location
  Future<List<dynamic>> getWorkOrdersByLocation(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations/$locationId/work-orders'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] ?? data) as List<dynamic>;
    } else {
      throw Exception('Failed to load work orders: ${response.body}');
    }
  }

  /// Get service history by location
  Future<List<dynamic>> getLocationServiceHistory(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations/$locationId/history'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] ?? data) as List<dynamic>;
    } else {
      throw Exception('Failed to load service history: ${response.body}');
    }
  }

  /// Get contacts/POCs by location
  Future<List<dynamic>> getLocationContacts(String locationId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/locations/$locationId/pocs'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['data'] ?? data) as List<dynamic>;
    } else {
      throw Exception('Failed to load contacts: ${response.body}');
    }
  }

  // ============================================
  // EQUIPMENT (New Backend - Portal API)
  // ============================================

  /// Get all equipment with optional filters
  Future<Map<String, dynamic>> getEquipment({
    String? locationId,
    String? clientId,
    String? status,
    String? equipmentType,
    String? search,
    int? page,
    int? pageSize,
  }) async {
    final queryParams = <String, String>{};
    if (locationId != null) queryParams['locationId'] = locationId;
    if (clientId != null) queryParams['clientId'] = clientId;
    if (status != null) queryParams['status'] = status;
    if (equipmentType != null) queryParams['equipmentType'] = equipmentType;
    if (search != null) queryParams['search'] = search;
    if (page != null) queryParams['page'] = page.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/equipment')
        .replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load equipment: ${response.body}');
    }
  }

  /// Get equipment by ID
  Future<Map<String, dynamic>> getEquipmentById(String equipmentId) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/equipment/$equipmentId'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'] ?? data;
    } else {
      throw Exception('Failed to load equipment: ${response.body}');
    }
  }

  /// Get equipment by serial number (critical for global search)
  Future<Map<String, dynamic>?> getEquipmentBySerial(String serialNumber) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/equipment/by-serial/$serialNumber'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['data'];
    } else if (response.statusCode == 404) {
      return null; // Equipment not found
    } else {
      throw Exception('Failed to load equipment: ${response.body}');
    }
  }

  /// Search equipment (global search by serial, model, etc.)
  Future<Map<String, dynamic>> searchEquipment(String query) async {
    return getEquipment(search: query);
  }

  // ============================================
  // OPERATIONS (New Backend - Portal API)
  // ============================================

  /// Get map data for Operations Map Widget
  /// Returns sites with coordinates optimized for Flutter Map
  Future<Map<String, dynamic>> getOperationsMapData({
    String? region,
    String? client,
  }) async {
    final queryParams = <String, String>{};
    if (region != null) queryParams['region'] = region;
    if (client != null) queryParams['client'] = client;

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/operations/map-data')
        .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load map data: ${response.body}');
    }
  }

  /// Get hierarchical clients list for Operations List View
  /// Returns Client → Locations → Details structure
  Future<Map<String, dynamic>> getOperationsClientsList({
    String? region,
    String? client,
    String? status,
  }) async {
    final queryParams = <String, String>{};
    if (region != null) queryParams['region'] = region;
    if (client != null) queryParams['client'] = client;
    if (status != null) queryParams['status'] = status;

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/operations/clients-list')
        .replace(queryParameters: queryParams.isNotEmpty ? queryParams : null);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load clients list: ${response.body}');
    }
  }

  // ============================================
  // SYNC (Offline-First Support)
  // ============================================

  /// Pull changes from server (cloud to local)
  Future<Map<String, dynamic>> syncPull({
    required DateTime since,
    List<String>? locationIds,
  }) async {
    final queryParams = <String, String>{
      'since': since.toIso8601String(),
    };
    if (locationIds != null && locationIds.isNotEmpty) {
      queryParams['locationIds'] = locationIds.join(',');
    }

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/sync/pull')
        .replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Sync pull failed: ${response.body}');
    }
  }

  /// Push location/contact changes to server (local to cloud)
  Future<Map<String, dynamic>> syncPush({
    List<Map<String, dynamic>>? locations,
    List<Map<String, dynamic>>? contacts,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/sync/push'),
      headers: _getHeaders(),
      body: jsonEncode({
        if (locations != null) 'locations': locations,
        if (contacts != null) 'contacts': contacts,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Sync push failed: ${response.body}');
    }
  }

  /// Push equipment changes to server (local to cloud)
  Future<Map<String, dynamic>> syncPushEquipment({
    required List<Map<String, dynamic>> equipment,
  }) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/sync/equipment/push'),
      headers: _getHeaders(),
      body: jsonEncode({
        'equipment': equipment,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Equipment sync push failed: ${response.body}');
    }
  }

  /// Pull equipment changes from server (cloud to local)
  Future<Map<String, dynamic>> syncPullEquipment({
    required DateTime since,
    List<String>? equipmentIds,
  }) async {
    final queryParams = <String, String>{
      'since': since.toIso8601String(),
    };
    if (equipmentIds != null && equipmentIds.isNotEmpty) {
      queryParams['equipmentIds'] = equipmentIds.join(',');
    }

    final uri = Uri.parse('${ApiConfig.newBackendUrl}$portalApiPrefix/sync/equipment/pull')
        .replace(queryParameters: queryParams);

    final response = await http.get(uri, headers: _getHeaders());

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Equipment sync pull failed: ${response.body}');
    }
  }

  // ============================================
  // EQUIPMENT (Legacy - kept for backward compatibility)
  // ============================================

  @Deprecated('Use getEquipmentByLocation instead')
  Future<List<dynamic>> getEquipmentByTechnician(int techId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/fsc/equipment/by-technician/$techId'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load equipment');
    }
  }

  // Get headers with auth token
  Map<String, String> _getHeaders() {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
  }

  // Generic GET request
  Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: _getHeaders(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('GET request failed: ${response.body}');
    }
  }

  // Generic POST request
  Future<dynamic> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: _getHeaders(),
      body: jsonEncode(data),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('POST request failed: ${response.body}');
    }
  }
}
