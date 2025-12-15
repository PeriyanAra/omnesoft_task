// ignore_for_file: unused_element_parameter

import 'package:flutter/material.dart';

enum FontSpecs {
  button(pixels: 14.0, weight: FontWeight.w500),
  headline1Regular(pixels: 36.0),
  headline3SemiBold(pixels: 24.0, weight: FontWeight.w600),
  headline2SemiBold(pixels: 28.0, weight: FontWeight.w600),
  headline5SemiBold(pixels: 20.0, weight: FontWeight.w600),
  headline5Regular(pixels: 20.0),
  body1Regular(pixels: 18.0),
  body1Medium(pixels: 18.0, weight: FontWeight.w500),
  body2Medium(pixels: 16.0, weight: FontWeight.w500),
  body2SemiBold(pixels: 16.0, weight: FontWeight.w600),
  body2Regular(pixels: 16.0),
  body3Medium(pixels: 14.0, weight: FontWeight.w500),
  body3Regular(pixels: 14.0),
  body3SemiBold(pixels: 14.0, weight: FontWeight.w600),
  body4Regular(pixels: 12.0),
  body4Medium(pixels: 12.0, weight: FontWeight.w500),
  body5Medium(pixels: 10.0, weight: FontWeight.w500),
  body5Regular(pixels: 10.0),
  body6Medium(pixels: 8.0, weight: FontWeight.w500),
  body6Regular(pixels: 8.0),
  headline3Regular(pixels: 24.0);

  const FontSpecs({
    required this.pixels,
    this.weight = FontWeight.normal,
  });

  final double pixels;
  final FontWeight weight;
}

extension SpecExtension on FontSpecs {
  TextStyle toStyle({
    required Color textColor,
    required String fontFamily,
  }) {
    return TextStyle(
      color: textColor,
      fontSize: pixels,
      fontWeight: weight,
      fontFamily: fontFamily,
    );
  }
}
