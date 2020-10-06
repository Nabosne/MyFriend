import 'package:flutter/material.dart';

class DescreverEspaco extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Descrever espaço'),
        ),
        body: Center(
            child: Text(
              ' Entrada e Saída da Universidade X é um corredor com quatro metros de largura que concede acesso a recepção e aos elevadores',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            )));
  }
}
