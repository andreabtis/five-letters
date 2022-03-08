import 'package:flutter/material.dart';
import 'package:flutter_wordle/styles/custom_elevated_button_styles.dart';

import '../styles/custom_elevated_button_style.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatefulWidget {
  final String label;
  final Function() onPressed;
  CustomElevatedButtonStyle? style;

  CustomElevatedButton({
    Key? key,
    required this.label,
    required this.onPressed,
    this.style,
  }) : super(key: key);

  @override
  State<CustomElevatedButton> createState() => _CustomElevatedButtonState();
}

class _CustomElevatedButtonState extends State<CustomElevatedButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.style ??= CustomElevatedButtonStyles.defaultStyle;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: widget.style?.backgroundColor,
        textStyle: widget.style?.textStyle,
        fixedSize: widget.style?.size,
        shape: widget.style?.shape,
      ),
      onPressed: widget.onPressed,
      child: Text(
        widget.label.toUpperCase(),
        style: widget.style?.textStyle,
      ),
    );
  }
}
