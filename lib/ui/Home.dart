import 'dart:io';
import 'package:flutter/material.dart';
import 'package:myfriend/ui/DescreverEspaco.dart';
import 'package:myfriend/ui/OndeEstou.dart';
import 'package:myfriend/ui/Tutorial.dart';
import 'package:myfriend/ui/Locais.dart';
import 'package:myfriend/ui/Destinos.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    var mediaQueryData = MediaQuery.of(context);
    final double widthScreen = mediaQueryData.size.width;
    final double heightScreen = mediaQueryData.size.height;

    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("MyFriend"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {})
        ],
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
          childAspectRatio: widthScreen/heightScreen * 1.68,
        children: <Widget>[
          Container(
            child: buildFlatButton("Onde\nestou?", Colors.black, Colors.white,
                MaterialPageRoute(builder: (context) => OndeEstou())),
          ),
          Container(
            child: buildFlatButton("Descrever\nEspaço", Colors.white, Colors.black,
                MaterialPageRoute(builder: (context) => DescreverEspaco())),
          ),
          Container(
            child: buildFlatButton("Destinos", Colors.white, Colors.black,
                MaterialPageRoute(builder: (context) => Destinos())),
          ),
          Container(
            child: buildFlatButton("Locais", Colors.black, Colors.white,
                MaterialPageRoute(builder: (context) => Locais())),
          ),
          Container(
            child: buildFlatButton("Tutorial", Colors.black, Colors.white,
                MaterialPageRoute(builder: (context) => Tutorial())),
          ),
          Container(
            child: buildFlatButton("Sair", Colors.white, Colors.black,
                MaterialPageRoute(builder: (context) => exit(0))),
          ),
        ],
        /*
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Icon(
                Icons.person_pin,
                size: 80,
                color: Colors.black,
              ),
              Row(
                children: [
                  buildFlatButton("Onde\nestou?", Colors.black, Colors.white,
                      MaterialPageRoute(builder: (context) => OndeEstou())),
                  buildFlatButton(
                      "Descrever\nEspaço",
                      Colors.white,
                      Colors.black,
                      MaterialPageRoute(
                          builder: (context) => DescreverEspaco())),
                ],
              ),
              Row(
                children: [
                  buildFlatButton("Destinos", Colors.white, Colors.black,
                      MaterialPageRoute(builder: (context) => Destinos())),
                  buildFlatButton("Locais", Colors.black, Colors.white,
                      MaterialPageRoute(builder: (context) => Locais())),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  buildFlatButton("Tutorial", Colors.black, Colors.white,
                      MaterialPageRoute(builder: (context) => Tutorial())),
                  buildFlatButton("Sair", Colors.white, Colors.black,
                      MaterialPageRoute(builder: (context) => exit(0))),
                ],
              ),
            ],
          )*/
      ),
    );
  }
  Widget buildFlatButton(String label, Color buttonColor, Color textColor,
      MaterialPageRoute m) {
    return  FlatButton(
        color: buttonColor,
        child: Text(
          label,
          style: TextStyle(color: textColor, fontSize: 14.0),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          //Navigator.pop(context, m);
          Navigator.push(context, m);
        });
  }
}
