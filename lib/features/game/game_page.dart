import 'dart:async';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/dialogs/finish_game_dialog.dart';
import 'package:flutter_wordle/features/dialogs/info_dialog.dart';
import 'package:flutter_wordle/features/game/game_api.dart';
import 'package:flutter_wordle/features/game/keyboard.dart';
import 'package:flutter_wordle/features/game/matrix.dart';
import 'package:flutter_wordle/features/tutorial/ui/tutorial_page.dart';
import 'package:flutter_wordle/utils/navigation_utils.dart';
import 'package:flutter_wordle/utils/shared_preferences.dart';
import 'package:flutter_wordle/widgets/generic_keyboard.dart';
import 'package:flutter_wordle/widgets/letter_model.dart';
import '../../utils/strings.dart';
import '../../widgets/generic_letter_widget.dart';
import '../stadistics/ui/custom_spinner.dart';
import 'game.dart';

class _Constants {
  static const String birdImgPath = 'assets/matrix_bird.png';
  static const String infoDialogTitle = 'Ops!';
  static const String infoDialogMessage = 'Please write a valid word';
  static const double topMatrixSpace = kIsWeb ? 10 : 30;
  static const double matrixHeight = kIsWeb ? 0.7 : 0.6;
  static const double matrixWidth = 0.3;
  static const double rightImageCoordinate = -18;
  static const double bottomImageRatioPosition = 0.007;
  static const double imageScaleRatio = 0.01;
}

class GamePage extends StatefulWidget {
  const GamePage({
    Key? key,
  }) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final StreamController<List<List<GenericLetterBox>>> _gridStreamController =
      StreamController();

  final StreamController<List<Letter>> _keyboardStreamController =
      StreamController();

  int currentRowIndex = 0;
  int currentBoxIndex = 0;
  bool isVisible = true;

  bool _isLoading = false;

  @override
  void initState() {
    clearMatrix();
    getData();
    super.initState();
  }

  clearMatrix() {
    Game.clearMatrix();
    _gridStreamController.add(Matrix.matrixWidgets);
    _keyboardStreamController.add(Keyboard.letters);
  }

  getData() async {
    showSpinner();
    await GameApi().getRandomWord();
    hideSpinner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => {
            //TODO: show dialog asking if want to stop the game and game data will be removed
            Navigator.of(context).pop()
          },
        ),
        actions: [
          IconButton(
            onPressed: () => NavigationUtils.push(
              context,
              const TutorialPage(
                navigateFromHome: false,
              ),
            ),
            icon: const Icon(
              Icons.help_outline,
            ),
          )
        ],
        title: const Text(
          Strings.gameName,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Column(
              children: [
                const SizedBox(height: _Constants.topMatrixSpace),
                StreamBuilder(
                  initialData: Matrix.matrixWidgets,
                  stream: _gridStreamController.stream,
                  builder: (BuildContext context,
                      AsyncSnapshot<List<List<GenericLetterBox>>> snapshot) {
                    return kIsWeb
                        ? Expanded(
                            child: Center(
                              child: _buildMatrix(snapshot.data!),
                            ),
                          )
                        : _buildMatrix(
                            snapshot.data!,
                          );
                  },
                ),
                isVisible
                    ? StreamBuilder(
                        initialData: Keyboard.letters,
                        stream: _keyboardStreamController.stream,
                        builder: (context, snapshot) {
                          return GenericKeyboard(
                            onLetterCallback: (value, index) {
                              if (currentBoxIndex < 5) {
                                Matrix
                                    .matrixWidgets[currentRowIndex]
                                        [currentBoxIndex]
                                    .letter
                                    .value = value;
                                currentBoxIndex++;
                                _gridStreamController.add(Matrix.matrixWidgets);
                              }
                            },
                            deleteCallBack: (value) {
                              if (currentBoxIndex > 0) {
                                value
                                    ? Matrix
                                        .matrixWidgets[currentRowIndex]
                                            [currentBoxIndex - 1]
                                        .letter
                                        .value = ''
                                    : null;
                                currentBoxIndex--;
                                _gridStreamController.add(Matrix.matrixWidgets);
                              }
                            },
                            enterCallBack: (value) async {
                              if (value) {
                                showSpinner();
                                String word = Matrix
                                    .matrixWidgets[currentRowIndex]
                                    .map((e) => e.letter.value)
                                    .join();
                                bool isWordValid = await Matrix.isWordValid(
                                  currentRowIndex,
                                  Matrix.matrixWidgets,
                                );

                                if (isWordValid) {
                                  if (Game.isLastLetterOfMatrix(
                                        currentRowIndex,
                                        currentBoxIndex,
                                      ) ||
                                      Matrix.isTheSameWord(word)) {
                                    onGameFinish(context, word);
                                  } else {
                                    _gridStreamController
                                        .add(Matrix.matrixWidgets);
                                    _keyboardStreamController
                                        .add(Keyboard.letters);
                                    currentRowIndex++;
                                    currentBoxIndex = 0;
                                  }
                                } else {
                                  hideSpinner();
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const InfoDialog(
                                        title: _Constants.infoDialogTitle,
                                        message: _Constants.infoDialogMessage,
                                      );
                                    },
                                  );
                                }
                                hideSpinner();
                              }
                            },
                          );
                        })
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }

  hideSpinner() => setState(() {
        _isLoading = false;
      });
  showSpinner() => setState(() {
        _isLoading = true;
      });

  onGameFinish(BuildContext context, String word) async {
    Game.clearMatrix();
    setState(() {
      isVisible = !isVisible;
    });

    bool hasWonTheGame = Matrix.isTheSameWord(word);

    await SharedPrefs.updateGamesPlayed();
    await SharedPrefs.setLastGameResult(hasWonTheGame);
    await SharedPrefs.updateGamesWon(hasWonTheGame);
    await SharedPrefs.updateGameRatio();

    await showEndGameDialog(context, word);
  }

  Future<void> showEndGameDialog(
    BuildContext context,
    String word,
  ) async =>
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => FinishGameDialog(
          guessesWord: word,
        ),
      );

  Widget _buildMatrix(List<List<GenericLetterBox>> matrixList) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        _isLoading
            ? Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: kIsWeb
                      ? maxHeight * _Constants.matrixHeight
                      : maxHeight * _Constants.matrixHeight,
                  width: kIsWeb ? maxWidth * _Constants.matrixWidth : null,
                  child: const Center(child: CustomSpinner()),
                ),
              )
            : Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: kIsWeb
                      ? maxHeight * _Constants.matrixHeight
                      : maxHeight * _Constants.matrixHeight,
                  width: kIsWeb ? maxWidth * _Constants.matrixWidth : null,
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: matrixList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: matrixList[index]
                            .map(
                              (e) => GenericLetterBox(
                                letter: e.letter,
                                isKeyboard: e.isKeyboard,
                                style: e.style,
                              ),
                            )
                            .toList(),
                      );
                    },
                  ),
                ),
              ),
        kIsWeb
            ? Align(
                alignment: Alignment.centerRight,
                child: Image.asset(
                  _Constants.birdImgPath,
                  scale: 1,
                ),
              )
            : Positioned(
                right: _Constants.rightImageCoordinate,
                bottom: maxHeight * _Constants.bottomImageRatioPosition,
                child: Image.asset(
                  _Constants.birdImgPath,
                  scale: maxWidth * _Constants.imageScaleRatio,
                ),
              ),
      ],
    );
  }
}
