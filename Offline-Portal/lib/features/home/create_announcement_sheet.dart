import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:drift/drift.dart' as drift;
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';

class CreateAnnouncementSheet extends StatefulWidget {
  const CreateAnnouncementSheet({super.key});

  @override
  State<CreateAnnouncementSheet> createState() =>
      _CreateAnnouncementSheetState();
}

class _CreateAnnouncementSheetState extends State<CreateAnnouncementSheet> {
  final _formKey = GlobalKey<FormState>();
  String _category = 'general';
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  final _actionLabelController = TextEditingController();

  final Map<String, IconData> _categoryIcons = {
    'general': Icons.info_outline,
    'hr': Icons.people_outline,
    'safety': Icons.health_and_safety,
    'fleet': Icons.local_shipping,
  };

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _actionLabelController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final db = context.read<AppDatabase>();

      await db.into(db.companyAnnouncements).insert(
            CompanyAnnouncementsCompanion.insert(
              category: _category,
              title: _titleController.text,
              body: _bodyController.text,
              actionLabel: drift.Value(_actionLabelController.text.isEmpty
                  ? null
                  : _actionLabelController.text),
              active: const drift.Value(true),
              publishedAt: DateTime.now(),
            ),
          );

      if (mounted) {
        Navigator.pop(context, true); // Return true to indicate success
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('✓ Announcement posted • Feed updating...'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fit content
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'New Announcement',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Category Selector
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categoryIcons.entries.map((entry) {
                  final isSelected = _category == entry.key;
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: FilterChip(
                      selected: isSelected,
                      label: Text(entry.key.toUpperCase()),
                      avatar: Icon(entry.value,
                          size: 16,
                          color: isSelected ? Colors.white : Colors.grey),
                      onSelected: (selected) {
                        setState(() => _category = entry.key);
                      },
                      checkmarkColor: Colors.white,
                      selectedColor: AppColors.primary,
                      backgroundColor: AppColors.background,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.grey,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.grey.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Title Input
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Headline',
                hintText: 'e.g. Winter Weather Advisory',
                prefixIcon: Icon(Icons.title),
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter a headline'
                  : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Body Input
            TextFormField(
              controller: _bodyController,
              decoration: const InputDecoration(
                labelText: 'Message Body',
                hintText: 'Full details of the announcement...',
                alignLabelWithHint: true,
                prefixIcon: Icon(Icons.notes),
              ),
              maxLines: 4,
              validator: (value) => value == null || value.isEmpty
                  ? 'Please enter message details'
                  : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),

            // Action Label (Optional)
            TextFormField(
              controller: _actionLabelController,
              decoration: const InputDecoration(
                labelText: 'Action Button Label (Optional)',
                hintText: 'e.g. VIEW POLICY, ACKNOWLEDGE',
                prefixIcon: Icon(Icons.touch_app),
              ),
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: _submit,
                icon: const Icon(Icons.send),
                label: const Text('POST ANNOUNCEMENT'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            // Add padding for keyboard if needed, though this is usually handled by Scaffold
            Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom)),
          ],
        ),
      ),
    );
  }
}
