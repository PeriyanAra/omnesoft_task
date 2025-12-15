import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/src/core/storage.dart';
import 'package:omnesoft_task/presentation/common/cubits/theme_cubit/theme_cubit.dart';
import 'package:omnesoft_task/presentation/settings/settings_screen.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_theme.dart';

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

Widget _buildTestApp(ThemeCubit cubit) {
  return MaterialApp(
    theme: OmnesoftAppTheme.light(),
    darkTheme: OmnesoftAppTheme.dark(),
    home: BlocProvider.value(
      value: cubit,
      child: const SettingsScreen(),
    ),
  );
}

void main() {
  late FakeAppKeyValueStorage storage;
  late ThemeCubit themeCubit;

  setUp(() {
    storage = FakeAppKeyValueStorage();
    themeCubit = ThemeCubit(preferences: storage);
  });

  tearDown(() async {
    await themeCubit.close();
  });

  testWidgets('shows Settings title and Theme mode label', (tester) async {
    await tester.pumpWidget(_buildTestApp(themeCubit));

    expect(find.text('Settings'), findsOneWidget);
    expect(find.text('Theme mode'), findsOneWidget);
  });

  testWidgets('tapping theme icons toggles ThemeCubit mode', (tester) async {
    await tester.pumpWidget(_buildTestApp(themeCubit));

    // initial state is light
    expect(themeCubit.state.mode, ThemeMode.light);

    // tap any theme toggle (light icon)
    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();

    expect(themeCubit.state.mode, ThemeMode.dark);

    // tap other toggle (dark icon) to switch back
    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();

    expect(themeCubit.state.mode, ThemeMode.light);
  });
}
