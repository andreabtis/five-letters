import 'package:flutter_wordle/widgets/letter_model.dart';

import '../../style/letter_box_styles.dart';
import '../../utils/shared_preferences.dart';
import 'keyboard.dart';
import 'matrix.dart';

class Game {
  static void clearMatrix() async {
    for (var row in Matrix.matrixWidgets) {
      for (var letterBox in row) {
        letterBox.letter.value = '';
        letterBox.style = LetterBoxStyles.defaultStyle;
      }
    }
    for (var i = 0; i < Keyboard.letters.length; i++) {
      Keyboard.letters[i] = Keyboard.letters[i].setNoneState;
    }
  }

  static bool isLastLetterOfMatrix(int currentRowIndex, int currentBoxIndex) =>
      currentRowIndex == Matrix.columns &&
      isLastLetterOnTheRow(currentBoxIndex);

  static bool isLastLetterOnTheRow(int currentBoxIndex) =>
      currentBoxIndex == Matrix.columns;

  static bool isValidWordLenght(String word) => word.length == Matrix.columns;
  static Future<bool> isWordUsedBefore(String word) async {
    List<String> usedWords = await SharedPrefs.getUsedWords();
    return usedWords.contains(word);
  }
}
