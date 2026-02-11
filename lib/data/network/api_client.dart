import 'package:dio/dio.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

/// Singleton Dio instance pre-configured with auth, error, and logging interceptors.
///
/// Call [ApiClient.configure] once during app startup (inside [AppInitializer.initialize]).
///
/// Usage:
///   ApiClient.configure(
///     baseUrl: AppConstants.baseUrl,
///     tokenProvider: () async => myAuthService.getToken(),
///   );
///   final dio = ApiClient.instance.dio;
class ApiClient {
  ApiClient._();
  static ApiClient? _instance;

  late final Dio dio;

  static ApiClient get instance {
    assert(
      _instance != null,
      'ApiClient.configure() must be called before accessing instance.',
    );
    return _instance!;
  }

  /// Idempotent — safe to call multiple times; only the first call takes effect.
  static void configure({
    required String baseUrl,
    required Future<String?> Function() tokenProvider,
  }) {
    if (_instance != null) return;

    final client = ApiClient._();
    client.dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    // Interceptor order: Auth → Error → Logging
    client.dio.interceptors.addAll([
      AuthInterceptor(tokenProvider: tokenProvider),
      ErrorInterceptor(),
      LoggingInterceptor(),
    ]);

    _instance = client;
  }
}
