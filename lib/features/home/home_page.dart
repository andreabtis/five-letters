import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/game/game_page.dart';
import 'package:flutter_wordle/features/statistics/ui/statistics_page.dart';
import 'package:flutter_wordle/features/tutorial/ui/tutorial_page.dart';
import 'package:flutter_wordle/utils/navigation_utils.dart';
import 'package:flutter_wordle/utils/shared_preferences.dart';
import 'package:flutter_wordle/utils/ui_helpers.dart';
import 'package:flutter_wordle/widgets/custom_elevated_button.dart';

import '../../styles/custom_elevated_button_styles.dart';
import '../../utils/strings.dart';
import '../game/game_page.dart';

class _Constants {
  static const String assetPath = 'assets/home.png';
  static const Size buttonSize = Size(160, 30);
}

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              _Constants.assetPath,
              scale: kIsWeb ? 2 : 3,
            ),
            UIHelper.verticalSpaceSmall(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomElevatedButton(
                  label: Strings.tutorial,
                  onPressed: () => NavigationUtils.push(
                    context,
                    const TutorialPage(
                      navigateFromHome: true,
                    ),
                  ),
                  style: CustomElevatedButtonStyles.defaultStyle.copyWith(
                    size: _Constants.buttonSize,
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
                CustomElevatedButton(
                  label: Strings.play,
                  style: CustomElevatedButtonStyles.secondaryStyle.copyWith(
                    size: _Constants.buttonSize,
                  ),
                  onPressed: () => NavigationUtils.push(
                    context,
                    const GamePage(),
                  ),
                ),
                UIHelper.verticalSpaceSmall(),
                FutureBuilder<String?>(
                  future: SharedPrefs.getUserName(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? CustomElevatedButton(
                            label: Strings.statistics,
                            onPressed: () => NavigationUtils.push(
                              context,
                              const StatisticsPage(),
                            ),
                            style: CustomElevatedButtonStyles.defaultStyle
                                .copyWith(
                              size: _Constants.buttonSize,
                            ),
                          )
                        : const SizedBox();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
