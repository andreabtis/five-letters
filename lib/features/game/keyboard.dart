import 'package:flutter/services.dart';

import '../../widgets/letter_model.dart';

class Keyboard {
  static final List<Letter> letters = [
    Letter(value: 'q'),
    Letter(value: 'w'),
    Letter(value: 'e'),
    Letter(value: 'r'),
    Letter(value: 't'),
    Letter(value: 'y'),
    Letter(value: 'u'),
    Letter(value: 'i'),
    Letter(value: 'o'),
    Letter(value: 'p'),
    Letter(value: 'a'),
    Letter(value: 's'),
    Letter(value: 'd'),
    Letter(value: 'f'),
    Letter(value: 'g'),
    Letter(value: 'h'),
    Letter(value: 'j'),
    Letter(value: 'k'),
    Letter(value: 'l'),
    Letter(value: 'z'),
    Letter(value: 'x'),
    Letter(value: 'c'),
    Letter(value: 'v'),
    Letter(value: 'b'),
    Letter(value: 'n'),
    Letter(value: 'm'),
  ];

  static RegExp alphabeticRegex = RegExp(
    '^[a-zA-Z]{1}',
    caseSensitive: false,
    multiLine: false,
  );

  static bool isEnterKey(LogicalKeyboardKey logicalKey) =>
      logicalKey == LogicalKeyboardKey.enter;

  static bool isBackSpaceKey(LogicalKeyboardKey logicalKey) =>
      logicalKey == LogicalKeyboardKey.backspace;

  static bool isAlphanumericKey(String key) =>
      (alphabeticRegex.hasMatch(key) && key.length == 1);

  static int currentKeyboardIndex(
          List<Letter> keyboard, String currentLetter) =>
      keyboard.lastIndexWhere(
        (element) => element.value == currentLetter,
      );

  static onPressKeyOnKeyboard({
    required LogicalKeyboardKey logicalKey,
    required void Function(bool) onDelete,
    required void Function(bool) onEnter,
    required void Function(String, int) onLetter,
    required List<Letter> keyboardLetters,
  }) {
    String keyLabel = logicalKey.keyLabel.toLowerCase();

    if (Keyboard.isBackSpaceKey(logicalKey)) {
      onDelete.call(true);
      return;
    }

    if (Keyboard.isEnterKey(logicalKey)) {
      onEnter.call(true);
      return;
    }

    if (Keyboard.isAlphanumericKey(keyLabel)) {
      onLetter.call(
        keyLabel,
        Keyboard.currentKeyboardIndex(
          keyboardLetters,
          keyLabel,
        ),
      );
    }
  }
}
