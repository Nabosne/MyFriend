import 'package:flutter/material.dart';


class OndeEstou extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Onde estou'),
        ),
        body: Center(
            child: Text(
              ' Você está na Entrada e Saída da Universidade X',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            )));
  }
}
