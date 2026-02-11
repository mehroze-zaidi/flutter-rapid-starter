import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/connectivity_service.dart';
import '../../router/app_routes.dart';

/// Full-screen no-internet overlay with Lottie animation and a retry button.
///
/// Shown automatically by [YourApp] when connectivity is lost.
/// Dismisses automatically when connectivity is restored (popped by [YourApp]),
/// or manually via the retry button.
class NoConnectionScreen extends StatefulWidget {
  const NoConnectionScreen({super.key});

  @override
  State<NoConnectionScreen> createState() => _NoConnectionScreenState();
}

class _NoConnectionScreenState extends State<NoConnectionScreen> {
  bool _isRetrying = false;

  Future<void> _retry() async {
    setState(() => _isRetrying = true);
    await Future.delayed(const Duration(milliseconds: 800));
    await ConnectivityService.instance.initialize();
    if (ConnectivityService.instance.isConnected && mounted) {
      context.go(AppRoutes.splash);
    }
    if (mounted) setState(() => _isRetrying = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/no_connection.zip',
                  width: 240,
                  height: 240,
                  repeat: true,
                ),
                const SizedBox(height: 24),
                Text(
                  AppStrings.noInternetTitle.tr(),
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  AppStrings.noInternetSubtitle.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                _isRetrying
                    ? const CircularProgressIndicator.adaptive()
                    : FilledButton.icon(
                        onPressed: _retry,
                        icon: const Icon(Icons.refresh),
                        label: Text(AppStrings.retry.tr()),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
