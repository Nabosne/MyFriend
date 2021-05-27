import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myfriend/model/DescreverEspacoModel.dart';
import 'package:myfriend/model/DestinosModel.dart';
import 'package:myfriend/model/LocaisModel.dart';
import 'package:myfriend/model/OndeEstouModel.dart';


const requestLocais = "http://myfriend.pythonanywhere.com/web/service/locais/";
const requestDescrever = "http://myfriend.pythonanywhere.com/web/service/descrever/";
const requestDestinos = "http://myfriend.pythonanywhere.com/web/service/destinos/";
const requestOndeEstou = "http://myfriend.pythonanywhere.com/web/service/ondeestou/";


Future<LocaisModel> getLocais() async {
  http.Response response = await http.get(requestLocais);
  final jsonResponse = json.decode(response.body);
  return LocaisModel.fromJson(jsonResponse);
}

Future<DescreverEspacoModel>postDescreverEspaco(String beaconLocal, String beaconEspaco) async {
  http.Response response = await http.post(requestDescrever, body: {'beacon_local': beaconLocal, 'beacon_espaco': beaconEspaco});
  final jsonResponse = json.decode(response.body);
  return DescreverEspacoModel.fromJson(jsonResponse);
}

Future<DestinosModel>postDestinos(String beaconLocal, String beaconEspaco) async {
  http.Response response = await http.post(requestDestinos, body: {'beacon_local': beaconLocal, 'beacon_espaco': beaconEspaco});
  final jsonResponse = json.decode(response.body);
  print(jsonResponse);
  return DestinosModel.fromJson(jsonResponse);
}

Future<OndeEstouModel>postOndeEstou(String beaconLocal, String beaconEspaco) async {
  http.Response response = await http.post(requestOndeEstou, body: {'beacon_local': beaconLocal, 'beacon_espaco': beaconEspaco});
  final jsonResponse = json.decode(response.body);
  return OndeEstouModel.fromJson(jsonResponse);
}