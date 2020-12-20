import 'dart:async';

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

  _clearAllBeacons() {
    setState(() {
      beacons = Map<int, Beacon>();
    });
  }

  _startScan() {
    print("Scanning now");
    _scanSubscription = flutterBlueBeacon
        .scan()
        .listen((beacon) {
      print('localName: ${beacon.scanResult.advertisementData.localName}');
      print(
          'manufacturerData: ${beacon.scanResult.advertisementData.manufacturerData}');
      print('serviceData: ${beacon.scanResult.advertisementData.serviceData}');
      setState(() {
        beacons[beacon.hash] = beacon;
      });
    }, onDone: _stopScan);

    setState(() {
      isScanning = true;
    });
  }

  _stopScan() {
    print("Scan stopped");
    _scanSubscription?.cancel();
    _scanSubscription = null;
    setState(() {
      isScanning = false;
    });
  }

  _buildScanningButton() {
    if (state != BluetoothState.on) {
      return null;
    }
    if (isScanning) {
      return new FloatingActionButton(
        child: new Icon(Icons.stop),
        onPressed: _stopScan,
        backgroundColor: Colors.red,
      );
    } else {
      return new FloatingActionButton(
          child: new Icon(Icons.search), onPressed: _startScan);
    }
  }

  _buildScanResultTiles() {

    return beacons.values.map<Widget>((b) {
      if (b is IBeacon) {
        return ScreenBeacon(iBeacon: b);

      }
      if (b is EddystoneUID) {
        return EddystoneUIDCard(eddystoneUID: b);
      }
      if (b is EddystoneEID) {
        return EddystoneEIDCard(eddystoneEID: b);
      }
      if (b == null || b.distance == "") {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                Text("Nenhum my friend proximo \n=(",
                  style: TextStyle(color: Colors.white, fontSize: 23),
                  textAlign: TextAlign.center,
                ),
                /*Text("iBeacon"),
            Text("major: ${iBeacon.major}"),
            Text("minor: ${iBeacon.minor}"),
            Text("tx: ${iBeacon.tx}"),
            Text("rssi: ${iBeacon.rssi}"),*/
                Padding(
                  padding: EdgeInsets.all(30.0),
                ),
                Text("",
                  style: TextStyle(color: Colors.white, fontSize: 23),textAlign: TextAlign.center,),
                Padding(
                  padding: EdgeInsets.all(150.0),
                ),
                Text("",
                  style: TextStyle(color: Colors.white, fontSize: 23),textAlign: TextAlign.center,),
              ],
            ),
          ],
        );
      }
      return Card();
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
    if (state != BluetoothState.on) {
      tiles.add(_buildAlertTile());
    }

    tiles.addAll(_buildScanResultTiles());

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: new AppBar(
        title: const Text('MyFriend Beacon'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.clear), onPressed: _clearAllBeacons)
        ],
      ),
      floatingActionButton: _buildScanningButton(),
      body: new Stack(
        children: <Widget>[
          (isScanning) ? _buildProgressBarTile() : new Container(),
          new ListView(
            children: tiles,
          )
        ],
      ),
    );
  }
}
