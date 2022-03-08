import 'package:flutter/material.dart';

class CustomElevatedButtonStyle {
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Size? size;
  final OutlinedBorder? shape;

  const CustomElevatedButtonStyle({
    this.textStyle,
    this.backgroundColor,
    this.size,
    this.shape,
  });

  CustomElevatedButtonStyle copyWith({
    TextStyle? textStyle,
    Color? backgroundColor,
    Size? size,
    OutlinedBorder? shape,
  }) {
    return CustomElevatedButtonStyle(
      textStyle: textStyle ?? this.textStyle,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      size: size ?? this.size,
      shape: shape ?? this.shape,
    );
  }
}
