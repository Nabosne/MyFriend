import 'package:flutter/material.dart';
import 'package:myfriend/ui/Tutorial.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenTutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      return SplashScreen(
        seconds: 3,
        navigateAfterSeconds: Tutorial(),
        image: Image.asset("images/imgMyFriend.png"),
        backgroundColor: Colors.white,
        photoSize: 170.0,
        loaderColor: Colors.black,

      );

  }
  }
