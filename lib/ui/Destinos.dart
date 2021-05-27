import 'package:flutter/material.dart';
import 'package:myfriend/model/DestinosModel.dart';
import 'package:myfriend/API/Requisicoes.dart';

class Destinos extends StatefulWidget {
  @override
  _DestinosState createState() => _DestinosState();
}

class _DestinosState extends State<Destinos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Destinos'),
      ),
      body: Container(
        child: FutureBuilder<DestinosModel>(
            future: postDestinos("0", "1"),
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
                  print(snapshot.data);
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: snapshot.data.destinos
                        .map((e) => Column(
                      children: [
                        Text(e.nome,
                            style: TextStyle(
                                color: Colors.white, fontSize: 25.0),
                            textAlign: TextAlign.center)
                      ],
                    ),
                    )
                        .toList(),
                  );
              }
            }),
      ),
    );
  }
}
