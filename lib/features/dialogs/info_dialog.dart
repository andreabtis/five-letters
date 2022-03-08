import 'package:flutter/material.dart';
import 'package:flutter_wordle/style/colors.dart';
import 'package:flutter_wordle/styles/custom_elevated_button_styles.dart';
import 'package:flutter_wordle/styles/font_size.dart';
import 'package:flutter_wordle/widgets/custom_elevated_button.dart';

import '../../utils/strings.dart';

class _Constants {
  static const double dialogPadding = 20;
  static const double divider = 20;
}

class InfoDialog extends StatefulWidget {
  final String title;
  final String message;

  const InfoDialog({
    Key? key,
    required this.title,
    required this.message,
  }) : super(key: key);

  @override
  _InfoDialogState createState() => _InfoDialogState();
}

class _InfoDialogState extends State<InfoDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: CustomColors.primary,
      child: Padding(
        padding: const EdgeInsets.all(
          _Constants.dialogPadding,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.title,
              style: const TextStyle(
                color: CustomColors.yellow,
                fontWeight: FontWeight.bold,
                fontSize: FontSize.twentyFour,
              ),
            ),
            const SizedBox(
              height: _Constants.divider,
            ),
            Text(
              widget.message,
              style: const TextStyle(
                color: CustomColors.yellow,
                fontSize: FontSize.sixteen,
              ),
            ),
            const SizedBox(
              height: _Constants.divider,
            ),
            CustomElevatedButton(
              label: Strings.infoDialogAcceptButton,
              onPressed: () => Navigator.pop(context),
              style: CustomElevatedButtonStyles.secondaryStyle,
            ),
          ],
        ),
      ),
    );
  }
}
