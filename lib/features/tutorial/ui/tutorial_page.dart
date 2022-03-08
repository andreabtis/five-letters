import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/game/game_page.dart';
import 'package:flutter_wordle/widgets/custom_elevated_button.dart';

import '../../../utils/navigation_utils.dart';
import '../models/tutorial_page_model.dart';

class _Strings {
  static const String previousButtonLabel = 'Previous';
  static const String nextButtonLabel = 'Next';
  static const String appBarTitle = 'Tutorial';
  static const String startButtonLabel = 'Start';
}

class _Constants {
  static const int animationDuration = 200;
  static const double onBoardingPaddingValue = 28;
  static const double isVisibleButtonConstant = 0;
}

class TutorialPage extends StatefulWidget {
  final bool navigateFromHome;

  const TutorialPage({
    Key? key,
    required this.navigateFromHome,
  }) : super(key: key);

  @override
  _TutorialPageState createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  Widget _toggleBtn(Widget widgetButton, bool isVisible) {
    return isVisible
        ? widgetButton
        : Opacity(
            opacity: _Constants.isVisibleButtonConstant,
            child: IgnorePointer(
              child: widgetButton,
            ),
          );
  }

  Widget buildNextBtn(
    BuildContext context,
    PageController pageController,
  ) =>
      CustomElevatedButton(
        onPressed: () {
          pageController.page == TutorialPageModel.pages.length - 1
              ? widget.navigateFromHome
                  ? NavigationUtils.pushAndReplace(
                      context,
                      const GamePage(),
                    )
                  : Navigator.of(context).pop()
              : _pageController.nextPage(
                  duration: const Duration(
                      milliseconds: _Constants.animationDuration),
                  curve: Curves.easeIn,
                );
        },
        label: _currentPage == 1
            ? _Strings.startButtonLabel
            : _Strings.nextButtonLabel,
        //style: maxWidth < 420 ? CustomElevatedButtonStyles.defaultStyle.copyWith(textStyle: TextStyle(fontSize:))
      );

  Widget buildPreviousBtn(
          BuildContext context, PageController pageController) =>
      CustomElevatedButton(
        label: _Strings.previousButtonLabel,
        onPressed: () {
          pageController.previousPage(
            duration:
                const Duration(milliseconds: _Constants.animationDuration),
            curve: Curves.easeIn,
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          _Strings.appBarTitle,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildPageView(),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(_Constants.onBoardingPaddingValue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _currentPage == 1
                      ? _toggleBtn(
                          buildPreviousBtn(
                            context,
                            _pageController,
                          ),
                          true,
                        )
                      : Container(),
                  _toggleBtn(
                    buildNextBtn(
                      context,
                      _pageController,
                    ),
                    true,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView() {
    return PageView(
      scrollDirection: Axis.horizontal,
      controller: _pageController,
      children: TutorialPageModel.pages.map((e) => Center(child: e)).toList(),
      physics: const BouncingScrollPhysics(),
      onPageChanged: (value) {
        setState(() {
          _currentPage = value;
        });
      },
    );
  }
}
