import 'package:flutter/material.dart';

/// Animated dot indicators for a [PageView].
///
/// The active dot is wider and uses the primary color.
/// Inactive dots are smaller and use a muted color.
///
/// Usage:
///   DotIndicators(count: 3, currentIndex: _currentPage)
class DotIndicators extends StatelessWidget {
  const DotIndicators({
    super.key,
    required this.count,
    required this.currentIndex,
    this.activeColor,
    this.inactiveColor,
    this.dotHeight = 8,
    this.activeDotWidth = 24,
    this.inactiveDotWidth = 8,
  });

  final int count;
  final int currentIndex;
  final Color? activeColor;
  final Color? inactiveColor;
  final double dotHeight;
  final double activeDotWidth;
  final double inactiveDotWidth;

  @override
  Widget build(BuildContext context) {
    final active = activeColor ?? Theme.of(context).colorScheme.primary;
    final inactive = inactiveColor ?? active.withValues(alpha: 0.3);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: dotHeight,
          width: isActive ? activeDotWidth : inactiveDotWidth,
          decoration: BoxDecoration(
            color: isActive ? active : inactive,
            borderRadius: BorderRadius.circular(dotHeight / 2),
          ),
        );
      }),
    );
  }
}
