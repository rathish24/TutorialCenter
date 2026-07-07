import 'dart:io';
import 'package:dio/dio.dart';

/// Interceptor that retries temporary request failures (timeouts, 503s) 
/// using an exponential backoff algorithm.
class RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration baseDelay;

  RetryInterceptor({
    required this.dio,
    this.maxRetries = 3,
    this.baseDelay = const Duration(seconds: 1),
  });

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    var attempt = err.requestOptions.extra['retry_attempt'] as int? ?? 0;
    
    if (_shouldRetry(err) && attempt < maxRetries) {
      attempt++;
      err.requestOptions.extra['retry_attempt'] = attempt;

      // Exponential Backoff: delay = baseDelay * (2 ^ (attempt - 1))
      final delay = baseDelay * (1 << (attempt - 1));
      await Future.delayed(delay);

      try {
        final response = await dio.fetch(err.requestOptions);
        return handler.resolve(response);
      } on DioException catch (newErr) {
        return handler.next(newErr);
      }
    }
    handler.next(err);
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return true;
    }
    
    final statusCode = err.response?.statusCode;
    if (statusCode != null) {
      return statusCode == 500 || statusCode == 503 || statusCode == 504;
    }
    
    if (err.error is SocketException) {
      return true;
    }
    
    return false;
  }
}
