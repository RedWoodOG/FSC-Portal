import 'package:flutter/material.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';

class EquipmentCard extends StatelessWidget {
  final EquipmentData equipment;
  final VoidCallback onTap;

  const EquipmentCard({
    super.key,
    required this.equipment,
    required this.onTap,
  });

  IconData _getEquipmentIcon(String type) {
    switch (type.toLowerCase()) {
      case 'atm':
        return Icons.atm;
      case 'counter':
      case 'currency counter':
        return Icons.calculate;
      case 'dvr':
        return Icons.video_camera_back;
      case 'lock':
        return Icons.lock;
      case 'scanner':
      case 'check scanner':
        return Icons.scanner;
      default:
        return Icons.devices;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.surface,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: AppColors.border),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Icon
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  _getEquipmentIcon(equipment.equipmentType),
                  color: AppColors.primary,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              // Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Equipment Type
                    Text(
                      equipment.equipmentType,
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    // Model/Manufacturer
                    if (equipment.model != null || equipment.manufacturer != null)
                      Text(
                        [equipment.manufacturer, equipment.model]
                            .where((e) => e != null && e.isNotEmpty)
                            .join(' '),
                        style: AppTypography.bodyText.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    const SizedBox(height: 4),
                    // Serial Number
                    if (equipment.serialNumber != null && equipment.serialNumber!.isNotEmpty)
                      Row(
                        children: [
                          Icon(Icons.qr_code, size: 14, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            'S/N: ${equipment.serialNumber}',
                            style: AppTypography.bodyText.copyWith(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
              // Status Badges
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (equipment.underWarranty)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Warranty',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (equipment.underServiceContract)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.blue.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Contract',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  if (!equipment.active)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.red.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        'Inactive',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
