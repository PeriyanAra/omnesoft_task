import 'package:flutter/material.dart';

class OmnesoftAppBarTheme extends ThemeExtension<OmnesoftAppBarTheme> {
  const OmnesoftAppBarTheme({
    this.centerTitle = true,
    this.leadingIconColor,
    this.backgroundColor,
    this.actionsIconColor,
    this.leadingIconSize = _leadingIconSize,
    this.actionsPadding = _actionsPadding,
    this.actionsIconSize = _actionsIconSize,
  });

  final bool centerTitle;
  final Color? leadingIconColor;
  final Color? actionsIconColor;
  final double leadingIconSize;
  final EdgeInsetsGeometry actionsPadding;
  final double actionsIconSize;
  final Color? backgroundColor;

  static const _leadingIconSize = 24.0;
  static const _actionsPadding = EdgeInsets.only(right: 16);
  static const _actionsIconSize = 32.0;

  @override
  ThemeExtension<OmnesoftAppBarTheme> copyWith() {
    return OmnesoftAppBarTheme(
      centerTitle: centerTitle,
      leadingIconColor: leadingIconColor,
      leadingIconSize: leadingIconSize,
      actionsPadding: actionsPadding,
      actionsIconColor: actionsIconColor,
      backgroundColor: backgroundColor,
      actionsIconSize: actionsIconSize,
    );
  }

  @override
  ThemeExtension<OmnesoftAppBarTheme> lerp(covariant ThemeExtension<OmnesoftAppBarTheme>? other, double t) {
    if (other is! OmnesoftAppBarTheme) {
      return this;
    }

    return OmnesoftAppBarTheme(
      centerTitle: centerTitle,
      leadingIconColor: leadingIconColor,
      actionsIconColor: actionsIconColor,
      backgroundColor: backgroundColor,
      leadingIconSize: leadingIconSize,
      actionsPadding: actionsPadding,
    );
  }

  static OmnesoftAppBarTheme of(BuildContext context) {
    return Theme.of(context).extension<OmnesoftAppBarTheme>()!;
  }
}
