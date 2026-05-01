import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A premium card component that implements the 2026 "Mica" / Glassmorphism design pattern.
///
/// Features:
/// - Real-time background blur (BackdropFilter)
/// - Subtle translucent gradients (AppGradients.glassSurface)
/// - "Shine" border effect
/// - Optimized for dark mode
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final bool hasShine;
  final Color? activeBorderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.borderRadius = AppLayout.radiusLG,
    this.hasShine = true,
    this.activeBorderColor,
  });

  @override
  Widget build(BuildContext context) {
    // Current design trend: Layering
    // 1. Container for Margin
    // 2. ClipRRect for Blur
    // 3. BackdropFilter for Blur
    // 4. Container for Gradient & Border
    // 5. InkWell for Touch

    return Container(
      margin: margin,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppGlass.blurSigma,
            sigmaY: AppGlass.blurSigma,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: AppGradients.glassSurface,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: activeBorderColor ?? Colors.white.withValues(alpha: 0.1),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: -5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                borderRadius: BorderRadius.circular(borderRadius),
                splashColor: AppColors.primary.withValues(alpha: 0.1),
                highlightColor: Colors.white.withValues(alpha: 0.05),
                child: Padding(
                  padding: padding ?? AppLayout.cardPaddingAll,
                  child: child,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
