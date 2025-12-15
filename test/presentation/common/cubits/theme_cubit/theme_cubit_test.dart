import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core/storage.dart';
import 'package:omnesoft_task/presentation/common/cubits/theme_cubit/theme_cubit.dart';

class FakeAppKeyValueStorage implements AppKeyValueStorage {
  final Map<String, Object?> _store = {};

  @override
  Future<T?> read<T>(String key) async {
    final value = _store[key];
    if (value is T) return value;
    return null;
  }

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

void main() {
  late FakeAppKeyValueStorage storage;
  late ThemeCubit cubit;

  setUp(() {
    storage = FakeAppKeyValueStorage();
    cubit = ThemeCubit(preferences: storage);
  });

  test('initial state is light mode', () {
    expect(cubit.state.mode, ThemeMode.light);
  });

  test('loadThemeMode uses light when no stored value', () async {
    await cubit.loadThemeMode();
    expect(cubit.state.mode, ThemeMode.light);
  });

  test('loadThemeMode sets dark when stored mode is dark', () async {
    await storage.write<String>('theme-mode', ThemeMode.dark.name);

    await cubit.loadThemeMode();

    expect(cubit.state.mode, ThemeMode.dark);
  });

  test('changeThemeMode toggles from light to dark and persists', () async {
    expect(cubit.state.mode, ThemeMode.light);

    await cubit.changeThemeMode();

    expect(cubit.state.mode, ThemeMode.dark);
    expect(await storage.read<String>('theme-mode'), ThemeMode.dark.name);
  });

  test('changeThemeMode toggles from dark to light and persists', () async {
    await storage.write<String>('theme-mode', ThemeMode.dark.name);
    await cubit.loadThemeMode();
    expect(cubit.state.mode, ThemeMode.dark);

    await cubit.changeThemeMode();

    expect(cubit.state.mode, ThemeMode.light);
    expect(await storage.read<String>('theme-mode'), ThemeMode.light.name);
  });
}
