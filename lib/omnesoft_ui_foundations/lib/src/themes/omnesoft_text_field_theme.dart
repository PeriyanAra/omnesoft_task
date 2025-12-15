import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class OmnesoftTextFieldTheme extends ThemeExtension<OmnesoftTextFieldTheme> {
  const OmnesoftTextFieldTheme({
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.errorIcon,
    this.errorIconSize,
    this.errorIconColor,
    this.errorTextStyle,
    this.hintStyle,
    this.textStyle,
    this.cursorColor,
    this.fillColor,
    this.cursorErrorColor,
    this.cursorHeight,
    this.contentPadding,
  });

  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final IconData? errorIcon;
  final double? errorIconSize;
  final Color? errorIconColor;
  final Color? fillColor;
  final TextStyle? errorTextStyle;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Color? cursorColor;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final EdgeInsetsGeometry? contentPadding;

  @override
  ThemeExtension<OmnesoftTextFieldTheme> copyWith({
    InputBorder? border,
    InputBorder? enabledBorder,
    InputBorder? focusedBorder,
    InputBorder? errorBorder,
    InputBorder? focusedErrorBorder,
    IconData? errorIcon,
    double? errorIconSize,
    Color? errorIconColor,
    Color? fillColor,
    TextStyle? errorTextStyle,
    TextStyle? hintStyle,
    TextStyle? textStyle,
    Color? cursorColor,
    Color? cursorErrorColor,
    double? cursorHeight,
    EdgeInsetsGeometry? contentPadding,
  }) {
    return OmnesoftTextFieldTheme(
      border: border ?? this.border,
      enabledBorder: enabledBorder ?? this.enabledBorder,
      focusedBorder: focusedBorder ?? this.focusedBorder,
      errorBorder: errorBorder ?? this.errorBorder,
      focusedErrorBorder: focusedErrorBorder ?? this.focusedErrorBorder,
      errorIcon: errorIcon ?? this.errorIcon,
      errorIconSize: errorIconSize ?? this.errorIconSize,
      errorIconColor: errorIconColor ?? this.errorIconColor,
      fillColor: fillColor ?? this.fillColor,
      errorTextStyle: errorTextStyle ?? this.errorTextStyle,
      hintStyle: hintStyle ?? this.hintStyle,
      textStyle: textStyle ?? this.textStyle,
      cursorColor: cursorColor ?? this.cursorColor,
      cursorErrorColor: cursorErrorColor ?? this.cursorErrorColor,
      cursorHeight: cursorHeight ?? this.cursorHeight,
      contentPadding: contentPadding ?? this.contentPadding,
    );
  }

  @override
  ThemeExtension<OmnesoftTextFieldTheme> lerp(
    covariant ThemeExtension<OmnesoftTextFieldTheme>? other,
    double t,
  ) {
    if (other is! OmnesoftTextFieldTheme) {
      return this;
    }

    return OmnesoftTextFieldTheme(
      border: t < 0.5 ? border : other.border,
      enabledBorder: t < 0.5 ? enabledBorder : other.enabledBorder,
      focusedBorder: t < 0.5 ? focusedBorder : other.focusedBorder,
      errorBorder: t < 0.5 ? errorBorder : other.errorBorder,
      focusedErrorBorder:
          t < 0.5 ? focusedErrorBorder : other.focusedErrorBorder,
      errorIcon: t < 0.5 ? errorIcon : other.errorIcon,
      errorIconSize: lerpDouble(errorIconSize, other.errorIconSize, t),
      errorIconColor: Color.lerp(errorIconColor, other.errorIconColor, t),
      errorTextStyle: TextStyle.lerp(errorTextStyle, other.errorTextStyle, t),
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t),
      fillColor: Color.lerp(fillColor, other.fillColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t),
      cursorColor: Color.lerp(cursorColor, other.cursorColor, t),
      cursorErrorColor: Color.lerp(cursorErrorColor, other.cursorErrorColor, t),
      cursorHeight: lerpDouble(cursorHeight, other.cursorHeight, t),
      contentPadding: EdgeInsetsGeometry.lerp(
        contentPadding,
        other.contentPadding,
        t,
      ),
    );
  }

  static OmnesoftTextFieldTheme of(BuildContext context) {
    return Theme.of(context).extension<OmnesoftTextFieldTheme>()!;
  }
}
