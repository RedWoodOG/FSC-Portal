import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';
import 'machine_profile_view.dart';

class EquipmentDetailSheet extends StatelessWidget {
  final EquipmentData equipment;

  const EquipmentDetailSheet({super.key, required this.equipment});

  @override
  Widget build(BuildContext context) {
    final db = context.read<AppDatabase>();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle Bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.border,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          // Header
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        equipment.equipmentType,
                        style: AppTypography.headlineSmall.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (equipment.model != null ||
                          equipment.manufacturer != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          [equipment.manufacturer, equipment.model]
                              .where((e) => e != null && e.isNotEmpty)
                              .join(' '),
                          style: AppTypography.bodyText.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          const Divider(color: AppColors.border),
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Serial Number
                  if (equipment.serialNumber != null &&
                      equipment.serialNumber!.isNotEmpty) ...[
                    _buildDetailRow(
                      icon: Icons.qr_code,
                      label: 'Serial Number',
                      value: equipment.serialNumber!,
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Status Badges
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      if (equipment.underWarranty)
                        _buildStatusChip('Under Warranty', Colors.green),
                      if (equipment.underServiceContract)
                        _buildStatusChip('Service Contract', Colors.blue),
                      if (!equipment.active)
                        _buildStatusChip('Inactive', Colors.red),
                      if (equipment.active &&
                          !equipment.underWarranty &&
                          !equipment.underServiceContract)
                        _buildStatusChip('Active', Colors.green),
                    ],
                  ),
                  if (equipment.contractReference != null &&
                      equipment.contractReference!.isNotEmpty) ...[
                    const SizedBox(height: 16),
                    _buildDetailRow(
                      icon: Icons.description,
                      label: 'Contract Reference',
                      value: equipment.contractReference!,
                    ),
                  ],
                  const SizedBox(height: 24),
                  // Location Info (if siteId is available)
                  FutureBuilder<Site?>(
                    future: db.getSiteById(equipment.siteId),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data != null) {
                        final site = snapshot.data!;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Location',
                              style: AppTypography.headlineSmall.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: Icons.business,
                              label: 'Branch',
                              value: site.branchName,
                            ),
                            const SizedBox(height: 8),
                            _buildDetailRow(
                              icon: Icons.location_on,
                              label: 'Address',
                              value: site.address,
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  // Machine Profile link
                  if (equipment.machineProfileId != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        icon:
                            const Icon(Icons.precision_manufacturing_outlined),
                        label: const Text('View Machine Profile'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.primary,
                          side: const BorderSide(color: AppColors.primary),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => MachineProfileView(
                                profileId: equipment.machineProfileId!,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.primary),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTypography.bodyText.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: AppTypography.bodyText.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
