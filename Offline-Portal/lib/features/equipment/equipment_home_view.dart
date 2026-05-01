import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import 'equipment_card.dart';
import 'equipment_detail_sheet.dart';

class EquipmentHomeView extends StatefulWidget {
  const EquipmentHomeView({super.key});

  @override
  State<EquipmentHomeView> createState() => _EquipmentHomeViewState();
}

class _EquipmentHomeViewState extends State<EquipmentHomeView> {
  String _searchQuery = '';
  String _selectedType = 'All';
  List<String> _equipmentTypes = ['All'];

  @override
  Widget build(BuildContext context) {
    final db = context.watch<AppDatabase>();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: StreamBuilder<List<EquipmentData>>(
          stream: db.watchAllEquipment(),
          builder: (context, snapshot) {
            final count = snapshot.hasData ? snapshot.data!.length : 0;
            return Text('Equipment${count > 0 ? ' ($count items)' : ''}');
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.deepOcean,
        ),
        child: Column(
          children: [
            // Search and Filter Bar
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.surface.withValues(alpha: 0.5),
              child: Column(
                children: [
                  // Search Bar
                  TextField(
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: 'Search by serial number, model, manufacturer...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: AppColors.primary, width: 2),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                  const SizedBox(height: 12),
                  // Equipment Type Filter
                  StreamBuilder<List<String>>(
                    stream: db.watchDistinctEquipmentTypes(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        final types = ['All', ...snapshot.data!];
                        if (types.length != _equipmentTypes.length) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _equipmentTypes = types;
                            });
                          });
                        }
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _equipmentTypes.map((type) {
                            final isSelected = _selectedType == type;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: FilterChip(
                                label: Text(type),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedType = type;
                                  });
                                },
                                selectedColor: AppColors.primary,
                                checkmarkColor: AppColors.textPrimary,
                                labelStyle: TextStyle(
                                  color: isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            // Equipment List
            Expanded(
              child: StreamBuilder<List<EquipmentData>>(
                stream: db.watchAllEquipment(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, size: 64, color: AppColors.error),
                          const SizedBox(height: 16),
                          Text(
                            'Error loading equipment',
                            style: TextStyle(color: AppColors.error),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          Text(
                            'No equipment found',
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  var equipment = snapshot.data!;

                  // Apply type filter
                  if (_selectedType != 'All') {
                    equipment = equipment.where((e) => e.equipmentType == _selectedType).toList();
                  }

                  // Apply search filter
                  if (_searchQuery.isNotEmpty) {
                    equipment = equipment.where((e) {
                      return (e.serialNumber?.toLowerCase().contains(_searchQuery) ?? false) ||
                          (e.model?.toLowerCase().contains(_searchQuery) ?? false) ||
                          (e.manufacturer?.toLowerCase().contains(_searchQuery) ?? false) ||
                          e.equipmentType.toLowerCase().contains(_searchQuery);
                    }).toList();
                  }

                  if (equipment.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 64, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          Text(
                            'No equipment matches your search',
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: equipment.length,
                    itemBuilder: (context, index) {
                      final item = equipment[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: EquipmentCard(
                          equipment: item,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => EquipmentDetailSheet(equipment: item),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
