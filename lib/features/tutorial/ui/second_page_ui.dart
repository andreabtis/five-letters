import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/tutorial/models/second_page_model.dart';

import '../../../styles/custom_text_styles.dart';

class _Constants {
  static const double lateralPadding = 20;
  static const double thirtyOne = 31;
  static const double initialSpace = 20;
  static const double bottomSpace = 80;
}

class SecondTutorialPage extends StatefulWidget {
  const SecondTutorialPage({Key? key}) : super(key: key);

  @override
  _SecondTutorialPageState createState() => _SecondTutorialPageState();
}

class _SecondTutorialPageState extends State<SecondTutorialPage> {
  TextStyle defaultStyle = CustomTextStyles.defaultFontStyle;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ConstrainedBox(
          constraints: constraints,
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildBody(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: _Constants.lateralPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: _Constants.initialSpace),
          Text(
            SecondTutorialPageModel.description1,
            style: CustomTextStyles.defaultFontStyle,
          ),
          const SizedBox(height: _Constants.thirtyOne),
          Row(
            children: SecondTutorialPageModel.getGenericLetterList(0),
          ),
          const SizedBox(height: _Constants.thirtyOne),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: SecondTutorialPageModel.description4,
                  style: CustomTextStyles.defaultFontStyle,
                ),
                TextSpan(
                  text: SecondTutorialPageModel.blueDescription5,
                  style: CustomTextStyles.blueFontStyle,
                ),
                TextSpan(
                  text: SecondTutorialPageModel.description5,
                  style: CustomTextStyles.defaultFontStyle,
                )
              ],
            ),
          ),
          const SizedBox(height: _Constants.thirtyOne),
          SecondTutorialPageModel.enterKey,
          const SizedBox(
            height: _Constants.thirtyOne,
          ),
          SecondTutorialPageModel.divider,
          const SizedBox(
            height: _Constants.thirtyOne,
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: SecondTutorialPageModel.description6,
                  style: CustomTextStyles.defaultFontStyle,
                ),
                TextSpan(
                  text: SecondTutorialPageModel.blueDescription6,
                  style: CustomTextStyles.blueFontStyle,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: _Constants.bottomSpace,
          ),
        ],
      ),
    );
  }
}
