import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';

class ScanReceiptSheet extends StatefulWidget {
  const ScanReceiptSheet({super.key});

  @override
  State<ScanReceiptSheet> createState() => _ScanReceiptSheetState();
}

class _ScanReceiptSheetState extends State<ScanReceiptSheet> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _vendorController = TextEditingController();
  final _notesController = TextEditingController();
  
  XFile? _selectedImage;
  String? _selectedCategory;
  DateTime? _receiptDate;
  int? _selectedSiteId;
  int? _selectedWorkOrderId;
  List<Site> _sites = [];
  List<WorkOrder> _workOrders = [];

  final List<String> _categories = [
    'Fuel',
    'Meals',
    'Supplies',
    'Tools',
    'Parts',
    'Other',
  ];

  @override
  void initState() {
    super.initState();
    _receiptDate = DateTime.now();
    _loadSitesAndWorkOrders();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _vendorController.dispose();
    _notesController.dispose();
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
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      
      if (image != null && mounted) {
        setState(() {
          _selectedImage = image;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking image: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _saveReceipt() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select or take a photo'), backgroundColor: Colors.red),
      );
      return;
    }

    final db = context.read<AppDatabase>();
    final user = await db.getUserById(1);

    try {
      // Create receipts directory
      final appDir = await getApplicationDocumentsDirectory();
      final receiptsDir = Directory(path.join(appDir.path, 'portal_offline', 'receipts'));
      if (!receiptsDir.existsSync()) {
        receiptsDir.createSync(recursive: true);
      }

      // Generate filename
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final extension = path.extension(_selectedImage!.path);
      final fileName = 'receipt_$timestamp$extension';
      final filePath = path.join(receiptsDir.path, fileName);

      // Copy image to receipts directory
      final imageFile = File(_selectedImage!.path);
      await imageFile.copy(filePath);

      // Save to Documents table
      await db.into(db.documents).insert(
        DocumentsCompanion.insert(
          workOrderId: drift.Value(_selectedWorkOrderId),
          siteId: drift.Value(_selectedSiteId),
          fileName: fileName,
          filePath: filePath,
          uploadedAt: DateTime.now(),
          uploadedBy: drift.Value(user?.fullName ?? 'System'),
        ),
      );

      // Save metadata as note if provided
      if (_amountController.text.isNotEmpty || _vendorController.text.isNotEmpty || _notesController.text.isNotEmpty) {
        final noteText = StringBuffer();
        if (_amountController.text.isNotEmpty) {
          noteText.writeln('Amount: \$${_amountController.text}');
        }
        if (_vendorController.text.isNotEmpty) {
          noteText.writeln('Vendor: ${_vendorController.text}');
        }
        if (_selectedCategory != null) {
          noteText.writeln('Category: $_selectedCategory');
        }
        if (_receiptDate != null) {
          noteText.writeln('Date: ${_receiptDate!.toString().split(' ')[0]}');
        }
        if (_notesController.text.isNotEmpty) {
          noteText.writeln('Notes: ${_notesController.text}');
        }

        if (_selectedSiteId != null) {
          await db.into(db.notes).insert(
            NotesCompanion.insert(
              siteId: _selectedSiteId!,
              workOrderId: drift.Value(_selectedWorkOrderId),
              noteType: 'general',
              noteText: noteText.toString(),
              createdAt: DateTime.now(),
              createdBy: drift.Value(user?.fullName ?? 'System'),
            ),
          );
        }
      }

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Receipt saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving receipt: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _receiptDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    if (picked != null && mounted) {
      setState(() {
        _receiptDate = picked;
      });
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
        initialChildSize: 0.8,
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
                    const Icon(Icons.camera_alt, color: AppColors.primary, size: 24),
                    const SizedBox(width: 12),
                    const Text(
                      'Scan Receipt',
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
                      // Image Picker
                      const Text(
                        'Receipt Photo *',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _pickImage(ImageSource.camera),
                              icon: const Icon(Icons.camera_alt),
                              label: const Text('Take Photo'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: BorderSide(color: AppColors.border),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () => _pickImage(ImageSource.gallery),
                              icon: const Icon(Icons.photo_library),
                              label: const Text('Choose from Gallery'),
                              style: OutlinedButton.styleFrom(
                                foregroundColor: AppColors.primary,
                                side: BorderSide(color: AppColors.border),
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_selectedImage != null) ...[
                        const SizedBox(height: 12),
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(_selectedImage!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                          icon: const Icon(Icons.delete, color: Colors.red),
                          label: const Text('Remove Photo', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                      const SizedBox(height: 24),
                      // Amount
                      const Text(
                        'Amount',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _amountController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          prefixText: '\$ ',
                          hintText: '0.00',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      // Category
                      const Text(
                        'Category',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        initialValue: _selectedCategory,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          hintText: 'Select category',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        dropdownColor: AppColors.surface,
                        style: const TextStyle(color: AppColors.textPrimary),
                        items: _categories.map((cat) {
                          return DropdownMenuItem(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // Date
                      const Text(
                        'Receipt Date',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _selectDate,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.background,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _receiptDate != null
                                    ? '${_receiptDate!.year}-${_receiptDate!.month.toString().padLeft(2, '0')}-${_receiptDate!.day.toString().padLeft(2, '0')}'
                                    : 'Select date',
                                style: TextStyle(
                                  color: _receiptDate != null ? AppColors.textPrimary : AppColors.textSecondary,
                                ),
                              ),
                              const Icon(Icons.calendar_today, color: AppColors.textSecondary, size: 20),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Vendor
                      const Text(
                        'Vendor/Merchant',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _vendorController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          hintText: 'Store name',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 16),
                      // Site (Optional)
                      const Text(
                        'Site (Optional)',
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
                          ..._sites.map((site) {
                            return DropdownMenuItem(
                              value: site.id,
                              child: Text(site.branchName),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedSiteId = value;
                            _selectedWorkOrderId = null;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      // Work Order (Optional)
                      if (_selectedSiteId != null) ...[
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
                            ..._workOrders.where((wo) => wo.siteId == _selectedSiteId).map((wo) {
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
                        const SizedBox(height: 16),
                      ],
                      // Notes
                      const Text(
                        'Notes',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _notesController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: AppColors.background,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(color: AppColors.border),
                          ),
                          hintText: 'Additional notes...',
                          hintStyle: const TextStyle(color: AppColors.textSecondary),
                        ),
                        style: const TextStyle(color: AppColors.textPrimary),
                      ),
                      const SizedBox(height: 32),
                      // Save Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _saveReceipt,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Save Receipt',
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
