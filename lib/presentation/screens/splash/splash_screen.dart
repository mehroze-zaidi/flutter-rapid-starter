import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../router/app_routes.dart';

/// Splash screen shown on every launch.
///
/// Checks whether the user has completed onboarding:
/// - First launch → [AppRoutes.onboarding]
/// - Returning user → [AppRoutes.home]
///
/// The check runs in parallel with a minimum 2-second display time
/// for a smooth branded experience.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigate();
  }

  Future<void> _navigate() async {
    final results = await Future.wait([
      Future.delayed(const Duration(seconds: 2)),
      SecureStorageService.instance.read(StorageKeys.onboardingCompleted),
    ]);

    if (!mounted) return;

    final onboardingDone = results[1] as String?;
    if (onboardingDone != null) {
      context.go(AppRoutes.home);
    } else {
      context.go(AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator.adaptive()),
    );
  }
}
