import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'package:myfriend/helpers/widgets.dart';
import 'package:myfriend/model/OndeEstouModel.dart';


class OndeEstou extends StatefulWidget {
  @override
  _OndeEstouState createState() => _OndeEstouState();
}

class _OndeEstouState extends State<OndeEstou> {
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
    if (beacon == null) {
      return TelaPadrao("Onde estou", "Não identificamos um local My Friend próximo a você.");
    }else if(cont<4){
      return TelaPadrao("Onde estou", "Buscando");
    }else {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Onde estou', style: TextStyle(fontSize: 25.0)),
        ),
        body: Container(
          child: FutureBuilder<OndeEstouModel>(
              future: postOndeEstou(beacon["beacon_local"], beacon["beacon_espaco"]),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Stack(
                      children: [Align(
                          alignment: Alignment(0, -1),
                          child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 30.0),
                        textAlign: TextAlign.center,)),
                        MenuButton(),
                      ],);
                  default:
                    print(snapshot.data.texto);
                    message = snapshot.data.texto+beacon["distancia"];
                    return Stack(
                      children: [Align(
                          alignment: Alignment(0, -1),
                          child: Text(snapshot.data.texto+beacon["distancia"],
                            style: TextStyle(color: Colors.white, fontSize: 30.0),
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    if (state != BluetoothState.on) {
      return TelaPadrao("Onde estou", "Favor ligar o bluetooth");
    }
    if (!scanned) {
      _startScan();
    }
    _returnBeacon();
    return _callService();
  }
}