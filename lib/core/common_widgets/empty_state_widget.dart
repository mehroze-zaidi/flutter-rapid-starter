import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants/app_strings.dart';

/// A full-screen-centered empty state with an optional action widget.
///
/// Usage:
///   if (items.isEmpty) const EmptyStateWidget()
class EmptyStateWidget extends StatelessWidget {
  const EmptyStateWidget({
    super.key,
    this.title,
    this.subtitle,
    this.icon,
    this.action,
  });

  final String? title;
  final String? subtitle;
  final IconData? icon;

  /// Optional action widget (e.g. a button to add the first item).
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon ?? Icons.inbox_outlined,
              size: 72,
              color: Theme.of(context).colorScheme.secondary,
            ),
            const SizedBox(height: 16),
            Text(
              title ?? AppStrings.emptyTitle.tr(),
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle ?? AppStrings.emptySubtitle.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              const SizedBox(height: 24),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}
