import 'package:flutter/material.dart';
import 'package:omnesoft_task/presentation/theme/omnesoft_theme.dart';

Widget wrapWithTestApp(Widget child) {
  return MaterialApp(
    theme: OmnesoftAppTheme.light(),
    home: Material(
      child: Directionality(textDirection: TextDirection.ltr, child: child),
    ),
  );
}
