import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/helpers/widgets.dart';
import 'package:myfriend/model/DescreverEspacoModel.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';

class DescreverEspaco extends StatefulWidget {
  @override
  _DescreverEspacoState createState() => _DescreverEspacoState();
}

class _DescreverEspacoState extends State<DescreverEspaco> {
  FlutterBlueBeacon flutterBlueBeacon = FlutterBlueBeacon.instance;
  FlutterBlue _flutterBlue = FlutterBlue.instance;

  /// Scanning
  StreamSubscription _scanSubscription;
  Map<int, Beacon> beacons = new Map();
  Map<String, String> beacon;
  String message = "";
  bool scanned = false;
  int cont = 0;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  @override
  void initState() {
    super.initState();
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    _stateSubscription = _flutterBlue.onStateChanged().listen((s) {
      setState(() {
        state = s;
      });
    });
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _stateSubscription = null;
    _scanSubscription?.cancel();
    _scanSubscription = null;
    super.dispose();
  }

  _startScan() async {
    _scanSubscription = flutterBlueBeacon
        .scan(timeout: const Duration(seconds: 5))
        .listen((beacon) {
      setState(() {
        beacons[beacon.hash] = beacon;
      });
    }, onDone: _stopScan);
    scanned = true;
  }

  _stopScan() {
    _scanSubscription?.cancel();
    _scanSubscription = null;
  }

  _returnBeacon() {
    var distance = 100.00;
    for (Beacon b in beacons.values) {
      if (b is IBeacon) {
        if (b.distance < distance) {
          distance = b.distance;
          var distanceTxt = distance < 1 ? "" : ". À "+distance.toStringAsFixed(2)+ " metros.";
          Map<String, String> nearBeacon = {
            'beacon_local': b.major.toString(),
            'beacon_espaco': b.minor.toString(),
            'distancia': distanceTxt};
          beacon = nearBeacon;
        }
      }
    }
  }



  _callService() {
    cont++;
    print("call webservice");
    if (beacon == null) {
      print("null");
      return TelaPadrao("Descrever espaço", "Não identificamos um local My Friend próximo a você.");
    }else if(cont<4){
      print("timer");
      return TelaPadrao("Descrever espaço", "Buscando");
    }else {
      print("chamando");
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Descrever espaço', style: TextStyle(fontSize: 25.0)),
        ),
        body: Container(
          child: FutureBuilder<DescreverEspacoModel>(
              future: postDescreverEspaco(beacon["beacon_local"], beacon["beacon_espaco"]),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Stack(
                      children: [Center(
                          child: Text(
                            message,
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                            textAlign: TextAlign.center,)),
                        MenuButton(),
                      ],);
                  default:
                    print(snapshot.data.texto);
                    message = snapshot.data.texto;
                    return Stack(
                      children: [Center(
                          child: Text(snapshot.data.texto,
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                            textAlign: TextAlign.center,)),
                        MenuButton(),
                      ],);
                }
              }),
        ),

      );
    }
  }


  @override
  Widget build(BuildContext context) {
    if (state != BluetoothState.on) {
      return TelaPadrao("Descrever espaço", "Favor ligar o bluetooth.");
    }
    if (!scanned) {
      _startScan();
    }
    _returnBeacon();
    return _callService();
  }
}

