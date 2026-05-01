import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

/// Field Readiness Screen
/// 
/// Utility surface for technicians to check parts, tools, and vehicle status.
/// Clicking tiles opens detail views for actionable management.
class ReadinessScreen extends StatefulWidget {
  const ReadinessScreen({super.key});

  @override
  State<ReadinessScreen> createState() => _ReadinessScreenState();
}

class _ReadinessScreenState extends State<ReadinessScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Field Readiness',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Equipment and parts status',
              style: TextStyle(
                fontSize: 14,
                color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
              ),
            ),
            const SizedBox(height: 32),

            // Status Tiles - Equal size, clickable
            Row(
              children: [
                Expanded(
                  child: _ReadinessTile(
                    icon: LucideIcons.package,
                    label: 'Parts Stock',
                    status: '94%',
                    color: ThemeProvider.green,
                    isHealthy: false,
                    onTap: () => _navigateToPartsStock(context, isDark),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ReadinessTile(
                    icon: LucideIcons.wrench,
                    label: 'Tools Ready',
                    status: '100%',
                    color: ThemeProvider.green,
                    isHealthy: true,
                    onTap: () => _navigateToTools(context, isDark),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _ReadinessTile(
                    icon: LucideIcons.car,
                    label: 'Vehicle',
                    status: 'Good',
                    color: ThemeProvider.green,
                    isHealthy: true,
                    onTap: () => _navigateToVehicle(context, isDark),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToPartsStock(BuildContext context, bool isDark) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const PartsStockDetailScreen(),
      ),
    );
  }

  void _navigateToTools(BuildContext context, bool isDark) {
    // TODO: Navigate to tools detail
  }

  void _navigateToVehicle(BuildContext context, bool isDark) {
    // TODO: Navigate to vehicle detail
  }
}

class _ReadinessTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String status;
  final Color color;
  final bool isHealthy;
  final VoidCallback onTap;

  const _ReadinessTile({
    required this.icon,
    required this.label,
    required this.status,
    required this.color,
    required this.isHealthy,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;
    final opacity = isHealthy ? 0.7 : 1.0;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Opacity(
          opacity: opacity,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isDark ? ThemeProvider.darkSidebar : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
                width: 1,
              ),
            ),
            child: Column(
              children: [
                Icon(icon, size: 28, color: color),
                const SizedBox(height: 12),
                Text(
                  status,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 13,
                    color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Parts Stock Detail Screen
/// 
/// Working surface for parts management with restock order template.
class PartsStockDetailScreen extends StatefulWidget {
  const PartsStockDetailScreen({super.key});

  @override
  State<PartsStockDetailScreen> createState() => _PartsStockDetailScreenState();
}

class _PartsStockDetailScreenState extends State<PartsStockDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedReason;
  String? _selectedPriority;

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return Scaffold(
      backgroundColor: isDark ? ThemeProvider.darkBackground : ThemeProvider.lightBackground,
      appBar: AppBar(
        title: const Text('Parts Stock'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Stock List
            Text(
              'Current Stock',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 16),
            _buildStockItem(
              isDark,
              'Commercial Lock Cylinders',
              'Hardware',
              3,
              10,
              false,
            ),
            const SizedBox(height: 12),
            _buildStockItem(
              isDark,
              'ATM Receipt Paper',
              'Supplies',
              45,
              20,
              true,
            ),
            const SizedBox(height: 32),

            // Low Stock Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFF59E0B).withOpacity(isDark ? 0.15 : 0.08),
                borderRadius: BorderRadius.circular(10),
                border: Border(
                  left: BorderSide(
                    color: const Color(0xFFF59E0B),
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        LucideIcons.alertTriangle,
                        color: const Color(0xFFF59E0B),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Low Stock',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _buildStockItem(
                    isDark,
                    'Commercial Lock Cylinders',
                    'Hardware',
                    3,
                    10,
                    false,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Restock Order Form
            Text(
              'Submit Restock Order',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
              ),
            ),
            const SizedBox(height: 16),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Part name or SKU
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Part Name or SKU',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter part name or SKU';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Quantity requested
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Quantity Requested',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter quantity';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Reason dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Reason',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    initialValue: _selectedReason,
                    items: const [
                      DropdownMenuItem(value: 'low_stock', child: Text('Low Stock')),
                      DropdownMenuItem(value: 'upcoming_pm', child: Text('Upcoming PM')),
                      DropdownMenuItem(value: 'emergency', child: Text('Emergency')),
                      DropdownMenuItem(value: 'other', child: Text('Other')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedReason = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a reason';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Job reference (optional)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Job Reference (Optional)',
                      hintText: 'Link to work order',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Priority dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    initialValue: _selectedPriority,
                    items: const [
                      DropdownMenuItem(value: 'normal', child: Text('Normal')),
                      DropdownMenuItem(value: 'urgent', child: Text('Urgent')),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedPriority = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select priority';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Notes (optional)
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Notes (Optional)',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    maxLines: 3,
                  ),
                  const SizedBox(height: 24),

                  // Submit button
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Submit restock request
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Restock request submitted for approval'),
                          ),
                        );
                        Navigator.of(context).pop();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: ThemeProvider.fscBlue,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Submit Restock Request',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStockItem(
    bool isDark,
    String partName,
    String category,
    int quantity,
    int minimum,
    bool isHealthy,
  ) {
    final isLowStock = quantity <= minimum;
    final statusColor = isLowStock ? const Color(0xFFF59E0B) : ThemeProvider.green;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? ThemeProvider.darkSidebar : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isDark ? ThemeProvider.darkBorder : const Color(0xFFE5E7EB),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              LucideIcons.package,
              color: statusColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  partName,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  category,
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$quantity on hand',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? ThemeProvider.darkText : ThemeProvider.lightText,
                ),
              ),
              Text(
                'Min: $minimum',
                style: TextStyle(
                  fontSize: 12,
                  color: isDark ? ThemeProvider.darkTextSecondary : ThemeProvider.lightTextSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(width: 12),
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}
