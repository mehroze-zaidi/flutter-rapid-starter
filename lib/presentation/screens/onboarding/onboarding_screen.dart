import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/services/secure_storage_service.dart';
import '../../router/app_routes.dart';
import 'widgets/dot_indicators.dart';
import 'widgets/onboarding_page.dart';

/// 3-slide onboarding flow shown on first app launch.
///
/// On completion, writes [StorageKeys.onboardingCompleted] to secure storage
/// and navigates to [AppRoutes.home].
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  static const _pageCount = 3;

  List<({String title, String description, IconData icon})> get _pages => [
        (
          title: AppStrings.onboardingTitle1.tr(),
          description: AppStrings.onboardingDesc1.tr(),
          icon: Icons.waving_hand_outlined,
        ),
        (
          title: AppStrings.onboardingTitle2.tr(),
          description: AppStrings.onboardingDesc2.tr(),
          icon: Icons.wifi_outlined,
        ),
        (
          title: AppStrings.onboardingTitle3.tr(),
          description: AppStrings.onboardingDesc3.tr(),
          icon: Icons.rocket_launch_outlined,
        ),
      ];

  bool get _isLastPage => _currentPage == _pageCount - 1;

  void _onPageChanged(int index) {
    setState(() => _currentPage = index);
  }

  void _nextPage() {
    _controller.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _complete() async {
    await SecureStorageService.instance
        .write(StorageKeys.onboardingCompleted, 'true');
    if (mounted) context.go(AppRoutes.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: AlignmentDirectional.topEnd,
              child: TextButton(
                onPressed: _complete,
                child: Text(AppStrings.skip.tr()),
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pageCount,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return OnboardingPage(
                    title: page.title,
                    description: page.description,
                    icon: page.icon,
                  );
                },
              ),
            ),

            // Bottom: dots + button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  DotIndicators(
                    count: _pageCount,
                    currentIndex: _currentPage,
                  ),
                  FilledButton(
                    onPressed: _isLastPage ? _complete : _nextPage,
                    child: Text(
                      _isLastPage
                          ? AppStrings.getStarted.tr()
                          : AppStrings.next.tr(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
