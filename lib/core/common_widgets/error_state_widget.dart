import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';

/// A full-screen-centered error state with an optional retry button.
///
/// Usage:
///   if (hasError)
///     ErrorStateWidget(message: errorMessage, onRetry: _load)
class ErrorStateWidget extends StatelessWidget {
  const ErrorStateWidget({
    super.key,
    this.title,
    this.message,
    this.onRetry,
    this.icon,
  });

  final String? title;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.error_outline_rounded,
              size: 72,
              color: AppColors.errorColor,
            ),
            const SizedBox(height: 16),
            Text(
              title ?? AppStrings.errorTitle.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              message ?? AppStrings.errorSubtitle.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: 24),
              FilledButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh),
                label: Text(AppStrings.retry.tr()),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
