// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';

class NavigationBar1 extends StatefulWidget {
  String shipments;
  String service;
  String home;
  NavigationBar1(
      {@required this.shipments, @required this.service, @required this.home});

  @override
  _NavigationBar1State createState() => _NavigationBar1State();
}

class _NavigationBar1State extends State<NavigationBar1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(
            top: variableGlobal.topNavigation(context),
            right: variableGlobal.margenPageWith(context),
            left: variableGlobal.margenPageWith(context),),
        height: MediaQuery.of(context).size.height * 0.085,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            home(context),
            megafono(context),
            box(context),
          ],
        ),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Color.fromRGBO(255, 206, 6, 1.0)),
      ),
    );
  }
}
