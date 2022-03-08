import 'package:flutter/material.dart';

class CustomFontStyle {
  final Color? fontColor;
  final double? fontSize;
  final String? familyFont;
  final double? letterSpacing;

  CustomFontStyle(
      {this.fontColor, this.familyFont, this.fontSize, this.letterSpacing});

  CustomFontStyle copyWith({
    Color? fontColor,
    double? fontSize,
    String? familyFont,
    double? letterSpacing,
  }) {
    return CustomFontStyle(
        fontColor: fontColor ?? this.fontColor,
        fontSize: fontSize ?? this.fontSize,
        familyFont: familyFont ?? this.familyFont,
        letterSpacing: letterSpacing ?? this.letterSpacing);
  }
}
