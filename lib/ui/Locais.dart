import 'package:flutter/material.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'package:myfriend/model/LocaisModel.dart';
import 'package:url_launcher/url_launcher.dart';

import 'Home.dart';

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
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<LocaisModel>(
                  future: getLocais(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Center(
                          child: Text(
                            "Carregando...",
                            style:
                                TextStyle(color: Colors.white, fontSize: 25.0),
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
                              .map(
                                (e) => Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: FlatButton(
                                          color: Colors.white,
                                          child: Text(e.nome,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 25.0),
                                              textAlign: TextAlign.justify),
                                          onPressed: () {
                                            print(e.texto);
                                            print(e.telefone);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        _telaDadosLocais(
                                                            e.nome,
                                                            e.texto,
                                                            e.telefone)));
                                          },
                                        )),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        );
                    }
                  }),
              Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: FlatButton(
                          color: Colors.white,
                          child: Text("Voltar a tela inicial",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 25.0),
                              textAlign: TextAlign.justify),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ));
  }

  Widget _telaDadosLocais(String nome, String texto, String telefone) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(nome),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    texto,
                    style: TextStyle(fontSize: 30.0, color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          GridView.count(
            padding: EdgeInsets.all(5.0),
            reverse: true,
            crossAxisCount: 2,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FlatButton(
                  child: Text(
                    "Retornar para locais",
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Locais()));
                  },
                  color: Colors.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: FlatButton(
                  child: Text(
                    "Ligar para local",
                    style: TextStyle(fontSize: 25.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _fazerLigacao("tel:" + telefone);
                  },
                  color: Colors.white,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Future<void> _fazerLigacao(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
