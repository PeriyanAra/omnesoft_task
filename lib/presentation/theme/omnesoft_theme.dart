import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/Omnesoft_ui_foundations.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_colors.dart';

class OmnesoftAppTheme {
  static ThemeData light() {
    final colorTheme = _lightColorTheme();
    final textTheme = _textTheme(textColor: colorTheme.textPrimary);

    return OmnesoftTheme.create(
      colorTheme: colorTheme,
      textTheme: textTheme,
      textFieldTheme: _textFieldTheme(colorTheme),
    );
  }

  static OmnesoftColorTheme _lightColorTheme() {
    return const OmnesoftColorTheme(
      brightness: Brightness.light,
      primary: OmnesoftColors.gray90,
      iconPrimary: OmnesoftColors.gray60,
      backgroundPrimary: OmnesoftColors.gray10,
      backgroundSecondary: OmnesoftColors.white,
      textPrimary: OmnesoftColors.gray90,
      textSecondary: OmnesoftColors.gray60,
      textTertiary: OmnesoftColors.gray50,
      success: OmnesoftColors.green50,
      remind: OmnesoftColors.orange40,
      warning: OmnesoftColors.red40,
    );
  }

  static ThemeData dark() {
    final colorTheme = _darkColorTheme();
    final textTheme = _textTheme(textColor: colorTheme.textPrimary);
    return OmnesoftTheme.create(
      colorTheme: colorTheme,
      textTheme: textTheme,
      textFieldTheme: _textFieldTheme(colorTheme),
    );
  }

  static OmnesoftColorTheme _darkColorTheme() {
    return const OmnesoftColorTheme(
      brightness: Brightness.dark,
      primary: OmnesoftColors.white,
      iconPrimary: OmnesoftColors.gray60,
      backgroundPrimary: OmnesoftColors.gray100,
      backgroundSecondary: OmnesoftColors.gray95,
      textPrimary: OmnesoftColors.white,
      textSecondary: OmnesoftColors.gray60,
      textTertiary: OmnesoftColors.gray50,
      success: OmnesoftColors.green50,
      remind: OmnesoftColors.orange40,
      warning: OmnesoftColors.red40,
    );
  }

  static OmnesoftTextTheme _textTheme({required Color textColor}) {
    final textTheme = OmnesoftTextTheme(
      textColor: textColor,
      fontFamily: 'OpenSans',
    );

    return textTheme;
  }

  static OmnesoftTextFieldTheme _textFieldTheme(OmnesoftColorTheme colorTheme) {
    final borderRadius = BorderRadius.circular(30.0);

    return OmnesoftTextFieldTheme(
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide.none,
      ),
      fillColor: colorTheme.backgroundSecondary,
      hintStyle: TextStyle(color: colorTheme.textSecondary),
      textStyle: TextStyle(color: colorTheme.textPrimary),
    );
  }
}
