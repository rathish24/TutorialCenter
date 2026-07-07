enum AppEnvironment { dev, uat, preprod, prod }

/// Central configuration class containing environment variables defined at build-time.
class AppConfig {
  final AppEnvironment environment;
  final String apiUrl;
  final String graphqlUrl;
  final bool isDebug;

  AppConfig({
    required this.environment,
    required this.apiUrl,
    required this.graphqlUrl,
    required this.isDebug,
  });

  /// Factory constructor that loads variables defined at compile-time via --dart-define
  factory AppConfig.fromEnvironment() {
    const envString = String.fromEnvironment('ENVIRONMENT', defaultValue: 'dev');
    const apiUrl = String.fromEnvironment('API_URL', defaultValue: 'https://dev-api.tutorialmanagement.com/v1');
    const graphqlUrl = String.fromEnvironment('GRAPHQL_URL', defaultValue: 'https://dev-api.tutorialmanagement.com/graphql');
    const isDebug = bool.fromEnvironment('IS_DEBUG', defaultValue: true);

    final env = AppEnvironment.values.firstWhere(
      (e) => e.name == envString,
      orElse: () => AppEnvironment.dev,
    );

    return AppConfig(
      environment: env,
      apiUrl: apiUrl,
      graphqlUrl: graphqlUrl,
      isDebug: isDebug,
    );
  }
}
