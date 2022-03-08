import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/tutorial/ui/second_page_ui.dart';

import '../ui/first_page_ui.dart';

class TutorialPageModel {
  static final List<Widget> pages = [
    const FirstTutorialPage(),
    const SecondTutorialPage()
  ];
}
