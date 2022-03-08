import 'package:flutter/material.dart';

class LetterBoxStyle {
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? textStyle;

  LetterBoxStyle({
    this.backgroundColor,
    this.borderColor,
    this.textStyle,
  });

  LetterBoxStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    Color? fontColor,
    TextStyle? textStyle,
  }) {
    return LetterBoxStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      textStyle: textStyle ?? this.textStyle,
    );
  }
}
