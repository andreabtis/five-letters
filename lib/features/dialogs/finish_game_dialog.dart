import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/game/game_page.dart';
import 'package:flutter_wordle/features/stadistics/ui/stadistics_page.dart';
import 'package:flutter_wordle/style/colors.dart';
import 'package:flutter_wordle/styles/custom_elevated_button_styles.dart';
import 'package:flutter_wordle/styles/custom_text_styles.dart';
import 'package:flutter_wordle/styles/font_size.dart';
import 'package:flutter_wordle/utils/navigation_utils.dart';
import 'package:flutter_wordle/utils/shared_preferences.dart';
import 'package:flutter_wordle/widgets/custom_elevated_button.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../../utils/ui_helpers.dart';

class _Constants {
  static const String winImage = 'assets/dialog_bird.png';
  static const String defeatImage = 'assets/defeat_bird.png';
  static const double screenPadding = 20;
  static const int inputTextMaxLenght = 20;
  static const double insetDialogPadding = 8;
  static const double dialogCircleSize = 370;
  static const double dialogCircleSizeWeb = 600;
  static const double dialogElevation = 0;
  static const double inputTextWidth = 250;
  static const int textFieldMaxLines = 1;
  static const UnderlineInputBorder underlineInputBorder = UnderlineInputBorder(
    borderSide: BorderSide(
      color: CustomColors.yellow,
      width: 2,
    ),
  );
}

class _Strings {
  static const String winTitle = "Victory!";
  static const String loseTitle = "Defeat";
  static const String firstButton = "play again";
  static const String secondButton = "stadistics";
  static const String helperText = "* Used to save the score";
  static const String hintText = "Enter your name";
  static const String prefixGuessedWord = "The word was:";
  static const String defeatText = "You didn't guess the word";
}

class FinishGameDialog extends StatefulWidget {
  final String guessesWord;

  const FinishGameDialog({
    Key? key,
    required this.guessesWord,
  }) : super(key: key);

  @override
  State<FinishGameDialog> createState() => _FinishGameDialogState();
}

class _FinishGameDialogState extends State<FinishGameDialog> {
  final _textEditController = TextEditingController();
  bool isUserAlreadySaved = false;
  bool wonLastGame = false;

  @override
  void initState() {
    isUserNameAlreadySaved();
    getLastGameResult();
    super.initState();
  }

  @override
  void dispose() {
    _textEditController.dispose();
    super.dispose();
  }

  void saveUserName() => SharedPrefs.setUserName(_textEditController.text);

  void getLastGameResult() async {
    await SharedPrefs.getlastGameResult()
        .then((value) => wonLastGame = value ?? false);
  }

  void isUserNameAlreadySaved() async {
    String? userName = await SharedPrefs.getUserName();
    bool isUsernameNull = userName != null && userName.isNotEmpty;
    setState(() {
      isUserAlreadySaved = isUsernameNull;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(
        _Constants.insetDialogPadding,
      ),
      backgroundColor: CustomColors.transparent,
      elevation: _Constants.dialogElevation,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            width: kIsWeb
                ? _Constants.dialogCircleSizeWeb
                : _Constants.dialogCircleSize,
            height: kIsWeb
                ? _Constants.dialogCircleSizeWeb
                : _Constants.dialogCircleSize,
            padding: const EdgeInsets.all(
              _Constants.screenPadding,
            ),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CustomColors.primary,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                kIsWeb
                    ? UIHelper.verticalSpaceLarge()
                    : UIHelper.verticalSpaceSmall(),
                Text(
                  wonLastGame
                      ? _Strings.winTitle.toUpperCase()
                      : _Strings.loseTitle.toUpperCase(),
                  style: CustomTextStyles.dialogTitle,
                ),
                Text(
                  wonLastGame
                      ? ('${_Strings.prefixGuessedWord} ${widget.guessesWord}')
                      : _Strings.defeatText,
                  style: CustomTextStyles.yellowFontstyle,
                ),
                kIsWeb
                    ? UIHelper.verticalSpaceLarge()
                    : UIHelper.verticalSpaceMedium(),
                isUserAlreadySaved
                    ? const SizedBox()
                    : SizedBox(
                        width: _Constants.inputTextWidth,
                        child: TextField(
                          controller: _textEditController,
                          maxLength: _Constants.inputTextMaxLenght,
                          maxLines: _Constants.textFieldMaxLines,
                          keyboardType: TextInputType.name,
                          cursorColor: CustomColors.yellow,
                          style: const TextStyle(
                            color: CustomColors.yellow,
                          ),
                          decoration: const InputDecoration(
                            enabledBorder: _Constants.underlineInputBorder,
                            focusedBorder: _Constants.underlineInputBorder,
                            focusColor: CustomColors.yellow,
                            hintStyle: TextStyle(
                              color: CustomColors.yellow,
                            ),
                            hintText: _Strings.hintText,
                            helperText: _Strings.helperText,
                            helperStyle: TextStyle(
                              color: CustomColors.yellow,
                              fontSize: FontSize.fourteen,
                            ),
                          ),
                        ),
                      ),
                kIsWeb
                    ? UIHelper.verticalSpaceLarge()
                    : UIHelper.verticalSpaceSmall(),
                CustomElevatedButton(
                  label: _Strings.firstButton,
                  onPressed: () {
                    isUserAlreadySaved ? null : saveUserName();
                    return Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const GamePage(),
                        ),
                        (route) => route.isFirst);
                  },
                  style: CustomElevatedButtonStyles.secondaryStyle,
                ),
                UIHelper.verticalSpaceSmall(),
                CustomElevatedButton(
                  label: _Strings.secondButton,
                  onPressed: () {
                    isUserAlreadySaved ? null : saveUserName();
                    return NavigationUtils.pushAndRemoveTill(
                      context,
                      const StadisticsPage(),
                    );
                  },
                  style: CustomElevatedButtonStyles.secondaryStyle,
                ),
              ],
            ),
          ),
          Positioned(
            left: kIsWeb
                ? _Constants.dialogCircleSize
                : MediaQuery.of(context).size.width / 2,
            top: kIsWeb
                ? _Constants.dialogCircleSize
                : _Constants.dialogCircleSize - 60,
            child: Image.asset(
              wonLastGame ? _Constants.winImage : _Constants.defeatImage,
              scale: kIsWeb ? 1 : 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
