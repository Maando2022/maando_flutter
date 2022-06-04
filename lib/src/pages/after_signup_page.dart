// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/socket_io.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/after_signup_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class AfterSignUpPage extends StatelessWidget {
  // const AfterSignUpPage({Key key}) : super(key: key);
  final preference = Preferencias();
  String nombre = '';

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'after_singup_page');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    preference.obtenerPreferencias();
    blocSocket.changeSocket(new SocketService());
    // extraemos el primer nombre si lo tiene
    if (preference.prefsInternal.get('fullName').toString().contains(' ') == true) {
      nombre = preference.prefsInternal.get('fullName').toString().split(' ')[0];
    } else {
      nombre = preference.prefsInternal?.get('fullName');
    }
    blocSocket.changeSocket(new SocketService());

    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
              SizedBox(
                height: height * 0.03,
              ),
              Container(
                  margin: EdgeInsets.only(top: height * 0.08),
                  child: Center(
                      child: Column(children: <Widget>[
                    iconFace2(context),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    //    *************************
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            '${generalText.hi()} ${(nombre == null) ? "Juan" : nombre},',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            afterSigupText.welcommeToMaando(),
                            style: TextStyle(
                                fontSize: height * 0.03,
                                fontWeight: FontWeight.bold),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal:
                                      variableGlobal.margenPageWith(context),
                                ),
                                child: Text(
                                  afterSigupText.toStartPlease(),
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: height * 0.02,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),

                    //    *************************
                    Stack(
                      children: <Widget>[
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(
                              bottom: height * 0.05,
                            ),
                            child: Column(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                SizedBox(
                                  height: height * 0.55,
                                ),
                                CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      'principal',
                                    );
                                  },
                                  child: Container(
                                    child: Text(
                                      afterSigupText.goToHome(),
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: height * 0.02,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          child: Container(
                            width: width,
                            margin: EdgeInsets.only(top: height * 0.01),
                            child: Column(
                              children: <Widget>[
                                CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        'create_ad_title_date_destination');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: variableGlobal
                                          .margenPageWith(context),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: height * 0.035,
                                      bottom: height * 0.035,
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1),
                                        border: Border.all(
                                            width: 2.0,
                                            color: Color.fromRGBO(
                                                234, 234, 234, 1.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1.0,
                                              // spreadRadius: 2.0,
                                              offset: Offset(1.0, 1.0))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(7)),
                                    child: Container(
                                      padding: EdgeInsets.only(left: 17.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.only(
                                                right: width * 0.06,
                                              ),
                                              child: megafono2_1(context)),
                                          Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    afterSigupText.sending(),
                                                    textAlign:
                                                        TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.02,
                                                        color: Color.fromRGBO(
                                                            33, 36, 41, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Text(
                                                    afterSigupText
                                                        .ifYouNeed(),
                                                    textAlign:
                                                        TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            height * 0.02,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                  ),
                                                  Text(
                                                    afterSigupText.createAd(),
                                                    textAlign:
                                                        TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            height * 0.02,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                  ),
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                // ************************************************
                                CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () {
                                    Navigator.pushNamed(context,
                                        'create_flight_form');
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                      horizontal: variableGlobal
                                          .margenPageWith(context),
                                    ),
                                    padding: EdgeInsets.only(
                                      top: height * 0.035,
                                      bottom: height * 0.035,
                                    ),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(255, 255, 255, 1),
                                        border: Border.all(
                                            width: 2.0,
                                            color: Color.fromRGBO(
                                                234, 234, 234, 1.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: Colors.black26,
                                              blurRadius: 1.0,
                                              // spreadRadius: 2.0,
                                              offset: Offset(1.0, 1.0))
                                        ],
                                        borderRadius:
                                            BorderRadius.circular(7)),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: width * 0.06),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Container(
                                              padding: EdgeInsets.only(
                                                right: width * 0.06,
                                              ),
                                              child: boton_plus_square(
                                                  context, () {
                                                Navigator.pushNamed(
                                                    context,
                                                    'create_flight_form');
                                              })),
                                          Container(
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    afterSigupText.taking(),
                                                    textAlign:
                                                        TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize:
                                                            height * 0.02,
                                                        color: Color.fromRGBO(
                                                            33, 36, 41, 1),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Text(
                                                    afterSigupText
                                                        .ifYouAreTraveling(),
                                                    textAlign:
                                                        TextAlign.right,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            height * 0.02,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                  ),
                                                  Text(
                                                    afterSigupText
                                                        .publishYouFlight(),
                                                    textAlign:
                                                        TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize:
                                                            height * 0.02,
                                                        fontWeight: FontWeight
                                                            .normal),
                                                  )
                                                ]),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ])))
            ])));
  }
}
