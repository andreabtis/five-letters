import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/home/home_page.dart';
import 'package:flutter_wordle/features/stadistics/models/stadistics_page_model.dart';
import 'package:flutter_wordle/styles/font_size.dart';
import 'package:flutter_wordle/styles/custom_text_styles.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_wordle/utils/navigation_utils.dart';
import 'package:flutter_wordle/utils/shared_preferences.dart';
import 'package:flutter_wordle/utils/ui_helpers.dart';

import '../../../style/colors.dart';
import 'custom_spinner.dart';

class _Constants {
  static const double webRatioHeight = 0.4;
  static const double mobileRatioHeight = 0.3;
  static const double bodyHeightRatio = 0.66;

  static const double imageWebLeft = 683;
  static const double imageMobileLeft = 140;
  static const double imageWebRight = 226;
  static const double imageMobileRight = 0.0;

  static const double trophyRight = 20;
  static const double trophyBottom = 20;

  static const double titleTopSpaceWeb = 62;
  static const double titleTopSpaceMobile = 40;

  static const double titleBodySpace = 60;
  static const double lateralWebBodyPadding = 64;
  static const double lateralMobileBodyPadding = 33;

  static const double verticalWebCardPadding = 47;
  static const double spaceWebBetweenCards = 100;
  static const double spaceMobileBetweencards = 11;

  static const double headerBorderRadius = 26;

  static const double leftRatioWebPadding = 0.2;
  static const double leftRatioMobilePadding = 0.08;

  static const double headerTitleMobileTopSpace = 40;
  static const double userNameWebWidth = 390;
  static const double userNameMobileWidth = 124;
  static const double heightWebScoreCard = 200;
  static const double heightMobileScoreCard = 100;
  static const double verticalScoreCardWebPadding = 13;
  static const double verticalScoreCardMobilePadding = 10;
  static const double horizontalScoreCardWebPadding = 38;
  static const double horizontalScoreCardMobilePadding = 10;
  static const double borderScoreCardRadius = 12.0;

  static const int scoreCardRowFlex1 = 2;
  static const int scoreCardRowFlex2 = 1;
  static const int scoreCardRowFlex3 = 4;

  static const String birdImage = 'assets/stadistics_bird.png';
  static const String trophyImage = 'assets/trophy.png';
}

class StadisticsPage extends StatefulWidget {
  const StadisticsPage({Key? key}) : super(key: key);

  @override
  _StadisticsPageState createState() => _StadisticsPageState();
}

class _StadisticsPageState extends State<StadisticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: CustomColors.white,
          ),
          onPressed: () =>
              NavigationUtils.pushAndRemoveTill(context, const HomePage()),
        ),
        backgroundColor: CustomColors.primary,
        elevation: 0,
      ),
      backgroundColor: CustomColors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: Stack(
              children: [
                Positioned(
                  top: kIsWeb
                      ? constraints.maxHeight * _Constants.webRatioHeight
                      : constraints.maxHeight * _Constants.mobileRatioHeight,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight * _Constants.bodyHeightRatio,
                    child: _body(),
                  ),
                ),
                SizedBox(
                  height: kIsWeb
                      ? constraints.maxHeight * _Constants.webRatioHeight
                      : constraints.maxHeight * _Constants.mobileRatioHeight,
                  child: _screenHeader(),
                ),
                Positioned(
                  bottom: _Constants.trophyBottom,
                  right: _Constants.trophyRight,
                  child: Image.asset(
                    _Constants.trophyImage,
                    scale: kIsWeb ? 1 : 1.5,
                  ),
                ),
                Positioned(
                  left: kIsWeb
                      ? _Constants.imageWebLeft
                      : _Constants.imageMobileLeft,
                  right: kIsWeb
                      ? _Constants.imageWebRight
                      : _Constants.imageMobileRight,
                  child: Image.asset(
                    _Constants.birdImage,
                    scale: kIsWeb ? 1 : 2,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
            height: kIsWeb
                ? _Constants.titleTopSpaceWeb
                : _Constants.titleTopSpaceMobile),
        StadisticsPageModel.buildText(
          StadisticsPageModel.title,
          CustomTextStyles.defaultFontStyle.copyWith(
            fontSize: kIsWeb ? FontSize.sixtyFour : FontSize.thirtyTwo,
          ),
        ),
        kIsWeb
            ? Container()
            : const SizedBox(height: _Constants.titleBodySpace),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kIsWeb
                ? _Constants.lateralWebBodyPadding
                : _Constants.lateralMobileBodyPadding,
          ),
          child: kIsWeb
              ? Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: _Constants.verticalWebCardPadding),
                        child: FutureBuilder(
                          future: SharedPrefs.getGamesPlayed(),
                          builder: (BuildContext context,
                              AsyncSnapshot<int?> snapshot) {
                            if (!snapshot.hasData) {
                              return const CustomSpinner();
                            } else {
                              return _buildScoreCard(
                                StadisticsPageModel.buildText(
                                  snapshot.data.toString(),
                                  CustomTextStyles.scoreHugeFontStyle,
                                ),
                                StadisticsPageModel.buildText(
                                  StadisticsPageModel.playedTitle,
                                  CustomTextStyles.scoreHugeFontStyle,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: _Constants.spaceWebBetweenCards),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: _Constants.verticalWebCardPadding),
                        child: FutureBuilder(
                          future: SharedPrefs.getGameWinRate(),
                          builder: (BuildContext context,
                              AsyncSnapshot<double?> snapshot) {
                            if (!snapshot.hasData) {
                              return const CustomSpinner();
                            } else {
                              return _buildScoreCard(
                                StadisticsPageModel.buildText(
                                  snapshot.data!.round().toString(),
                                  CustomTextStyles.scoreHugeFontStyle,
                                ),
                                StadisticsPageModel.buildText(
                                  StadisticsPageModel.winTitle,
                                  CustomTextStyles.scoreHugeFontStyle,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                )
              : Column(
                  children: [
                    FutureBuilder(
                      future: SharedPrefs.getGamesPlayed(),
                      builder: ((BuildContext context,
                          AsyncSnapshot<int?> snapshot) {
                        if (!snapshot.hasData) {
                          return const CustomSpinner();
                        } else {
                          return _buildScoreCard(
                            StadisticsPageModel.buildText(
                              snapshot.data!.round().toString(),
                              CustomTextStyles.scoreRegularFontStyle
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            StadisticsPageModel.buildText(
                              StadisticsPageModel.playedTitle,
                              CustomTextStyles.scoreRegularFontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                    const SizedBox(height: _Constants.spaceMobileBetweencards),
                    FutureBuilder(
                      future: SharedPrefs.getGameWinRate(),
                      builder: ((BuildContext context,
                          AsyncSnapshot<double?> snapshot) {
                        if (!snapshot.hasData) {
                          return const CustomSpinner();
                        } else {
                          return _buildScoreCard(
                            StadisticsPageModel.buildText(
                              snapshot.data!.round().toString(),
                              CustomTextStyles.scoreRegularFontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            StadisticsPageModel.buildText(
                              StadisticsPageModel.winTitle,
                              CustomTextStyles.scoreRegularFontStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ],
                ),
        )
      ],
    );
  }

  Widget _screenHeader() {
    double maxWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: CustomColors.primary,
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(_Constants.headerBorderRadius),
        ),
      ),
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: kIsWeb
                  ? maxWidth * _Constants.leftRatioWebPadding
                  : maxWidth * _Constants.leftRatioMobilePadding,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kIsWeb
                    ? Container()
                    : const SizedBox(
                        height: _Constants.headerTitleMobileTopSpace),
                FutureBuilder<String?>(
                    future: StadisticsPageModel.getUserName(),
                    builder: (context, snapshot) {
                      return Flexible(
                        child: SizedBox(
                          width: kIsWeb
                              ? _Constants.userNameWebWidth
                              : _Constants.userNameMobileWidth,
                          child: StadisticsPageModel.buildText(
                            snapshot.data ?? '',
                            kIsWeb
                                ? CustomTextStyles.whiteTitleFontStyle.copyWith(
                                    fontSize: FontSize.ninetySix,
                                  )
                                : CustomTextStyles.whiteTitleFontStyle,
                          ),
                        ),
                      );
                    }),
                UIHelper.verticalSpaceSmall(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(Text title, Text score) {
    return Container(
      height: kIsWeb
          ? _Constants.heightWebScoreCard
          : _Constants.heightMobileScoreCard,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: kIsWeb
            ? _Constants.verticalScoreCardWebPadding
            : _Constants.verticalScoreCardMobilePadding,
        horizontal: kIsWeb
            ? _Constants.horizontalScoreCardWebPadding
            : _Constants.horizontalScoreCardMobilePadding,
      ),
      decoration: BoxDecoration(
        color: CustomColors.lightGrayBackground,
        borderRadius: BorderRadius.circular(_Constants.borderScoreCardRadius),
      ),
      child: Row(
        children: [
          Expanded(
            flex: _Constants.scoreCardRowFlex1,
            child: Center(child: title),
          ),
          const Expanded(
            flex: _Constants.scoreCardRowFlex2,
            child: VerticalDivider(
              color: CustomColors.darkestGray,
            ),
          ),
          Expanded(
            flex: _Constants.scoreCardRowFlex3,
            child: Center(child: score),
          )
        ],
      ),
    );
  }
}
