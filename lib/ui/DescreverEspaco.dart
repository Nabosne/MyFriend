import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/model/DescreverEspacoModel.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:myfriend/model/OndeEstouModel.dart';

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
  String message = "Buscando local";
  bool scann = true;
  bool isFirst = true;
  bool callService = false;
  OndeEstouModel odObject;

  /// State
  StreamSubscription _stateSubscription;
  BluetoothState state = BluetoothState.unknown;

  @override
  void initState() {
    super.initState();
    // Immediately get the state of FlutterBlue
    _flutterBlue.state.then((s) {
      setState(() {
        state = s;
      });
    });
    // Subscribe to state changes
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

  _startScan() {
    print("Scanning now");
    _scanSubscription = flutterBlueBeacon
        .scan(timeout: const Duration(seconds: 5))
        .listen((beacon) {
      print('localName: ${beacon.scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${beacon.scanResult.advertisementData
              .manufacturerData}');
      print('serviceData: ${beacon.scanResult.advertisementData.serviceData}');
      setState(() {
        beacons[beacon.hash] = beacon;
      });
    }, onDone: _stopScan);

    //setState(() {
    //  isScanning = true;
    //});
  }

  _stopScan() {
    print("Scan stopped");
    _scanSubscription?.cancel();
    _scanSubscription = null;
    return _returnScaffold(message);
  }

  _returnBeacon() {
    var distance = 100.00;

    for (Beacon b in beacons.values) {
      if (b is IBeacon) {
        if (b.distance < distance) {
          print("populando beacon"+b.major.toString());
          distance = b.distance;
          Map<String, String> nearBeacon = {
            'beacon_local': b.major.toString(),
            'beacon_espaco': b.minor.toString(),
            'distancia': b.distance.toString()};
          beacon = nearBeacon;
        }
      }
    }
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme
              .of(context)
              .primaryTextTheme
              .subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme
              .of(context)
              .primaryTextTheme
              .subhead
              .color,
        ),
      ),
    );
  }

  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  _returnScaffold(String msg) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Descrever espaço', style: TextStyle(fontSize: 25.0)),
        ),
        body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(msg,
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                  textAlign: TextAlign.center,),
              ],
            )));
  }


  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }
    if (scann) {
      _startScan();
      scann = false;
    }
    if(isFirst){
      _returnBeacon();
    }


    Future.delayed(const Duration(seconds: 2), () {
      if (beacon != null) {
        callService = true;
      } else {
        print("Local não encontrado");
        message = "Local não encontrado";
      }
      return _returnScaffold(message);
    });
    if(callService){
      isFirst=false;
      callService = false;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Descrever espaço'),
        ),
        body: Container(
          child: FutureBuilder<DescreverEspacoModel>(
              future: postDescreverEspaco(beacon["beacon_local"], beacon["beacon_espaco"]),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return Center(
                      child: Text(
                        message,
                        style: TextStyle(color: Colors.white, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  default:
                    print(snapshot.data.texto);
                    message = snapshot.data.texto;
                    return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(snapshot.data.texto,
                            style: TextStyle(color: Colors.white, fontSize: 25.0),
                            textAlign: TextAlign.center,),
                        ]);
                }
              }),
        ),

      );
    }
    return _returnScaffold(message);

  }

}

