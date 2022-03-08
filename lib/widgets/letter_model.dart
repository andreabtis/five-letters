import 'package:flutter_wordle/style/letter_box_style.dart';
import 'package:flutter_wordle/style/letter_box_styles.dart';
import 'package:flutter_wordle/utils/enums/letter_state.dart';

class Letter {
  String value = "";
  bool? isEmpty = true;
  LetterState? state = LetterState.none;

  Letter({
    required this.value,
    this.isEmpty,
    this.state,
  });

  Letter copyWith({
    String? value,
    bool? isEmpty,
    LetterState? state,
  }) {
    return Letter(
      value: value ?? this.value,
      isEmpty: isEmpty ?? this.isEmpty,
      state: state ?? this.state,
    );
  }
}

extension LetterExtension on Letter {
  LetterBoxStyle get keyboardStyleByState {
    switch (state) {
      case LetterState.position:
        return LetterBoxStyles.keyboardPositionedStyle;
      case LetterState.contain:
        return LetterBoxStyles.keyboardContainsStyle;
      case LetterState.noContains:
        return LetterBoxStyles.keyboardNotContainsStyle;
      default:
        return LetterBoxStyles.defaultKeyboardStyle;
    }
  }

  Letter get setPositionState => copyWith(state: LetterState.position);
  Letter get setContainState => copyWith(state: LetterState.contain);
  Letter get setNoContainState => copyWith(state: LetterState.noContains);
  Letter get setNoneState => copyWith(state: LetterState.none);
}
