import 'package:flutter/material.dart';

// Widget fondo(String imagen, double heigth, double width) {
//   return Container(
//     height: heigth * 0.7,
//     width: width,
//     margin: EdgeInsets.only(bottom: heigth * 0.01),
//     decoration: new BoxDecoration(
//       // border: Border.all(color: Colors.red),
//       image: new DecorationImage(
//           image: new AssetImage(imagen), fit: BoxFit.contain),
//     ),
//   );
// }

// Widget fondo2(String imagen, double heigth, double width) {
//   return Container(
//     height: heigth * 0.7,
//     width: width,
//     margin: EdgeInsets.only(bottom: heigth * 0.01),
//     decoration: new BoxDecoration(
//       // border: Border.all(color: Colors.red),
//       image: new DecorationImage(
//           image: new AssetImage(imagen), fit: BoxFit.contain),
//     ),
//   );
// }

// Widget fondo3(String imagen, double heigth, double width) {
//   return Container(
//     height: heigth * 0.7,
//     width: width * 0.85,
//     margin: EdgeInsets.only(bottom: heigth * 0.01),
//     decoration: new BoxDecoration(
//       // border: Border.all(color: Colors.red),
//       image: new DecorationImage(
//           image: new AssetImage(imagen), fit: BoxFit.contain),
//     ),
//   );
// }

Widget fondo1(String imagen, heigth, width) {
  return Container(
    height: heigth * 0.67,
    // width: width * 0.85,
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(imagen), fit: BoxFit.contain),
    ),
  );
}

Widget fondo2(String imagen, heigth, width) {
  return Container(
     height: heigth * 0.63,
    width: width,
    margin: EdgeInsets.only(bottom: heigth * 0.75),
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(imagen), fit: BoxFit.contain),
    ),
  );
}

Widget fondo3(String imagen, heigth, width) {
  return Container(
    height: heigth * 0.63,
    // width: width * 0.7,
    // margin: EdgeInsets.only(top: heigth * 0.23),
    decoration: new BoxDecoration(
      image: new DecorationImage(
          image: new AssetImage(imagen), fit: BoxFit.contain),
    ),
  );
}
