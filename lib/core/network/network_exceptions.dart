import 'package:dio/dio.dart';

/// Custom domain-specific exception wrapping DioException.
class NetworkException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic originalError;

  NetworkException(this.message, {this.statusCode, this.originalError});

  factory NetworkException.fromDioException(DioException dioException) {
    String message = 'Unexpected error occurred.';
    int? statusCode = dioException.response?.statusCode;

    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        message = 'Connection timed out. Please try again.';
        break;
      case DioExceptionType.connectionError:
        message = 'Host connection failed. Check your internet connection.';
        break;
      case DioExceptionType.badResponse:
        final data = dioException.response?.data;
        if (data is Map && data.containsKey('message')) {
          message = data['message'].toString();
        } else {
          message = 'Received invalid response status: ${dioException.response?.statusCode}';
        }
        break;
      default:
        message = dioException.message ?? 'Unknown network anomaly.';
    }

    return NetworkException(message, statusCode: statusCode, originalError: dioException);
  }
}
