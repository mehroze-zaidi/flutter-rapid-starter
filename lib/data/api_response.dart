/// A sealed class representing either a successful response or a failure.
///
/// Usage:
///   final result = await repository.fetchUser(id);
///   switch (result) {
///     case Success(:final data): print(data);
///     case Failure(:final message, :final statusCode): showError(message);
///   }
sealed class ApiResponse<T> {
  const ApiResponse();
}

final class Success<T> extends ApiResponse<T> {
  final T data;
  const Success(this.data);
}

final class Failure<T> extends ApiResponse<T> {
  final String message;
  final int? statusCode;
  final Object? exception;

  const Failure({
    required this.message,
    this.statusCode,
    this.exception,
  });
}
