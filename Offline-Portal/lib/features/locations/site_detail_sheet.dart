import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../util/log.dart';

class SiteDetailSheet extends StatefulWidget {
  final Site site;
  final VoidCallback onSiteUpdated;

  const SiteDetailSheet({
    super.key,
    required this.site,
    required this.onSiteUpdated,
  });

  @override
  State<SiteDetailSheet> createState() => _SiteDetailSheetState();
}

class _SiteDetailSheetState extends State<SiteDetailSheet> {
  late TextEditingController _nameController;
  late TextEditingController _addressController;
  bool _isEditing = false;
  List<Document> _photos = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.site.branchName);
    _addressController = TextEditingController(text: widget.site.address);
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final db = context.read<AppDatabase>();
    final docs = await db.getDocumentsBySite(widget.site.id);
    if (mounted) {
      setState(() {
        _photos = docs;
      });
    }
  }

  Future<void> _saveChanges() async {
    try {
      final db = context.read<AppDatabase>();
      final updatedSite = SitesCompanion(
        id: drift.Value(widget.site.id),
        branchName: drift.Value(_nameController.text),
        address: drift.Value(_addressController.text),
        clientId: drift.Value(widget.site.clientId),
        latitude: drift.Value(widget.site.latitude),
        longitude: drift.Value(widget.site.longitude),
        region: drift.Value(widget.site.region),
      );
      await db.updateSite(updatedSite);

      setState(() => _isEditing = false);
      widget.onSiteUpdated();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Site parameters updated'),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );
    } catch (e) {
      Log.error('Error updating site: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Update failed: $e'),
            backgroundColor: AppColors.error),
      );
    }
  }

  Future<void> _addMockPhoto() async {
    final db = context.read<AppDatabase>();
    final newDoc = DocumentsCompanion(
      siteId: drift.Value(widget.site.id),
      fileName: drift.Value(
          'IMG_${DateTime.now().millisecondsSinceEpoch % 10000}.JPG'),
      filePath: drift.Value('assets/mock_photo.jpg'),
      uploadedAt: drift.Value(DateTime.now()),
      uploadedBy: drift.Value('Field Agent'),
    );

    await db.insertDocument(newDoc);
    await _loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: GlassCard(
        borderRadius: 24,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 32),
            _buildFields(),
            const SizedBox(height: 32),
            _buildPhotosSection(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'SITE INSPECTION',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 10,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              widget.site.branchName,
              style: AppTypography.sectionTitle.copyWith(fontSize: 24),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _isEditing
                      ? AppColors.success.withValues(alpha: 0.2)
                      : Colors.white10,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _isEditing ? Icons.check : Icons.edit,
                  color: _isEditing ? AppColors.success : Colors.white,
                  size: 20,
                ),
              ),
              onPressed: _isEditing
                  ? _saveChanges
                  : () => setState(() => _isEditing = true),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white60),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFields() {
    return Column(
      children: [
        _buildTextField('Physical Address', _addressController,
            enabled: _isEditing, icon: Icons.map_outlined),
      ],
    );
  }

  Widget _buildPhotosSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'SITE DOCUMENTATION',
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.4),
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
              ),
            ),
            TextButton.icon(
              onPressed: _addMockPhoto,
              icon: const Icon(Icons.add_a_photo_outlined,
                  size: 16, color: AppColors.primary),
              label: Text('APPEND',
                  style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2)),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (_photos.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                  color: Colors.white.withValues(alpha: 0.05),
                  style: BorderStyle.solid),
            ),
            child: Column(
              children: [
                Icon(Icons.cloud_off_outlined,
                    color: Colors.white.withValues(alpha: 0.1), size: 32),
                const SizedBox(height: 12),
                Text('No technical photos attached.',
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.3),
                        fontSize: 12)),
              ],
            ),
          )
        else
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _photos.length,
              itemBuilder: (context, index) {
                final photo = _photos[index];
                return Container(
                  width: 120,
                  margin: const EdgeInsets.only(right: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.insert_drive_file_outlined,
                          color: Colors.white38, size: 32),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          photo.fileName,
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.5),
                              fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool enabled = false, IconData? icon}) {
    return TextField(
      controller: controller,
      enabled: enabled,
      style: const TextStyle(color: Colors.white, fontSize: 14),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.primary, size: 20)
            : null,
        filled: true,
        fillColor:
            enabled ? Colors.white.withValues(alpha: 0.05) : Colors.transparent,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      ),
    );
  }
}
