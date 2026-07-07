import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tutorial_management/core/network/connectivity_service.dart';

/// Interceptor that instantly rejects requests with a connection error when offline.
class ConnectivityInterceptor extends Interceptor {
  final ConnectivityService _connectivity;

  ConnectivityInterceptor(this._connectivity);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final isConnected = await _connectivity.isConnected();
    if (!isConnected) {
      return handler.reject(
        DioException(
          requestOptions: options,
          error: const SocketException('No Internet Connection available.'),
          type: DioExceptionType.connectionError,
        ),
      );
    }
    handler.next(options);
  }
}
