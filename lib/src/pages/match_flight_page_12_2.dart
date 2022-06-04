// @dart=2.9
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_flight_match.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/card_flight.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/modal_confirm_submit_request_flight.dart';
import '../utils/config.dart';
import '../utils/date.dart';

class Match_Flight_page_12_2 extends StatefulWidget {
  Match_Flight_page_12_2({Key key}) : super(key: key);

  @override
  _Match_Flight_page_12_2State createState() => _Match_Flight_page_12_2State();
}

class _Match_Flight_page_12_2State extends State<Match_Flight_page_12_2> {
  List<CardFlight> arrayAdWidget;
  CardFlightMatch cardFlight;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'match_flight_12_2');
    blocGeneral.changeSendRequest(false);
    // final scanMap = blocGeneral.argPage;
    final scanMap = json.decode(ModalRoute.of(context).settings.arguments);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);

    arrayAdWidget =[];

    List<dynamic> myFlights = scanMap["myFlights"];
    dynamic flightSelect;
    dynamic ad = scanMap["ad"];



    if (myFlights.length > 0) {
      for (var flight in myFlights) {
        arrayAdWidget.add(CardFlight(
                flight: flight,
                viewCodes: true,
                viewRatings: false,
                viewDates: true,
                viewPakages: true,
                viewButtonOption: false,
                tapBackground: true,
                functionTapBackground: (){
                      flightSelect = flight;
                      blocGeneral.changeSendRequest(true);
                    },
                    actionSheet: null));
      }
      // print('scanMap["data"]  ==> ${scanMap["data"]}');
    } else if (scanMap["flightDB"]["type"] == 'Ad') {
      print('entroe 1');
      if (scanMap["data"]["type"] == true) {
        // for (var anuncio in scanMap["data"]) {
        //   arrayAdWidget.add(CardFlightMatch(
        //     departureAirport: anuncio["departureAirport"],
        //     arrivalAirport: anuncio["arrivalAirport"],
        //     departure: anuncio["departure"],
        //     destination: anuncio["destination"],
        //     packageDesc: anuncio["packageDesc"],
        //     departureDT: (anuncio['departureDT'] != '')
        //         ? '${formatearfechaDateTime(anuncio['departureDT'])}'
        //         : '',
        //     arrivalDT: (anuncio['arrivalDT'] != '')
        //         ? '${formatearfechaDateTime(anuncio['arrivalDT'])}'
        //         : '',
        //     elements: anuncio['elements'],
        //   ));
        // }
      } else {
        cardFlight = CardFlightMatch(
          departureAirport: scanMap["data"]["departureAirport"],
          arrivalAirport: scanMap["data"]["arrivalAirport"],
          departure: scanMap["data"]["departure"],
          destination: scanMap["data"]["destination"],
          packageDesc: scanMap["data"]["packageDesc"],
          departureDT: (scanMap["data"]['departureDT'] != '')
              ? '${formatearfechaDateTime(scanMap["data"]['departureDT'])}'
              : '',
          arrivalDT: (scanMap["data"]['arrivalDT'] != '')
              ? '${formatearfechaDateTime(scanMap["data"]['arrivalDT'])}'
              : '',
          elements: scanMap["data"]['elements'],
        );
      }
    } else {
      // Aqui se hace el proceso para los vuelos
    }

    return Stack(
      children: <Widget>[
    StreamBuilder(
        stream: blocGeneral.sendRequestStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshopt) {
          if (snapshopt.hasData) {
            if (snapshopt.data == true) {
              return scaffold2(context, responsive, height, width, flightSelect, ad);
            } else {
              return scaffold1(responsive, height, width);
            }
          } else if (snapshopt.hasError) {
            return Container();
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        })
      ],
    );
  }

  // *****************************
  // *****************************
  Widget scaffold1(Responsive responsive, double height, double width) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(
                  left: variableGlobal.margenPageWith(context),
                  right: variableGlobal.margenPageWith(context),
                  top: variableGlobal.margenTopGeneral(context),
                ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                    child: Column(children: <Widget>[
                  _encabezado(responsive, height, width),
                  SizedBox(
                    height: 16.0,
                  ),
                  (arrayAdWidget.length > 0)
                      ? Column(
                          children: arrayAdWidget,
                        )
                      : cardFlight,
                  SizedBox(
                    height: 30.0,
                  ),
                ])),
              ]),
        )));
  }

  // *****************************
  // *****************************
  Widget scaffold2(BuildContext context, Responsive responsive, double height, double width, dynamic flight, dynamic ad) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
              margin: EdgeInsets.only(
                      left: variableGlobal.margenPageWith(context),
                      right: variableGlobal.margenPageWith(context),
                      top: variableGlobal.margenTopGeneral(context),
                    ),
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
                            _encabezado(responsive, height, width),
                            SizedBox(
                              height: 16.0,
                            ),
                            (arrayAdWidget.length > 0)
                                ? Column(
                                    children: arrayAdWidget,
                                  )
                                : cardFlight,
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
                    child: Center(child: ModalConfirmSubmitRequestFlight(flight: flight, ad: ad, c: context))),
              ),
            ),
          ],
        ),
      ),
    );
  }
  // *****************************

  Widget _encabezado(Responsive responsive, double height, double width) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    iconFace1(context),
                  ],
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    // alignment: Alignment.center,
                    children: [
                      arrwBackYellowPersonalizado( context, 'principal'),
                    ],
                  ),
                ],
              ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            child: Text(generalText.theElementsOnTheLWeve(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(33, 36, 41, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(3.5))),
          )
        ],
      ),
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
