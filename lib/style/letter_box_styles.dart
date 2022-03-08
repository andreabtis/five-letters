import 'package:flutter/material.dart';
import 'package:flutter_wordle/style/colors.dart';
import 'package:flutter_wordle/styles/font_family.dart';

import 'letter_box_style.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class _Constants {
  static const double keyboardLetterFontSize = kIsWeb ? 25 : 12.0;
  static const double letterFontSize = kIsWeb ? 50 : 40.0;
}

class LetterBoxStyles {
  static LetterBoxStyle defaultStyle = LetterBoxStyle(
    backgroundColor: CustomColors.grayBackgroundLetter,
    borderColor: CustomColors.transparent,
    textStyle: const TextStyle(
      color: CustomColors.white,
      fontSize: _Constants.letterFontSize,
      fontFamily: FontFamily.mulishBold,
      fontWeight: FontWeight.bold,
    ),
  );

  static LetterBoxStyle defaultKeyboardStyle = defaultStyle.copyWith(
    textStyle: defaultStyle.textStyle?.copyWith(
      fontSize: _Constants.keyboardLetterFontSize,
    ),
  );
  static LetterBoxStyle keyboardNotContainsStyle =
      defaultKeyboardStyle.copyWith(
    backgroundColor: matrixNotContainsStyle.backgroundColor,
  );
  static LetterBoxStyle keyboardContainsStyle = defaultKeyboardStyle.copyWith(
    backgroundColor: matrixContainsStyle.backgroundColor,
  );

  static LetterBoxStyle keyboardPositionedStyle = defaultKeyboardStyle.copyWith(
    backgroundColor: matrixPositionedStyle.backgroundColor,
  );

  static LetterBoxStyle matrixContainsStyle = defaultStyle.copyWith(
    backgroundColor: CustomColors.primary,
  );

  static LetterBoxStyle matrixPositionedStyle = defaultStyle.copyWith(
    backgroundColor: CustomColors.accent,
  );

  static LetterBoxStyle matrixNotContainsStyle = defaultStyle.copyWith(
    backgroundColor: CustomColors.darkGray,
  );
}
