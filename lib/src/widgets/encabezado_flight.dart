// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class EncabezadoFlight extends StatelessWidget {
  // const EncabezadoFlight({Key key}) : super(key: key);

  String head;
  int to;
  int from;
  String title;
  String subtitle;
  String page;
  EncabezadoFlight({
    @required this.head = '',
    @required this.to = 1,
    @required this.from = 3,
    @required this.title = '',
    @required this.subtitle = '',
    @required this.page = '',
  });

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
        // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                      arrwBackYellowPersonalizado(context, page),
                    ],
                  ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          child: Text(head,
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(3.7))),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              circuloVerde(context, to, from),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(3))),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08
                  ),
                  Text(subtitle,
                      style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(2)))
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}

class EncabezadoFlightFlightForm extends StatelessWidget {
  // const EncabezadoFlight({Key key}) : super(key: key);

  final blocNavigator = blocGeneral;

  String head;
  int to;
  int from;
  String title;
  String subtitle;
  EncabezadoFlightFlightForm({
    @required this.head,
    @required this.to,
    @required this.from,
    @required this.title,
    @required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            child: Center(
                child: Column(children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 0.0,
                  ),
                  child: closeFlightForm(
                      context, 'assets/images/close/close button 1@3x.png')),
              iconFace1(context),
              SizedBox(
                width: width * 0.06,
              ),
            ],
          ),
        ]))),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          child: Text(head,
              style: TextStyle(
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(3.7))),
        ),
        SizedBox(
          height: height * 0.02,
        ),
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              circuloVerde(context, to, from),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(title,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(3))),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Text(subtitle,
                      style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(2)))
                ],
              )
            ],
          ),
        ),
      ],
    ));
  }
}
