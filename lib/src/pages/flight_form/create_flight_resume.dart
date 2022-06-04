// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/flight_form_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/elements.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_package_type.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:objectid/objectid.dart';
// import 'package:uuid/uuid.dart';

class CreateFlightResume extends StatelessWidget {
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;
  bool selectPackageCompact = false;
  bool selectPackageHandybag = false;
  List<dynamic> elementsSelectCompact = [];
  List<dynamic> elementsSelectHandybag = [];

  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_flight_resume');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofFlightForm(context);
    bloc.changeInsurance(generalText.free());

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
      for (var c in bloc.listElementsCompact) {
        if (c["select"] == true) {
          elementsSelectCompact.add(c);
        }
      }
    }
    if (bloc.listElementsHandybag != null) {
      if (bloc.listElementsHandybag.length > 0) {
        selectPackageHandybag = true;
      }
      for (var h in bloc.listElementsHandybag) {
        if (h["select"] == true) {
          elementsSelectHandybag.add(h);
        }
      }
    }

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                  top: variableGlobal.margenTopGeneral(context),
                  right: variableGlobal.margenPageWith(context),
                  left: variableGlobal.margenPageWith(context)),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            iconFace1(context),
                          ],
                        ),
                        arrwBackYellow(context, 'create_flight_type_package'),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      padding: EdgeInsets.only(
                          top: height * 0.01,
                          bottom: height * 0.01,
                          left: height * 0.015,
                          right: height * 0.015),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 1.0,
                                // spreadRadius: 2.0,
                                offset: Offset(1.0, 1.0))
                          ],
                          color: Color.fromRGBO(255, 255, 255, 1)),
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            _cabezera(context, responsive, codeCityDeparture,
                                departure, codeCityDestination, destination),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _departArrives(
                                context,
                                responsive,
                                bloc.dateTimeDeparture.toString(),
                                bloc.dateTimeDestination.toString(),
                                height,
                                width),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _typePackage(context, responsive, bloc),
                            // SizedBox(
                            //   height: height * 0.01,
                            // ),
                            // _insurance(context, responsive, bloc),
                            SizedBox(
                              height: height * 0.02,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _publish(context, responsive, height, width, bloc)
        ],
      ),
    );
  }

  // ***************************

  Widget _cabezera(
      BuildContext context,
      Responsive responsive,
      String departureAirport,
      String departure,
      String arrivalAirport,
      String destination) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * 0.3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Text(departureAirport,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(6))),
                    ),
                  ),
                  Text(departure,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(2)))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.width * 0.06,
              width: MediaQuery.of(context).size.width * 0.06,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.022,
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/images/general/icon flight.png',
                      ),
                      fit: BoxFit.contain),
                ),
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            Container(
              width: MediaQuery.of(context).size.width * 0.35,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Text(arrivalAirport,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(6))),
                    ),
                  ),
                  Text(destination,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(2)))
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // *************************

  Widget _departArrives(BuildContext context, Responsive responsive,
      String departureDT, String arrivalDT, double height, double width) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.departsArrives(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.ip(2))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Row(
            children: <Widget>[
              // Container(
              //   width: MediaQuery.of(context).size.width * 0.05,
              //   height: MediaQuery.of(context).size.width * 0.05,
              //   child: Image.asset(
              //     'assets/images/general/icon-date-3@3x.png',
              //     fit: BoxFit.contain,
              //   ),
              // ),
              Container(
                width: width * 0.85,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      width: width * 0.4,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(formatearfechaDateTime(departureDT),
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: responsive.ip(1.8))),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: width * 0.4,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(formatearfechaDateTime(arrivalDT),
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.w500,
                                    fontSize: responsive.ip(1.8))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  // *************************

  Widget _typePackage(BuildContext context, Responsive responsive, bloc) {
    return Container(
      child: Column(
        children: [
          (elementsSelectCompact.length != 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                          (selectPackageCompact == true ||
                                  selectPackageCompact != null)
                              ? adspacktypeText.compactName()
                              : '',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(173, 181, 189, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: responsive.ip(2))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Row(
                      children: <Widget>[
                        // packageCompact(MediaQuery.of(context).size.width * 0.05,
                        //     MediaQuery.of(context).size.width * 0.05),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.01),
                        Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                    elementsString(elementsSelectCompact),
                                    style: TextStyle(
                                        letterSpacing: 0.07,
                                        color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontWeight: FontWeight.w500,
                                        fontSize: responsive.ip(1.8))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                )
              : Container(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          (elementsSelectHandybag.length != 0)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                          (selectPackageHandybag == true ||
                                  selectPackageHandybag != null)
                              ? adspacktypeText.handybagName()
                              : '',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(173, 181, 189, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: responsive.ip(2))),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    (selectPackageHandybag == true ||
                            selectPackageHandybag != null)
                        ? Row(
                            children: <Widget>[
                              // (selectPackageHandybag == true)
                              //     ? packageHandybag(
                              //         MediaQuery.of(context).size.width * 0.05,
                              //         MediaQuery.of(context).size.width * 0.05)
                              //     : Container(),
                              SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.01),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          elementsString(
                                              elementsSelectHandybag),
                                          style: TextStyle(
                                              letterSpacing: 0.07,
                                              color:
                                                  Color.fromRGBO(0, 0, 0, 1.0),
                                              fontWeight: FontWeight.w500,
                                              fontSize: responsive.ip(1.8))),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  // ***************************

  Widget _insurance(BuildContext context, Responsive responsive, bloc) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.8,
          child: Row(children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(flightText.specialService(),
                    style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(2))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Row(
                    children: <Widget>[
                      insurance(context),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.02,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        child: Row(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      bloc.insurance,
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(33, 36, 41, 1.0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: responsive.ip(1.8)),
                                      textScaleFactor: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ]),
        ),
      ],
    );
  }
  // ***************************

  // ***************************

  tresPuntosGrises(context) {
    return Column(
      children: <Widget>[
        Container(
          width: 4.5,
          height: 4.5,
          margin: EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Color.fromRGBO(173, 181, 189, 1.0)),
        ),
        Container(
          width: 4.5,
          height: 4.5,
          margin: EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Color.fromRGBO(173, 181, 189, 1.0)),
        ),
        Container(
          width: 4.5,
          height: 4.5,
          margin: EdgeInsets.only(bottom: 2.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0),
              color: Color.fromRGBO(173, 181, 189, 1.0)),
        ),
      ],
    );
  }

  Widget _publish(BuildContext context, Responsive responsive, double height,
      double width, bloc) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.75,
        ),
        child: RaisedButton(
          onPressed: () {
            _publishFlight(context, bloc);
          },
          child: Container(
            width: width * 0.85,
            height: height * 0.09,
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(generalText.publish(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 206, 6, 1),
                      fontSize: responsive.ip(2.5),
                      fontWeight: FontWeight.bold,
                    )),
                // page(context)
              ],
            ),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
              side: BorderSide(color: Colors.black, width: 1)),
          elevation: 5.0,
          color: Color.fromRGBO(33, 36, 41, 1),
        ),
      ),
    );
  }

  // ****************************

  void _publishFlight(BuildContext context, FlightFormBloc bloc) {
    Http _http = Http();
    ObjectId  id = ObjectId();
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

    _http
        .createFlight(
            context: context,
            id: id.hexString,
            email: prefsInternal.prefsInternal.get('email'),
            cityDepartureAirport: bloc.cityDeparture,
            cityDestinationAirport: bloc.cityDestination,
            departureDate: bloc.dateTimeDeparture.toString(),
            destinationDate: bloc.dateTimeDestination.toString(),
            flightNumber: bloc.flightNumber,
            reservationCode: bloc.reservationCode,
            insurance: bloc.insurance,
            typePackageCompact: selectPackageCompact,
            typePackageHandybag: selectPackageHandybag,
            elementsCompact: elementsSelectCompact,
            elementsHandybag: elementsSelectHandybag)
        .then((value) {
      // print('LA RESPUESTA   >>>>>>>>>>>  ==== >>> ${value}');

      dynamic valueMap = json.decode(value);

      if (valueMap["ok"] == true) {
        Navigator.pop(context);
        blocGeneral.changeListMyFlights(blocGeneral.listMyFlights
          ..add(valueMap[
              "flightCreado"])); // agregamos el vuelo ala lista de mis vuelos
        blocGeneral.changeFlight(valueMap[
            "flightCreado"]); // gualdamos el vuelo para que en la pagina que siga se pueda hacer el match
        blocSocket.socket.addEntityToHome(valueMap[
            "flightCreado"]); // enviamos un socket para que actualize el home de los demás
        Navigator.pushNamed(context, 'create_flight_publish_and_maches');
      } else {
        Navigator.pop(context);
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } );
      }
    });
  }
}
