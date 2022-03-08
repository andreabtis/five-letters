import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/styles/font_size.dart';

import '../style/colors.dart';
import 'custom_elevated_button_style.dart';
import 'font_family.dart';

class _Constants {
  static const double borderRadius = 8;
}

class CustomElevatedButtonStyles {
  static CustomElevatedButtonStyle defaultStyle = CustomElevatedButtonStyle(
    backgroundColor: CustomColors.primary,
    textStyle: const TextStyle(
      color: CustomColors.white,
      fontFamily: FontFamily.mulishLight,
      fontSize: kIsWeb ? FontSize.twentyFour : FontSize.fourteen,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        _Constants.borderRadius,
      ),
    ),
  );

  static CustomElevatedButtonStyle secondaryStyle = defaultStyle.copyWith(
    backgroundColor: CustomColors.accent,
  );
}
