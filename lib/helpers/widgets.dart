// Copyright 2017, Paul DeMarco.
// All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/ui/Home.dart';

class MenuButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment(0, 1),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                minWidth: 80,
                height: 80,
                color: Colors.white,
                child: Text("Voltar ao menu",
                    style:
                    TextStyle(color: Colors.black, fontSize: 30.0),
                    textAlign: TextAlign.justify),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TelaPadrao extends StatelessWidget {

  String title;
  String text;

  TelaPadrao(this.title, this.text);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(title, style: TextStyle(fontSize: 25.0)),
        ),
        body: Container(
            child: Stack(
              children: [Center(
                  child: Text(text,
                    style: TextStyle(color: Colors.white, fontSize: 25.0),
                    textAlign: TextAlign.center,)),
                MenuButton(),
              ],
            )
        ));
  }
}




class IBeaconCard extends StatelessWidget {
  final IBeacon iBeacon;

  IBeaconCard({@required this.iBeacon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text("iBeacon"),
          Text("uuid: ${iBeacon.uuid}"),

          Text("major: ${iBeacon.major}"),
          Text("minor: ${iBeacon.minor}"),
          Text("tx: ${iBeacon.tx}"),
          Text("rssi: ${iBeacon.rssi}"),
          Text("distance: ${iBeacon.distance.toStringAsFixed(3)}"),
          Text("txAt1Meter: ${iBeacon.txAt1Meter}"),
          Text("name: ${iBeacon.name}"),
        ],
      ),
    );
  }
}

class EddystoneUIDCard extends StatelessWidget {
  final EddystoneUID eddystoneUID;

  EddystoneUIDCard({@required this.eddystoneUID});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text("EddystoneUID"),
          Text("beaconId: ${eddystoneUID.beaconId}"),
          Text("namespaceId: ${eddystoneUID.namespaceId}"),
          Text("tx: ${eddystoneUID.tx}"),
          Text("rssi: ${eddystoneUID.rssi}"),
        ],
      ),
    );
  }
}

class EddystoneEIDCard extends StatelessWidget {
  final EddystoneEID eddystoneEID;

  EddystoneEIDCard({@required this.eddystoneEID});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          Text("EddystoneEID"),
          Text("ephemeralId: ${eddystoneEID.ephemeralId}"),
          Text("tx: ${eddystoneEID.tx}"),
          Text("rssi: ${eddystoneEID.rssi}"),
          Text("distance: ${eddystoneEID.distance}"),
        ],
      ),
    );
  }
}
