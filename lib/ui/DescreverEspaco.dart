import 'package:flutter/material.dart';
import 'package:myfriend/model/DescreverEspacoModel.dart';
import 'package:myfriend/API/Requisicoes.dart';

class DescreverEspaco extends StatefulWidget {
  @override
  _DescreverEspacoState createState() => _DescreverEspacoState();
}

class _DescreverEspacoState extends State<DescreverEspaco> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Descrever Espaço'),
      ),
      body: Container(
        child: FutureBuilder<DescreverEspacoModel>(
            future: postDescreverEspaco("0", "1"),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return Center(
                    child: Text(
                      "Carregando...",
                      style: TextStyle(color: Colors.white, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                default:
                  print(snapshot.data.texto);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(snapshot.data.local,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,),
                      Text(snapshot.data.espaco,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,),
                      Text(snapshot.data.texto,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,)
                    ],
                  );
              }
            }),
      ),

    );
  }
}

