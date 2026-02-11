import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/app_theme.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/utils/snackbar_helper.dart';
import '../router/app_router.dart';
import '../router/app_routes.dart';

/// The root widget of the application.
///
/// Responsibilities:
/// - Wraps the tree with [EasyLocalization] for i18n support
/// - Wraps with [ScreenUtilInit] for responsive sizing
/// - Mounts [MaterialApp.router] with [AppRouter.router]
/// - Attaches [SnackbarHelper.messengerKey] for app-wide snackbars
/// - Listens to [ConnectivityService] and navigates to the no-connection
///   screen when offline, then pops it when back online
class YourApp extends StatefulWidget {
  const YourApp({super.key});

  @override
  State<YourApp> createState() => _YourAppState();
}

class _YourAppState extends State<YourApp> {
  bool _isShowingNoConnection = false;

  @override
  void initState() {
    super.initState();
    _listenToConnectivity();
  }

  void _listenToConnectivity() {
    ConnectivityService.instance.onConnectivityChanged.listen((isConnected) {
      if (!isConnected && !_isShowingNoConnection) {
        _isShowingNoConnection = true;
        AppRouter.router.push(AppRoutes.noConnection).then((_) {
          _isShowingNoConnection = false;
        });
      } else if (isConnected && _isShowingNoConnection) {
        AppRouter.router.pop();
        _isShowingNoConnection = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: AppConstants.translationsPath,
      fallbackLocale: AppConstants.fallbackLocale,
      child: ScreenUtilInit(
        designSize: const Size(
          AppConstants.designWidth,
          AppConstants.designHeight,
        ),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            title: 'Flutter Rapid Starter',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            routerConfig: AppRouter.router,
            scaffoldMessengerKey: SnackbarHelper.messengerKey,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}
