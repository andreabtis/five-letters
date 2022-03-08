import 'package:flutter/material.dart';

import '../../../style/colors.dart';

class CustomSpinner extends StatefulWidget {
  const CustomSpinner({Key? key}) : super(key: key);

  @override
  _CustomSpinnerState createState() => _CustomSpinnerState();
}

class _CustomSpinnerState extends State<CustomSpinner> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Container(
            color: CustomColors.transparent,
            child: const CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}
