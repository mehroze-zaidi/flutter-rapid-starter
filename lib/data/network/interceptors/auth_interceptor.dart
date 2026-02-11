import 'package:dio/dio.dart';

/// Attaches a Bearer token to every request that requires authentication.
///
/// The [tokenProvider] is called lazily on each request so the token is
/// always fresh (e.g. after a token refresh).
///
/// To mark a request as public (no auth header), add:
///   options.extra['requiresAuth'] = false
class AuthInterceptor extends Interceptor {
  final Future<String?> Function() tokenProvider;

  const AuthInterceptor({required this.tokenProvider});

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.extra['requiresAuth'] == false) {
      return handler.next(options);
    }

    final token = await tokenProvider();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
