// @dart=2.9
import 'dart:convert';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/elements.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/globals.dart';

class CardFlight extends StatelessWidget {
  final Map<String, dynamic> flight;
  // VALIDAMOS QUE INFORMACION SE QUIERE VER
  bool viewCodes;
  bool viewRatings;
  bool viewDates;
  bool viewPakages;
  Function actionSheet;
  final bool viewButtonOption;
  final bool tapBackground;
  Function functionTapBackground;

  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;

  CardFlight({
    @required this.flight,
    @required this.viewCodes,
    @required this.viewRatings,
    @required this.viewDates,
    @required this.viewPakages,
    @required this.actionSheet,
    @required this.viewButtonOption,
    @required this.tapBackground,
    @required this.functionTapBackground,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    // LLENAMOS LA LISTA DE MAPS DE CIUDADES
    for (int i = 0; i < aiports.length; i++) {
      for (var a in aiports[i]["aiports"]) {
        listaCiudadesMap.add(a);
      }
    }

    for (var c in listaCiudadesMap) {
      if ('${c["city"]} (${c["code"]})' == flight["cityDepartureAirport"]) {
        codeCityDeparture = c["code"];
        departure = c["city"].split('(')[0];
      }

      if ('${c["city"]} (${c["code"]})' == flight["cityDestinationAirport"]) {
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
                          return Stack(
                                  children: [
                                    CupertinoButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: (this.tapBackground == true && functionTapBackground != null) ?
                                      functionTapBackground :
                                      null,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context), vertical: height * 0.01),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black26,
                                                  spreadRadius: 2,
                                                  offset: Offset(0.5, 0.5))
                                            ],
                                            color: Color.fromRGBO(255, 255, 255, 1)),
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: width * 0.02, vertical: width * 0.02),
                                          child: Column(
                                            children: [
                                              // ****************************  Codigos de aeropuertos y ciudades
                                              (this.viewCodes == true)
                                                  ? CodesAndCities(
                                                      codeAiportDeparture:
                                                          CodeAiport(code: codeCityDeparture, city: departure),
                                                      codeAiportDestination: CodeAiport(
                                                          code: codeCityDestination, city: destination))
                                                  : Container(),
                                              // ****************************  Codigos de aeropuertos y ciudadealificacion
                                              SizedBox(height: (this.viewCodes == true) ? height * 0.02 : 0),
                                              (this.viewRatings == true) ? Ratings(emailUser: flight["user"]["email"]) : Container(),
                                              SizedBox(height: (this.viewRatings == true) ? height * 0.02 : 0),
                                              (this.viewDates == true)
                                                  ? DatesDeparturesAndArrivals(
                                                      departureDate: flight['departureDate'],
                                                      destinationDate: flight['destinationDate'])
                                                  : Container(),
                                              SizedBox(height: (this.viewDates == true) ? height * 0.02 : 0),
                                              (this.viewPakages == true)
                                                  ? PaquagesAndElements(
                                                      typePackageCompact: flight["typePackageCompact"],
                                                      typePackageHandybag: flight["typePackageHandybag"],
                                                      elementsCompact: flight["elementsCompact"],
                                                      elementsHandybag: flight["elementsHandybag"],
                                                    )
                                                  : Container(),
                                                  SizedBox(height:height * 0.015),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                      Positioned(
                                        right: width * 0.02,
                                        top: height * 0.02,
                                        child: (viewButtonOption == true)
                                            ? botonTresPuntosGrises(context, width * 0.1, actionSheet)
                                            : Container())
                                  ],
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
}

// *************  CODIGO DEL AEROPUERTO Y LA CIUDAD
class CodeAiport extends StatelessWidget {
  String code;
  String city;
  CodeAiport({@required this.code, @required this.city});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text((this.code == null) ? '   ' : this.code,
              textAlign: TextAlign.start,
              style: TextStyle(
                  letterSpacing: 0.07,
                  color: Color.fromRGBO(33, 36, 41, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(5.5))),
                  textExpanded(
                    (this.city == null) ? '   ' : city.toUpperCase(), 
                    width * 0.35,
                    responsive.ip(1.5),
                    Color.fromRGBO(173, 181, 189, 1.0),
                    FontWeight.bold,
                    TextAlign.start
                    )
                  
        ],
      ),
    );
  }
}

// *************  FILA DE CODIGOS Y CIUDADA CON EL AVION EN LA MITAD
class CodesAndCities extends StatelessWidget {
  CodeAiport codeAiportDeparture;
  CodeAiport codeAiportDestination;


  CodesAndCities(
      {@required this.codeAiportDeparture,
      @required this.codeAiportDestination,});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Stack(
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: width * 0.02),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              codeAiportDeparture,
              codeAiportDestination,
            ],
          ),
        ),
        Positioned(
          right: width * 0.45,
          top: height * 0.02,
          child: Container(
          height: width * 0.06,
          width: width * 0.06,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    'assets/images/general/icon flight.png',
                  ),
                  fit: BoxFit.fitWidth),
            ),
          ),
        )
      ],
    );
  }
}

// *************  CALIFICACION DEL VUELO RECIBE UN ENTERO
class Ratings extends StatelessWidget {
  int rating = 0;
  final String emailUser;
  Ratings({@required this.emailUser});


  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

       return FutureBuilder(
        future: Http().findMatchForEmailOfFlight(context: context, email: emailUser),
        builder: (_, AsyncSnapshot snapshot) {
          if(snapshot.hasData){


            dynamic valueMap = json.decode(snapshot.data);
            int r = 0;
            List qualifiedServices = [];

            if(valueMap["ok"] == true){
                for (var m in valueMap['arrayMatch']) {
                  for(var r in m["reviews"]){
                    rating = rating + r["rating"];
                    if(r["rating"] != 0 ||  r["rating"] != null){
                      qualifiedServices.add(r);
                    }
                  }
                }
                // Validamos que el denominador sea diferente de cero
                if(qualifiedServices.length > 0){
                   r = (valueMap['arrayMatch'].length != 0) ? (rating ~/ qualifiedServices.length)  : 0;
                } else{
                  rating = 0;
                  r = 0;
                }
                
            }else{
              rating = 0;
              r = 0;
            }   

            return Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.02),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Text(generalText.customerratings(),
                              style: TextStyle(
                                  letterSpacing: 0.07,
                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: responsive.ip(1.5))),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.007,
                    ),
                    Row(
                      children: [
                        ratings(context, r),
                        SizedBox(
                              width: width * 0.03,
                            ),
                        GestureDetector(
                              child: Text(generalText.seeCustomerReviews(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(81, 201, 245, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.ip(1.5))),
                              onTap: () {
                                Navigator.pushNamed(context, 'reviews_12_3',
                                    arguments: this.emailUser);
                              },
                            )
                      ],
                    ),
                  ],
                ),
              ),
            );
          }else if(snapshot.hasError){
            return Container();
          }else{
            return Container(height: height * 0.05);
          }
        });
  }
}

// *************  FECHAS SALIDAS Y LLEGADAS
class DatesDeparturesAndArrivals extends StatelessWidget {
  String departureDate;
  String destinationDate;
  DatesDeparturesAndArrivals(
      {@required this.departureDate, @required this.destinationDate});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.departsArrives(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.ip(1.5))),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          Row(
            children: <Widget>[
              Container(
                width: width * 0.055,
                height: width * 0.055,
                child: Image.asset('assets/images/general/icon-date-3@3x.png'),
              ),

              Container(
                margin: EdgeInsets.only(left: width * 0.01),
                child: textExpanded('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(departureDate)).toString())} / ${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(destinationDate)).toString())}',
                            width * 0.7,  responsive.ip(1.6), Color.fromRGBO(0, 0, 0, 1.0), FontWeight.w600, TextAlign.start
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

// *************  PAQUETES Y ELEMENTOS
class PaquagesAndElements extends StatelessWidget {
  bool typePackageCompact;
  bool typePackageHandybag;
  List<dynamic> elementsCompact;
  List<dynamic> elementsHandybag;

  PaquagesAndElements({
    @required this.typePackageCompact,
    @required this.typePackageHandybag,
    @required this.elementsCompact,
    @required this.elementsHandybag,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
      width: width * 0.9,
      margin: EdgeInsets.symmetric(horizontal: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.typePackage(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.ip(1.5))),
          ),
          SizedBox(
            height: 3.0,
          ),
          (elementsString(elementsCompact).length <= 0)
              ? Container()
              : Row(
                  children: <Widget>[
                    packageCompact(height * 0.03, height * 0.03),
                    Container(
                      width: width * 0.65,
                      margin: EdgeInsets.only(left: width * 0.015),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${elementsString(elementsCompact)}',
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.ip(1.5))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(
            height: height * 0.02,
          ),
          (elementsString(elementsHandybag).length <= 0)
              ? Container()
              : Row(
                  children: <Widget>[
                    packageHandybag(height * 0.03, height * 0.03),
                    Container(
                      width: width * 0.65,
                      margin: EdgeInsets.only(left: width * 0.015),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text('${elementsString(elementsHandybag)}',
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.ip(1.5))),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
