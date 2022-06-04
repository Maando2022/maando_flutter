// @dart=2.9
import 'dart:convert';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';

import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/general_text.dart';


class Fligths extends StatefulWidget {

  @override
  _FligthsState createState() => _FligthsState();
}

class _FligthsState extends State<Fligths> {

  ScrollController _scrollController = ScrollController();
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  Http _http = Http();
  int cont = 30;


@override
void initState() {
  // TODO: implement initState
    super.initState();
        blocGeneral.changeViewNavBar(true);
      _http.getMatchesAdmin(email: preference.prefsInternal.get('email'), cont: cont)
          .then((flights) {
        final valueMap = json.decode(flights);
        // print('LOS VUELOS  =====>>> ${valueMap}');
        if (valueMap['ok'] == false) {
        } else {
          blocAdmin.changeFlights(valueMap["flights"]);
        }
      });


    // *********

    _scrollController
      ..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 500), () {
          blocGeneral.changeViewNavBar(true);
        });

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta abajo
          cont = cont + 15;
          _http.getMatchesAdmin(
                  email: preference.prefsInternal.get('email'), cont: cont)
              .then((flights) {
            final valueMap = json.decode(flights);
            // print('LOS VUELOS  =====>>> ${valueMap}');
            if (valueMap['ok'] == false) {

            } else {
              blocAdmin.changeFlights(valueMap["flights"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });
}



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container();
                      }else{
                        return Container(
                          height: height * 0.73,
                          width: width,
                          child: listFlight(responsive, height, width),
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

  // **********
  Widget listFlight(Responsive responsive, double height, double width){
  return StreamBuilder(
          stream: blocAdmin.flightsStream,
          builder: (BuildContext context, snapshotFlight) {
            if(snapshotFlight.hasData){

              if(snapshotFlight.data.length > 0){
                  return ListView.builder(
                    itemCount: snapshotFlight.data.length,
                    controller: _scrollController,
                    itemBuilder: (context, i) {

                      return CupertinoButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () => _viewDetailUser(snapshotFlight.data[i]),
                        child: ListTile(
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              textExpanded('${snapshotFlight.data[i]["flight"]["cityDepartureAirport"]} / ${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshotFlight.data[i]["flight"]["departureDate"])).toString())}',
                                                width * 0.9, responsive.ip(1.8), Color.fromRGBO(173, 181, 189, 1), FontWeight.w400, TextAlign.start
                                            ),
                              textExpanded('${snapshotFlight.data[i]["flight"]["cityDestinationAirport"]} / ${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(snapshotFlight.data[i]["flight"]["destinationDate"])).toString())}',
                                                width * 0.9, responsive.ip(1.8), Color.fromRGBO(173, 181, 189, 1), FontWeight.w400, TextAlign.start
                                            )
                              ],
                          ),
                          title: Text(snapshotFlight.data[i]["ad"]["title"].toString(),
                          style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 0, 0, 1.0),
                                          fontSize: responsive.ip(2.5))),
                        ),
                      );

                      },
                    );
              }else{
                return Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: height * 0.2),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                Text(generalText.weWillGetItThereFast(),
                                textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(
                                            0, 0, 0, 1.0),
                                        fontSize:
                                            MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                              ],
                            ),
                          ),
                        );
              }
      

            }else if(snapshotFlight.hasError){
              return Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Error!!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontSize: 24.0)),
                  ],
                ),
              ));
            } else {
                return Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
          });
  }


  _viewDetailUser(dynamic flight){
    blocAdmin.changeMatch(flight);
    Navigator.pushNamed(context, 'flight_datail');
  }
}
