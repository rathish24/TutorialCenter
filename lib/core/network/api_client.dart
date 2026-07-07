import 'dart:io';
import 'package:dio/dio.dart';
import 'package:tutorial_management/core/network/network_exceptions.dart';

/// Abstract contract for standard HTTP REST operations.
abstract class ApiClient {
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<T> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<T> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<T> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<T> uploadMultipart<T>({
    required String path,
    required Map<String, dynamic> files,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  });

  Future<void> downloadFile({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    void Function(int count, int total)? onProgress,
  });
}

/// Concrete implementation of [ApiClient] utilizing [Dio].
class ApiClientImpl implements ApiClient {
  final Dio _dio;

  ApiClientImpl(this._dio);

  @override
  Future<T> get<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<T> post<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<T> put<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<T> patch<T>({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<T> delete<T>({
    required String path,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<T> uploadMultipart<T>({
    required String path,
    required Map<String, dynamic> files,
    Map<String, dynamic>? data,
    CancelToken? cancelToken,
    required T Function(Map<String, dynamic> json) fromJson,
  }) async {
    try {
      final multipartMap = <String, dynamic>{...data ?? {}};
      for (final entry in files.entries) {
        if (entry.value is File) {
          final file = entry.value as File;
          final fileName = file.path.split('/').last;
          multipartMap[entry.key] = await MultipartFile.fromFile(
            file.path,
            filename: fileName,
          );
        }
      }

      final formData = FormData.fromMap(multipartMap);
      final response = await _dio.post(
        path,
        data: formData,
        cancelToken: cancelToken,
      );
      return _parseResponse<T>(response, fromJson);
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  @override
  Future<void> downloadFile({
    required String url,
    required String savePath,
    CancelToken? cancelToken,
    void Function(int count, int total)? onProgress,
  }) async {
    try {
      await _dio.download(
        url,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: onProgress,
      );
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  T _parseResponse<T>(Response response, T Function(Map<String, dynamic> json) fromJson) {
    final responseData = response.data;
    if (responseData is Map<String, dynamic>) {
      return fromJson(responseData);
    } else {
      throw FormatException('Response is not a valid JSON object: $responseData');
    }
  }

  Exception _handleDioException(DioException e) {
    return NetworkException.fromDioException(e);
  }
}
