import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../knowledge/enhanced_knowledge_entry_view.dart';

/// Consolidated machine profile view showing canonical identity,
/// linked equipment instances, and related knowledge articles.
class MachineProfileView extends StatefulWidget {
  final int profileId;

  const MachineProfileView({super.key, required this.profileId});

  @override
  State<MachineProfileView> createState() => _MachineProfileViewState();
}

class _MachineProfileViewState extends State<MachineProfileView>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  MachineProfile? _profile;
  List<EquipmentData> _linkedEquipment = [];
  List<KnowledgeEntry> _linkedKnowledge = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    final db = context.read<AppDatabase>();
    final profile = await db.getMachineProfileById(widget.profileId);
    final equipment = await db.getEquipmentByMachineProfile(widget.profileId);
    final knowledge = await db.getKnowledgeByMachineProfile(widget.profileId);

    if (mounted) {
      setState(() {
        _profile = profile;
        _linkedEquipment = equipment;
        _linkedKnowledge = knowledge;
        _isLoading = false;
      });
    }
  }

  List<String> _parseAliases() {
    if (_profile?.aliases == null) return [];
    try {
      return List<String>.from(jsonDecode(_profile!.aliases!));
    } catch (_) {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text('Machine Profile'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (_profile == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          title: const Text('Machine Profile'),
        ),
        body: const Center(
          child: Text('Profile not found',
              style: TextStyle(color: Colors.white70)),
        ),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          '${_profile!.manufacturer} ${_profile!.model}',
          style: const TextStyle(
              color: AppColors.textPrimary, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          tabs: [
            Tab(text: 'OVERVIEW', icon: Icon(Icons.info_outline, size: 18)),
            Tab(
              text: 'EQUIPMENT (${_linkedEquipment.length})',
              icon: Icon(Icons.inventory_2_outlined, size: 18),
            ),
            Tab(
              text: 'KNOWLEDGE (${_linkedKnowledge.length})',
              icon: Icon(Icons.library_books_outlined, size: 18),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildEquipmentTab(),
          _buildKnowledgeTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    final aliases = _parseAliases();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero card
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primary,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _iconForType(_profile!.equipmentType),
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _profile!.equipmentType.toUpperCase(),
                            style: TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${_profile!.manufacturer} ${_profile!.model}',
                            style: AppTypography.sectionTitle
                                .copyWith(fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (_profile!.description != null) ...[
                  const SizedBox(height: 20),
                  Text(
                    _profile!.description!,
                    style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                        height: 1.5),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Details grid
          GlassCard(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPECIFICATIONS',
                  style: TextStyle(
                    color: AppColors.textTertiary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                _buildDetailRow('Manufacturer', _profile!.manufacturer),
                _buildDetailRow('Model', _profile!.model),
                _buildDetailRow('Equipment Type', _profile!.equipmentType),
                _buildDetailRow(
                    'Installed Units', '${_linkedEquipment.length}'),
                _buildDetailRow(
                    'Knowledge Articles', '${_linkedKnowledge.length}'),
              ],
            ),
          ),

          if (aliases.isNotEmpty) ...[
            const SizedBox(height: 20),
            GlassCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'KNOWN ALIASES',
                    style: TextStyle(
                      color: AppColors.textTertiary,
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: aliases.map((alias) {
                      return Chip(
                        label:
                            Text(alias, style: const TextStyle(fontSize: 12)),
                        backgroundColor: AppColors.surface,
                        side: BorderSide(color: AppColors.border),
                        labelStyle:
                            const TextStyle(color: AppColors.textPrimary),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEquipmentTab() {
    if (_linkedEquipment.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.inventory_2_outlined,
                size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('No equipment linked',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _linkedEquipment.length,
      itemBuilder: (context, index) {
        final eq = _linkedEquipment[index];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  _iconForType(eq.equipmentType),
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eq.serialNumber ?? 'No Serial',
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${eq.manufacturer ?? ''} ${eq.model ?? ''}'.trim(),
                      style: TextStyle(
                          color: AppColors.textSecondary, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: eq.active
                      ? AppColors.success.withValues(alpha: 0.1)
                      : AppColors.error.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  eq.active ? 'ACTIVE' : 'INACTIVE',
                  style: TextStyle(
                    color: eq.active ? AppColors.success : AppColors.error,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKnowledgeTab() {
    if (_linkedKnowledge.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.library_books_outlined,
                size: 48, color: AppColors.textTertiary),
            const SizedBox(height: 12),
            Text('No knowledge articles linked',
                style: TextStyle(color: AppColors.textSecondary)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _linkedKnowledge.length,
      itemBuilder: (context, index) {
        final entry = _linkedKnowledge[index];
        return GlassCard(
          margin: const EdgeInsets.only(bottom: 12),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    EnhancedKnowledgeEntryView(entryId: entry.id),
              ),
            );
          },
          child: Row(
            children: [
              const Icon(Icons.article_outlined,
                  color: AppColors.primary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      entry.category,
                      style: TextStyle(
                          color: AppColors.textTertiary, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white24, size: 14),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
          ),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type.toLowerCase()) {
      case 'counter':
        return Icons.calculate_outlined;
      case 'atm':
        return Icons.atm;
      case 'dvr':
        return Icons.videocam_outlined;
      case 'lock':
        return Icons.lock_outline;
      case 'safe':
        return Icons.shield_outlined;
      default:
        return Icons.precision_manufacturing_outlined;
    }
  }
}
