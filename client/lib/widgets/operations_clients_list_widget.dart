// Operations Clients List Widget - Portal Integrated
// Uses ApiService instead of direct HTTP calls
// Displays hierarchical view: Client → Locations → Details

import 'package:flutter/material.dart';
import '../services/api_service.dart';

class OperationsClientsListWidget extends StatefulWidget {
  final String? region;
  final String? client;
  final String? status;

  const OperationsClientsListWidget({
    super.key,
    this.region,
    this.client,
    this.status,
  });

  @override
  State<OperationsClientsListWidget> createState() => _OperationsClientsListWidgetState();
}

class _OperationsClientsListWidgetState extends State<OperationsClientsListWidget> {
  final _apiService = ApiService();
  Map<String, dynamic>? _data;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTokenAndFetch();
  }

  Future<void> _loadTokenAndFetch() async {
    await _apiService.loadToken();
    _fetchClientsList();
  }

  Future<void> _fetchClientsList() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _apiService.getOperationsClientsList(
        region: widget.region,
        client: widget.client,
        status: widget.status,
      );

      setState(() {
        _data = data;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = 'Failed to load clients: $e';
        _isLoading = false;
      });
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'green':
        return Colors.green;
      case 'yellow':
        return Colors.orange;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
      case 'cyan':
        return Colors.cyan;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchClientsList,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final clients = _data?['clients'] as List<dynamic>? ?? [];

    if (clients.isEmpty) {
      return const Center(
        child: Text('No clients found', style: TextStyle(fontSize: 16)),
      );
    }

    return RefreshIndicator(
      onRefresh: _fetchClientsList,
      child: ListView.builder(
        itemCount: clients.length,
        itemBuilder: (context, clientIndex) {
          final client = clients[clientIndex];
          return _buildClientCard(client);
        },
      ),
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client) {
    final locations = client['locations'] as List<dynamic>? ?? [];
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: _getStatusColor(client['contract_status'] ?? 'active'),
          child: Text(
            (client['name'] as String? ?? '?').substring(0, 1).toUpperCase(),
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          client['name'] ?? 'Unknown Client',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${locations.length} location${locations.length != 1 ? 's' : ''}',
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: client['contract_status'] != null
            ? Chip(
                label: Text(
                  client['contract_status'],
                  style: const TextStyle(fontSize: 12),
                ),
                backgroundColor: _getStatusColor(client['contract_status']).withOpacity(0.2),
              )
            : null,
        children: locations.map((location) => _buildLocationTile(location)).toList(),
      ),
    );
  }

  Widget _buildLocationTile(Map<String, dynamic> location) {
    final address = location['address'] as Map<String, dynamic>? ?? {};
    final equipment = location['equipment'] as Map<String, dynamic>? ?? {};
    
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      leading: Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: _getStatusColor(location['status'] ?? 'green'),
          shape: BoxShape.circle,
        ),
      ),
      title: Text(
        location['site_name'] ?? 'Unknown Site',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 4),
          Text(
            address['full'] ?? 'No address',
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
          if (equipment['needs_service_flag'] == true) ...[
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                '⚠ ${equipment['needs_service'] ?? 0} equipment needs service',
                style: TextStyle(fontSize: 11, color: Colors.red[700], fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ],
      ),
      trailing: (equipment['total'] as int? ?? 0) > 0
          ? Chip(
              label: Text('${equipment['total']} eq'),
              backgroundColor: Colors.blue[50],
            )
          : null,
      onTap: () => _showLocationDetails(location),
    );
  }

  void _showLocationDetails(Map<String, dynamic> location) {
    final address = location['address'] as Map<String, dynamic>? ?? {};
    final equipment = location['equipment'] as Map<String, dynamic>? ?? {};
    final contact = location['contact'] as Map<String, dynamic>?;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _getStatusColor(location['status'] ?? 'green'),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            location['site_name'] ?? 'Unknown Site',
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      address['full'] ?? 'No address',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    const Divider(height: 32),
                    if (contact != null) ...[
                      _buildDetailSection('Contact', [
                        Text(contact['name'] ?? '', style: const TextStyle(fontWeight: FontWeight.w600)),
                        if (contact['title'] != null) Text(contact['title']!),
                        if (contact['phone'] != null) Text('📞 ${contact['phone']}'),
                        if (contact['email'] != null) Text('✉ ${contact['email']}'),
                      ]),
                    ],
                    _buildDetailSection('Equipment', [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard('Total', '${equipment['total'] ?? 0}', Colors.blue),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: _buildStatCard(
                              'Needs Service',
                              '${equipment['needs_service'] ?? 0}',
                              (equipment['needs_service_flag'] == true) ? Colors.red : Colors.green,
                            ),
                          ),
                        ],
                      ),
                    ]),
                    if (location['operating_hours'] != null)
                      _buildDetailSection('Operating Hours', [
                        Text(location['operating_hours']),
                      ]),
                    if (location['restrictions'] != null)
                      _buildDetailSection('Restrictions', [
                        Text(location['restrictions'], style: TextStyle(color: Colors.orange[700])),
                      ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailSection(String title, List<Widget> content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(height: 8),
          ...content,
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(fontSize: 12, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
