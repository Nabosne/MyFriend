import 'package:flutter/material.dart';
import 'package:myfriend/ui/Home.dart';
import 'package:myfriend/ui/Tutorial.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenInitial extends StatefulWidget {
  @override
  _SplashScreenInitialState createState() => _SplashScreenInitialState();
}

class _SplashScreenInitialState extends State<SplashScreenInitial> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getBoolValuesSF(),
      builder: (BuildContext context, snapshot){
        return !snapshot.hasData ? _buildSplash(Tutorial()) : _buildSplash(Home());
      },
    );
  }
  getBoolValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    bool boolValue = prefs.getBool('firstTime');
    addBoolToSF();
    print(boolValue);
    return boolValue;
  }
  addBoolToSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('firstTime', true);
  }
  Widget _buildSplash(dynamic destino){
    return SplashScreen(
      seconds: 3,
      navigateAfterSeconds:destino,
      image: Image.asset("images/imgMyFriend.png"),
      backgroundColor: Colors.white,
      photoSize: 170.0,
      loaderColor: Colors.black,
      title: Text("Iniciando o aplicativo",
        style: TextStyle(color: Colors.white),)
    );
  }
}
