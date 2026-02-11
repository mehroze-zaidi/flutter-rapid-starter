import 'package:dio/dio.dart';
import '../../../core/constants/app_strings.dart';

/// Maps Dio errors to human-readable messages from [AppStrings].
///
/// Enriches [DioException.message] so consumers can display it directly
/// without parsing raw error types or status codes.
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    handler.next(_enrichError(err));
  }

  DioException _enrichError(DioException err) {
    final message = switch (err.type) {
      DioExceptionType.connectionTimeout ||
      DioExceptionType.sendTimeout ||
      DioExceptionType.receiveTimeout =>
        AppStrings.errorTimeout,
      DioExceptionType.connectionError => AppStrings.errorConnection,
      DioExceptionType.badResponse =>
        _messageFromStatusCode(err.response?.statusCode),
      _ => AppStrings.errorUnknown,
    };
    return err.copyWith(message: message);
  }

  String _messageFromStatusCode(int? code) => switch (code) {
    401 => AppStrings.error401,
    403 => AppStrings.error403,
    404 => AppStrings.error404,
    int c when c >= 500 => AppStrings.error500,
    _ => AppStrings.errorUnknown,
  };
}
