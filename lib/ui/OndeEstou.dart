import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/API/Requisicoes.dart';
import 'package:myfriend/helpers/widgets.dart';
import 'package:myfriend/model/OndeEstouModel.dart';
import 'package:myfriend/ui/ScreenBeacon.dart';

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
            'distancia': ("À "+b.distance.toStringAsFixed(2)+ " metros.")};
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

  _callService() {
    print("call webservice");
    return FutureBuilder<OndeEstouModel> (
      future: postOndeEstou(beacon["beacon_local"], beacon["beacon_espaco"]),
      builder: (context, snapshot) {
        String resultado="blublu";
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            print("waiting");
            resultado = "carregando";
            return _returnScaffold(resultado);
          case ConnectionState.none:
            print("waiting");
            return _returnScaffold(resultado);
          case ConnectionState.done:
            print("conexão");
            if (snapshot.hasError) {
              resultado = "ERROR";
            } else {
              print("sem erro");
            }
            return _returnScaffold(resultado);
          default:
            print("default");
            return _returnScaffold(resultado);
        }
        //return _returnScaffold(resultado);
      });

    }

  _returnScaffold(String msg) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text('Onde Estou'),
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
          title: Text('Onde estou'),
        ),
        body: Container(
          child: FutureBuilder<OndeEstouModel>(
              future: postOndeEstou(beacon["beacon_local"], beacon["beacon_espaco"]),
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
                        Text(beacon["distancia"],
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