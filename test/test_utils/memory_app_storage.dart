import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

final class InMemoryAppStorage implements AppKeyValueStorage {
  final Map<String, Object?> _store = <String, Object?>{};

  @override
  Future<T?> read<T>(String key) async => _store[key] as T?;

  @override
  Future<void> write<T>(String key, T value) async {
    _store[key] = value;
  }

  @override
  Future<Set<String>> getKeys() async => _store.keys.toSet();

  @override
  Future<void> remove(String key) async {
    _store.remove(key);
  }
}
