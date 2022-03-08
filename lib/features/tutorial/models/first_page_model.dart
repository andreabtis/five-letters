import 'package:flutter/material.dart';
import 'package:flutter_wordle/widgets/generic_letter_widget.dart';

import '../../../style/colors.dart';
import '../../../style/letter_box_styles.dart';
import '../../../widgets/letter_model.dart';

class _Constants {
  static const double lateralBoxPadding = 1.0;
}

class FirstTutorialPageModel {
  //Strings

  static const String description1 = 'Guess the word in';

  static const String description2 =
      'After each guess, the color of the tiles will change to show how close is your guess.';
  static const String description3 = 'The letter';
  static const String description4 = 'is in the word and in the correct spot.';
  static const String description5 = 'The letters';
  static const String description6 = ' and ';
  static const String description7 = 'are in the word but in the wrong spot.';
  static const String blueDescription1 = ' 6 tries. ';
  static const String blueDescription2 = ' A ';
  static const String blueDescription3 = ' T, O ';
  static const String blueDescription4 = ' A ';
  static const String blueDescription5 = ' F,L,I,E ';
  static const String blueDescription6 = ' S ';

  static List<String> letters = ['ABOUT', 'TOADS', 'FLIES'];
  static List<String> buttonLabels = ['PLAY', 'HOME'];

  //LetterBoxesRow

  static List<List<Widget>> tutorialWordBoxes = [
    getGenericLetterList(0),
    getGenericLetterList(1),
    getGenericLetterList(2),
  ];

  //Divider

  static Widget divider = const Divider(
    thickness: 1.5,
    color: CustomColors.black,
  );

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
                style: LetterBoxStyles.defaultStyle,
              ),
            ),
          );
        }
      } else if (wordIndex == 1) {
        if (i < 3) {
          row.add(
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: _Constants.lateralBoxPadding),
              child: GenericLetterBox(
                letter: Letter(value: letters[wordIndex][i]),
                isKeyboard: false,
                style: LetterBoxStyles.matrixContainsStyle,
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
                style: LetterBoxStyles.defaultStyle,
              ),
            ),
          );
        }
      } else {
        row.add(
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: _Constants.lateralBoxPadding),
            child: GenericLetterBox(
              letter: Letter(value: letters[wordIndex][i]),
              isKeyboard: false,
              style: LetterBoxStyles.defaultStyle,
            ),
          ),
        );
      }
    }
    return row;
  }
}
