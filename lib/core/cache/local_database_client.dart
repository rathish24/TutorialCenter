/// Abstract interface for local key-value storage client.
abstract class LocalDatabaseClient {
  /// Retrieves a value for the given key. Returns [defaultValue] if key doesn't exist.
  dynamic get(String key, {dynamic defaultValue});

  /// Stores a value for the given key.
  Future<void> put(String key, dynamic value);

  /// Deletes a record by key.
  Future<void> delete(String key);

  /// Clears all stored data inside the client box/storage.
  Future<void> clear();
}
