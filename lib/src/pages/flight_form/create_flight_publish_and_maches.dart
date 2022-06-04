// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/flight_form_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_package_type.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class CreateFlightPubishAndMaches extends StatefulWidget {
  CreateFlightPubishAndMaches({Key key}) : super(key: key);

  @override
  _CreateFlightPubishAndMachesState createState() =>
      _CreateFlightPubishAndMachesState();
}

class _CreateFlightPubishAndMachesState
    extends State<CreateFlightPubishAndMaches> {
  final blocNavigator = blocGeneral;
  Http _http = Http();
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;
  bool selectPackageCompact = false;
  bool selectPackageHandybag = false;

  @override
  Widget build(BuildContext context) {
    final bloc = ProviderApp.ofFlightForm(context);
    conectivity.validarConexion(context, 'create_flight_publish_and_maches');
    if (bloc.listElementsCompact == null) {
      bloc.changeListElementsCompact([]);
    }
    if (bloc.listElementsHandybag == null) {
      bloc.changeListElementsHandybag([]);
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

// LLENAMOS LA LISTA DE MAPS DE CIUDADES
    for (int i = 0; i < aiports.length; i++) {
      for (var a in aiports[i]["aiports"]) {
        listaCiudadesMap.add(a);
      }
    }

    for (var c in listaCiudadesMap) {
      if ('${c["city"]} (${c["code"]})' == bloc.cityDeparture) {
        codeCityDeparture = c["code"];

        departure = c["city"].split('(')[0];
      }

      if ('${c["city"]} (${c["code"]})' == bloc.cityDestination) {
        codeCityDestination = c["code"];
        destination = c["city"].split('(')[0];
      }
    }

    // **************************
    if (bloc.listElementsCompact != null) {
      if (bloc.listElementsCompact.length > 0) {
        selectPackageCompact = true;
      }
    }
    if (bloc.listElementsHandybag != null) {
      if (bloc.listElementsHandybag.length > 0) {
        selectPackageHandybag = true;
      }
    }

    return Container(
      height: double.infinity,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(255, 206, 6, 1),
          body: SingleChildScrollView(
            child: Column(
                //column principal
                children: <Widget>[
                  _parte1(responsive, height, width),
                  SizedBox(
                    height: height * 0.0,
                  ),
                  _parte2(responsive, bloc),
                  Container(
                    width: width * 0.91,
                    height: height * 0.09,
                    margin: EdgeInsets.only(
                        top: height * 0.02,
                        right: variableGlobal.margenPageWith(context),
                        left: variableGlobal.margenPageWith(context)),
                    child: CupertinoButton(
                        child: Text(flightText.findShipmentsMatches(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(255, 206, 6, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(2))),
                        color: Color.fromRGBO(33, 36, 41, 1.0),
                        onPressed: () {
                          _findShipmentMatches(bloc);
                        }),
                  ),
                  Container(
                    width: width * 0.91,
                    height: height * 0.09,
                    margin: EdgeInsets.only(top: height * 0.03),
                    child: CupertinoButton(
                        child: Text(flightText.goToFlight(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(2.2))),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        onPressed: () {
                          blocNavigator.servicePrincipal();
                          bloc.streamNull();
                          Navigator.pushReplacementNamed(context, 'principal',
                              arguments: jsonEncode(
                                  {"shipments": false, "service": true}));
                        }),
                  ),
                  SizedBox(
                    height: height * 0.05,
                  ),
                ]),
          )),
    );
  }

  _parte1(Responsive responsive, double height, double width) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            width: width,
            height: height * 0.47,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: width * 1,
                  // alignment: Alignment.center,
                  child: Image.asset(
                    'assets/images/general/bg-ad-created-1.png',
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  width: width * 1,
                  alignment: Alignment.center,
                  child: Image.asset(
                      'assets/images/general/icon-maando-white-1.png'),
                ),
                Container(
                  margin: EdgeInsets.only(top: height * 0.35),
                  child: Center(
                    child: Text(flightText.yourFlightHasBeenSuccefully(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(3.3))),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _parte2(Responsive responsive, bloc) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: variableGlobal.margenPageWith(context),
            vertical: MediaQuery.of(context).size.height * 0.03),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(7.0)),
        child: Column(children: [
          Container(
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.07,
                vertical: MediaQuery.of(context).size.height * 0.01),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _vuelo(responsive, codeCityDeparture, departure),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.06,
                      height: MediaQuery.of(context).size.width * 0.06,
                      margin: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.03),
                      alignment: Alignment.center,
                      child: Image.asset(
                        'assets/images/general/icon flight@3x.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                    _vuelo(responsive, codeCityDestination, destination),
                  ],
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height * 0.02),
                              child: Text(generalText.departure(),
                                  style: TextStyle(
                                      letterSpacing: 0.07,
                                      color: Color.fromRGBO(173, 181, 189, 1.0),
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsive.ip(2))),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.01,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width * 0.05,
                                    height:
                                        MediaQuery.of(context).size.width * 0.05,
                                    child: Image.asset(
                                        'assets/images/general/icon-date-3@3x.png')),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.01,
                                ),
                                textExpanded(
                                    formatearfecha(bloc.dateTimeDeparture),
                                    MediaQuery.of(context).size.width * 0.35,
                                    responsive.ip(1.6),
                                    null,
                                    FontWeight.w500,
                                    TextAlign.left)
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   height: MediaQuery.of(context).size.height * 0.12,
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Container(
                      //         margin: EdgeInsets.only(
                      //             top: MediaQuery.of(context).size.height * 0.02),
                      //         child: Text(generalText.typePackage(),
                      //             style: TextStyle(
                      //                 letterSpacing: 0.07,
                      //                 color: Color.fromRGBO(173, 181, 189, 1.0),
                      //                 fontWeight: FontWeight.normal,
                      //                 fontSize: responsive.ip(2))),
                      //       ),
                      //       Row(
                      //         crossAxisAlignment: CrossAxisAlignment.center,
                      //         children: [
                      //           Container(
                      //               width: MediaQuery.of(context).size.width * 0.05,
                      //               height:
                      //                   MediaQuery.of(context).size.width * 0.05,
                      //               child: Image.asset(
                      //                   'assets/images/general/envelope.png')),
                      //           SizedBox(
                      //             width: MediaQuery.of(context).size.width * 0.015,
                      //           ),
                      //           Column(
                      //             children: [
                      //               (selectPackageCompact == true)
                      //                   ? textExpanded(
                      //                       adspacktypeText.compactName(),
                      //                       MediaQuery.of(context).size.width * 0.3,
                      //                       responsive.ip(1.8),
                      //                       null,
                      //                       FontWeight.w600,
                      //                       TextAlign.left)
                      //                   : Container(),
                      //               (selectPackageHandybag == true)
                      //                   ? textExpanded(
                      //                       adspacktypeText.handybagName(),
                      //                       MediaQuery.of(context).size.width * 0.3,
                      //                       responsive.ip(1.8),
                      //                       null,
                      //                       FontWeight.w600,
                      //                       TextAlign.left)
                      //                   : Container(),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Container(
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      
                    

                      Future<File> getImageFileFromAssets(String path) async {
                        final byteData = await rootBundle.load('assets/images/general/logo-1024x1024.png');
                        final file = File('${(await getTemporaryDirectory()).path}/$path');
                        Share.shareFiles(
                          ['${file.path}/image.jpg'],
                          text: 'I’ve an ad using www.https://maando.com\n\nKind of backage: ${(selectPackageCompact == true) ? adspacktypeText.compactName() : ""} ${(selectPackageHandybag == true) ? adspacktypeText.handybagName() : ""}\nDate, time and destination: $destination, ${formatearfechaDateTime(bloc.dateTimeDestination.toString())}\n\n'
                        );
                      }
                    },
                    child: Row(children: <Widget>[
                      Container(
                        alignment: Alignment.bottomRight,
                        child: Text(flightText.shareFlight(),
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.w500,
                                fontSize: responsive.ip(2))),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        alignment: Alignment.bottomRight,
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
                        child: Image.asset(
                            'assets/images/general/icon-share-1@3x.png'),
                      ),
                    ]),
                  ),
                )
              ],
            ),
          )
        ]));
  }

  Widget _vuelo(Responsive responsive, String code, String ciudad) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(code,
            style: TextStyle(
                letterSpacing: 0.07,
                color: Color.fromRGBO(33, 36, 41, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(6.5))),
        Text(ciudad,
            style: TextStyle(
                letterSpacing: 0.07,
                color: Color.fromRGBO(196, 196, 196, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(2))),
      ],
    );
  }

  // *******************************************
  _findShipmentMatches(FlightFormBloc bloc) {
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

    _http
        .searchMatchesToFlight(
            context: context, 
            email: preference.prefsInternal.get('email'),
            departureDate: blocGeneral.flight["departureDate"],
            destinationDate: blocGeneral.flight["destinationDate"],
            cityDepartureAirport: blocGeneral.flight["cityDepartureAirport"],
            cityDestinationAirport: blocGeneral.flight["cityDestinationAirport"])
        .then((value) {
      // print('LA RESPUESTA DEL MACH  ${value}');
      final valueMap = json.decode(value);
      if (valueMap['count'] <= 0) {
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.noresults()); } );
      } else {
        Navigator.pop(context);
        // Navigator.of(context).pop();
        blocGeneral.changeListMyAds(valueMap['AdDB']);
        bloc.streamNull();
        Navigator.pushNamed(context, 'list_ads',
            arguments: jsonEncode(blocGeneral.flight));
      }
    });
  }


  @override
    void dispose() {
      // TODO: implement dispose
      super.dispose();
      // final bloc = ProviderApp.ofFlightForm(context);
      // print('ENTRO AQUÍ  =============>>>>>>>>>>  ${true}');
      // bloc.streamNull();
    }
}
