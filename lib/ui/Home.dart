import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: GridView.count(
        padding: EdgeInsets.zero,
        crossAxisCount: 2,
        childAspectRatio: widthScreen / heightScreen * 1.68,
        children: <Widget>[
          Container(
            child: buildButton(
                context, "Onde\nestou?", Colors.black, Colors.white,
                destino: OndeEstou()),
          ),
          Container(
            child: buildButton(
                context, "Descrever\nEspaço", Colors.white, Colors.black,
                destino: DescreverEspaco()),
          ),
          Container(
            child: buildButton(context, "Destinos", Colors.white, Colors.black,
                destino: Destinos()),
          ),
          Container(
            child: buildButton(context, "Locais", Colors.black, Colors.white,
                destino: Locais()),
          ),
          Container(
            child: buildButton(context, "Tutorial", Colors.black, Colors.white,
                destino: Tutorial()),
          ),
          Container(
              child: buildButton(context, "Sair", Colors.white, Colors.black)
          ),
        ],
      ),
    );
  }

  Widget buildButton(
      BuildContext context, String label, Color buttonColor, Color textColor,
      {dynamic destino}) {
    return FlatButton(
      color: buttonColor,
      child: Text(
        label,
        style: TextStyle(color: textColor, fontSize: 15.0),
        textAlign: TextAlign.center,
      ),
      onPressed: () {
        if (label == "Sair") {
          SystemNavigator.pop();
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => destino));
        }
      },
    );
  }
}
