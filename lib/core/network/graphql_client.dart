import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:tutorial_management/core/network/token_storage.dart';

/// Abstract contract for standard GraphQL operations.
abstract class GraphQLClientWrapper {
  /// Perform a GraphQL Query operation.
  Future<QueryResult<T>> query<T>(QueryOptions<T> options);

  /// Perform a GraphQL Mutation operation.
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options);
}

/// Concrete implementation of [GraphQLClientWrapper] utilizing [GraphQLClient].
class GraphQLClientWrapperImpl implements GraphQLClientWrapper {
  final TokenStorage _tokenStorage;
  late final GraphQLClient client;

  GraphQLClientWrapperImpl(this._tokenStorage) {
    _initClient();
  }

  void _initClient() {
    // 1. HTTP Endpoint Link
    final HttpLink httpLink = HttpLink(
      'https://api.example.com/graphql', // Placeholder URL, to be configured
    );

    // 2. Auth Link to dynamically fetch and inject access tokens
    final AuthLink authLink = AuthLink(
      getToken: () async {
        final token = await _tokenStorage.getAccessToken();
        return token != null ? 'Bearer $token' : null;
      },
    );

    // 3. Chain the links
    final Link link = authLink.concat(httpLink);

    // 4. Initialize the GraphQL Client
    client = GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
    );
  }

  @override
  Future<QueryResult<T>> query<T>(QueryOptions<T> options) async {
    return await client.query(options);
  }

  @override
  Future<QueryResult<T>> mutate<T>(MutationOptions<T> options) async {
    return await client.mutate(options);
  }
}
