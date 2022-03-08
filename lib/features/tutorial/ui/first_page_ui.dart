import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/tutorial/models/first_page_model.dart';
import 'package:flutter_wordle/styles/custom_text_styles.dart';

import '../../../style/colors.dart';

class _Constants {
  static const double thirtyOne = 31;
  static const double thirteen = 13;

  static const double lateralPadding = 20;
}

class FirstTutorialPage extends StatefulWidget {
  const FirstTutorialPage({Key? key}) : super(key: key);

  @override
  _FirstTutorialPageState createState() => _FirstTutorialPageState();
}

class _FirstTutorialPageState extends State<FirstTutorialPage> {
  TextStyle defaultStyle = CustomTextStyles.defaultFontStyle;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return ConstrainedBox(
        constraints: constraints,
        child: SingleChildScrollView(
          child: Column(
            children: [_buildBody()],
          ),
        ),
      );
    });
  }

  Widget _buildBody() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: _Constants.lateralPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(FirstTutorialPageModel.description1,
                  style: CustomTextStyles.defaultFontStyle),
              Text(
                FirstTutorialPageModel.blueDescription1,
                style: CustomTextStyles.defaultFontStyle
                    .copyWith(color: CustomColors.accent),
              ),
            ],
          ),
          Text(
            FirstTutorialPageModel.description2,
            style: CustomTextStyles.defaultFontStyle,
          ),
          const SizedBox(height: _Constants.thirtyOne),
          FirstTutorialPageModel.divider,
          const SizedBox(height: _Constants.thirtyOne),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: FirstTutorialPageModel.getGenericLetterList(0),
          ),
          const SizedBox(height: _Constants.thirteen),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: FirstTutorialPageModel.description3,
                    style: CustomTextStyles.defaultFontStyle),
                TextSpan(
                  text: FirstTutorialPageModel.blueDescription2,
                  style: CustomTextStyles.defaultFontStyle.copyWith(
                    color: CustomColors.accent,
                  ),
                ),
                TextSpan(
                  text: FirstTutorialPageModel.description4,
                  style: CustomTextStyles.defaultFontStyle,
                ),
              ],
            ),
          ),
          const SizedBox(height: _Constants.thirteen),
          const SizedBox(height: _Constants.thirtyOne),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: FirstTutorialPageModel.getGenericLetterList(1),
          ),
          const SizedBox(height: _Constants.thirteen),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: FirstTutorialPageModel.description5,
                  style: CustomTextStyles.defaultFontStyle,
                ),
                TextSpan(
                    text: FirstTutorialPageModel.blueDescription3,
                    style: CustomTextStyles.defaultFontStyle
                        .copyWith(color: CustomColors.accent)),
                TextSpan(
                  text: FirstTutorialPageModel.description6,
                  style: CustomTextStyles.defaultFontStyle,
                ),
                TextSpan(
                    text: FirstTutorialPageModel.blueDescription4,
                    style: CustomTextStyles.defaultFontStyle
                        .copyWith(color: CustomColors.accent)),
                TextSpan(
                    text: FirstTutorialPageModel.description7,
                    style: CustomTextStyles.defaultFontStyle),
              ],
            ),
          ),
          const SizedBox(height: 80)
        ],
      ),
    );
  }
}
