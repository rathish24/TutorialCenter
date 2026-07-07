import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Interceptor that prints formatted network requests and responses in debug mode, 
/// and streams errors to an external logger in production.
class LoggingInterceptor extends Interceptor {
  final bool isDebug;
  final void Function(String message)? externalLogger;

  LoggingInterceptor({required this.isDebug, this.externalLogger});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (isDebug) {
      _log('🌐 [REQ] [${options.method}] ${options.uri}');
      _log('Headers: ${options.headers}');
      if (options.data != null) _log('Body: ${options.data}');
    }
    options.extra['request_start_time'] = DateTime.now().millisecondsSinceEpoch;
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (isDebug) {
      final duration = _getDuration(response.requestOptions);
      _log('✅ [RESP] [${response.statusCode}] ${response.requestOptions.uri} (${duration}ms)');
      _log('Data: ${response.data}');
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final duration = _getDuration(err.requestOptions);
    final errorMsg = '❌ [ERR] [${err.response?.statusCode}] ${err.requestOptions.uri} (${duration}ms)\n'
        'Message: ${err.message}\n'
        'Response: ${err.response?.data}';
    
    if (isDebug) {
      _log(errorMsg);
    } else {
      // Send to Crashlytics/External Monitor in production
      externalLogger?.call(errorMsg);
    }
    handler.next(err);
  }

  int _getDuration(RequestOptions options) {
    final startTime = options.extra['request_start_time'] as int?;
    if (startTime == null) return 0;
    return DateTime.now().millisecondsSinceEpoch - startTime;
  }

  void _log(String msg) {
    if (isDebug) {
      debugPrint(msg);
    }
  }
}
