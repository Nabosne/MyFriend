import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'package:myfriend/helpers/widgets.dart';
import 'package:myfriend/model/LocaisModel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:myfriend/ui/Home.dart';

class Locais extends StatefulWidget {
  @override
  _Locais createState() => _Locais();
}

class _Locais extends State<Locais> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Locais',style: TextStyle(fontSize: 25.0)),
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
          child: Stack(
            children: [
              FutureBuilder<LocaisModel>(
                  future: getLocais(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Align(
                          alignment: Alignment(0, -1),
                          child: Text(
                            "Buscando",
                            style:
                                TextStyle(color: Colors.white, fontSize: 30.0),
                            textAlign: TextAlign.center,
                          ),
                        );
                      default:
                        print(snapshot.data.locais
                            .map((e) => e.beaconLocal)
                            .toList());
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                                  fontSize: 30.0),
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
             MenuButton(),
            ],
          ),
        ));
  }

  Widget _telaDadosLocais(String nome, String texto, String telefone) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(nome),
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
            padding: EdgeInsets.all(4.0),
            reverse: true,
            crossAxisCount: 2,
            children: [Align(
              alignment: Alignment(0, -1.7),
              child:
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FlatButton(
                  minWidth: 105,
                  height: 105,
                  child: Text(
                    "Voltar para locais",
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Locais()));
                  },
                  color: Colors.white,
                ),
              )),
              Align(
                alignment: Alignment(0, -1.7),
                child:
                Padding(
                padding: const EdgeInsets.all(4.0),
                child: FlatButton(
                  minWidth: 105,
                  height: 105,
                  child: Text(
                    "Ligar para local",
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    _fazerLigacao("tel:" + telefone);
                  },
                  color: Colors.white,
                ),
              )),
            ],
          ),
          MenuButton(),
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
