import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import '../../util/log.dart';
import '../../database/app_database.dart';
import '../../widgets/glass_card.dart';
import 'enhanced_knowledge_entry_view.dart';
import '../equipment/machine_profile_list_view.dart';

/// Enhanced Knowledge Base Home with FTS5 search, filters, and hierarchical navigation
class EnhancedKnowledgeHomeView extends StatefulWidget {
  const EnhancedKnowledgeHomeView({super.key});

  @override
  State<EnhancedKnowledgeHomeView> createState() =>
      _EnhancedKnowledgeHomeViewState();
}

class _EnhancedKnowledgeHomeViewState extends State<EnhancedKnowledgeHomeView> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  List<KnowledgeSearchResult> _searchResults = [];
  List<String> _suggestions = [];
  bool _isSearching = false;
  bool _showFilters = false;

  // Filter states
  String? _equipmentFilter;
  String? _categoryFilter;
  String? _difficultyFilter;
  String? _safetyFilter;

  // Navigation state
  List<KnowledgeCategory> _categoryBreadcrumb = [];
  int? _currentCategoryId;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _performSearch(String query) async {
    if (query.trim().isEmpty) {
      setState(() {
        _isSearching = false;
        _searchResults = [];
        _suggestions = [];
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchQuery = query;
    });

    try {
      final db = context.read<AppDatabase>();

      // Get FTS5 search results with filters
      final results = await db.searchKnowledgeFTS5(
        query,
        equipmentFilter: _equipmentFilter,
        categoryFilter: _categoryFilter,
        difficultyFilter: _difficultyFilter,
        safetyFilter: _safetyFilter,
        limit: 100,
      );

      if (mounted) {
        setState(() {
          _searchResults = results;
          _isSearching = false;
        });
      }
    } catch (e, stackTrace) {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Search error: ${e.toString()}'),
            backgroundColor: AppColors.error,
          ),
        );
      }
      Log.error('Enhanced search error: $e\n$stackTrace');
    }
  }

  Future<void> _getAutocomplete(String prefix) async {
    if (prefix.length < 2) {
      setState(() => _suggestions = []);
      return;
    }

    try {
      final db = context.read<AppDatabase>();
      final suggestions = await db.getSearchSuggestions(prefix, limit: 5);

      if (mounted) {
        setState(() => _suggestions = suggestions);
      }
    } catch (e) {
      Log.error('Autocomplete error: $e');
    }
  }

  void _navigateToCategory(KnowledgeCategory category) async {
    final db = context.read<AppDatabase>();
    final breadcrumb = await db.getCategoryBreadcrumb(category.id);

    setState(() {
      _currentCategoryId = category.id;
      _categoryBreadcrumb = breadcrumb;
    });
  }

  void _navigateBack() {
    if (_categoryBreadcrumb.length > 1) {
      // Go to parent category
      final parent = _categoryBreadcrumb[_categoryBreadcrumb.length - 2];
      _navigateToCategory(parent);
    } else {
      // Go to root
      setState(() {
        _currentCategoryId = null;
        _categoryBreadcrumb = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: StreamBuilder<List<KnowledgeEntry>>(
          stream: context.read<AppDatabase>().watchAllKnowledgeEntries(),
          builder: (context, snapshot) {
            final count = snapshot.hasData ? snapshot.data!.length : 0;
            return Text(
                'Knowledge Base${count > 0 ? ' ($count entries)' : ''}');
          },
        ),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.precision_manufacturing_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MachineProfileListView(),
                ),
              );
            },
            tooltip: 'Machine Profiles',
          ),
          IconButton(
            icon:
                Icon(_showFilters ? Icons.filter_list_off : Icons.filter_list),
            onPressed: () {
              setState(() => _showFilters = !_showFilters);
            },
            tooltip: 'Toggle Filters',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: AppGradients.deepOcean,
        ),
        child: Column(
          children: [
            // Search box with autocomplete
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search knowledge base...',
                      hintStyle: TextStyle(color: AppColors.textSecondary),
                      prefixIcon:
                          const Icon(Icons.search, color: AppColors.primary),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                _searchController.clear();
                                _performSearch('');
                              },
                            )
                          : null,
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
                        borderSide:
                            BorderSide(color: AppColors.primary, width: 2),
                      ),
                      filled: true,
                      fillColor: AppColors.surface,
                    ),
                    style: const TextStyle(color: AppColors.textPrimary),
                    onChanged: (value) {
                      _performSearch(value);
                      _getAutocomplete(value);
                    },
                  ),

                  // Autocomplete suggestions
                  if (_suggestions.isNotEmpty && _searchQuery.isNotEmpty)
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        children: _suggestions.map((suggestion) {
                          return ListTile(
                            dense: true,
                            leading: const Icon(Icons.history,
                                size: 16, color: AppColors.textSecondary),
                            title: Text(
                              suggestion,
                              style: const TextStyle(
                                  color: AppColors.textPrimary, fontSize: 14),
                            ),
                            onTap: () {
                              _searchController.text = suggestion;
                              _performSearch(suggestion);
                              setState(() => _suggestions = []);
                            },
                          );
                        }).toList(),
                      ),
                    ),
                ],
              ),
            ),

            // Advanced Filters (collapsible)
            if (_showFilters)
              GlassCard(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ADVANCED FILTERS',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Difficulty filter
                    _buildFilterChipRow(
                      label: 'Difficulty',
                      options: [
                        'beginner',
                        'intermediate',
                        'advanced',
                        'expert'
                      ],
                      selectedValue: _difficultyFilter,
                      onSelected: (value) {
                        setState(() => _difficultyFilter = value);
                        if (_searchQuery.isNotEmpty)
                          _performSearch(_searchQuery);
                      },
                    ),

                    const SizedBox(height: 12),

                    // Safety level filter
                    _buildFilterChipRow(
                      label: 'Safety',
                      options: ['none', 'caution', 'warning', 'danger'],
                      selectedValue: _safetyFilter,
                      onSelected: (value) {
                        setState(() => _safetyFilter = value);
                        if (_searchQuery.isNotEmpty)
                          _performSearch(_searchQuery);
                      },
                      colors: {
                        'none': AppColors.textSecondary,
                        'caution': Colors.yellow.shade700,
                        'warning': Colors.orange.shade700,
                        'danger': AppColors.error,
                      },
                    ),

                    const SizedBox(height: 12),

                    // Clear filters button
                    TextButton.icon(
                      onPressed: () {
                        setState(() {
                          _equipmentFilter = null;
                          _categoryFilter = null;
                          _difficultyFilter = null;
                          _safetyFilter = null;
                        });
                        if (_searchQuery.isNotEmpty)
                          _performSearch(_searchQuery);
                      },
                      icon: const Icon(Icons.clear_all, size: 16),
                      label: const Text('Clear All Filters'),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),

            // Breadcrumb navigation (if in category view)
            if (_categoryBreadcrumb.isNotEmpty)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back,
                          color: AppColors.primary),
                      onPressed: _navigateBack,
                      tooltip: 'Back',
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children:
                              _categoryBreadcrumb.asMap().entries.map((entry) {
                            final isLast =
                                entry.key == _categoryBreadcrumb.length - 1;
                            return Row(
                              children: [
                                Text(
                                  entry.value.name,
                                  style: TextStyle(
                                    color: isLast
                                        ? AppColors.primary
                                        : AppColors.textSecondary,
                                    fontSize: 14,
                                    fontWeight: isLast
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                if (!isLast)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Icon(
                                      Icons.chevron_right,
                                      size: 16,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                              ],
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Content area
            Expanded(
              child: _searchQuery.isNotEmpty
                  ? _buildSearchResults()
                  : _currentCategoryId != null
                      ? _buildCategoryContent()
                      : _buildCategoryBrowser(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChipRow({
    required String label,
    required List<String> options,
    String? selectedValue,
    required Function(String?) onSelected,
    Map<String, Color>? colors,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            // "All" chip
            FilterChip(
              label: const Text('All'),
              selected: selectedValue == null,
              onSelected: (selected) {
                if (selected) onSelected(null);
              },
              selectedColor: AppColors.primary.withValues(alpha: 0.3),
              backgroundColor: AppColors.background,
              labelStyle: TextStyle(
                color: selectedValue == null
                    ? AppColors.primary
                    : AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            // Option chips
            ...options.map((option) {
              final color = colors?[option] ?? AppColors.primary;
              final isSelected = selectedValue == option;

              return FilterChip(
                label: Text(option[0].toUpperCase() + option.substring(1)),
                selected: isSelected,
                onSelected: (selected) {
                  onSelected(selected ? option : null);
                },
                selectedColor: color.withValues(alpha: 0.3),
                backgroundColor: AppColors.background,
                labelStyle: TextStyle(
                  color: isSelected ? color : AppColors.textSecondary,
                  fontSize: 12,
                ),
              );
            }).toList(),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryBrowser() {
    final db = context.read<AppDatabase>();

    return FutureBuilder<List<KnowledgeCategory>>(
      future: db.getTopLevelCategories(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primary));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.category_outlined,
                    size: 64, color: Colors.grey[600]),
                const SizedBox(height: 16),
                Text(
                  'No categories available',
                  style: TextStyle(color: Colors.grey[600], fontSize: 16),
                ),
                const SizedBox(height: 8),
                Text(
                  'Categories will appear after importing knowledge base',
                  style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final categories = snapshot.data!;

        return GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return _buildCategoryCard(category);
          },
        );
      },
    );
  }

  Widget _buildCategoryCard(KnowledgeCategory category) {
    final iconData = _getIconData(category.icon);
    final color = category.color != null
        ? _parseColor(category.color!)
        : AppColors.primary;

    return GlassCard(
      onTap: () => _navigateToCategory(category),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              iconData,
              color: color,
              size: 32,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            category.name,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            '${category.articleCount} articles',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryContent() {
    final db = context.read<AppDatabase>();

    return FutureBuilder<List<KnowledgeCategory>>(
      future: db.getChildCategories(_currentCategoryId!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: AppColors.primary));
        }

        final children = snapshot.data ?? [];
        final hasChildren = children.isNotEmpty;

        return Column(
          children: [
            // Show child categories if any
            if (hasChildren)
              Expanded(
                flex: 1,
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.3,
                  ),
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return _buildCategoryCard(children[index]);
                  },
                ),
              ),

            // Articles in this category
            Expanded(
              flex: 2,
              child: _buildArticlesInCategory(),
            ),
          ],
        );
      },
    );
  }

  Widget _buildArticlesInCategory() {
    // TODO: Add query to get articles by category_id
    // For now, fallback to showing all articles
    return Center(
      child: Text(
        'Articles in this category will appear here',
        style: TextStyle(color: AppColors.textSecondary),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_isSearching) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primary),
      );
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[600]),
            const SizedBox(height: 16),
            Text(
              'No results found for "$_searchQuery"',
              style: TextStyle(color: Colors.grey[600], fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              'Try different keywords or clear filters',
              style: TextStyle(color: Colors.grey[700], fontSize: 12),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _searchResults.length,
      itemBuilder: (context, index) {
        final result = _searchResults[index];
        final entry = result.entry;

        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          onTap: () async {
            // Track view
            await context.read<AppDatabase>().trackArticleView(entry.id);

            if (mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EnhancedKnowledgeEntryView(entryId: entry.id),
                ),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title with highlighting
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 4,
                    height: 48,
                    decoration: BoxDecoration(
                      color: _getDifficultyColor(entry.difficultyLevel),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _removeMarkTags(result.highlightedTitle),
                          style: const TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.category,
                                size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Text(
                              entry.category,
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 11,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Icon(Icons.devices,
                                size: 12, color: AppColors.textSecondary),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                entry.equipmentType,
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
                      ],
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Content snippet
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  _removeMarkTags(result.contentSnippet),
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),

              const SizedBox(height: 8),

              // Metadata badges
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    // Difficulty badge
                    _buildBadge(
                      entry.difficultyLevel,
                      _getDifficultyIcon(entry.difficultyLevel),
                      _getDifficultyColor(entry.difficultyLevel),
                    ),

                    // Time estimate
                    if (entry.estimatedTimeMinutes != null)
                      _buildBadge(
                        '${entry.estimatedTimeMinutes} min',
                        Icons.schedule,
                        AppColors.textSecondary,
                      ),

                    // Safety level
                    if (entry.safetyLevel != 'none')
                      _buildBadge(
                        entry.safetyLevel.toUpperCase(),
                        Icons.warning,
                        _getSafetyColor(entry.safetyLevel),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBadge(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  String _removeMarkTags(String text) {
    return text.replaceAll('<mark>', '').replaceAll('</mark>', '');
  }

  IconData _getIconData(String? iconName) {
    if (iconName == null) return Icons.folder;

    final iconMap = {
      'account_balance': Icons.account_balance,
      'security': Icons.security,
      'shield': Icons.shield,
      'computer': Icons.computer,
      'atm': Icons.atm,
      'toll': Icons.toll,
      'attach_money': Icons.attach_money,
      'verified': Icons.verified,
      'videocam': Icons.videocam,
      'lock': Icons.lock,
      'settings_input_component': Icons.settings_input_component,
      'ac_unit': Icons.ac_unit,
      'build': Icons.build,
      'handyman': Icons.handyman,
      'construction': Icons.construction,
      'library_books': Icons.library_books,
      'warning': Icons.warning,
      'business': Icons.business,
      'search': Icons.search,
      'error': Icons.error,
      'science': Icons.science,
      'schedule': Icons.schedule,
      'build_circle': Icons.build_circle,
      'tune': Icons.tune,
      'today': Icons.today,
      'date_range': Icons.date_range,
      'calendar_month': Icons.calendar_month,
      'add_box': Icons.add_box,
      'swap_horiz': Icons.swap_horiz,
      'settings': Icons.settings,
      'inventory_2': Icons.inventory_2,
      'description': Icons.description,
      'cable': Icons.cable,
      'health_and_safety': Icons.health_and_safety,
    };

    return iconMap[iconName] ?? Icons.folder;
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

  IconData _getDifficultyIcon(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Icons.circle;
      case 'intermediate':
        return Icons.circle_outlined;
      case 'advanced':
        return Icons.stars;
      case 'expert':
        return Icons.workspace_premium;
      default:
        return Icons.help_outline;
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
}
