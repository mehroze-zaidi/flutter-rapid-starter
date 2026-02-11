import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum SnackbarType { success, error, warning, info }

/// Shows styled floating snackbars via [ScaffoldMessenger].
///
/// Two ways to use:
///
/// 1. With a [BuildContext] (inside a widget):
///    SnackbarHelper.show(context, message: 'Saved!', type: SnackbarType.success);
///
/// 2. Without a context (from a service or interceptor):
///    SnackbarHelper.showGlobal(message: 'Error', type: SnackbarType.error);
///    Requires [messengerKey] to be assigned to [MaterialApp.scaffoldMessengerKey].
class SnackbarHelper {
  SnackbarHelper._();

  /// Assign to [MaterialApp.scaffoldMessengerKey] in your root widget.
  static final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static void show(
    BuildContext context, {
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(_build(message, type, duration));
  }

  static void showGlobal({
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    messengerKey.currentState
      ?..hideCurrentSnackBar()
      ..showSnackBar(_build(message, type, duration));
  }

  static SnackBar _build(String message, SnackbarType type, Duration duration) {
    return SnackBar(
      content: Row(
        children: [
          Icon(_iconFor(type), color: Colors.white, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
      backgroundColor: _colorFor(type),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.all(16),
    );
  }

  static Color _colorFor(SnackbarType type) => switch (type) {
    SnackbarType.success => AppColors.successColor,
    SnackbarType.error => AppColors.errorColor,
    SnackbarType.warning => const Color(0xFFFF9800),
    SnackbarType.info => const Color(0xFF2196F3),
  };

  static IconData _iconFor(SnackbarType type) => switch (type) {
    SnackbarType.success => Icons.check_circle_outline,
    SnackbarType.error => Icons.error_outline,
    SnackbarType.warning => Icons.warning_amber_outlined,
    SnackbarType.info => Icons.info_outline,
  };
}
