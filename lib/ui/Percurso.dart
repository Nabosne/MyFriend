import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_beacon/flutter_blue_beacon.dart';
import 'package:myfriend/helpers/widgets.dart';


import 'package:myfriend/model/DestinosModel.dart';

class Percurso extends StatefulWidget {

  Destinos destino;
  int position;

  Percurso(this.destino, this.position);
  @override
  _PercursoState createState() => _PercursoState();
}

class _PercursoState extends State<Percurso> {
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
      return TelaPadrao("Percurso", "Validando");
    } else if (cont < 4) {
      return TelaPadrao("Percurso", "Validando");
    } else {
      if (widget.destino.percursos[widget.position].idEspacoInicio.toString() ==
          beacon["beacon_espaco"]) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text('Percurso', style: TextStyle(fontSize: 25.0)),
            ),
            body: Stack(
                  children: [
                    Align(
                      alignment: Alignment(0, -1),
                    child: Text(widget.destino.percursos[widget.position].instrucao,
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                      textAlign: TextAlign.center,)),
            if(widget.destino.percursos.length > widget.position+1)
              Align(
                alignment: Alignment(0, 0.65),
                child: Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          minWidth: 80,
                          height: 80,
                          color: Colors.white,
                          child: Text("Próximo",
                              style:
                              TextStyle(color: Colors.black, fontSize: 30.0),
                              textAlign: TextAlign.justify),
                          onPressed: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (context) =>
                                Percurso(widget.destino, widget.position + 1)));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
                    MenuButton()
                  ]
            )
        );
      }else{
        return TelaPadrao("Percurso", "Caminho incorreto, favor recalcular a rota em destinos.");
      }
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