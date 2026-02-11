import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Logs HTTP requests, responses, and errors using the [logger] package.
/// Automatically disabled in release mode.
class LoggingInterceptor extends Interceptor {
  final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 5,
      lineLength: 80,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kReleaseMode) {
      _logger.d(
        '[REQUEST] ${options.method} ${options.uri}\n'
        'Headers: ${options.headers}\n'
        '${options.data != null ? "Body: ${options.data}" : ""}',
      );
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!kReleaseMode) {
      _logger.d(
        '[RESPONSE] ${response.statusCode} ${response.requestOptions.uri}\n'
        'Data: ${response.data}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kReleaseMode) {
      _logger.e(
        '[ERROR] ${err.response?.statusCode} ${err.requestOptions.uri}\n'
        'Message: ${err.message}',
        error: err,
      );
    }
    handler.next(err);
  }
}
