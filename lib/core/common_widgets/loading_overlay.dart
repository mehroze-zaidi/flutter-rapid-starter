import 'package:flutter/material.dart';

/// Wraps a [child] and shows a modal loading overlay when [isLoading] is true.
///
/// The overlay blocks user interaction while visible.
///
/// Usage:
///   LoadingOverlay(
///     isLoading: _isLoading,
///     child: MyContent(),
///   )
class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.loadingWidget,
    this.overlayColor,
  });

  final bool isLoading;
  final Widget child;

  /// Custom widget shown in the center of the overlay.
  /// Defaults to [CircularProgressIndicator.adaptive].
  final Widget? loadingWidget;

  /// Background color of the overlay. Defaults to semi-transparent black.
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: ColoredBox(
              color: overlayColor ?? Colors.black.withValues(alpha: 0.4),
              child: Center(
                child: loadingWidget ?? const CircularProgressIndicator.adaptive(),
              ),
            ),
          ),
      ],
    );
  }
}
