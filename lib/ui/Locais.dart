import 'package:flutter/material.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'package:myfriend/model/LocaisModel.dart';

const request = "http://myfriend.pythonanywhere.com/web/service/locais/";

class Locais extends StatefulWidget {
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
        body: Container(
          child: FutureBuilder<LocaisModel>(
              future: getLocais(),
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
                    print(snapshot.data.locais
                        .map((e) => e.beaconLocal)
                        .toList());
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: snapshot.data.locais
                          .map((e) =>
                          Container(
                            alignment: Alignment.center,
                            child:
                            Text(e.nome, style: TextStyle(color: Colors.white, fontSize: 25.0),
                              textAlign: TextAlign.center,)),
                          )
                          .toList(),
                    );
                }
              }),
        ));
  }
}
