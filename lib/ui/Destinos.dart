import 'package:flutter/material.dart';


class Destinos extends StatefulWidget {
  Destinos({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Destinos createState() => _Destinos();
}

class _Destinos extends State<Destinos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Destinos'),
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
                  context, MaterialPageRoute(builder: (context) => Destinos()));
            },
            child: Text(
              "Banheiro",
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
                  context, MaterialPageRoute(builder: (context) => Destinos()));
            },
            child: Text(
              "Secretaria",
              style: TextStyle(fontSize: 25.0),
            ),
          ),
        )
      ],
    );
  }
}