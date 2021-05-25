import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const request = "http://myfriend.pythonanywhere.com/web/service/locais/";


Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Locais extends StatefulWidget {
  @override
  _Locais createState() => _Locais();
}

class _Locais extends State<Locais> {
  String nome;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Locais'),
        ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
              return Center(
                child: Text(
                  "Carregando...",
                  style: TextStyle(color: Colors.amber, fontSize: 25.0),
                  textAlign: TextAlign.center,
                ),
              );
              default:
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Erro ao carregar dados =/",
                      style: TextStyle(color: Colors.amber, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                }else{
                  print(snapshot.data);
                  return Container(
                    child: Column(
                      children: [
                        Text(
                          snapshot.data.toString(),
                          style: TextStyle(fontSize: 30.0, color: Colors.white),
                        ),
                      ],
                    ),
                  );
                }
            }
          },
        ));
  }

}