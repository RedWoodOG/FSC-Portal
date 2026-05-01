import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/api_service.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _apiService = ApiService();
  List<dynamic> _locations = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      await _apiService.loadToken();
      final response = await _apiService.getLocations();
      setState(() {
        _locations = response['data'] ?? [];
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load locations: $e';
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'red':
        return Colors.red;
      case 'yellow':
        return Colors.orange;
      case 'blue':
        return Colors.blue;
      case 'cyan':
        return Colors.cyan;
      case 'green':
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(_errorMessage!, textAlign: TextAlign.center),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadLocations,
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Locations',
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${_locations.length} locations',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: _loadLocations,
                            tooltip: 'Refresh',
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: _locations.isEmpty
                          ? Center(
                              child: Text(
                                'No locations found',
                                style: TextStyle(
                                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                                ),
                              ),
                            )
                          : ListView.builder(
                              padding: const EdgeInsets.symmetric(horizontal: 32),
                              itemCount: _locations.length,
                              itemBuilder: (context, index) {
                                final location = _locations[index];
                                final status = location['status'] ?? 'green';
                                return Card(
                                  margin: const EdgeInsets.only(bottom: 16),
                                  child: ListTile(
                                    leading: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: _getStatusColor(status),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    title: Text(
                                      location['branchName'] ?? 'Unknown',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 4),
                                        Text(location['clientName'] ?? ''),
                                        const SizedBox(height: 2),
                                        Text(
                                          location['address'] ?? '',
                                          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                        ),
                                        if (location['equipmentCount'] != null) ...[
                                          const SizedBox(height: 4),
                                          Text(
                                            '${location['equipmentCount']} equipment',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                        ],
                                      ],
                                    ),
                                    trailing: Text(
                                      status.toUpperCase(),
                                      style: TextStyle(
                                        color: _getStatusColor(status),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 11,
                                      ),
                                    ),
                                    onTap: () {
                                      // TODO: Navigate to Location Details screen
                                      // Navigator.push(context, MaterialPageRoute(
                                      //   builder: (context) => LocationDetailsScreen(locationId: location['id']),
                                      // ));
                                    },
                                  ),
                                );
                              },
                            ),
                    ),
                  ],
                ),
    );
  }
}
