import 'package:flutter/material.dart';


class Locais extends StatefulWidget {
  Locais({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Locais createState() => _Locais();
}

class _Locais extends State<Locais> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Locais'),
        ),
        body: Center(child: widgetColumn()));
  }

  widgetColumn() {
    return Column(
      children: <Widget>[
        SizedBox(
          width: 350.0,
          height: 80.0,
          child: FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Locais()));
            },
            child: Text(
              "Faculdade X",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        ),
        SizedBox(
          width: 350.0,
          height: 80.0,
          child: FlatButton(
            color: Colors.white60,
            textColor: Colors.black,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            //padding: EdgeInsets.all(30.0),
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Locais()));
            },
            child: Text(
              "Museu X",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        ),
        SizedBox(
          width: 350.0,
          height: 80.0,
          child: FlatButton(
            color: Colors.black,
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            splashColor: Colors.blueAccent,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Locais()));
            },
            child: Text(
              "Shopping X",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        ),
      ],
    );
  }
}