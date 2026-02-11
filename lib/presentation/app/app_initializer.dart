import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import '../../core/constants/app_constants.dart';
import '../../data/network/api_client.dart';

/// Performs all async initialization before [runApp] is called.
///
/// Call via [AppInitializer.initialize] inside an async [main].
class AppInitializer {
  AppInitializer._();

  static Future<void> initialize() async {
    // 1. Ensure Flutter is ready for platform channel calls
    WidgetsFlutterBinding.ensureInitialized();

    // 2. easy_localization
    await EasyLocalization.ensureInitialized();

    // 3. Dio — tokenProvider returns null by default.
    //    Replace with your auth token source when adding authentication.
    ApiClient.configure(
      baseUrl: AppConstants.baseUrl,
      tokenProvider: () async => null,
    );
  }
}
