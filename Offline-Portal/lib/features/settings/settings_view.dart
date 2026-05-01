import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import '../../widgets/glass_card.dart';
import '../auth/security_settings_screen.dart';
import '../auth/auth_state.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  String _selectedCategory = 'general';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppGradients.deepOcean,
        ),
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(32),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _buildContent(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 48, 32, 24),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.2),
        border: Border(
            bottom: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Row(
        children: [
          Hero(
            tag: 'settings_icon',
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.settings_outlined,
                  color: AppColors.primary, size: 28),
            ),
          ),
          const SizedBox(width: 24),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "SYSTEM CONFIGURATION",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                "TERMINAL v2.0.26 // OFFLINE PRIORITY",
                style: TextStyle(
                  color: Colors.white24,
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.2,
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildCategorySelector(),
        ],
      ),
    );
  }

  Widget _buildCategorySelector() {
    return GlassCard(
      padding: const EdgeInsets.all(4),
      borderRadius: 12,
      child: Row(
        children: [
          _buildCategoryItem("GENERAL", Icons.tune, 'general'),
          _buildCategoryItem("KNOWLEDGE", Icons.menu_book, 'knowledge'),
          _buildCategoryItem("SECURITY", Icons.security, 'security'),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String label, IconData icon, String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () => setState(() => _selectedCategory = category),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon,
                size: 16, color: isSelected ? Colors.white : Colors.white38),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white38,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
    switch (_selectedCategory) {
      case 'knowledge':
        return _buildKnowledgeTab();
      case 'security':
        return _buildSecurityTab();
      default:
        return _buildGeneralTab();
    }
  }

  Widget _buildGeneralTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("INTERFACE PREFERENCES"),
        const SizedBox(height: 24),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          childAspectRatio: 2.5,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            _buildToggleCard(
                "OFFLINE-FIRST MODE",
                "Prioritize local storage and sync in background.",
                true,
                (v) {}),
            _buildToggleCard("BIOMETRIC ACCESS",
                "Require Windows Hello for secure stop entry.", false, (v) {}),
            _buildToggleCard("HIGH DENSITY UI",
                "Maximize information display for wide screens.", true, (v) {}),
            _buildToggleCard("DYNAMICY COLOR",
                "Allow client themes to color map markers.", true, (v) {}),
          ],
        ),
        const SizedBox(height: 48),
        _buildSectionHeader("SYSTEM HEALTH"),
        const SizedBox(height: 24),
        GlassCard(
          padding: const EdgeInsets.all(24),
          child: Row(
            children: [
              _buildHealthMetric("CPU", "12%", AppColors.success),
              _buildSeparator(),
              _buildHealthMetric("STORAGE", "1.2 GB", AppColors.primary),
              _buildSeparator(),
              _buildHealthMetric("DATABASE", "HEALTHY", AppColors.success),
              _buildSeparator(),
              _buildHealthMetric("LATENCY", "42ms", AppColors.success),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildKnowledgeTab() {
    final db = context.watch<AppDatabase>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader("DATA INGESTION ENGINE"),
        const SizedBox(height: 24),
        StreamBuilder<List<KnowledgeEntry>>(
          stream: db.watchAllKnowledgeEntries(),
          builder: (context, snapshot) {
            final count = snapshot.data?.length ?? 0;
            return GlassCard(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Row(
                    children: [
                      _buildMetricBox("INDEXED ENTRIES", count.toString(),
                          Colors.tealAccent),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("LOCAL KNOWLEDGE REPOSITORY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 4),
                            Text(
                              "Files stored at C:\\Portal_Knowledge_Staging\\knowledge_entries",
                              style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  Row(
                    children: [
                      Expanded(
                          child: _buildActionButton(
                              "REBUILD INDEX",
                              Icons.refresh,
                              () => _ingestKnowledgeEntries(db))),
                      const SizedBox(width: 16),
                      Expanded(
                          child: _buildActionButton(
                              "EXPORT DATA", Icons.ios_share, () {})),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSecurityTab() {
    final authState = context.watch<AuthState>();
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('AUTHENTICATION'),
          const SizedBox(height: 16),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.shield_outlined,
                          color: AppColors.primary, size: 24),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Password & PIN',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16)),
                          const SizedBox(height: 4),
                          Text(
                            authState.hasPinSet
                                ? 'Password set \u2022 PIN enabled'
                                : 'Password set \u2022 No PIN',
                            style: TextStyle(
                                color: AppColors.textSecondary, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const SecuritySettingsScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: const Text('MANAGE',
                          style: TextStyle(
                              fontWeight: FontWeight.w800, letterSpacing: 1)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionHeader('SESSION'),
          const SizedBox(height: 16),
          _buildToggleCard(
            'Auto-Lock',
            'Lock session after 15 minutes of inactivity',
            true,
            (val) {},
          ),
          const SizedBox(height: 12),
          GlassCard(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Sign Out',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 13)),
                      const SizedBox(height: 4),
                      Text('End current session and return to login',
                          style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.4),
                              fontSize: 11)),
                    ],
                  ),
                ),
                OutlinedButton(
                  onPressed: () {
                    authState.logout();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.error,
                    side: const BorderSide(color: AppColors.error),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('SIGN OUT',
                      style: TextStyle(
                          fontWeight: FontWeight.w800, letterSpacing: 1)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.4),
        fontSize: 11,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
      ),
    );
  }

  Widget _buildToggleCard(
      String title, String desc, bool value, ValueChanged<bool> onChanged) {
    return GlassCard(
      padding: const EdgeInsets.all(24),
      borderRadius: 20,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 13)),
                const SizedBox(height: 4),
                Text(desc,
                    style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 11)),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.2),
          ),
        ],
      ),
    );
  }

  Widget _buildHealthMetric(String label, String value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.white38,
                  fontSize: 10,
                  fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 18, fontWeight: FontWeight.w900)),
        ],
      ),
    );
  }

  Widget _buildMetricBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(value,
              style: TextStyle(
                  color: color, fontSize: 24, fontWeight: FontWeight.w900)),
          Text(label,
              style: TextStyle(
                  color: color.withValues(alpha: 0.5),
                  fontSize: 9,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSeparator() => Container(
      height: 32, width: 1, color: Colors.white.withValues(alpha: 0.05));

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 18),
      label: Text(label,
          style: const TextStyle(
              fontSize: 12, fontWeight: FontWeight.w900, letterSpacing: 1)),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 20),
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        foregroundColor: Colors.white,
        side: const BorderSide(color: Colors.white10),
      ),
    );
  }

  Future<void> _ingestKnowledgeEntries(AppDatabase db) async {
    final knowledgeDir = r'C:\Portal_Knowledge_Staging\knowledge_entries';
    if (!Directory(knowledgeDir).existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Source directory missing: $knowledgeDir'),
          backgroundColor: Colors.red));
      return;
    }

    try {
      await db.clearAllKnowledgeEntries();
      final dir = Directory(knowledgeDir);
      final mdFiles = dir
          .listSync(recursive: true)
          .whereType<File>()
          .where((f) => f.path.endsWith('.md'))
          .toList();

      int success = 0;
      for (final file in mdFiles) {
        final content = await file.readAsString();
        String title = path.basenameWithoutExtension(file.path);
        String? category;

        if (content.startsWith('---')) {
          final yamlMatch =
              RegExp(r'---\s*\n(.*?)\n---', dotAll: true).firstMatch(content);
          if (yamlMatch != null) {
            final doc = loadYaml(yamlMatch.group(1)!);
            if (doc is Map) {
              title = doc['title']?.toString() ?? title;
              category = doc['category']?.toString();
            }
          }
        }

        await db.insertOrReplaceKnowledge(
          KnowledgeEntriesCompanion.insert(
            id: title.toLowerCase().replaceAll(' ', '-'),
            title: title,
            category: category ?? 'General',
            content: content,
            equipmentType: 'general',
            sourceType: 'settings_import',
            sourceFile: path.basename(file.path),
            version: '1.0.0',
            status: 'active',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
        );
        success++;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('INDEX REBUILT: $success ENTRIES PROCESSED'),
            backgroundColor: AppColors.success));
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('FAILURE: $e'), backgroundColor: Colors.red));
    }
  }
}
