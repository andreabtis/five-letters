import 'package:flutter/material.dart';
import 'package:flutter_wordle/style/letter_box_style.dart';
import 'package:flutter_wordle/style/letter_box_styles.dart';
import 'package:flutter_wordle/widgets/letter_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class _Constants {
  static const double letterMargin = 4;
  static const double letterKeyWidth = 50;
  static const double letterKeyHeight = kIsWeb ? 60 : 30;
  static const double widthLetterMatrix = kIsWeb ? 65 : 50;
  static const double heightLetterMatrix = kIsWeb ? 65 : 50;
  static const double letterWidthRatio = 0.07;
}

// ignore: must_be_immutable
class GenericLetterBox extends StatefulWidget {
  final Letter letter;
  final bool isKeyboard;
  LetterBoxStyle? style;
  final void Function()? onPressed;

  GenericLetterBox({
    Key? key,
    required this.letter,
    required this.isKeyboard,
    this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  _GenericLetterBoxState createState() => _GenericLetterBoxState();
}

class _GenericLetterBoxState extends State<GenericLetterBox> {
  @override
  Widget build(BuildContext context) {
    //double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(
        _Constants.letterMargin,
      ),
      child: SizedBox(
        width: widget.isKeyboard
            ? kIsWeb
                ? _Constants.letterKeyWidth
                : maxWidth * _Constants.letterWidthRatio
            : _Constants.widthLetterMatrix,
        height: widget.isKeyboard
            ? _Constants.letterKeyHeight
            : _Constants.heightLetterMatrix,
        child: ElevatedButton(
          style: ButtonStyle(
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            backgroundColor: MaterialStateProperty.all(
              widget.style?.backgroundColor ??
                  LetterBoxStyles.defaultStyle.backgroundColor,
            ),
          ),
          onPressed: widget.isKeyboard ? () => widget.onPressed?.call() : null,
          child: Text(widget.letter.value.toUpperCase(),
              style: widget.style?.textStyle),
        ),
      ),
    );
  }
}
