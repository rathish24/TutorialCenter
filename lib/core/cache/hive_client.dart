import 'package:hive/hive.dart';
import 'package:tutorial_management/core/cache/local_database_client.dart';

/// Decoupled wrapper client for performing Hive local database operations.
class HiveClient implements LocalDatabaseClient {
  final Box _box;

  HiveClient(this._box);

  @override
  dynamic get(String key, {dynamic defaultValue}) {
    return _box.get(key, defaultValue: defaultValue);
  }

  @override
  Future<void> put(String key, dynamic value) async {
    await _box.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    await _box.delete(key);
  }

  @override
  Future<void> clear() async {
    await _box.clear();
  }
}
