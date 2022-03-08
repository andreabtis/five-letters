import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wordle/features/home/home_page.dart';
import 'package:flutter_wordle/utils/navigation_utils.dart';

class _Constants {
  static const String img = 'assets/home.png';
  static const int secondsSplash = 2;
}

class SplashPage extends StatefulWidget {
  const SplashPage({
    Key? key,
  }) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    navigateAfterDelay();
  }

  navigateAfterDelay() async {
    await Future.delayed(
      const Duration(
        seconds: _Constants.secondsSplash,
      ),
    ).then(
      (value) => NavigationUtils.pushAndReplace(
        context,
        const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(
              _Constants.img,
              scale: kIsWeb ? 2 : 3,
            ),
          ),
        ],
      ),
    );
  }
}
