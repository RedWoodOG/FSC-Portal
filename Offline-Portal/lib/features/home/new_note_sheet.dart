import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';

class NewNoteSheet extends StatefulWidget {
  const NewNoteSheet({super.key});

  @override
  State<NewNoteSheet> createState() => _NewNoteSheetState();
}

class _NewNoteSheetState extends State<NewNoteSheet> {
  final _formKey = GlobalKey<FormState>();
  final _noteController = TextEditingController();
  String _selectedNoteType = 'general';
  int? _selectedSiteId;
  int? _selectedWorkOrderId;
  List<Site> _sites = [];
  List<WorkOrder> _workOrders = [];

  @override
  void initState() {
    super.initState();
    _loadSitesAndWorkOrders();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _loadSitesAndWorkOrders() async {
    final db = context.read<AppDatabase>();
    final sites = await db.getAllSites();
    final workOrders = await db.getAllWorkOrders();
    
    if (mounted) {
      setState(() {
        _sites = sites;
        _workOrders = workOrders.where((wo) => wo.status == 'open').toList();
        // Default to first site if available
        if (_sites.isNotEmpty && _selectedSiteId == null) {
          _selectedSiteId = _sites.first.id;
        }
      });
    }
  }

  Future<void> _saveNote() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedSiteId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a site'), backgroundColor: Colors.red),
      );
      return;
    }

    final db = context.read<AppDatabase>();
    final user = await db.getUserById(1); // Current user

    try {
      await db.into(db.notes).insert(
        NotesCompanion.insert(
          siteId: _selectedSiteId!,
          workOrderId: drift.Value(_selectedWorkOrderId),
          noteType: _selectedNoteType,
          noteText: _noteController.text.trim(),
          createdAt: DateTime.now(),
          createdBy: drift.Value(user?.fullName ?? 'System'),
        ),
      );

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Note saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving note: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        expand: false,
        builder: (context, scrollController) {
          return Column(
            children: [
              // Handle bar
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(Icons.note_add, color: AppColors.primary, size: 24),
                    const SizedBox(width: 12),
                    const Text(
                      'New Note',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, color: AppColors.textSecondary),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(color: AppColors.border, height: 1),
              // Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    controller: scrollController,
                    padding: const EdgeInsets.all(20),
                    children: [
                      // Note Type
                      const Text(
                        'Note Type',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      SegmentedButton<String>(
                        segments: const [
                          ButtonSegment(value: 'general', label: Text('General')),
                          ButtonSegment(value: 'poi', label: Text('POI')),
                          ButtonSegment(value: 'warning', label: Text('Warning')),
                        ],
                        selected: {_selectedNoteType},
                        onSelectionChanged: (Set<String> newSelection) {
                          setState(() {
                            _selectedNoteType = newSelection.first;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      // Site Selection
                      const Text(
                        'Site *',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedSiteId,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                        ),
                        dropdownColor: AppColors.surface,
                        style: const TextStyle(color: AppColors.textPrimary),
                        items: _sites.map((site) {
                          return DropdownMenuItem(
                            value: site.id,
                            child: Text(site.branchName),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSiteId = value;
                            // Clear work order if site changes
                            _selectedWorkOrderId = null;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      // Work Order Selection (Optional)
                      const Text(
                        'Work Order (Optional)',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<int>(
                        initialValue: _selectedWorkOrderId,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          hintText: 'None',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        dropdownColor: AppColors.surface,
                        style: const TextStyle(color: AppColors.textPrimary),
                        items: [
                          const DropdownMenuItem<int>(
                            value: null,
                            child: Text('None'),
                          ),
                          ..._workOrders.map((wo) {
                            return DropdownMenuItem(
                              value: wo.id,
                              child: Text('WO-${wo.id}: ${wo.descriptionOfWork ?? "No description"}'),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedWorkOrderId = value;
                          });
                        },
                      ),
                      const SizedBox(height: 24),
                      // Note Text
                      const Text(
                        'Note Text *',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _noteController,
                        maxLines: 6,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          hintText: 'Enter your note...',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        style: const TextStyle(color: AppColors.textPrimary),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter note text';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 32),
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveNote,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Save Note',
                            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
