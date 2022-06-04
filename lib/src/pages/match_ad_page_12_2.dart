// @dart=2.9
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_ad_match.dart';

import '../utils/config.dart';
import '../utils/date.dart';

import 'package:maando/src/widgets/send-request-ad.dart';

class Match_Ad_page_12_2 extends StatefulWidget {
  Match_Ad_page_12_2({Key key}) : super(key: key);

  @override
  _Match_Ad_page_12_2State createState() => _Match_Ad_page_12_2State();
}

class _Match_Ad_page_12_2State extends State<Match_Ad_page_12_2> {
  List<CardAdMatch> arrayAdWidget = [];
  CardAdMatch cardAd;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'match_ad_12_2');
    blocGeneral.changeSendRequest(false);
    final scanMap = blocGeneral.argPage;

    if (scanMap is String) {
      print('Es string ==> $scanMap');
    } else {
      print('No es string ==> ${scanMap["data"]}');
      // result = scanMap;
    }

    if (scanMap["data"].length > 0) {
      for (var anuncio in scanMap["data"]) {
        arrayAdWidget.add(CardAdMatch(
            ad: 'anuncio["data"]',
            title: anuncio["adTitle"],
            dateToDeliver: formatearfechaDateTime(anuncio["deliveryDT"]),
            destination: shortString(anuncio["destination"], 20)));
        // cardAd = CardAdMatch(
        //     ad: anuncio["adTitle"],
        //     title: anuncio["adTitle"],
        //     dateToDeliver: formatearfechaDateTime(anuncio["deliveryDT"]),
        //     destination: shortString(anuncio["destination"], 20));
      }
      // print('scanMap["data"]  ==> ${scanMap["data"]}');
    } else if (scanMap["data"]["type"] == 'Ad') {
      print('entroe 1');
      if (scanMap["data"]["type"] == true) {
        for (var anuncio in scanMap["data"]) {
          arrayAdWidget.add(CardAdMatch(
              ad: anuncio["data"],
              title: anuncio["data"]["adTitle"],
              dateToDeliver: anuncio["data"]["deliveryDT"],
              destination: anuncio["data"]["destination"]));
        }
      } else {
        print('entroe 2');
        print('Es un object: ${scanMap["data"]}');
        cardAd = CardAdMatch(
            ad: 'scanMap["data"]',
            title: scanMap["data"]["adTitle"],
            dateToDeliver:
                formatearfechaDateTime(scanMap["data"]["deliveryDT"]),
            destination: shortString(scanMap["data"]["destination"], 20));
      }
    } else {
      // Aqui se hace el proceso para los vuelos
    }
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Stack(
      children: <Widget>[
        StreamBuilder(
            stream: blocGeneral.sendRequestStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshopt) {
              if (snapshopt.hasData) {
                print('Prueba 1 ${snapshopt.data}');
                if (snapshopt.data == true) {
                  return scaffold2(height, width);
                } else {
                  return scaffold1(height, width);
                }
              } else if (snapshopt.hasError) {
                print('Prueba 2 ${snapshopt.data}');
                return Container();
              } else {
                print('Prueba 3 ${snapshopt.data}');
                return Container(
                  child: Center(child: CircularProgressIndicator()),
                );
              }
            })
      ],
    ));
  }

  // *****************************
  // *****************************
  Widget scaffold1(double height, double width) {
    print('entro aqui ${arrayAdWidget.length}');
    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.symmetric(vertical: 30.0),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        child: Column(children: <Widget>[
                      _encabezado(),
                      SizedBox(
                        height: 16.0,
                      ),
                      (arrayAdWidget.length > 0)
                          ? Column(
                              children: arrayAdWidget,
                            )
                          : cardAd,
                      SizedBox(
                        height: 30.0,
                      ),
                    ])),
                  ]),
            ))),
      ],
    );
  }

  // *****************************
  // *****************************
  Widget scaffold2(double height, double width) {
    return Scaffold(
      // backgroundColor: Color.fromRGBO(33, 36, 41, 0.5),
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.white.withOpacity(0.2),
              child: Scaffold(
                  backgroundColor: Color.fromRGBO(33, 36, 41, 0.8),
                  body: SingleChildScrollView(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              child: Column(children: <Widget>[
                            _encabezado(),
                            SizedBox(
                              height: 16.0,
                            ),
                            (arrayAdWidget.length > 0)
                                ? Column(
                                    children: arrayAdWidget,
                                  )
                                : cardAd,
                            SizedBox(
                              height: 30.0,
                            ),
                          ])),
                        ]),
                  ))),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.white.withOpacity(0.2),
                child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: height * 0.18, horizontal: width * 0.04),
                    child: Center(child: SendRequestAd(type: 'flight'))),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // *****************************

  Widget _encabezado() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: arrwBackYellowPersonalizado(
                    context, 'flight_published_12')),
            // SizedBox(
            //   width: 110,
            // ),
            Text('Cartagena',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: 16.0)),
            SizedBox(
              width: 10,
            ),
          ],
        ),
      ],
    );
  }

  Widget _tarjeta(BuildContext context, flight, double height, double width) {
    return Container(
      margin: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      decoration: BoxDecoration(
          // border: Border.all(color: Colors.red),
          borderRadius: BorderRadius.circular(7.0),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black26,
                blurRadius: 1.0,
                // spreadRadius: 2.0,
                offset: Offset(1.0, 1.0))
          ],
          color: Color.fromRGBO(255, 255, 255, 1)),
      child: Column(
        children: <Widget>[
          _parte1Tarjeta(context, flight, height, width),
          _parte2Tarjeta(context, flight, height, width),
          SizedBox(
            height: 20.0,
          )
        ],
      ),
    );
  }

  // *****************************
  Widget _parte1Tarjeta(
      BuildContext context, flight, double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 20, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Departure',
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          '${DateFormat().add_Hm().format(DateTime.parse(flight["departureDT"]))} ',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.1)),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                            '${DateFormat("a").format(DateTime.parse(flight["departureDT"]))}',
                            style: TextStyle(
                                letterSpacing: 0.07,
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03)),
                      ),
                    ],
                  ),
                  Text(flight["departure"].toUpperCase(),
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30),
              height: 23.0,
              width: 23.0,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/general/icon flight.png',
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 20, top: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Destination',
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w400,
                          fontSize: 12.0)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                          '${DateFormat().add_Hm().format(DateTime.parse(flight["deliveryDT"]))} ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.1)),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                            '${DateFormat("a").format(DateTime.parse(flight["deliveryDT"]))}',
                            style: TextStyle(
                                letterSpacing: 0.07,
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.03)),
                      ),
                    ],
                  ),
                  Text(flight["destination"].toUpperCase(),
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0)),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: 20, top: 10.0),
          // child: Text('YYZ - LGA, Delta',
          child: Text(
              '${flight["departureAirport"]} - ${flight["arrivalAirport"]}',
              style: TextStyle(
                  letterSpacing: 0.07,
                  color: Color.fromRGBO(33, 36, 41, 1.0),
                  fontSize: 14.0)),
        ),
      ],
    );
  }

  // **********************

  Widget _parte2Tarjeta(
      BuildContext context, flight, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 16.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 32.0,
          ),
          Text('Package type',
              style: TextStyle(
                  letterSpacing: 0.07,
                  color: Color.fromRGBO(173, 181, 189, 1.0),
                  fontWeight: FontWeight.w400,
                  fontSize: 12.0)),
          SizedBox(
            height: 6.0,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 15,
                height: 13,
                child: Image.asset('assets/images/general/envelope.png'),
              ),
              SizedBox(
                width: 6.0,
              ),
              Container(
                child: Text('${shortString(flight["elements"], 60)}',
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontSize: 14.0)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _botonSend(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.only(
          top: height * 0.84,
          right: width * 0.08,
          left: width * 0.08,
          bottom: width * 0.08),
      decoration: BoxDecoration(
          color: Color.fromRGBO(33, 36, 41, 1.0),
          border:
              Border.all(width: 2.0, color: Color.fromRGBO(33, 36, 41, 1.0)),
          borderRadius: BorderRadius.circular(14)),
      child: CupertinoButton(
        onPressed: () {
          print('Se va por send request');
        },
        child: Row(
          children: <Widget>[
            Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Send request',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Color.fromRGBO(255, 206, 6, 1),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocGeneral.changeSendRequest(true);
  }
}
