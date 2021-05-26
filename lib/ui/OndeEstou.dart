import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/helpers/widgets.dart';
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
  bool isScanning = false;
  bool isFirst = true;

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
          'manufacturerData: ${beacon.scanResult.advertisementData.manufacturerData}');
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
    //setState(() {
    //  isScanning = false;
    //});
  }

  _returnBeacon() {

    return beacons.values.map<Map>((b) {
      if (b is IBeacon) {
        Map<String, String> beacons = {
          'beacon_local': b.major.toString(),
          'beacon_espaco': b.minor.toString(),
          'distancia': b.distance.toString()};
        return beacons;

      }
      else{
        return null;
      }

    }).toList();
  }

  _buildAlertTile() {
    return new Container(
      color: Colors.redAccent,
      child: new ListTile(
        title: new Text(
          'Bluetooth adapter is ${state.toString().substring(15)}',
          style: Theme.of(context).primaryTextTheme.subhead,
        ),
        trailing: new Icon(
          Icons.error,
          color: Theme.of(context).primaryTextTheme.subhead.color,
        ),
      ),
    );
  }
  _buildProgressBarTile() {
    return new LinearProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    var tiles = new List<Widget>();
    List<dynamic> map;
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }
    if(isFirst) {
      _startScan();
      isFirst = false;
    }
    map = _returnBeacon();
    if(map.isNotEmpty){
      print(map);
      _stopScan();
      //implementação do serviço aqui
    }
    print(map);



    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: const Text('Onde estou'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear), onPressed: null)
        ],
      ),
      body: new Stack(
        children: <Widget>[
          (isScanning) ? _buildProgressBarTile() : new Container(),
          Center(
            child: Text(map.toString(), style: TextStyle(color: Colors.white)),

          )
        ],
      ),
    );
  }
}
