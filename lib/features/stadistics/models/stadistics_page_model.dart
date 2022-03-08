import 'package:flutter/material.dart';
import '../../../styles/custom_text_styles.dart';
import '../../../utils/shared_preferences.dart';

class StadisticsPageModel {
  static const String userName = 'Andrea Serrano';
  static const String hashtag = '#';
  static const String title = 'STADISTICS';

  static const String playedTitle = 'Played';
  static const String streakTitle = 'Current Streak %';
  static const String maxStreakTitle = 'Max Streak %';
  static const String winTitle = 'WIN %';

  static Text buildText(String text, TextStyle? style) {
    TextStyle _defaultStyle = CustomTextStyles.defaultFontStyle;
    return Text(
      text,
      style: TextStyle(
        fontSize: style?.fontSize ?? _defaultStyle.fontSize,
        fontFamily: style?.fontFamily ?? _defaultStyle.fontFamily,
        color: style?.color ?? _defaultStyle.color,
        fontWeight: style?.fontWeight ?? _defaultStyle.fontWeight,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  static Future<String?> getUserName() async {
    return await SharedPrefs.getUserName();
  }

  static Future<String?> getRankingPosition() async {
    //TODO: add the real position (use the index from the ranking list)
    return await SharedPrefs.getUserName();
  }
}
