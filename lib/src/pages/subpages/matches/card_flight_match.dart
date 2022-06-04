// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/elements.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';

class CardFlightMatch extends StatelessWidget {
  final Map<String, dynamic> flight;
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<Map<String, dynamic>> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;
  CardFlightMatch(
      {@required this.flight});

  @override
  Widget build(BuildContext context) {
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

    int rating = 0;
    for (var r in flight['reviews']) {
      rating = rating + r['rating'];
    }
        // Validamos que el denominador sea diferente de cero
    int r = (flight['reviews'].length != 0)
        ? (rating ~/ flight['reviews'].length)
        : 0;

    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.aiportsOriginStream,
        builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
            if(snapshotConutriesOrigin.hasData){
                if(snapshotConutriesOrigin.data.length <= 0){
                  return Container();
                }else{
                      return GestureDetector(
                              onTap: () {
                                blocGeneral.changeArgPage(flight);
                                Navigator.pushNamed(context, 'detail_flight_match');
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                    bottom: height * 0.03,
                                    right: variableGlobal.margenPageWith(context),
                                    left: variableGlobal.margenPageWith(context)),
                                decoration: BoxDecoration(
                                    // border: Border.all(color: Colors.red),
                                    borderRadius: BorderRadius.circular(7.0),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                          color: Color.fromRGBO(33, 36, 41, 0.2),
                                          blurRadius: 1.0,
                                          offset: Offset(0.0, 1.0))
                                    ],
                                    color: Color.fromRGBO(255, 255, 255, 1)),
                                    child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        _cabezera(context, height, width),
                                        SizedBox(
                                          height: height * 0.01,
                                        ),
                                        _dates(context, height, width),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                        _typePackages(context, height, width),
                                        SizedBox(
                                          height: height * 0.02,
                                        ),
                                      ],
                                    ),
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

  Widget _cabezera(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
      width: width * 0.9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width * 0.67,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(generalText.departure(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.03)),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text((codeCityDeparture.length <= 0) ? '    ' : codeCityDeparture,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  letterSpacing: 0.07,
                                  color: Color.fromRGBO(33, 36, 41, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.08)),
                        ],
                      ),
                    ),
                    Text(departure.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.03))
                  ],
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(generalText.destination(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.03)),
                    Container(
                      // padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                           Text((codeCityDestination.length <= 0) ? '    ' : codeCityDestination,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  letterSpacing: 0.07,
                                  color: Color.fromRGBO(33, 36, 41, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.08)),
                        ],
                      ),
                    ),
                    Text(destination.toUpperCase(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            letterSpacing: 0.07,
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.03))
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.1,
          )
        ],
      ),
    );
  }

  // *************************

  Widget _dates(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.01, left: width * 0.03),
        width: width * 0.9,
        child: Row(
          children: [
            Expanded(
              child: Text('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(flight["departureDate"])).toString())}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0)),
            ),
            SizedBox(width: width * 0.04,),
            Expanded(
              child: Text('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(flight["destinationDate"])).toString())}',
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.w600,
                              fontSize: 13.0)),
            ),
          ],
        ));
  }

  // *************************

  Widget _typePackages(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.01, left: width * 0.03),
      width: width * 0.9,
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
                width: width * 0.7,
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
                width: width * 0.7,
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
}
