import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/Omnesoft_ui_foundations.dart';

class OmnesoftTheme {
  static ThemeData create({
    required OmnesoftColorTheme colorTheme,
    required OmnesoftTextTheme textTheme,
    OmnesoftTextFieldTheme textFieldTheme = const OmnesoftTextFieldTheme(),
    List<ThemeExtension<dynamic>>? themes,
    OmnesoftAppBarTheme appBarTheme = const OmnesoftAppBarTheme(),
  }) {
    return ThemeData(
      extensions: [
        colorTheme,
        textTheme,
        appBarTheme,
        textFieldTheme,
        if (themes != null) ...themes,
      ],
    );
  }
}
