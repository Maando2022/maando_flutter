// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_flight_search.dart';

class Result_Flight_Search extends StatefulWidget {
  // const Result_Flight_Search({Key key}) : super(key: key);
  @override
  _Result_Flight_SearchState createState() => _Result_Flight_SearchState();
}

class _Result_Flight_SearchState extends State<Result_Flight_Search> {
  List<Card_Flight_Search> arrayAdWidget;
  Card_Flight_Search cardFlight;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'search_9_4');
    blocGeneral.changeSendRequest(false);
    String search = jsonDecode(ModalRoute.of(context).settings.arguments)['text'];
    String pageBack = jsonDecode(ModalRoute.of(context).settings.arguments)['pageBack'];
    final scanMap = blocGeneral.arrayFlightSearch;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    arrayAdWidget = [];

    for (var f in scanMap) {
      arrayAdWidget.add(Card_Flight_Search(flight: f));
    }
    return Stack(
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
                      _encabezado(height, width, search, pageBack),
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
      ],
    );
  }

  // *****************************
  // *****************************

  Widget _encabezado(double height, double width, String search, String pageBack) {
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
                  child: arrwBackYellowPersonalizado(context, pageBack)),
              SizedBox(
                width: width * 0.05,
              ),
              Text(search,
                  style: TextStyle(
                      letterSpacing: 0.07,
                      color: Color.fromRGBO(173, 181, 189, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0)),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          // Container(
          //   child: Text('We’ve found a match',
          //       style: TextStyle(
          //           letterSpacing: 0.07,
          //           color: Color.fromRGBO(33, 36, 41, 1.0),
          //           fontWeight: FontWeight.bold,
          //           fontSize: 24.0)),
          // )
        ],
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocGeneral.changeSendRequest(false);
    blocGeneral.changeArrayFlightSearch([]);
  }
}
