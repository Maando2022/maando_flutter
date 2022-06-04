// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';


class TimeLineAd extends StatelessWidget {
  dynamic flight;

  @override
  Widget build(BuildContext context) {

   double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
  

    final valueMap = json.decode(ModalRoute.of(context).settings.arguments);
    this.flight = json.decode(valueMap["flight"]);   



    return  Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: [
               // *******************************************************
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: width * 0.325, top:  height * 0.2),
                width: width * 0.002,
                height: height * 0.7,
                color: Color.fromRGBO(173, 181, 189, 1),
              ),
            ],
          ),
          // **************************************************************************************
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Container(
                        margin: EdgeInsets.only(
                          left:
                              variableGlobal.margenPageWithFlight(context),
                          right:
                              variableGlobal.margenPageWithFlight(context),
                          top: variableGlobal.margenTopGeneral(context),
                          bottom: width * 0.03,
                        ),
                        child: Center(
                            child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              (valueMap["pageBack"] == 'service') ?
                              arrwBackYellowSHIPMENTSservice(context) :
                              arrwBackYellowShipmentSERVICE(context),
                              iconFace1(context),
                              SizedBox(width: width * 0.07,)
                            ],
                          ),
                        ]))
                        ),
                    SizedBox(height: height * 0.01),
                    _timelineText(context, height, width),
                    SizedBox(height: height * 0.05),
                    _timelines(height, width)
                    
            ],
          )
        ]
      ));
  }

  Widget _timelineText(BuildContext context, double height, double width){
    return Container(
          margin: EdgeInsets.only(
                    left:
                        variableGlobal.margenPageWithFlight(context),
                    right:
                        variableGlobal.margenPageWithFlight(context),
                  ),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           Text('Timeline',
                  textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: width * 0.085,
                        color: Color.fromRGBO(33, 36, 41, 1),
                        fontWeight: FontWeight.bold),
                  ),
          SizedBox(height: height * 0.01,),
          lineYellowShipmentSevice(context)
         ],
       ),
    );
  }

    Widget _timelines(double height, double width){
      return Column(
        children: [
          _timeline(height, width, (this.flight["statusFlight"]["atTheFrontDoor"]["date"] == '') ? '' : '${DateFormat.jm().format(convertirMilliSecondsToDateTime(int.parse(this.flight["statusFlight"]["atTheFrontDoor"]["date"])))}', generalText.atTheFrontDoor(), 'Description if need it.', gate(height, width), (this.flight["statusFlight"]["atTheFrontDoor"]["value"] == true)),
          SizedBox(height: height * 0.04,),
          _timeline(height, width, (this.flight["statusFlight"]["takingOff"]["date"] == '') ? '' : '${DateFormat.jm().format(convertirMilliSecondsToDateTime(int.parse(this.flight["statusFlight"]["takingOff"]["date"])))}', generalText.takingOff(), 'Description if need it.', take(height, width), (this.flight["statusFlight"]["takingOff"]["value"] == true)),
          SizedBox(height: height * 0.04,),
          _timeline(height, width, (this.flight["statusFlight"]["landing"]["date"] == '') ? '' : '${DateFormat.jm().format(convertirMilliSecondsToDateTime(int.parse(this.flight["statusFlight"]["landing"]["date"])))}', generalText.landing(), 'Stop, 1:40m', landed(height, width), (this.flight["statusFlight"]["landing"]["value"] == true)),
          SizedBox(height: height * 0.04,),
          _timeline(height, width, (this.flight["statusFlight"]["atTheExitDoor"]["date"] == '') ? '' : '${DateFormat.jm().format(convertirMilliSecondsToDateTime(int.parse(this.flight["statusFlight"]["atTheExitDoor"]["date"])))}', generalText.atTheExitDoor(), 'Description if need it.', take(height, width), (this.flight["statusFlight"]["atTheExitDoor"]["value"] == true)),
          SizedBox(height: height * 0.04,),
          _timeline(height, width, (this.flight["statusFlight"]["delivered"]["date"] == '') ? '' : '${DateFormat.jm().format(convertirMilliSecondsToDateTime(int.parse(this.flight["statusFlight"]["delivered"]["date"])))}', generalText.delivered(), 'Description if need it.', landed(height, width), (this.flight["statusFlight"]["delivered"]["value"] == true)),
      ],);
    }

    Widget _timeline(double height, double width, String time, String state, String description, Widget img, bool active){
    return Container(
         margin: EdgeInsets.only(
                left: width * 0.1
              ),
        child: Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Container(
        width: width * 0.2,
        child: Text(time,
                style: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: width * 0.045)),
      ),
    SizedBox(width:  width * 0.009,),
          _circuloVerde(height, width, active),
    SizedBox(width:  width * 0.03,),
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        img,
        SizedBox(height: height * 0.005,),
         Text(state,
              textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: width * 0.04,
                    color: Color.fromRGBO(33, 36, 41, 1),
                    fontWeight: FontWeight.bold),
              ),
        SizedBox(height: height * 0.005,),
         Text(description,
              textAlign: TextAlign.start,
                style: TextStyle(
                    fontSize: width * 0.03,
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontWeight: FontWeight.bold),
              ),
    ],)
    ],
        ),
      );
    }

    Widget _circuloVerde(double height, double width, bool active){
      return (active == true)
      ? Container(
            width: width * 0.035,
            height: width * 0.035,
            decoration: BoxDecoration(
                border:
                    Border.all(color: Color.fromRGBO(45, 222, 152, 1.0), width: 3.0),
                borderRadius: BorderRadius.circular(100.0)),
          ) :
          Container(
              width: width * 0.035,
              height: width * 0.035,
              decoration: BoxDecoration(
                  border:
                      Border.all(color: Color.fromRGBO(45, 222, 152, 0.0), width: 3.0),
                  borderRadius: BorderRadius.circular(100.0)),
            );
    }
}
