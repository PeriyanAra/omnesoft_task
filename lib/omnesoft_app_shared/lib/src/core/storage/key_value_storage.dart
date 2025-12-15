abstract class KeyValueStorage {
  Future<T?> read<T>(String key);
  Future<void> write<T>(String key, T value);
  Future<Set<String>> getKeys();
  Future<void> remove(String key);
}
