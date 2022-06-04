// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/pages/subpages/pending.dart/ad_pending.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class ListAdPending extends StatefulWidget {
  @override
  _ListAdPendingState createState() => _ListAdPendingState();
}

class _ListAdPendingState extends State<ListAdPending> {
  List<AdPending> arrayAdMatchWidget = [];
  AdPending cardAd;

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'principal');
    blocGeneral.changeSendRequest(false);
    final List<dynamic> arrayAdtMatch =
        jsonDecode(ModalRoute.of(context).settings.arguments);

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    arrayAdMatchWidget = [];

    for (var a in arrayAdtMatch) {
      arrayAdMatchWidget.add(AdPending(match: a));
    }

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
                child: Container(
              margin: EdgeInsets.only(
                  top: variableGlobal.margenTopGeneral(context)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        child: Column(children: <Widget>[
                      _encabezado(responsive, height, width, 'pageBack'),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      (arrayAdMatchWidget.length > 0)
                          ? Column(
                              children: arrayAdMatchWidget,
                            )
                          : cardAd,
                      SizedBox(
                        height: height * 0.02,
                      ),
                    ])),
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
              arrwBackYellowShipmentSERVICE(context),
              iconFace1(context),
              Container(width: width * 0.06),
            ],
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Text(generalText.listOfpendingAds(),
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
