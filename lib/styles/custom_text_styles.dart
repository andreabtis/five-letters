import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../style/colors.dart';

import 'font_family.dart';
import 'font_size.dart';

class CustomTextStyles {
  static TextStyle defaultFontStyle = const TextStyle(
    color: CustomColors.darkGray,
    fontSize: FontSize.twentyFour,
    fontFamily: FontFamily.mulishLight,
    letterSpacing: -0.65,
    fontWeight: FontWeight.normal,
  );
  static TextStyle blueFontStyle = defaultFontStyle.copyWith(
    color: CustomColors.accent,
  );

  static TextStyle descriptionFontStyle = defaultFontStyle.copyWith(
    fontSize: FontSize.fourTeen,
    fontWeight: FontWeight.w700,
  );

  static TextStyle scoreRegularFontStyle = defaultFontStyle.copyWith(
    fontSize: kIsWeb ? FontSize.fourtyEight : FontSize.thirtySix,
    fontFamily: FontFamily.leagueGothicRegular,
    fontWeight: FontWeight.w400,
    color: CustomColors.darkestGray,
  );

  static TextStyle scoreHugeFontStyle = defaultFontStyle.copyWith(
    fontSize: kIsWeb ? FontSize.sixtyFour : FontSize.thirtySix,
    fontFamily: FontFamily.leagueGothicRegular,
    fontWeight: FontWeight.bold,
    color: CustomColors.darkestGray,
  );

  static TextStyle whiteTitleFontStyle = defaultFontStyle.copyWith(
    fontSize: FontSize.thirtyTwo,
    fontFamily: FontFamily.mulishLight,
    fontWeight: FontWeight.w800,
    color: CustomColors.white,
  );

  static TextStyle yellowFontstyle = defaultFontStyle.copyWith(
    fontSize: kIsWeb ? FontSize.thirtySix : FontSize.twentyFour,
    color: CustomColors.yellow,
    fontWeight: FontWeight.bold,
  );

  static TextStyle dialogTitle = const TextStyle(
    fontFamily: FontFamily.mulishBold,
    color: CustomColors.white,
    fontSize: kIsWeb ? FontSize.thirtySix : FontSize.twentyFour,
    fontWeight: FontWeight.bold,
  );

  static TextStyle rankPosition = dialogTitle.copyWith(
    color: CustomColors.yellow,
    fontSize: FontSize.thirtySix,
  );
}
