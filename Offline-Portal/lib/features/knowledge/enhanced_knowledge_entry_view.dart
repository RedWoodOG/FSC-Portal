import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';

/// Enhanced Knowledge Entry View with TOC, metadata, related articles, and feedback
class EnhancedKnowledgeEntryView extends StatefulWidget {
  final String entryId;

  const EnhancedKnowledgeEntryView({super.key, required this.entryId});

  @override
  State<EnhancedKnowledgeEntryView> createState() =>
      _EnhancedKnowledgeEntryViewState();
}

class _EnhancedKnowledgeEntryViewState
    extends State<EnhancedKnowledgeEntryView> {
  KnowledgeEntry? _entry;
  EntryMetadataData? _metadata;
  List<KnowledgeTag> _tags = [];
  // ignore: unused_field
  List<KnowledgeAttachment> _attachments = [];
  List<KnowledgeCategory> _breadcrumb = [];
  List<KnowledgeEntry> _relatedArticles = [];
  List<String> _tableOfContents = [];
  bool _isLoading = true;
  DateTime? _viewStartTime;

  @override
  void initState() {
    super.initState();
    _viewStartTime = DateTime.now();
    _loadEntry();
  }

  @override
  void dispose() {
    _trackTimeSpent();
    super.dispose();
  }

  Future<void> _trackTimeSpent() async {
    if (_viewStartTime == null) return;

    // ignore: unused_local_variable
    final timeSpent = DateTime.now().difference(_viewStartTime!).inSeconds;
    // TODO: Update average time in metadata
  }

  Future<void> _loadEntry() async {
    final db = context.read<AppDatabase>();

    try {
      final entry = await db.getKnowledgeEntryById(widget.entryId);
      if (entry == null) {
        setState(() => _isLoading = false);
        return;
      }

      // Load all related data
      final metadata = await db.getEntryMetadata(widget.entryId);
      final tags = await db.getEntryTags(widget.entryId);
      final attachments = await db.getEntryAttachments(widget.entryId);
      final related = await db.getRelatedArticles(widget.entryId);

      List<KnowledgeCategory> breadcrumb = [];
      if (entry.categoryId != null) {
        breadcrumb = await db.getCategoryBreadcrumb(entry.categoryId!);
      }

      // Generate table of contents from markdown headings
      final toc = _generateTableOfContents(entry.content);

      if (mounted) {
        setState(() {
          _entry = entry;
          _metadata = metadata;
          _tags = tags;
          _attachments = attachments;
          _breadcrumb = breadcrumb;
          _relatedArticles = related;
          _tableOfContents = toc;
          _isLoading = false;
        });
      }

      // Track view
      await db.trackArticleView(widget.entryId);
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error loading article: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    }
  }

  List<String> _generateTableOfContents(String markdown) {
    final toc = <String>[];
    final lines = markdown.split('\n');

    for (final line in lines) {
      if (line.startsWith('## ') && !line.startsWith('### ')) {
        toc.add(line.replaceFirst('## ', '').trim());
      }
    }

    return toc;
  }

  Future<void> _recordFeedback(bool isHelpful) async {
    final db = context.read<AppDatabase>();
    await db.recordArticleFeedback(widget.entryId, isHelpful);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(isHelpful
              ? 'Thank you for your feedback!'
              : 'We\'ll improve this article.'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(_entry?.title ?? 'Knowledge Entry'),
        backgroundColor: AppColors.surface,
        foregroundColor: AppColors.textPrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: () {
              // TODO: Implement print functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Print functionality coming soon')),
              );
            },
            tooltip: 'Print',
          ),
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              // TODO: Implement share functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text('Share functionality coming soon')),
              );
            },
            tooltip: 'Share',
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primary))
          : _entry == null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error_outline,
                          size: 64, color: AppColors.error),
                      const SizedBox(height: 16),
                      const Text(
                        'Entry not found',
                        style: TextStyle(
                            color: AppColors.textPrimary, fontSize: 16),
                      ),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMetadataHeader(),
                      const SizedBox(height: 24),
                      if (_tableOfContents.isNotEmpty) ...[
                        _buildTableOfContents(),
                        const SizedBox(height: 24),
                      ],
                      if (_entry!.safetyLevel != 'none') ...[
                        _buildSafetyWarning(),
                        const SizedBox(height: 24),
                      ],
                      if (_entry!.requiredTools != null ||
                          _entry!.requiredParts != null) ...[
                        _buildRequirements(),
                        const SizedBox(height: 24),
                      ],
                      _buildContent(),
                      const SizedBox(height: 24),
                      if (_relatedArticles.isNotEmpty) ...[
                        _buildRelatedArticles(),
                        const SizedBox(height: 24),
                      ],
                      _buildFeedbackSection(),
                      const SizedBox(height: 24),
                      _buildArticleFooter(),
                    ],
                  ),
                ),
    );
  }

  Widget _buildMetadataHeader() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Breadcrumb
          if (_breadcrumb.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Icon(Icons.folder_outlined,
                      size: 14, color: AppColors.textSecondary),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      _breadcrumb.map((c) => c.name).join(' > '),
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

          // Title
          Text(
            _entry!.title,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          // Equipment and manufacturer
          Row(
            children: [
              Icon(Icons.devices, size: 16, color: AppColors.primary),
              const SizedBox(width: 8),
              Text(
                _entry!.equipmentType,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (_entry!.manufacturer != null) ...[
                Text(
                  ' • ',
                  style: TextStyle(color: AppColors.textSecondary),
                ),
                Text(
                  _entry!.manufacturer!,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 12),

          // Metadata chips
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // Difficulty
              _buildMetadataChip(
                'Difficulty: ${_entry!.difficultyLevel}',
                Icons.signal_cellular_alt,
                _getDifficultyColor(_entry!.difficultyLevel),
              ),

              // Time estimate
              if (_entry!.estimatedTimeMinutes != null)
                _buildMetadataChip(
                  '${_entry!.estimatedTimeMinutes} min',
                  Icons.schedule,
                  AppColors.primary,
                ),

              // Safety level
              if (_entry!.safetyLevel != 'none')
                _buildMetadataChip(
                  'Safety: ${_entry!.safetyLevel.toUpperCase()}',
                  Icons.warning_amber,
                  _getSafetyColor(_entry!.safetyLevel),
                ),

              // Service type
              _buildMetadataChip(
                _entry!.serviceType,
                _getServiceTypeIcon(_entry!.serviceType),
                AppColors.textSecondary,
              ),
            ],
          ),

          // Tags
          if (_tags.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _tags.map((tag) {
                final color = tag.color != null
                    ? _parseColor(tag.color!)
                    : AppColors.primary;

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: color.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    tag.name,
                    style: TextStyle(
                      color: color,
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 16),
          const Divider(color: AppColors.border, height: 1),
          const SizedBox(height: 12),

          // Author and review info
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_entry!.author != null)
                      Row(
                        children: [
                          Icon(Icons.person,
                              size: 12, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'By ${_entry!.author}${_entry!.authorRole != null ? " (${_entry!.authorRole})" : ""}',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    if (_entry!.reviewer != null)
                      Row(
                        children: [
                          Icon(Icons.verified,
                              size: 12, color: AppColors.success),
                          const SizedBox(width: 4),
                          Text(
                            'Reviewed by ${_entry!.reviewer}',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),

              // Version and update info
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'v${_entry!.version}',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _formatDate(_entry!.updatedAt),
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // View count
          if (_metadata != null && _metadata!.viewCount > 0)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  Icon(Icons.visibility,
                      size: 12, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    '${_metadata!.viewCount} views',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 11,
                    ),
                  ),
                  if (_metadata!.helpfulCount > 0) ...[
                    const SizedBox(width: 12),
                    Icon(Icons.thumb_up, size: 12, color: AppColors.success),
                    const SizedBox(width: 4),
                    Text(
                      '${_metadata!.helpfulCount}',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildMetadataChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableOfContents() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.list, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'TABLE OF CONTENTS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._tableOfContents.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${entry.key + 1}.',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSafetyWarning() {
    final color = _getSafetyColor(_entry!.safetyLevel);
    final icon = _getSafetyIcon(_entry!.safetyLevel);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        border: Border.all(color: color, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _entry!.safetyLevel.toUpperCase(),
                  style: TextStyle(
                    color: color,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getSafetyMessage(_entry!.safetyLevel),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements() {
    final tools = _entry!.requiredTools != null
        ? (jsonDecode(_entry!.requiredTools!) as List).cast<String>()
        : <String>[];

    final parts = _entry!.requiredParts != null
        ? (jsonDecode(_entry!.requiredParts!) as List).cast<String>()
        : <String>[];

    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.build, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'REQUIRED TOOLS & PARTS',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (tools.isNotEmpty) ...[
            Text(
              'Tools:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ...tools.map((tool) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppColors.primary)),
                    Expanded(
                      child: Text(
                        tool,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            const SizedBox(height: 12),
          ],
          if (parts.isNotEmpty) ...[
            Text(
              'Parts:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            ...parts.map((part) {
              return Padding(
                padding: const EdgeInsets.only(left: 12, bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• ', style: TextStyle(color: AppColors.primary)),
                    Expanded(
                      child: Text(
                        part,
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ],
      ),
    );
  }

  Widget _buildContent() {
    return GlassCard(
      child: MarkdownBody(
        data: _entry!.content,
        styleSheet: MarkdownStyleSheet(
          p: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 15,
            height: 1.6,
          ),
          h1: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 28,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          h2: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            height: 1.3,
          ),
          h3: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            height: 1.3,
          ),
          h4: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          code: TextStyle(
            backgroundColor: AppColors.background,
            color: AppColors.primary,
            fontFamily: 'monospace',
            fontSize: 14,
          ),
          codeblockDecoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.border),
          ),
          codeblockPadding: const EdgeInsets.all(16),
          listBullet: const TextStyle(color: AppColors.primary),
          listIndent: 24,
          strong: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          em: const TextStyle(
            color: AppColors.textPrimary,
            fontStyle: FontStyle.italic,
          ),
          blockquote: TextStyle(
            color: AppColors.textSecondary,
            fontStyle: FontStyle.italic,
          ),
          blockquoteDecoration: BoxDecoration(
            border: Border(
              left: BorderSide(color: AppColors.primary, width: 4),
            ),
          ),
          blockquotePadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          tableHead: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          tableBody: const TextStyle(
            color: AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildRelatedArticles() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.link, size: 18, color: AppColors.primary),
              const SizedBox(width: 8),
              const Text(
                'RELATED ARTICLES',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ..._relatedArticles.map((article) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EnhancedKnowledgeEntryView(entryId: article.id),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.background,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.article_outlined,
                          size: 16, color: AppColors.primary),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          article.title,
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 13,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios,
                          size: 12, color: AppColors.textSecondary),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection() {
    return GlassCard(
      child: Column(
        children: [
          const Text(
            'WAS THIS HELPFUL?',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () => _recordFeedback(true),
                icon: const Icon(Icons.thumb_up),
                label: const Text('Yes'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.success,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton.icon(
                onPressed: () => _recordFeedback(false),
                icon: const Icon(Icons.thumb_down),
                label: const Text('No'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  foregroundColor: AppColors.textSecondary,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArticleFooter() {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'DOCUMENT INFORMATION',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 8),
          _buildInfoRow('Document ID', _entry!.id),
          _buildInfoRow('Source', _entry!.sourceFile),
          _buildInfoRow('Status', _entry!.reviewStatus),
          if (_entry!.externalId != null)
            _buildInfoRow('External ID', _entry!.externalId!),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 11,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) return 'Today';
    if (difference.inDays == 1) return 'Yesterday';
    if (difference.inDays < 7) return '${difference.inDays} days ago';
    if (difference.inDays < 30)
      return '${(difference.inDays / 7).floor()} weeks ago';

    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  Color _parseColor(String colorHex) {
    try {
      return Color(int.parse(colorHex.replaceFirst('#', '0xFF')));
    } catch (e) {
      return AppColors.primary;
    }
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.primary;
      case 'advanced':
        return Colors.orange;
      case 'expert':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  Color _getSafetyColor(String safety) {
    switch (safety.toLowerCase()) {
      case 'none':
        return AppColors.textSecondary;
      case 'caution':
        return Colors.yellow.shade700;
      case 'warning':
        return Colors.orange.shade700;
      case 'danger':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  IconData _getSafetyIcon(String safety) {
    switch (safety.toLowerCase()) {
      case 'caution':
        return Icons.report_problem;
      case 'warning':
        return Icons.warning;
      case 'danger':
        return Icons.dangerous;
      default:
        return Icons.info_outline;
    }
  }

  String _getSafetyMessage(String safety) {
    switch (safety.toLowerCase()) {
      case 'caution':
        return 'Exercise caution when performing this procedure. Follow all safety guidelines.';
      case 'warning':
        return 'WARNING: This procedure involves potential hazards. Ensure proper safety equipment and training.';
      case 'danger':
        return 'DANGER: High-risk procedure. Only qualified personnel should perform this task. Follow all safety protocols and lockout/tagout procedures.';
      default:
        return 'Standard safety procedures apply.';
    }
  }

  IconData _getServiceTypeIcon(String serviceType) {
    switch (serviceType.toLowerCase()) {
      case 'troubleshooting':
        return Icons.build;
      case 'maintenance':
        return Icons.handyman;
      case 'installation':
        return Icons.construction;
      case 'safety':
        return Icons.shield;
      default:
        return Icons.library_books;
    }
  }
}
