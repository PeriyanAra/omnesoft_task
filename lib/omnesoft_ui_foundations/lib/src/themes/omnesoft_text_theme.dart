import 'package:flutter/material.dart';
import 'package:omnesoft_task/omnesoft_ui_foundations/lib/src/utils.dart';

@immutable
class OmnesoftTextTheme extends ThemeExtension<OmnesoftTextTheme> {
  OmnesoftTextTheme({
    required Color textColor,
    required String fontFamily,
  })  : button = FontSpecs.button.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body2Medium = FontSpecs.body2Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body4Regular = FontSpecs.body4Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body4Medium = FontSpecs.body4Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body5Regular = FontSpecs.body5Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body5Medium = FontSpecs.body5Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body6Medium = FontSpecs.body6Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body1Medium = FontSpecs.body1Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline3SemiBold = FontSpecs.headline3SemiBold.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline3Regular = FontSpecs.headline3Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline2SemiBold = FontSpecs.headline2SemiBold.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline5SemiBold = FontSpecs.headline5SemiBold.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline5Regular = FontSpecs.headline5Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body1Regular = FontSpecs.body1Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body2SemiBold = FontSpecs.body2SemiBold.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body2Regular = FontSpecs.body2Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body3SemiBold = FontSpecs.body3SemiBold.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body3Medium = FontSpecs.body3Medium.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body3Regular = FontSpecs.body3Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        body6Regular = FontSpecs.body6Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        ),
        headline1Regular = FontSpecs.headline1Regular.toStyle(
          textColor: textColor,
          fontFamily: fontFamily,
        );

  const OmnesoftTextTheme._({
    required this.button,
    required this.headline5SemiBold,
    required this.body4Regular,
    required this.body1Medium,
    required this.body5Regular,
    required this.headline3SemiBold,
    required this.headline3Regular,
    required this.body1Regular,
    required this.body2Regular,
    required this.body3SemiBold,
    required this.body3Medium,
    required this.body3Regular,
    required this.body6Regular,
    required this.headline5Regular,
    required this.body2SemiBold,
    required this.body2Medium,
    required this.body4Medium,
    required this.body5Medium,
    required this.body6Medium,
    required this.headline2SemiBold,
    required this.headline1Regular,
  });

  final TextStyle button;
  final TextStyle body2Medium;
  final TextStyle body4Regular;
  final TextStyle body4Medium;
  final TextStyle body5Regular;
  final TextStyle body5Medium;
  final TextStyle body6Medium;
  final TextStyle headline5SemiBold;
  final TextStyle headline3SemiBold;
  final TextStyle headline3Regular;
  final TextStyle headline2SemiBold;
  final TextStyle headline5Regular;
  final TextStyle body1Regular;
  final TextStyle body2SemiBold;
  final TextStyle body2Regular;
  final TextStyle body3Regular;
  final TextStyle body1Medium;
  final TextStyle body3SemiBold;
  final TextStyle body3Medium;
  final TextStyle body6Regular;
  final TextStyle headline1Regular;

  @override
  int get hashCode => button.hashCode;

  @override
  ThemeExtension<OmnesoftTextTheme> copyWith({
    TextStyle? button,
    TextStyle? body1Medium,
    TextStyle? body1Regular,
    TextStyle? body2Regular,
    TextStyle? body3Medium,
    TextStyle? body3Regular,
    TextStyle? body6Regular,
    TextStyle? headline5Regular,
    TextStyle? body2SemiBold,
    TextStyle? body2Medium,
    TextStyle? body4Regular,
    TextStyle? body4Medium,
    TextStyle? body5Regular,
    TextStyle? body5Medium,
    TextStyle? body6Medium,
    TextStyle? headline5SemiBold,
    TextStyle? headline3SemiBold,
    TextStyle? headline3Regular,
    TextStyle? headline2SemiBold,
    TextStyle? body3SemiBold,
    TextStyle? headline1Regular,
  }) {
    return OmnesoftTextTheme._(
      button: button ?? this.button,
      headline5SemiBold: headline5SemiBold ?? this.headline5SemiBold,
      headline3SemiBold: headline3SemiBold ?? this.headline3SemiBold,
      headline3Regular: headline3Regular ?? this.headline3Regular,
      headline2SemiBold: headline2SemiBold ?? this.headline2SemiBold,
      headline5Regular: headline5Regular ?? this.headline5Regular,
      body1Regular: body1Regular ?? this.body1Regular,
      body2Regular: body2Regular ?? this.body2Regular,
      body3SemiBold: body3SemiBold ?? this.body3SemiBold,
      body3Medium: body3Medium ?? this.body3Medium,
      body6Regular: body6Regular ?? this.body6Regular,
      body2SemiBold: body2SemiBold ?? this.body2SemiBold,
      body2Medium: body2Medium ?? this.body2Medium,
      body1Medium: body1Medium ?? this.body1Medium,
      body4Regular: body4Regular ?? this.body4Regular,
      body5Regular: body5Regular ?? this.body5Regular,
      body3Regular: body3Regular ?? this.body3Regular,
      body4Medium: body4Medium ?? this.body4Medium,
      body5Medium: body5Medium ?? this.body5Medium,
      body6Medium: body6Medium ?? this.body6Medium,
      headline1Regular: headline1Regular ?? this.headline1Regular,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OmnesoftTextTheme &&
          runtimeType == other.runtimeType &&
          button == other.button &&
          headline3SemiBold == other.headline3SemiBold &&
          headline3Regular == other.headline3Regular &&
          body4Regular == other.body4Regular &&
          body3SemiBold == other.body3SemiBold &&
          body3Medium == other.body3Medium &&
          body3Regular == other.body3Regular &&
          body5Regular == other.body5Regular &&
          body3Medium == other.body3Medium &&
          body1Regular == other.body1Regular &&
          body2Regular == other.body2Regular &&
          body6Regular == other.body6Regular &&
          headline5SemiBold == other.headline5SemiBold &&
          headline5Regular == other.headline5Regular &&
          body4Medium == other.body4Medium &&
          body5Medium == other.body5Medium &&
          body2SemiBold == other.body2SemiBold &&
          body6Medium == other.body6Medium &&
          body6Regular == other.body6Regular &&
          body5Regular == other.body5Regular &&
          body3Medium == other.body3Medium &&
          body3Regular == other.body3Regular &&
          body2Medium == other.body2Medium &&
          headline1Regular == other.headline1Regular;

  @override
  OmnesoftTextTheme lerp(covariant ThemeExtension<OmnesoftTextTheme>? other, double t) {
    if (other is! OmnesoftTextTheme) {
      return this;
    }

    return OmnesoftTextTheme._(
      button: TextStyle.lerp(other.button, button, t)!,
      body1Medium: TextStyle.lerp(other.body1Medium, body1Medium, t)!,
      headline3Regular: TextStyle.lerp(other.headline3Regular, headline3Regular, t)!,
      body4Regular: TextStyle.lerp(other.body4Regular, body4Regular, t)!,
      body5Regular: TextStyle.lerp(other.body5Regular, body5Regular, t)!,
      headline3SemiBold: TextStyle.lerp(other.headline3SemiBold, headline3SemiBold, t)!,
      body1Regular: TextStyle.lerp(other.body1Regular, body1Regular, t)!,
      body2Regular: TextStyle.lerp(other.body2Regular, body2Regular, t)!,
      body3Medium: TextStyle.lerp(other.body3Medium, body3Medium, t)!,
      body3Regular: TextStyle.lerp(other.body3Regular, body3Regular, t)!,
      body3SemiBold: TextStyle.lerp(other.body3SemiBold, body3SemiBold, t)!,
      body6Regular: TextStyle.lerp(other.body6Regular, body6Regular, t)!,
      headline5Regular: TextStyle.lerp(other.headline5Regular, headline5Regular, t)!,
      body2SemiBold: TextStyle.lerp(other.body2SemiBold, body2SemiBold, t)!,
      body2Medium: TextStyle.lerp(other.body2Medium, body2Medium, t)!,
      body4Medium: TextStyle.lerp(other.body4Medium, body4Medium, t)!,
      body5Medium: TextStyle.lerp(other.body5Medium, body5Medium, t)!,
      body6Medium: TextStyle.lerp(other.body6Medium, body6Medium, t)!,
      headline5SemiBold: TextStyle.lerp(other.headline5SemiBold, headline5SemiBold, t)!,
      headline2SemiBold: TextStyle.lerp(other.headline2SemiBold, headline2SemiBold, t)!,
      headline1Regular: TextStyle.lerp(other.headline1Regular, headline1Regular, t)!,
    );
  }

  static OmnesoftTextTheme of(BuildContext context) {
    return Theme.of(context).extension<OmnesoftTextTheme>()!;
  }
}
