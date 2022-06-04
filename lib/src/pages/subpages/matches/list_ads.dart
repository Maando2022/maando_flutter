// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/pages/subpages/matches/card_ad_match.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';

class ListaAds extends StatefulWidget {
  @override
  _ListaAdsState createState() => _ListaAdsState();
}

class _ListaAdsState extends State<ListaAds> {
  List<CardAdMatch> arrayAdWidget;
  CardAdMatch cardAd;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'principal');
    blocGeneral.changeSendRequest(false);
    String pageBack = jsonDecode(ModalRoute.of(context).settings.arguments)['pageBack'];
    final scanMap = blocGeneral.listMyAds;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    arrayAdWidget = [];

    for (var a in scanMap) {
      arrayAdWidget.add(CardAdMatch(ad: json.encode(a)));
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
              Container(child: arrwBackYellowShipmentSERVICE(context)),
              SizedBox(
                width: width * 0.05,
              ),
              Text(generalText.adsMatchList(),
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
