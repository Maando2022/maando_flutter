// @dart=2.9
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/elements.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/details_da_flight.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/modal_confirm_submit_request_flight.dart';

class DetailFlightMatch extends StatefulWidget {
  @override
  _DetailFlightMatchState createState() => _DetailFlightMatchState();
}

class _DetailFlightMatchState extends State<DetailFlightMatch> {
  Map<String, dynamic> flight = blocGeneral.flight;
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'detail_flight_match');
    blocGeneral.changeSendRequest(false);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);

    // LLENAMOS LA LISTA DE MAPS DE CIUDADES
    for(int i=0; i<aiports.length; i++){
      for(var a in aiports[i]["aiports"]){
        listaCiudadesMap.add(a);
      }
    }

    for(var c in listaCiudadesMap){
      if('${c["city"]} (${c["code"]})'== flight["cityDepartureAirport"]){
        codeCityDeparture = c["code"];
        departure = c["city"].split('(')[0];
      }

      if('${c["city"]} (${c["code"]})'== flight["cityDestinationAirport"]){
        codeCityDestination = c["code"];
        destination = c["city"].split('(')[0];
      }
    }

    final ad = blocGeneral.ad;
    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.aiportsOriginStream,
        builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
            if(snapshotConutriesOrigin.hasData){
                if(snapshotConutriesOrigin.data.length <= 0){
                  return Container();
                }else{
                      return StreamBuilder(
                              stream: blocGeneral.sendRequestStream,
                              builder: (BuildContext context, AsyncSnapshot<bool> snapshopt) {
                                if (snapshopt.hasData) {
                                  if (snapshopt.data == true) {
                                    return _scaffold2(context, height, width, ad);
                                  } else {
                                    return _scaffold1(context, height, width);
                                  }
                                } else if (snapshopt.hasError) {
                                  return Container();
                                } else {
                                  return Container(
                                    child: Center(child: CircularProgressIndicator()),
                                  );
                                }
                              });
                }
            }else if(snapshotConutriesOrigin.hasError){
                return Container();
            }else{
                return Container();
            }
          },
    );
  }

  Widget _cabezera(double height, double width) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Text((codeCityDeparture.length <= 0) ? '    ' : codeCityDeparture,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.08)),
                    ),
                  ),
                  Text(departure,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
              Container(
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        'assets/images/general/icon flight.png',
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Container(
                      child: Text((codeCityDestination.length <= 0) ? '    ' : codeCityDestination,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.08)),
                    ),
                  ),
                  Text(destination,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          letterSpacing: 0.07,
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _contomerRating(BuildContext context, int customerRatings, Responsive responsive) {
    return Container(
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(generalText.customerratings(),
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(173, 181, 189, 1.0),
                        fontWeight: FontWeight.normal,
                        fontSize: 12.0)),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Row(
            children: [
              ratings(context, customerRatings),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.04,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'reviews_12_3',
                      arguments: 'flight_detail');
                },
                child: Text(generalText.seeCustomerReviews(),
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(81, 201, 245, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(1.5))),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _departArrives(BuildContext context, String departureDT,
      String arrivalDT, double height, double width) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.departsArrives(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0)),
          ),
          SizedBox(
            height: 6.0,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 15,
                height: 13,
                child: Image.asset('assets/images/general/icon-date-3@3x.png'),
              ),
              Container(
                width: width * 0.68,
                margin: EdgeInsets.only(left: 6),
                child: Row(
                  children: <Widget>[
                     Expanded(
                       child: Text('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(flight["departureDate"])).toString())}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035)),
                     ),
                    Text(' / ',
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0)),
                    Expanded(
                      child: Text('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(flight["destinationDate"])).toString())}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.035)),
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

  Widget _typePackages(BuildContext context, double height, double width) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.typePackage(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0)),
          ),
          SizedBox(
            height: 3.0,
          ),
         (flight["typePackageCompact"] == false) 
          ? Container() : Row(
            children: <Widget>[
              packageCompact(height * 0.04, height * 0.04),
              Container(
                width: width * 0.65,
                margin: EdgeInsets.only(left: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('${elementsString(flight["elementsCompact"])}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0)),
                    ),
                  ],
                ),
              ),
            ],
          ),
           SizedBox(
            height: 5.0,
          ),
          (flight["typePackageHandybag"] == false) 
          ? Container() : Row(
            children: <Widget>[
              packageHandybag(height * 0.04, height * 0.04),
              Container(
                 width: width * 0.65,
                margin: EdgeInsets.only(left: 6),
                child: Row(
                  children: [
                    Expanded(
                      child: Text('${elementsString(flight["elementsHandybag"])}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0)),
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

  Widget _crearTakeService(BuildContext context, double height, double width) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.75,
        ),
        child: RaisedButton(
          onPressed: () {
            blocGeneral.changeSendRequest(true);
          },
          child: Container(
            width: width * 0.8,
            height: height * 0.09,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(detailAdFlifhtText.takeService(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 206, 6, 1),
                      fontSize: 16.0,
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

  Widget _scaffold1(BuildContext context, double height, double width){
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(
                    bottom: 20.0, left: variableGlobal.margenPageWith(context), right: variableGlobal.margenPageWith(context), top: 30.0),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          arrwBackYellowDetailFlightMatch(context),
                          iconFace1(context),
                          botonTresPuntosGrises(context, width * 0.09, (){}),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          detailAdFlifhtText.submitPackageDeliveryRequest(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: width * 0.05),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        padding: EdgeInsets.only(top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              _cabezera(height, width),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              _departArrives(context, flight['departureDate'],
                                  flight['destinationDate'], height, width),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              _typePackages(context, height, width),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _crearTakeService(context, height, width)
          ],
        ),
      ),
    );
  }

  Widget _scaffold2(BuildContext context, double height, double width, ad){
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                // margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
                margin: EdgeInsets.only(
                    bottom: 20.0, left: variableGlobal.margenPageWith(context), right: variableGlobal.margenPageWith(context), top: height * 0.15),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          detailAdFlifhtText.serviceDetails(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 32.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: height * 0.05),
                        padding: EdgeInsets.only(
                            top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              _cabezera(height, width),
                                SizedBox(
                                  height: height * 0.02,
                                ),
                              _departArrives(context, flight['departureDate'],
                                  flight['destinationDate'], height, width),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              _typePackages(context, height, width),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 100.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _crearTakeService(context, height, width),
            BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                child: Container(
                  color: Colors.white.withOpacity(0.2),
                  child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: height * 0.18, horizontal: width * 0.04),
                      child: Center(child: ModalConfirmSubmitRequestFlight(flight: flight, ad: ad, c: context))),
                ),
              )
          ],
        ),
      ),
    );
  }


   @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocGeneral.changeSendRequest(false);
  }
}
