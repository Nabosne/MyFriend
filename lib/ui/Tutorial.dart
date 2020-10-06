import 'package:flutter/material.dart';


class Tutorial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Tutorial'),
        ),
        body: Center(
            child: Text(
              ' Seja bem vindo ao My friend. \n Preparamos esse conteúdo especial que irá lhe fornecer dicas sobre o uso do aplicativo.',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            )));
  }
}
