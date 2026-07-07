/// Model representing refreshed access token results.
class TokenRefreshResult {
  final String accessToken;
  final String refreshToken;

  TokenRefreshResult({required this.accessToken, required this.refreshToken});
}

/// Abstract contract to request new authorization credentials using a refresh token.
abstract class TokenRefresher {
  Future<TokenRefreshResult> refresh(String refreshToken);
}

/// Mock/No-op Token Refresher implementation.
class MockTokenRefresher implements TokenRefresher {
  @override
  Future<TokenRefreshResult> refresh(String refreshToken) async {
    // Simulated remote network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return dummy fresh values
    return TokenRefreshResult(
      accessToken: 'fresh_dummy_access_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: refreshToken,
    );
  }
}
