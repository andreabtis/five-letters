import 'package:flutter_wordle/features/game/game_api.dart';
import 'package:flutter_wordle/utils/enums/letter_state.dart';

import '../../style/letter_box_styles.dart';
import '../../widgets/generic_letter_widget.dart';
import '../../widgets/letter_model.dart';
import 'game.dart';
import 'keyboard.dart';

class Matrix {
  static const int columns = 5;
  static const int rows = 6;
  static String wordTarget = '';
  static List<List<GenericLetterBox>> matrixWidgets = List.generate(
    rows,
    (index) => List.generate(
      columns,
      (index) => GenericLetterBox(
        letter: Letter(
          value: '',
          state: LetterState.noContains,
        ),
        isKeyboard: false,
        style: LetterBoxStyles.defaultStyle,
      ),
    ),
  );

  static bool isLetterOnRightPosition(String letter, int index) =>
      letter == wordTarget[index];

  static bool isLetterOnOtherPosition(String letter) =>
      wordTarget.contains(letter);

  static bool isTheSameWord(String word) => word == wordTarget;

  static Future<bool> isWordValid(
      int rowIndex, List<List<GenericLetterBox>> matrixWords) async {
    int matrixIndex = 0;

    String word = matrixWords[rowIndex].map((e) => e.letter.value).join();

    if (Game.isValidWordLenght(word) && await GameApi().isAValidWord(word)) {
      for (GenericLetterBox letterBox in matrixWords[rowIndex]) {
        String currentLetter = letterBox.letter.value;
        if (currentLetter.isEmpty) {
          return false;
        } else {
          int keyboardIndex = Keyboard.currentKeyboardIndex(
            Keyboard.letters,
            currentLetter,
          );

          if (!Matrix.isLetterOnOtherPosition(currentLetter)) {
            Keyboard.letters[keyboardIndex] =
                Keyboard.letters[keyboardIndex].setNoContainState;
            letterBox.style = LetterBoxStyles.matrixNotContainsStyle;
          }
          if (Matrix.isLetterOnOtherPosition(currentLetter)) {
            letterBox.style = LetterBoxStyles.matrixContainsStyle;
            if (Keyboard.letters[keyboardIndex].state != LetterState.position) {
              Keyboard.letters[keyboardIndex] =
                  Keyboard.letters[keyboardIndex].setContainState;
            }
          }
          if (Matrix.isLetterOnRightPosition(currentLetter, matrixIndex)) {
            letterBox.style = LetterBoxStyles.matrixPositionedStyle;

            Keyboard.letters[keyboardIndex] =
                Keyboard.letters[keyboardIndex].setPositionState;
          }

          matrixIndex++;
        }
      }
    } else {
      return false;
    }
    return true;
  }
}
