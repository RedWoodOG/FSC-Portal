import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../database/app_database.dart';
import '../../theme/app_theme.dart';

class CourseDetailView extends StatelessWidget {
  final ContinuingEducationCourse course;

  const CourseDetailView({super.key, required this.course});

  String _getCategoryColor(String category) {
    switch (category) {
      case 'Technical':
        return '#4CAF50';
      case 'Safety':
        return '#FF9800';
      case 'Compliance':
        return '#2196F3';
      case 'HR':
        return '#9C27B0';
      default:
        return '#757575';
    }
  }

  Future<void> _launchExternalUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryColor = _getCategoryColor(course.category);

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
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Color(int.parse(categoryColor.replaceFirst('#', '0xFF'))),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          course.category,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        course.title,
                        style: AppTypography.headlineSmall.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.business, size: 18, color: AppColors.textSecondary),
                          const SizedBox(width: 6),
                          Text(
                            course.provider,
                            style: AppTypography.bodyText.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
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
                  // Duration
                  if (course.durationHours != null)
                    Row(
                      children: [
                        Icon(Icons.access_time, color: AppColors.primary),
                        const SizedBox(width: 8),
                        Text(
                          'Duration: ${course.durationHours} hours',
                          style: AppTypography.bodyText.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 24),
                  // Description
                  if (course.description != null && course.description!.isNotEmpty) ...[
                    Text(
                      'Description',
                      style: AppTypography.headlineSmall.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      course.description!,
                      style: AppTypography.bodyText,
                    ),
                    const SizedBox(height: 24),
                  ],
                  // External Link Button
                  if (course.externalUrl != null && course.externalUrl!.isNotEmpty) ...[
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _launchExternalUrl(course.externalUrl!),
                        icon: const Icon(Icons.open_in_new),
                        label: const Text('Open Course Link'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.textPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
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
}
