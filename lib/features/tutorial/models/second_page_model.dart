import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../style/colors.dart';
import '../../../style/letter_box_styles.dart';
import '../../../styles/font_family.dart';
import '../../../utils/strings.dart';
import '../../../widgets/generic_letter_widget.dart';
import '../../../widgets/letter_model.dart';

class _Constants {
  static const double lateralBoxPadding = 1.0;
  static const double letterFontSize = kIsWeb ? 50 : 40.0;
  static const double lateralEnterKey = 10;
}

class SecondTutorialPageModel {
  static const String comma = ',';
  static const String description1 =
      'The word does not contain the letters B, O, U, and T';

  static const String description4 = 'Press ';
  static const String description5 =
      ' key to check if you have guessed the word';
  static const String description6 =
      'To track your previous games stadistics, you can check your win ratio and the games you have played in ';
  static const String blueDescription5 = 'ENTER';
  static const String blueDescription6 = 'Stadistics';

  static List<String> letters = ['ABOUT'];

  static List<List<Widget>> tutorialWordBoxes = [
    getGenericLetterList(0),
  ];

  static List<Widget> getGenericLetterList(int wordIndex) {
    List<Widget> row = [];
    for (int i = 0; i < letters[wordIndex].length; i++) {
      if (wordIndex == 0) {
        if (i == 0) {
          row.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: _Constants.lateralBoxPadding),
              child: GenericLetterBox(
                letter: Letter(value: letters[wordIndex][i]),
                isKeyboard: false,
                style: LetterBoxStyles.matrixPositionedStyle,
              ),
            ),
          );
        } else {
          row.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: _Constants.lateralBoxPadding),
              child: GenericLetterBox(
                letter: Letter(value: letters[wordIndex][i]),
                isKeyboard: false,
                style: LetterBoxStyles.matrixNotContainsStyle,
              ),
            ),
          );
        }
      }
    }
    return row;
  }

  static Widget divider =
      const Divider(thickness: 1.5, color: CustomColors.black);

  static Widget enterKey = ElevatedButton(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(
        CustomColors.grayBackgroundLetter,
      ),
      padding: MaterialStateProperty.all(
        EdgeInsets.zero,
      ),
    ),
    onPressed: null,
    child: Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: _Constants.lateralEnterKey),
      child: Text(
        Strings.enterButton.toUpperCase(),
        style: const TextStyle(
          color: CustomColors.white,
          fontSize: _Constants.letterFontSize,
          fontFamily: FontFamily.mulishBold,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
