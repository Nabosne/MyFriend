import 'package:myfriend/ui/Home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
    title: "My Friend",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

// listview(){
//   return ListView(
//     children: <Widget>[
//     Container(
//   child: widgetRowColumn1(),
//   ),
//       Container(
//         child: widgetRowColumn2(),
//       ),
//       Container(
//         child: widgetRowColumn3(),
//       ),
//   ],
//   );
// }
// widgetRowColumn1() {
//   return Row (
//
//     children: <Widget>[
//       SizedBox(
//         width: 180.0,
//         height: 200.0,
//         child: FlatButton(
//         color: Colors.black,
//         textColor: Colors.white,
//         disabledColor: Colors.grey,
//         disabledTextColor: Colors.black,
//         //padding: EdgeInsets.all(30.0),
//         splashColor: Colors.blueAccent,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => OndeEstou()));
//         },
//         child: Text(
//           "Onde estou",
//           style: TextStyle(fontSize: 30.0),
//         ),
//       ),
//   ),
//   SizedBox(
//     width: 180.0,
//     height: 200.0,
//       child: FlatButton(
//         color: Colors.white70,
//         textColor: Colors.black,
//         disabledColor: Colors.grey,
//         disabledTextColor: Colors.black,
//         //padding: EdgeInsets.all(30.0),
//         splashColor: Colors.blueAccent,
//         onPressed: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => DescreverEspaco()));
//         },
//         child: Text(
//           "Descrever espaço",
//           style: TextStyle(fontSize: 30.0),
//         ),
//       ),
//   )
//     ],
//   );
// }

// widgetRowColumn2() {
//   return Row (
//     children: <Widget>[
//       SizedBox(
//         width: 180.0,
//         height: 200.0,
//         child: FlatButton(
//           color: Colors.white60,
//           textColor: Colors.black,
//           disabledColor: Colors.grey,
//           disabledTextColor: Colors.black,
//           splashColor: Colors.blueAccent,
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Destinos()));
//           },
//           child: Text(
//             "Destinos",
//             style: TextStyle(fontSize: 30.0),
//           ),
//         ),
//       ),
//       SizedBox(
//         width: 180.0,
//         height: 200.0,
//         child: FlatButton(
//           color: Colors.black,
//           textColor: Colors.white,
//           disabledColor: Colors.grey,
//           disabledTextColor: Colors.black,
//           //padding: EdgeInsets.all(30.0),
//           splashColor: Colors.blueAccent,
//           onPressed: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Locais()));
//           },
//           child: Text(
//             "Locais",
//             style: TextStyle(fontSize: 30.0),
//           ),
//         ),
//       )
//     ],
//   );
// }

//   widgetRowColumn3() {
//     return Row (
//       children: <Widget>[
//         SizedBox(
//           width: 180.0,
//           height: 200.0,
//           child: FlatButton(
//             color: Colors.black,
//             textColor: Colors.white,
//             disabledColor: Colors.grey,
//             disabledTextColor: Colors.black,
//             splashColor: Colors.blueAccent,
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => Tutorial()));
//             },
//             child: Text(
//               "Tutorial",
//               style: TextStyle(fontSize: 30.0),
//             ),
//           ),
//         ),
//
//         SizedBox(
//           width: 180.0,
//           height: 200.0,
//           child: FlatButton(
//             color: Colors.white60,
//             textColor: Colors.black,
//             disabledColor: Colors.grey,
//             disabledTextColor: Colors.black,
//             //padding: EdgeInsets.all(30.0),
//             splashColor: Colors.blueAccent,
//             onPressed: ()=> exit(0),
//             child: Text(
//               "Sair",
//               style: TextStyle(fontSize: 30.0),
//             ),
//           ),
//         )
//       ],
//     );
//   }
//
// }

