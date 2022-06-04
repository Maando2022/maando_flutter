import 'package:flutter/material.dart';

Widget separador1(BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Container(
        margin: EdgeInsets.only(right: 10.0),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 1.0,
        color: Color.fromRGBO(230, 232, 235, 1),
      ),
      Text(
        '0',
        style: TextStyle(color: Color.fromRGBO(230, 232, 235, 1)),
      ),
      Container(
        margin: EdgeInsets.only(left: 10.0),
        width: MediaQuery.of(context).size.width * 0.4,
        height: 1.0,
        color: Color.fromRGBO(230, 232, 235, 1),
      )
    ],
  );
}
