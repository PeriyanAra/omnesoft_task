import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_app_shared/lib/omnesoft_app_shared.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required AppKeyValueStorage preferences})
    : _preferences = preferences,
      super(ThemeState());

  final AppKeyValueStorage _preferences;
  final _themeKey = 'theme-mode';

  Future<void> loadThemeMode() async {
    try {
      final mode = await _preferences.read<String>(_themeKey);

      if (mode == null || mode == ThemeMode.light.name) {
        safeEmit(ThemeState());

        return;
      }

      safeEmit(ThemeState(mode: ThemeMode.dark));
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> changeThemeMode() async {
    try {
      final mode = await _preferences.read<String>(_themeKey);

      if (mode == null || mode == ThemeMode.light.name) {
        await _preferences.write<String>(_themeKey, ThemeMode.dark.name);

        safeEmit(ThemeState(mode: ThemeMode.dark));

        return;
      }

      await _preferences.write<String>(_themeKey, ThemeMode.light.name);

      safeEmit(ThemeState());
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
