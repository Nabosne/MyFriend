import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myfriend/ui/TutorialPages/SplashScreenInitial.dart';


void main() {
  runApp(MaterialApp(
    home: SplashScreenInitial(),
    title: "My Friend",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

