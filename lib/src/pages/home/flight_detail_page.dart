// @dart=2.9
import 'dart:ui';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/elements.dart';
import 'package:maando/src/utils/textos/details_da_flight.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/modalListAd.dart';

class FlightDetailPage extends StatefulWidget {
  @override
  _FlightDetailPageState createState() => _FlightDetailPageState();
}

class _FlightDetailPageState extends State<FlightDetailPage> {
  Map<String, dynamic> flight = blocGeneral.argPage;

  List<dynamic> aiports = [];
  List<Map<String, dynamic>> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aiports = blocGeneral.aiportsDestination;
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'search_9_4');
    blocGeneral.changeSendRequest(false);
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

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

    // int rating = 0;
    // for (var r in flight['reviews']) {
    //   rating = rating + r['rating'];
    // }
    //     // Validamos que el denominador sea diferente de cero
    // int r = (flight['reviews'].length != 0)
    //     ? (rating ~/ flight['reviews'].length)
    //     : 0;


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
                                  return _scaffold2(context, height, width);
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

  Widget _contomerRating(BuildContext context, int customerRatings) {
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
                        fontSize: 12.0)),
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
           showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
            Http().searchMatchesToFlight(
                      context: context, 
                      email: flight["user"]["email"],
                      departureDate: flight["departureDate"],
                      destinationDate: flight["destinationDate"],
                      cityDepartureAirport: flight["cityDepartureAirport"],
                      cityDestinationAirport: flight["cityDestinationAirport"])
                  .then((value) {
                final valueMap = json.decode(value);
                // print('LA RESPUESTA DEL MACH  ${valueMap}');
                if (valueMap['count'] <= 0) {
                  showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.noresults()); } );
                } else {
                  Navigator.pop(context);
                  blocGeneral.changeListMyAds(valueMap['AdDB']);
                  blocGeneral.changeSendRequest(true);
                }
             });
          },
          child: Container(
            width: width * 0.8,
            height: height * 0.09,
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              // margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
              margin: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: 30.0),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        arrwBackYellow(context, 'search_9_4'),
                        iconFace1(context),
                        botonTresPuntosGrises(context, 16, (){}),
                      ],
                    ),
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
                      margin: EdgeInsets.only(top: 30.0),
                      padding: EdgeInsets.only(
                          top: 10.0, bottom: 20.0, left: 20.0, right: 20.0),
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.red),
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
                            _cabezera(height, width),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            // _contomerRating(context, r),
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
    );
  }

  Widget _scaffold2(BuildContext context, double height, double width){
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 0.1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
              // margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 30.0),
              margin: EdgeInsets.only(
                  bottom: 20.0, left: 20.0, right: 20.0, top: height * 0.15),
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
                      decoration: BoxDecoration(
                          // border: Border.all(color: Colors.red),
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
                            _cabezera(height, width),
                              SizedBox(
                                height: height * 0.02,
                              ),
                            // _contomerRating(context, r),
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
                        vertical: height * 0.15, horizontal: width * 0.04),
                    child: Center(child: ModalListAd(flight: flight, c: context))),
              ),
            )
        ],
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
