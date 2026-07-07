import 'package:dio/dio.dart';
import 'package:tutorial_management/core/network/token_storage.dart';
import 'package:tutorial_management/core/network/token_refresher.dart';

/// Interceptor that attaches authorization headers, catches 401s, 
/// locks the request queue, refreshes tokens, and retries the original request.
class AuthInterceptor extends QueuedInterceptor {
  final TokenStorage _tokenStorage;
  final TokenRefresher _tokenRefresher;
  final Dio _refreshDio;

  AuthInterceptor({
    required TokenStorage tokenStorage,
    required TokenRefresher tokenRefresher,
    required Dio refreshDio,
  })  : _tokenStorage = tokenStorage,
        _tokenRefresher = tokenRefresher,
        _refreshDio = refreshDio;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      try {
        final newToken = await _refreshToken();
        if (newToken != null) {
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';
          final response = await _refreshDio.fetch(options);
          return handler.resolve(response);
        }
      } catch (e) {
        _tokenStorage.clearTokens();
        return handler.next(err);
      }
    }
    handler.next(err);
  }

  Future<String?> _refreshToken() async {
    final refreshToken = await _tokenStorage.getRefreshToken();
    if (refreshToken == null) return null;
    
    final result = await _tokenRefresher.refresh(refreshToken);
    await _tokenStorage.saveTokens(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );
    return result.accessToken;
  }
}
