// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/pages/subpages/pending.dart/flight_pending.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class ListFlightPending extends StatefulWidget {
  @override
  _ListFlightPendingState createState() => _ListFlightPendingState();
}

class _ListFlightPendingState extends State<ListFlightPending> {
  List<FlightPending> arrayFlightMatchWidget;
  FlightPending flight;



  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'principal');
    blocGeneral.changeSendRequest(false);
    final List<dynamic> arrayFlightMatch = jsonDecode(ModalRoute.of(context).settings.arguments);
    blocGeneral.changeListMatch(arrayFlightMatch);  // GUARDAMOS LA LISTA DE MATCH E UN STREAM

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.only(
                  top: variableGlobal.margenTopGeneral(context)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                     StreamBuilder(
                    stream: blocGeneral.listMatchStream,
                    // ignore: missing_return
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if(snapshot.hasData){

                          arrayFlightMatchWidget = [];

                          for (var m in blocGeneral.listMatch) {  
                            arrayFlightMatchWidget.add(FlightPending(match: m));
                          }


                          return Container(
                                    child: Column(children: <Widget>[
                                  _encabezado(responsive, height, width, 'pageBack'),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  (arrayFlightMatchWidget.length > 0)
                                      ? Column(
                                          children: arrayFlightMatchWidget,
                                        )
                                      : flight,
                                  SizedBox(
                                    height: 30.0,
                                  ),
                                ]));
                        }else if(snapshot.hasError){
                          return Container();
                        }else{
                          return Container();
                        }
                     })
,
                  ]),
            ))),
      ],
    );
  }

  // *****************************
  // *****************************

  Widget _encabezado(Responsive responsive, double height, double width, String pageBack) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: variableGlobal.margenPageWith(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
             height: height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              arrwBackYellowSHIPMENTSservice(context),
              iconFace1(context),
              Container(width: width * 0.06),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(generalText.listOfpendingFlights(),
                  style: TextStyle(
                      letterSpacing: 0.07,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(3.5)))
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
