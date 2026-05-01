import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        // Watermark FIRST - behind all content
        Positioned.fill(
          child: IgnorePointer(
            child: Align(
              alignment: const Alignment(0, 0.35), // Push watermark down away from content
              child: Opacity(
                opacity: isDark ? 0.025 : 0.045,
                child: FractionallySizedBox(
                  widthFactor: 0.6,
                  child: SvgPicture.asset(
                    'assets/FSC_Logo.svg',
                    color: isDark
                        ? Colors.blueGrey.shade700
                        : Colors.grey.shade400,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
        // App content SECOND - floats above watermark
        child,
      ],
    );
  }
}
