import 'package:hive/hive.dart';

/// Decoupled wrapper client for performing Hive local database operations.
class HiveClient {
  final Box _box;

  HiveClient(this._box);

  /// Retrieves data from local storage, returning defaultValue if key does not exist.
  dynamic get(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  /// Inserts or updates data in local storage.
  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  /// Deletes a key-value record from local storage.
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  /// Clears all database records from the box.
  Future<void> clear() async {
    await _box.clear();
  }
}
