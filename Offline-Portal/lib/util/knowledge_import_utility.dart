import 'dart:io';
import 'dart:convert';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';

import 'knowledge_categorizer.dart';

class KnowledgeImportUtility {
  final AppDatabase database;

  KnowledgeImportUtility(this.database);

  /// Import all markdown files from the staging directory
  Future<ImportResult> importFromStaging(String stagingPath) async {
    final stagingDir = Directory(stagingPath);
    final importResult = ImportResult();

    if (!await stagingDir.exists()) {
      throw Exception('Staging directory does not exist: $stagingPath');
    }

    // Find all .md files recursively
    await for (final entity in stagingDir.list(recursive: true)) {
      if (entity is File && entity.path.endsWith('.md')) {
        // Skip logs and temporary folders
        final lowerPath = entity.path.toLowerCase();
        if (lowerPath.contains('_logs') ||
            lowerPath.contains('_unclassified') ||
            lowerPath.contains('phase4-database') ||
            lowerPath.contains('temp')) {
          continue;
        }

        try {
          await _importSingleFile(entity, importResult);
        } catch (e, stackTrace) {
          importResult.errors.add(ImportError(
            file: entity.path,
            error: e.toString(),
            stackTrace: stackTrace.toString(),
          ));
        }
      }
    }

    return importResult;
  }

  Future<void> _importSingleFile(File file, ImportResult result) async {
    final content = await file.readAsString();
    final parsed = _parseMarkdownWithFrontmatter(content);

    final metadata = Map<String, dynamic>.from(parsed.metadata ?? {});

    // Provide defaults for missing fields
    final fileName = path.basenameWithoutExtension(file.path);
    metadata['id'] ??= fileName
        .toLowerCase()
        .replaceAll(' ', '-')
        .replaceAll(RegExp(r'[^a-zA-Z0-9-]'), '');

    // Improved title extraction: Use extracted title if available, otherwise look for first H1, otherwise use filename
    if (metadata['title'] == null) {
      final h1Match =
          RegExp(r'^#\s+(.+)$', multiLine: true).firstMatch(parsed.body);
      if (h1Match != null) {
        metadata['title'] = h1Match.group(1);
      } else {
        metadata['title'] = fileName.replaceAll('_', ' ').replaceAll('-', ' ');
      }
    }

    metadata['category'] ??= _guessCategoryFromPath(file.path);
    metadata['equipment_type'] ??= _guessEquipmentTypeFromPath(file.path);
    metadata['source_type'] ??= 'manual_import';
    metadata['source_file'] ??= path.basename(file.path);
    metadata['version'] ??= '1.0.0';
    metadata['status'] ??= 'active';

    // Check if entry already exists
    final existingEntry = await database.getKnowledgeEntryById(metadata['id']);
    if (existingEntry != null) {
      // Compare versions or content to determine if update is needed
      if (_shouldUpdateEntry(existingEntry, metadata, parsed.body)) {
        await _updateKnowledgeEntry(existingEntry, metadata, parsed.body);
        result.updated.add(file.path);
      } else {
        result.skipped.add('${file.path} - No changes detected');
      }
      return;
    }

    // Create new entry
    await _createKnowledgeEntry(metadata, parsed.body);
    result.created.add(file.path);
  }

  ParsedMarkdown _parseMarkdownWithFrontmatter(String content) {
    final lines = content.split('\n');

    if (lines.isEmpty || lines.first.trim() != '---') {
      return ParsedMarkdown(body: content, metadata: null);
    }

    int endIndex = -1;
    for (int i = 1; i < lines.length; i++) {
      if (lines[i].trim() == '---') {
        endIndex = i;
        break;
      }
    }

    if (endIndex == -1) {
      return ParsedMarkdown(body: content, metadata: null);
    }

    final frontmatterLines = lines.sublist(1, endIndex);
    final bodyLines = lines.sublist(endIndex + 1);

    try {
      final yaml = loadYaml(frontmatterLines.join('\n'));
      final metadata = Map<String, dynamic>.from(yaml);
      final body = bodyLines.join('\n').trim();

      return ParsedMarkdown(body: body, metadata: metadata);
    } catch (e) {
      return ParsedMarkdown(body: content, metadata: null);
    }
  }

  // ignore: unused_element
  bool _hasRequiredFields(Map<String, dynamic> metadata) {
    final required = [
      'id',
      'title',
      'category',
      'equipment_type',
      'source_type',
      'source_file',
      'version',
      'status'
    ];
    return required.every(
        (field) => metadata.containsKey(field) && metadata[field] != null);
  }

  bool _shouldUpdateEntry(
      KnowledgeEntry existing, Map<String, dynamic> metadata, String body) {
    // Compare version strings or content hash
    final newVersion = metadata['version'] as String;
    final existingVersion = existing.version;

    // Simple version comparison - you might want to enhance this
    if (newVersion != existingVersion) return true;

    // Compare body content
    if (existing.content != body) return true;

    // Compare other metadata
    if (existing.title != metadata['title']) return true;
    if (existing.category != metadata['category']) return true;
    if (existing.equipmentType != metadata['equipment_type']) return true;
    if (existing.equipmentModel != metadata['equipment_model']) return true;
    if (existing.sourceType != metadata['source_type']) return true;
    if (existing.sourceFile != metadata['source_file']) return true;
    if (existing.status != metadata['status']) return true;

    return false;
  }

  Future<void> _createKnowledgeEntry(
      Map<String, dynamic> metadata, String body) async {
    // Generate summary from content
    final summary = body.length > 200 ? body.substring(0, 200) : body;

    // Convert arrays to JSON strings
    String? requiredTools;
    if (metadata['required_tools'] != null) {
      requiredTools = metadata['required_tools'] is List
          ? jsonEncode(metadata['required_tools'])
          : metadata['required_tools'] as String?;
    }

    String? requiredParts;
    if (metadata['required_parts'] != null) {
      requiredParts = metadata['required_parts'] is List
          ? jsonEncode(metadata['required_parts'])
          : metadata['required_parts'] as String?;
    }

    String? applicableModels;
    if (metadata['applicable_models'] != null) {
      applicableModels = metadata['applicable_models'] is List
          ? jsonEncode(metadata['applicable_models'])
          : metadata['applicable_models'] as String?;
    }

    String? complianceTags;
    if (metadata['compliance_tags'] != null) {
      complianceTags = metadata['compliance_tags'] is List
          ? jsonEncode(metadata['compliance_tags'])
          : metadata['compliance_tags'] as String?;
    }

    final entry = KnowledgeEntriesCompanion(
      // Core fields
      id: Value(metadata['id'] as String),
      title: Value(metadata['title'] as String),
      content: Value(body),
      summary: Value(summary),

      // Taxonomy
      category: Value(metadata['category'] as String),
      equipmentType: Value(metadata['equipment_type'] as String),
      equipmentModel: _optionalValue(metadata['equipment_model']),
      manufacturer: _optionalValue(metadata['manufacturer']),
      applicableModels: applicableModels != null
          ? Value(applicableModels)
          : const Value.absent(),

      // Classification
      serviceType: Value(metadata['service_type'] as String? ?? 'reference'),
      difficultyLevel:
          Value(metadata['difficulty_level'] as String? ?? 'intermediate'),
      priorityLevel: Value(metadata['priority_level'] as String? ?? 'standard'),
      safetyLevel: Value(metadata['safety_level'] as String? ?? 'none'),
      complianceTags:
          complianceTags != null ? Value(complianceTags) : const Value.absent(),

      // Procedure metadata
      estimatedTimeMinutes:
          _optionalIntValue(metadata['estimated_time_minutes']),
      requiredTools:
          requiredTools != null ? Value(requiredTools) : const Value.absent(),
      requiredParts:
          requiredParts != null ? Value(requiredParts) : const Value.absent(),
      prerequisites: _optionalValue(metadata['prerequisites']),
      specialRequirements: _optionalValue(metadata['special_requirements']),

      // Content structure
      symptoms: _optionalValue(metadata['symptoms']),
      solutionsCount: Value(metadata['solutions_count'] as int? ?? 1),
      hasImages: Value(body.contains('![') || body.contains('<img')),
      hasAttachments:
          const Value(false), // Will be set when attachments are processed

      // Authoring
      author: _optionalValue(metadata['author']),
      authorRole: _optionalValue(metadata['author_role']),
      reviewer: _optionalValue(metadata['reviewer']),
      reviewedAt: metadata['reviewed_at'] != null
          ? Value(DateTime.parse(metadata['reviewed_at'] as String))
          : const Value.absent(),
      reviewStatus: Value(metadata['review_status'] as String? ?? 'draft'),
      approvalRequired: Value(metadata['approval_required'] as bool? ?? false),
      changeNotes: _optionalValue(metadata['change_notes']),

      // Source
      sourceType: Value(metadata['source_type'] as String),
      sourceFile: Value(metadata['source_file'] as String),
      externalId: _optionalValue(metadata['external_id']),
      syncSource: Value(metadata['sync_source'] as String? ?? 'file_system'),

      // Version
      version: Value(metadata['version'] as String),
      status: Value(metadata['status'] as String),

      // Timestamps
      createdAt: Value(DateTime.now()),
      updatedAt: Value(DateTime.now()),
      publishedAt: metadata['status'] == 'active' ||
              metadata['review_status'] == 'published'
          ? Value(DateTime.now())
          : const Value.absent(),
    );

    await database.into(database.knowledgeEntries).insert(entry);

    // Auto-link to machine profile if equipment type + manufacturer match
    await _linkToMachineProfile(metadata);

    // Create metadata record
    await database.into(database.entryMetadata).insert(
          EntryMetadataCompanion.insert(
            entryId: metadata['id'] as String,
          ),
        );
  }

  /// Try to match a knowledge entry to a machine profile by equipment type,
  /// manufacturer, and model. Updates the entry's machineProfileId if found.
  Future<void> _linkToMachineProfile(Map<String, dynamic> metadata) async {
    final equipmentType = metadata['equipment_type'] as String?;
    final manufacturer = metadata['manufacturer'] as String?;
    final model = metadata['equipment_model'] as String?;

    if (equipmentType == null || equipmentType.isEmpty) return;

    // Try exact match first (type + manufacturer + model)
    if (manufacturer != null && model != null) {
      final profile = await database.getMachineProfileByTypeAndModel(
          equipmentType, manufacturer, model);
      if (profile != null) {
        await (database.update(database.knowledgeEntries)
              ..where((k) => k.id.equals(metadata['id'] as String)))
            .write(
                KnowledgeEntriesCompanion(machineProfileId: Value(profile.id)));
        return;
      }
    }

    // Fallback: search by equipment type + manufacturer only
    if (manufacturer != null) {
      final profiles = await database.getAllMachineProfiles();
      final match = profiles.where((p) =>
          p.equipmentType.toLowerCase() == equipmentType.toLowerCase() &&
          p.manufacturer.toLowerCase() == manufacturer.toLowerCase());
      if (match.isNotEmpty) {
        await (database.update(database.knowledgeEntries)
              ..where((k) => k.id.equals(metadata['id'] as String)))
            .write(KnowledgeEntriesCompanion(
                machineProfileId: Value(match.first.id)));
        return;
      }
    }

    // Fallback: search by equipment type + searchKeys
    final profiles = await database.getAllMachineProfiles();
    for (final profile in profiles) {
      if (profile.equipmentType.toLowerCase() == equipmentType.toLowerCase()) {
        await (database.update(database.knowledgeEntries)
              ..where((k) => k.id.equals(metadata['id'] as String)))
            .write(
                KnowledgeEntriesCompanion(machineProfileId: Value(profile.id)));
        return;
      }
    }
  }

  Value<String> _optionalValue(dynamic value) {
    return value != null ? Value(value as String) : const Value.absent();
  }

  Value<int> _optionalIntValue(dynamic value) {
    if (value == null) return const Value.absent();
    if (value is int) return Value(value);
    if (value is String) {
      final parsed = int.tryParse(value);
      return parsed != null ? Value(parsed) : const Value.absent();
    }
    return const Value.absent();
  }

  Future<void> _updateKnowledgeEntry(KnowledgeEntry existing,
      Map<String, dynamic> metadata, String body) async {
    // Generate summary from content
    final summary = body.length > 200 ? body.substring(0, 200) : body;

    // Convert arrays to JSON strings
    String? requiredTools;
    if (metadata['required_tools'] != null) {
      requiredTools = metadata['required_tools'] is List
          ? jsonEncode(metadata['required_tools'])
          : metadata['required_tools'] as String?;
    }

    String? requiredParts;
    if (metadata['required_parts'] != null) {
      requiredParts = metadata['required_parts'] is List
          ? jsonEncode(metadata['required_parts'])
          : metadata['required_parts'] as String?;
    }

    String? applicableModels;
    if (metadata['applicable_models'] != null) {
      applicableModels = metadata['applicable_models'] is List
          ? jsonEncode(metadata['applicable_models'])
          : metadata['applicable_models'] as String?;
    }

    String? complianceTags;
    if (metadata['compliance_tags'] != null) {
      complianceTags = metadata['compliance_tags'] is List
          ? jsonEncode(metadata['compliance_tags'])
          : metadata['compliance_tags'] as String?;
    }

    final update = KnowledgeEntriesCompanion(
      // Core fields
      title: Value(metadata['title'] as String),
      content: Value(body),
      summary: Value(summary),

      // Taxonomy
      category: Value(metadata['category'] as String),
      equipmentType: Value(metadata['equipment_type'] as String),
      equipmentModel: _optionalValue(metadata['equipment_model']),
      manufacturer: _optionalValue(metadata['manufacturer']),
      applicableModels: applicableModels != null
          ? Value(applicableModels)
          : const Value.absent(),

      // Classification
      serviceType: Value(metadata['service_type'] as String? ?? 'reference'),
      difficultyLevel:
          Value(metadata['difficulty_level'] as String? ?? 'intermediate'),
      priorityLevel: Value(metadata['priority_level'] as String? ?? 'standard'),
      safetyLevel: Value(metadata['safety_level'] as String? ?? 'none'),
      complianceTags:
          complianceTags != null ? Value(complianceTags) : const Value.absent(),

      // Procedure metadata
      estimatedTimeMinutes:
          _optionalIntValue(metadata['estimated_time_minutes']),
      requiredTools:
          requiredTools != null ? Value(requiredTools) : const Value.absent(),
      requiredParts:
          requiredParts != null ? Value(requiredParts) : const Value.absent(),
      prerequisites: _optionalValue(metadata['prerequisites']),
      specialRequirements: _optionalValue(metadata['special_requirements']),

      // Content structure
      symptoms: _optionalValue(metadata['symptoms']),
      solutionsCount: Value(metadata['solutions_count'] as int? ?? 1),
      hasImages: Value(body.contains('![') || body.contains('<img')),

      // Authoring
      author: _optionalValue(metadata['author']),
      authorRole: _optionalValue(metadata['author_role']),
      reviewer: _optionalValue(metadata['reviewer']),
      reviewedAt: metadata['reviewed_at'] != null
          ? Value(DateTime.parse(metadata['reviewed_at'] as String))
          : const Value.absent(),
      reviewStatus:
          Value(metadata['review_status'] as String? ?? existing.reviewStatus),
      changeNotes: _optionalValue(metadata['change_notes']),

      // Source
      sourceType: Value(metadata['source_type'] as String),
      sourceFile: Value(metadata['source_file'] as String),
      externalId: _optionalValue(metadata['external_id']),

      // Version
      version: Value(metadata['version'] as String),
      status: Value(metadata['status'] as String),

      // Timestamps
      updatedAt: Value(DateTime.now()),
    );

    await (database.update(database.knowledgeEntries)
          ..where((k) => k.id.equals(existing.id)))
        .write(update);
  }

  String _guessCategoryFromPath(String filePath) {
    return KnowledgeCategorizer.guessCategory(filePath);
  }

  String _guessEquipmentTypeFromPath(String filePath) {
    return KnowledgeCategorizer.guessEquipmentType(filePath);
  }
}

class ParsedMarkdown {
  final String body;
  final Map<String, dynamic>? metadata;

  ParsedMarkdown({required this.body, this.metadata});
}

class ImportResult {
  final List<String> created = [];
  final List<String> updated = [];
  final List<String> skipped = [];
  final List<ImportError> errors = [];

  void printSummary() {
    print('Import Complete:');
    print('  Created: ${created.length} entries');
    print('  Updated: ${updated.length} entries');
    print('  Skipped: ${skipped.length} entries');
    print('  Errors: ${errors.length} entries');

    if (errors.isNotEmpty) {
      print('\nErrors:');
      for (final error in errors) {
        print('  ${error.file}: ${error.error}');
      }
    }
  }
}

class ImportError {
  final String file;
  final String error;
  final String stackTrace;

  ImportError({
    required this.file,
    required this.error,
    required this.stackTrace,
  });
}
