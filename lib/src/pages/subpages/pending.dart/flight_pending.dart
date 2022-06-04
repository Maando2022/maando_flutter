// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/pages/subpages/pending.dart/card_ad_pending.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/matches/matchesAdText.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_header.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/dialog_select_PayMethodAd.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maando/src/utils/responsive.dart';

class FlightPending extends StatefulWidget {
  // final Map<String, dynamic> flight;
  dynamic match;

  FlightPending({@required this.match});

  @override
  _FlightPendingState createState() => _FlightPendingState();
}

class _FlightPendingState extends State<FlightPending> {
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;
  int _tab = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    // CONSULTAMOS EL MATCH PARA CATUALUZARLO CUANDO VENGA DEL WEBVIEW
    Http().findMatch(context: context, id: widget.match["_id"]).then((resp) {
      var respMap = json.decode(resp);
      if (respMap["ok"] == false) {
      } else {
        setState(() {
          widget.match = respMap["match"][0];
        });
      }
    });

// LLENAMOS LA LISTA DE MAPS DE CIUDADES
    for (int i = 0; i < aiports.length; i++) {
      for (var a in aiports[i]["aiports"]) {
        listaCiudadesMap.add(a);
      }
    }

    for (var c in listaCiudadesMap) {
      if ('${c["city"]} (${c["code"]})' ==
          widget.match["flight"]["cityDepartureAirport"]) {
        codeCityDeparture = c["code"];
        departure = c["city"].split('(')[0];
      }

      if ('${c["city"]} (${c["code"]})' ==
          widget.match["flight"]["cityDestinationAirport"]) {
        codeCityDestination = c["code"];
        destination = c["city"].split('(')[0];
      }
    }

    return StreamBuilder<List<dynamic>>(
            stream: blocGeneral.aiportsOriginStream,
            builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                if(snapshotConutriesOrigin.hasData){
                    if(snapshotConutriesOrigin.data.length <= 0){
                      return Container();
                    }else{
                          return Container(
                                  margin: EdgeInsets.only(
                                      bottom: height * 0.03, right: width * 0.03, left: width * 0.03),
                                      decoration: BoxDecoration(
                                          // border:
                                          //     Border.all(color: Color.fromRGBO(33, 36, 41, 0.5), width: 0.5),
                                          borderRadius: BorderRadius.circular(7.0),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: Color.fromRGBO(33, 36, 41, 0.5),
                                                blurRadius: 1.0,
                                                offset: Offset(0.5, 0.5))
                                          ],
                                          color: Color.fromRGBO(255, 255, 255, 1)),
                                      child: Column(
                                        children: <Widget>[
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: width * 0.03),
                                            width: width * 0.9,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    _tabAd(responsive, height, width),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    _tabFlight(responsive, height, width),
                                                  ],
                                                ),
                                                botonTresPuntosGrises(context, width * 0.09, () {
                                                  ActionSheetHeaderFlight(
                                                          context: context,
                                                          flight: widget.match["flight"],
                                                          listActions:
                                                              _listaAccionesFlight(context, widget.match))
                                                      .sheetHeader();
                                                })
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: height * 0.02,
                                          ),
                                          // _state(context, height, width),
                                          // SizedBox(
                                          //   height: height * 0.02,
                                          // ),
                                          // _barraSeparadora(height, width),
                                          // SizedBox(
                                          //   height: height * 0.02,
                                          // ),
                                          (_tab == 1)
                                              ? _infoAd(context, responsive, height, width, widget.match["ad"])
                                              : _infoFlight(context, responsive, height, width),
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                        ],
                                      ),
                                    );
                    }
                }else if(snapshotConutriesOrigin.hasError){
                    return Container();
                }else{
                    return Container();
                }
              },
        );
  }

//  ***********************************
//  ***********************************
  Widget _tabAd(Responsive responsive, double height, double width) {
    return CupertinoButton(
        child: Container(
          height: height * 0.055,
          width: width * 0.25,
          child: Center(
            child: Text(generalText.ad(),
                style: TextStyle(
                    color: (_tab == 1)
                        ? Color.fromRGBO(33, 36, 41, 0.5)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(1.5))),
          ),
        ),
        color: (_tab == 1)
            ? Color.fromRGBO(255, 206, 6, 1.0)
            : Color.fromRGBO(234, 234, 234, 0.5),
        borderRadius: BorderRadius.circular(14.0),
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            _tab = 1;
          });
        });
  }

  Widget _tabFlight(Responsive responsive, double height, double width) {
    return CupertinoButton(
        child: Container(
          height: height * 0.055,
          width: width * 0.25,
          child: Center(
            child: Text(generalText.flight(),
                style: TextStyle(
                    color: (_tab == 2)
                        ? Color.fromRGBO(33, 36, 41, 0.5)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(1.5))),
          ),
        ),
        color: (_tab == 2)
            ? Color.fromRGBO(255, 206, 6, 1.0)
            : Color.fromRGBO(234, 234, 234, 0.5),
        borderRadius: BorderRadius.circular(14.0),
        padding: EdgeInsets.all(0),
        onPressed: () {
          setState(() {
            _tab = 2;
          });
        });
  }

//  ***********************************
//  ***********************************

  Widget _infoFlight(context, responsive, height, width) {
    return Container(
      child: Column(
        children: [
          _cabezera(context, responsive, height, width),
          SizedBox(
              height: height * 0.01,
              ),
          _dates(context, responsive, height, width),
        ],
      ),
    );
  }

  Widget _infoAd(context, responsive, height, width, ad) {
    return CardAdPending(match: widget.match, ad: blocGeneral.ad);
  }


  Widget _cabezera(BuildContext context, Responsive responsive, double height, double width) {
    return Container(
      width: width * 0.75,
      margin: EdgeInsets.only(top: height * 0.02),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(generalText.departure(),
                  //     textAlign: TextAlign.start,
                  //     style: TextStyle(
                  //         letterSpacing: 0.07,
                  //         color: Color.fromRGBO(173, 181, 189, 1.0),
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: width * 0.04)),
                  Container(
                    child: Row(
                      children: [
                        Text(codeCityDeparture,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                letterSpacing: 0.07,
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(4))),
                      ],
                    ),
                  ),
                  Text(departure.toUpperCase(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(1.8)))
                ],
              ),
            ),
            Container(
              height: width * 0.055,
              width: width * 0.055,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/general/icon flight.png',
                      ),
                      fit: BoxFit.fitWidth),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(generalText.destination(),
                  //     textAlign: TextAlign.start,
                  //     style: TextStyle(
                  //         letterSpacing: 0.07,
                  //         color: Color.fromRGBO(173, 181, 189, 1.0),
                  //         fontWeight: FontWeight.bold,
                  //         fontSize: width * 0.04)),
                  Container(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(codeCityDestination,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                letterSpacing: 0.07,
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(4))),
                      ],
                    ),
                  ),
                  Text(destination.toUpperCase(),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(1.8)))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _dates(BuildContext context, Responsive responsive, double height, double width) {
    return Container(
        margin: EdgeInsets.only(top: height * 0.01, left: width * 0.03),
        width: width * 0.8,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
            child: Text(generalText.departsArrives(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.ip(2))),
          ),
            Row(
              children: [
                Expanded(
                  child: Text(
                      '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.match["flight"]["departureDate"])).toString())}',
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(1.5))),
                ),
                SizedBox(
                  width: width * 0.04,
                ),
                Expanded(
                  child: Text(
                      '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(widget.match["flight"]["destinationDate"])).toString())}',
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(1.5))),
                ),
              ],
            ),
          ],
        ));
  }

  List<ActionSheetAction> _listaAccionesFlight(
      BuildContext context, dynamic match) {
    // print(
    //     '============================================ stateAd  =====>>>>>>>>>> ${match["stateAd"]}');
    // print(
    //     '============================================ stateFlight =====>>>>>>>>>> ${match["stateFlight"]}');

    return validaMatch(context, match);
  }

  List<ActionSheetAction> validaMatch(BuildContext context, match) {
    if (match["stateFlight"] == 'request_sendFlight') {
      if (match["stateAd"] == 'request_receivedAd') {
        return [aceptRequest(context, match), rejectRequest(context, match)];
      } else if (match["stateAd"] == 'request_rejectedAd') {
        return [];
      } else if (match["stateAd"] == 'request_acceptedAd') {
        return [makeThePayment(context, match), rejectRequest(context, match)];
      } else if (match["stateAd"] == 'request_paidAd') {
        return [seeDeliveryStatus(context, match)];
      } else {
        return [];
      }
    } else if (match["stateFlight"] == 'request_retractedFlight') {
      return [];
    } else if (match["stateFlight"] == 'request_receivedFlight') {
      if (match["stateAd"] == 'request_sendAd') {
        // return [aceptRequest(context, match) ,retractedRequest(context, match)];
        return [retractedRequest(context, match)];
      } else if (match["stateAd"] == 'request_rejectedAd') {
        return [];
      } else {
        return [];
      }
    } else if (match["stateFlight"] == 'request_rejectedFlight') {
      return [];
    } else if (match["stateFlight"] == 'request_acceptedFlight') {
      if (match["stateAd"] == 'request_sendAd') {
        return [
          makeThePayment(context, match),
          retractedRequest(context, match)
        ];
      } else if (match["stateAd"] == 'request_retractedAd') {
        return [];
      } else if (match["stateAd"] == 'request_paidAd') {
        return [seeDeliveryStatus(context, match)];
      } else {
        return [];
      }
    } else if (match["stateFlight"] == 'request_paidFlight') {
      return [seeDeliveryStatus(context, match)];
    } else {
      return [];
    }
  }

  ActionSheetAction aceptRequest(BuildContext context, match) {

    return ActionSheetAction(
      text: matchAdText.aceptRequest(), // ACEPTAR LA SOLICITUD
      defaultAction: false,
      onPressed: () {
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
        Http()
            .requestAcceptedAd(
              context: context, 
                email: preference.prefsInternal.get('email'),
                idMatch: match["_id"])
            .then((resp) {
          var respMap = json.decode(resp);
          Navigator.pop(context);
          if (respMap["ok"] == false) {
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, respMap["message"]); })
                .then((_) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } else {
            // BUSCAMOS NUEVAMENTE LOS MATCHES Y ACTUALIZAMOS EL BLOC
            Http()
                .findMatchSendAd(
                  context: context, 
                    email: preference.prefsInternal.get('email'),
                    id: match["ad"]["_id"])
                .then((listMatch) {
              var respListMap = json.decode(listMatch);
              if (respListMap["ok"] == true) {
                blocGeneral.changeListMatch(
                    respListMap["matchDB"]); // actualizamos la lista de matches
                blocSocket.socket.getUserEmiter(respMap["flight"]["user"][
                    "email"]); // emitimos un evento socket para el email del vuelo
                
                  showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, respMap["message"]); } )
                    .then((_) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              } else {
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, respListMap["message"]); } )
                    .then((_) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                });
              }
            });
          }
        });
      },
      hasArrow: true,
    );
  }

  ActionSheetAction rejectRequest(BuildContext context, match) {

    return ActionSheetAction(
      text: matchAdText.rejectRequest(), // ACEPTAR LA SOLICITUD
      defaultAction: false,
      onPressed: () {
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
        Http()
            .requestRejectedAd(
              context: context, 
                email: preference.prefsInternal.get('email'),
                idMatch: match["_id"],
                idAd: match["ad"]["_id"],
                idFlight: match["flight"]["_id"])
            .then((resp) {
          var respMap = json.decode(resp);
          Navigator.pop(context);
          if (respMap["ok"] == false) {
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, respMap["message"]); } )
                .then((_) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } else {
            blocSocket.socket.getUserEmiter(respMap["flight"]["user"]
                ["email"]); // emitimos un evento socket para el email del vuelo
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, respMap["message"]); } )
                .then((_) {
              Navigator.pop(context);
              Navigator.pop(context);
              blocNavigator.shipmentPrincipal();
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}));
            });
          }
        });
      },
      hasArrow: true,
    );
  }

  ActionSheetAction makeThePayment(BuildContext context, match) {
    return ActionSheetAction(
      text: matchAdText.makeThePayment(), // ACEPTAR LA SOLICITUD
      defaultAction: false,
      onPressed: () async {   
        Navigator.pop(context);
        dialogSelectPayMethodAd.showMaterialDialog(context, match);
        return;
      },
      hasArrow: true,
    );
  }

  ActionSheetAction seeDeliveryStatus(BuildContext context, match) {
    return ActionSheetAction(
      text: matchAdText.seeDeliveryStatus(), // VER EL ESTADO DE LA ENTREGA
      defaultAction: false,
      onPressed: () {
        print('VER EL ESTADO DE LA ENTREGA');
      },
      hasArrow: true,
    );
  }

  ActionSheetAction retractedRequest(BuildContext context, match) {
    return ActionSheetAction(
      text:
          matchAdText.undoRequestSubmission(), // DESHACER ENVIO DE LA SOLICITUD
      defaultAction: false,
      onPressed: () {
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
        Http()
            .requestRetractedAd(
              context: context, 
                email: preference.prefsInternal.get('email'),
                idMatch: match["_id"],
                idAd: match["ad"]["_id"],
                idFlight: match["flight"]["_id"])
            .then((resp) {
          var respMap = json.decode(resp);
          Navigator.pop(context);
          if (respMap["ok"] == false) {
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, respMap["message"]); })
                .then((_) {
              Navigator.pop(context);
              Navigator.pop(context);
            });
          } else {
            blocSocket.socket.getUserEmiter(respMap["flight"]["user"]
                ["email"]); // emitimos un evento socket para el email del vuelo
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, respMap["message"]); })
                .then((_) {
              Navigator.pop(context);
              Navigator.pop(context);
              blocNavigator.shipmentPrincipal();
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}));
            });
          }
        });
      },
      hasArrow: true,
    );
  }


  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
