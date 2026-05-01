import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/app_theme.dart';
import 'eva_state.dart';

/// EVA Collapsed Rail - Slim vertical rail when EVA is collapsed
/// Still visible, still clickable, preserves spatial memory
class EvaCollapseRail extends StatelessWidget {
  const EvaCollapseRail({super.key});

  @override
  Widget build(BuildContext context) {
    final evaState = context.watch<EvaState>();

    return Container(
      width: 56, // Collapsed width
      color: AppColors.surface,
      child: Column(
        children: [
          // Top spacer
          const SizedBox(height: 24),
          // EVA indicator/button
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                evaState.setExpanded(true);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: evaState.hasUnread
                        ? AppColors.primary
                        : AppColors.border,
                    width: evaState.hasUnread ? 2 : 1,
                  ),
                ),
                child: const Icon(
                  Icons.auto_awesome,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Unread indicator if present
          if (evaState.hasUnread)
            Container(
              width: 8,
              height: 8,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
          const Spacer(),
          // Expand hint
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: RotatedBox(
              quarterTurns: 1,
              child: Text(
                'EVA',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
