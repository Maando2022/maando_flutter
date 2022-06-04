// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/pages/subpages/matches/card_flight_match.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_flight.dart';

class ListaFlights extends StatefulWidget {

  @override
  _ListaFlightsState createState() => _ListaFlightsState();
}

class _ListaFlightsState extends State<ListaFlights> {
  List<GestureDetector> arrayFlightWidget = [];
  CardFlightMatch cardFlight;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'search_9_4');
    blocGeneral.changeSendRequest(false);
    Map<String, dynamic> adselected = jsonDecode(ModalRoute.of(context).settings.arguments);
    String pageBack = jsonDecode(ModalRoute.of(context).settings.arguments)['pageBack'];
    final scanMap = blocGeneral.arrayFlightSearch;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    for (var f in scanMap) {
      arrayFlightWidget.add(GestureDetector(
                            onTap: (){
                              blocGeneral.changeFlight(f);
                               Navigator.pushNamed(context, 'detail_flight_match');
                            },
                            child: CardFlight( flight: f,
                                      viewCodes: true,
                                      viewRatings: true,
                                      viewDates: true,
                                      viewPakages: true,
                                      viewButtonOption: false,
                                      tapBackground: false,
                                      functionTapBackground: null,
                                      actionSheet: null
                              ),
      ));
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Color.fromRGBO(251, 251, 251, 1),
              body: SingleChildScrollView(
                  child: Container(
                margin: EdgeInsets.only(
                    top: variableGlobal.margenTopGeneral(context)),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          child: Column(children: <Widget>[
                        _encabezado(height, width, pageBack),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        (arrayFlightWidget.length > 0)
                            ? Column(
                                children: arrayFlightWidget,
                              )
                            : cardFlight,
                        SizedBox(
                          height: height * 0.04,
                        ),
                      ])),
                    ]),
              ))),
        ],
      ),
    );
  }

  // *****************************
  // *****************************

  Widget _encabezado(double height, double width, String pageBack) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: variableGlobal.margenPageWith(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  child: arrwBackYellowSHIPMENTSservice(context)),
              SizedBox(
                width: width * 0.05,
              ),
              Text(generalText.flightMatchList(),
                  style: TextStyle(
                      letterSpacing: 0.07,
                      color: Color.fromRGBO(173, 181, 189, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: width * 0.05)),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocGeneral.changeSendRequest(false);
    // blocGeneral.changeArrayFlightSearch([]);
    blocGeneral.changeAd(null);
  }
}
