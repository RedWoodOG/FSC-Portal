import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../util/knowledge_import_utility.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../../database/app_database.dart';

// lib/features/admin/knowledge_import_screen.dart

class KnowledgeImportScreen extends StatefulWidget {
  const KnowledgeImportScreen({super.key});

  @override
  State<KnowledgeImportScreen> createState() => _KnowledgeImportScreenState();
}

class _KnowledgeImportScreenState extends State<KnowledgeImportScreen> {
  final TextEditingController _pathController =
      TextEditingController(text: r'C:\Portal_Knowledge_Staging');

  bool _isImporting = false;
  ImportResult? _lastResult;
  String? _errorMessage;

  @override
  void dispose() {
    _pathController.dispose();
    super.dispose();
  }

  Future<void> _runImport() async {
    if (_isImporting) return;

    setState(() {
      _isImporting = true;
      _errorMessage = null;
      _lastResult = null;
    });

    try {
      final database = context.read<AppDatabase>();
      final importer = KnowledgeImportUtility(database);

      final result = await importer.importFromStaging(_pathController.text);

      if (mounted) {
        setState(() {
          _lastResult = result;
          _isImporting = false;
        });
      }
    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isImporting = false;
        });
      }
      debugPrint('Import error: $e\n$stackTrace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Knowledge Base Import'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            border: Border(
                bottom:
                    BorderSide(color: Colors.white.withValues(alpha: 0.05))),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.deepOcean,
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImportSection(),
                AppSpacing.v24,
                _buildResultsSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImportSection() {
    return GlassCard(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Import Knowledge Entries',
            style: AppTypography.sectionTitle.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
          AppSpacing.v16,
          Text(
            'Import all markdown files from the staging directory into the knowledge database.',
            style: AppTypography.bodyText.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          AppSpacing.v16,
          TextField(
            controller: _pathController,
            style: const TextStyle(color: AppColors.textPrimary),
            decoration: const InputDecoration(
              labelText: 'Staging Directory Path',
              labelStyle: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          AppSpacing.v24,
          Row(
            children: [
              ElevatedButton(
                onPressed: _isImporting ? null : _runImport,
                child: _isImporting
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Run Import'),
              ),
              if (_isImporting) ...[
                AppSpacing.h16,
                Text(
                  'Importing knowledge entries...',
                  style: AppTypography.bodyText.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultsSection() {
    if (_errorMessage != null) {
      return _buildErrorCard();
    }

    if (_lastResult != null) {
      return _buildResultCard();
    }

    return const SizedBox.shrink();
  }

  Widget _buildErrorCard() {
    return GlassCard(
      padding: const EdgeInsets.all(24.0),
      activeBorderColor: AppColors.error.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.error, color: AppColors.error),
              AppSpacing.h8,
              Text(
                'Import Failed',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.error,
                ),
              ),
            ],
          ),
          AppSpacing.v16,
          Text(
            _errorMessage!,
            style: AppTypography.bodyText.copyWith(
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultCard() {
    final result = _lastResult!;

    return GlassCard(
      padding: const EdgeInsets.all(24.0),
      activeBorderColor: AppColors.success.withValues(alpha: 0.3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.check_circle, color: AppColors.success),
              AppSpacing.h8,
              Text(
                'Import Complete',
                style: AppTypography.headlineSmall.copyWith(
                  color: AppColors.success,
                ),
              ),
            ],
          ),
          AppSpacing.v16,
          _buildResultStats(result),
          if (result.errors.isNotEmpty) ...[
            AppSpacing.v16,
            _buildErrorDetails(result),
          ],
        ],
      ),
    );
  }

  Widget _buildResultStats(ImportResult result) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildStatChip('Created', result.created.length, AppColors.success),
        _buildStatChip('Updated', result.updated.length, AppColors.primary),
        _buildStatChip(
            'Skipped', result.skipped.length, AppColors.textSecondary),
        if (result.errors.isNotEmpty)
          _buildStatChip('Errors', result.errors.length, AppColors.error),
      ],
    );
  }

  Widget _buildStatChip(String label, int count, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        '$label: $count',
        style: AppTypography.tagText.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildErrorDetails(ImportResult result) {
    return ExpansionTile(
      title: Text(
        'View Errors (${result.errors.length})',
        style: const TextStyle(color: AppColors.error),
      ),
      children: result.errors.map((error) {
        return ListTile(
          leading: const Icon(Icons.error_outline, color: AppColors.error),
          title: Text(
            error.file.split('\\').last, // Show just filename
            style: const TextStyle(color: AppColors.textPrimary),
          ),
          subtitle: Text(
            error.error,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        );
      }).toList(),
    );
  }
}
