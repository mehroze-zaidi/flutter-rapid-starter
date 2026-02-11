import 'package:dio/dio.dart';
import '../api_response.dart';
import '../network/api_client.dart';

/// Base class for all remote data repositories.
///
/// Provides generic CRUD helpers that wrap Dio calls in [ApiResponse],
/// so every call site gets a type-safe Success/Failure result.
///
/// Usage — extend for a feature:
///   class UserRepository extends RemoteRepository {
///     Future<ApiResponse<User>> fetchUser(String id) =>
///         get('/users/$id', fromJson: User.fromJson);
///   }
class RemoteRepository {
  Dio get _dio => ApiClient.instance.dio;

  /// GET request. [fromJson] converts the response map to [T].
  Future<ApiResponse<T>> get<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>(
        path,
        queryParameters: queryParameters,
        options: Options(extra: extra),
      );
      return Success(fromJson(response.data!));
    } on DioException catch (e) {
      return Failure(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
        exception: e,
      );
    } catch (e) {
      return Failure(message: e.toString(), exception: e);
    }
  }

  /// POST request.
  Future<ApiResponse<T>> post<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> body,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _dio.post<Map<String, dynamic>>(
        path,
        data: body,
        options: Options(extra: extra),
      );
      return Success(fromJson(response.data!));
    } on DioException catch (e) {
      return Failure(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
        exception: e,
      );
    } catch (e) {
      return Failure(message: e.toString(), exception: e);
    }
  }

  /// PUT request.
  Future<ApiResponse<T>> put<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    required Map<String, dynamic> body,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _dio.put<Map<String, dynamic>>(
        path,
        data: body,
        options: Options(extra: extra),
      );
      return Success(fromJson(response.data!));
    } on DioException catch (e) {
      return Failure(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
        exception: e,
      );
    } catch (e) {
      return Failure(message: e.toString(), exception: e);
    }
  }

  /// DELETE request.
  Future<ApiResponse<T>> delete<T>(
    String path, {
    required T Function(Map<String, dynamic>) fromJson,
    Map<String, dynamic>? extra,
  }) async {
    try {
      final response = await _dio.delete<Map<String, dynamic>>(
        path,
        options: Options(extra: extra),
      );
      return Success(fromJson(response.data!));
    } on DioException catch (e) {
      return Failure(
        message: e.message ?? 'Unknown error',
        statusCode: e.response?.statusCode,
        exception: e,
      );
    } catch (e) {
      return Failure(message: e.toString(), exception: e);
    }
  }
}
