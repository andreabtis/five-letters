import 'package:flutter/material.dart';
import 'package:flutter_wordle/widgets/letter_model.dart';
import '../features/game/keyboard.dart';
import '../style/colors.dart';
import '../style/letter_box_style.dart';
import '../style/letter_box_styles.dart';
import '../utils/strings.dart';
import 'generic_letter_widget.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class _Constants {
  static const double horizontalSpace = 2;
  static const double bottomSpace = 10;

  static const double specialKeyWidth = kIsWeb ? 90 : 50;
  static const double specialKeyHeight = kIsWeb ? 60 : 30;
  static const double letterKeyWidth = kIsWeb ? 70 : 30;
  static const double letterKeyHeight = kIsWeb ? 80 : 40;

  static const int firstRowStartIndex = 0;
  static const int firstRowEndIndex = 10;
  static const int secondRowEndIndex = 19;

  static const double specialKeyRatioWidth = 0.13;
  static const double deleteKeyIconsize = 20;
}

typedef StringLetterValue = void Function(String, int);
typedef SpecialLetterCallBack = void Function(bool);

class GenericKeyboard extends StatefulWidget {
  final StringLetterValue onLetterCallback;
  final SpecialLetterCallBack deleteCallBack;
  final SpecialLetterCallBack enterCallBack;

  const GenericKeyboard({
    Key? key,
    required this.onLetterCallback,
    required this.deleteCallBack,
    required this.enterCallBack,
  }) : super(key: key);

  @override
  _GenericKeyboardState createState() => _GenericKeyboardState();
}

class _GenericKeyboardState extends State<GenericKeyboard> {
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FocusScope.of(context).requestFocus(_focusNode);

    return RawKeyboardListener(
      onKey: (e) {
        //TODO: investigate a bit RawKeyUpEvent pls
        if (e.runtimeType.toString() == 'RawKeyUpEvent') {
          Keyboard.onPressKeyOnKeyboard(
            logicalKey: e.logicalKey,
            onLetter: (string, integer) => widget.onLetterCallback(
              e.logicalKey.keyLabel.toLowerCase(),
              Keyboard.currentKeyboardIndex(
                Keyboard.letters,
                e.logicalKey.keyLabel,
              ),
            ),
            keyboardLetters: Keyboard.letters,
            onDelete: widget.deleteCallBack,
            onEnter: widget.enterCallBack,
          );
        }
      },
      focusNode: _focusNode,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double maxWidth = MediaQuery.of(context).size.width;
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _getRow(
                    startIndex: _Constants.firstRowStartIndex,
                    endIndex: _Constants.firstRowEndIndex,
                    width: _Constants.letterKeyWidth,
                    height: _Constants.letterKeyHeight,
                  ),
                  _getRow(
                    startIndex: _Constants.firstRowEndIndex,
                    endIndex: _Constants.secondRowEndIndex,
                    width: _Constants.letterKeyWidth,
                    height: _Constants.letterKeyHeight,
                  ),
                  Row(
                    children: [
                      _enterKey(
                        width: kIsWeb
                            ? _Constants.specialKeyWidth
                            : maxWidth * _Constants.specialKeyRatioWidth,
                        height: _Constants.specialKeyHeight,
                      ),
                      const SizedBox(width: _Constants.horizontalSpace),
                      _getRow(
                        startIndex: _Constants.secondRowEndIndex,
                        endIndex: Keyboard.letters.length,
                        width: _Constants.letterKeyWidth,
                        height: _Constants.letterKeyHeight,
                      ),
                      const SizedBox(width: _Constants.horizontalSpace),
                      _deleteKey(
                        width: kIsWeb
                            ? _Constants.specialKeyWidth
                            : maxWidth * _Constants.specialKeyRatioWidth,
                        height: _Constants.specialKeyHeight,
                      ),
                    ],
                  ),
                  const SizedBox(height: _Constants.bottomSpace),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _enterKey({required double height, required double width}) {
    LetterBoxStyle style = LetterBoxStyles.defaultKeyboardStyle;

    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              style.backgroundColor,
            ),
            padding: MaterialStateProperty.all(
              EdgeInsets.zero,
            ),
          ),
          onPressed: () => widget.enterCallBack(true),
          child: Text(
            Strings.enterButton.toUpperCase(),
            style: style.textStyle,
          ),
        ),
      );
    });
  }

  Widget _deleteKey({
    required double height,
    required double width,
  }) {
    LetterBoxStyle style = LetterBoxStyles.defaultStyle;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return SizedBox(
        width: width,
        height: height,
        child: ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.zero,
              ),
              backgroundColor: MaterialStateProperty.all(
                style.backgroundColor,
              ),
            ),
            onPressed: () => widget.deleteCallBack(true),
            child: const Icon(
              Icons.backspace,
              size: _Constants.deleteKeyIconsize,
              color: CustomColors.white,
            )),
      );
    });
  }

  Widget _getRow({
    required int startIndex,
    required int endIndex,
    required double width,
    required double height,
  }) {
    List<Letter> lettersList = Keyboard.letters.sublist(startIndex, endIndex);

    return Row(
      children: lettersList
          .map(
            (e) => GenericLetterBox(
              letter: e,
              isKeyboard: true,
              onPressed: () => widget.onLetterCallback(
                e.value,
                lettersList.indexOf(e),
              ),
              style: e.keyboardStyleByState,
            ),
          )
          .toList(),
    );
  }
}
