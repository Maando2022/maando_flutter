// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/convertListElementsString.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';

class CardFlightMatch extends StatelessWidget {
  // const CardAd({Key key}) : super(key: key);
  String departureAirport;
  String arrivalAirport;
  String departure;
  String destination;
  String departureDT;
  String arrivalDT;
  String elements;
  String packageDesc;
  CardFlightMatch(
      {@required this.departureAirport,
      @required this.arrivalAirport,
      @required this.departure,
      @required this.destination,
      @required this.departureDT,
      @required this.arrivalDT,
      @required this.elements,
      @required this.packageDesc});

  @override
  Widget build(BuildContext context) {
    final args = {
      "departureAirport": departureAirport,
      "arrivalAirport": arrivalAirport,
      "departure": departure,
      "destination": destination,
      "departureDT": departureDT,
      "arrivalDT": arrivalDT,
      "elements": elements
    };

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);

    return Container(
      margin: EdgeInsets.only(
          bottom: 20.0,
          right: variableGlobal.margenPageWith(context),
          left: variableGlobal.margenPageWith(context)),
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
      height: height * 0.34,
      width: width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _cabezera(context, height, width),
          SizedBox(
            height: 8.0,
          ),
          // _contomerRating(context, args, height, width),
          // SizedBox(
          //   height: 12.0,
          // ),
          Container(
            width: width * 0.855,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _departArrives(context),
                SizedBox(
                  width: width * 0.02,
                ),
                _packageType(context),
                Container(
                  child: Icon(Icons.keyboard_arrow_down,
                      color: Color.fromRGBO(230, 230, 230, 1)),
                )
              ],
            ),
          ),
          SizedBox(
            height: 16.0,
          ),
          Container(
            width: width * 0.815,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _botonSend(context),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          )
        ],
      ),
    );
  }

  Widget _cabezera(BuildContext context, double height, double width) {
    return Container(
      width: width * 0.9,
      child: Row(
        children: [
          Container(
            width: width * 0.75,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(departureAirport,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 48.0)),
                    ),
                    Positioned(
                      top: 48.0,
                      child: Text(departure.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(173, 181, 189, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    )
                  ],
                ),
                Container(
                  height: 23.0,
                  width: 23.0,
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
                Stack(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(arrivalAirport,
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 48.0)),
                    ),
                    Positioned(
                      top: 48.0,
                      left: 1.0,
                      child: Text(destination.toUpperCase(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(173, 181, 189, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0)),
                    )
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

  Widget _contomerRating(
      BuildContext context, args, double height, double width, Responsive responsive) {
    return Container(
      width: width * 0.82,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                child: Text(generalText.customerratings(),
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(173, 181, 189, 1.0),
                        fontWeight: FontWeight.w600,
                        fontSize: 12.0)),
              ),
            ],
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/general/staryellow.png'),
                      ),
                    ),
                  ),
                  Container(
                      width: 20,
                      height: 15,
                      child:
                          Image.asset('assets/images/general/staryellow.png')),
                  Container(
                      width: 20,
                      height: 15,
                      child:
                          Image.asset('assets/images/general/staryellow.png')),
                  Container(
                      width: 20,
                      height: 15,
                      child:
                          Image.asset('assets/images/general/staryellow.png')),
                  Container(
                      width: 20,
                      height: 15,
                      child:
                          Image.asset('assets/images/general/staryellow.png')),
                  Container(
                      width: 20,
                      height: 15,
                      child:
                          Image.asset('assets/images/general/Vector@3x.png')),
                ],
              ),
              SizedBox(
                width: 16.0,
              ),
              GestureDetector(
                child: Text(generalText.seeCustomerReviews(),
                    style: TextStyle(
                        color: Color.fromRGBO(81, 201, 245, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(1.5))),
                onTap: () {
                  Navigator.pushNamed(context, 'flight_detail',
                      arguments: jsonEncode(args));
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  // *************************

  Widget _departArrives(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(generalText.departure(),
                style: TextStyle(
                    letterSpacing: 0.07,
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: 12.0)),
          ),
          SizedBox(
            height: 3.0,
          ),
          Row(
            children: <Widget>[
              Container(
                width: 15,
                height: 13,
                child: Image.asset('assets/images/general/icon-date-3@3x.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Text(departureDT,
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0)),
              ),
            ],
          )
        ],
      ),
    );
  }

  // *************************

  Widget _packageType(BuildContext context) {
    // return Container();
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
          Row(
            children: <Widget>[
              Container(
                width: 15,
                height: 13,
                child: Image.asset('assets/images/general/envelope.png'),
              ),
              Container(
                margin: EdgeInsets.only(left: 6),
                child: Text(
                    convert.convertCodePackageToDescription(packageDesc),
                    style: TextStyle(
                        letterSpacing: 0.07,
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0)),
              ),
            ],
          )
        ],
      ),
    );
  }
  // **********************************

  Widget _botonSend(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: 100.0,
          height: 25.0,
          decoration: BoxDecoration(
              color: Color.fromRGBO(33, 36, 41, 1.0),
              border: Border.all(
                  width: 2.0, color: Color.fromRGBO(33, 36, 41, 1.0)),
              borderRadius: BorderRadius.circular(14)),
          child: Center(
            child: Text(
              generalText.sendrequest(),
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Color.fromRGBO(255, 206, 6, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          blocGeneral.changeSendRequest(true);
        });
  }
}
