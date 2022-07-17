abstract class SecureCacheStorage {
  Future<dynamic> fetch(String key);
  Future<void> save({required String key, required String value});
  Future<void> delete(String key);
}
