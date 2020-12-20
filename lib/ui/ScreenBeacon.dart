import 'package:flutter/material.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';

class ScreenBeacon extends StatefulWidget {
  final IBeacon iBeacon;

  ScreenBeacon({@required this.iBeacon});

  @override
  _ScreenBeaconState createState() => _ScreenBeaconState();
}

class _ScreenBeaconState extends State<ScreenBeacon> {
  String beacon1 = 'e2c56db5dffb48d2b060d0f5a71096e0';

  @override
  Widget build(BuildContext context) {
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
            Text(
              beacon1 == widget.iBeacon.uuid || widget.iBeacon.uuid != null
                  ? "Você está próximo de um My friend! =) "
                  : "Nenhum my friend proximo \n=(",
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
            Text(
                beacon1 == widget.iBeacon.uuid  || widget.iBeacon.uuid != null
                    ? "Você está a ${widget.iBeacon.distance.toStringAsFixed(2)} metros do Myfriend mais proximo"
                    : "",
                style: TextStyle(color: Colors.white, fontSize: 23),textAlign: TextAlign.center,),
            Padding(
              padding: EdgeInsets.all(150.0),
            ),
            Text(
                beacon1 == widget.iBeacon.uuid || widget.iBeacon.uuid != null
                    ? "Destino: Banheiro da casa do João"
                    : "",
                style: TextStyle(color: Colors.white, fontSize: 23),textAlign: TextAlign.center,),
          ],
        ),
      ],
    );
  }
}
