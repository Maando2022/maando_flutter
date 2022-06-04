// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/card_flight.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class Shipment_SERVICE_intransit extends StatelessWidget {
  Http _http = Http();

  Map<String, dynamic> flight;
  Shipment_SERVICE_intransit({@required this.flight});
  
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;

  @override
  Widget build(BuildContext context) {
   final height = MediaQuery.of(context).size.height;
   final width = MediaQuery.of(context).size.width;
   final Responsive responsive = Responsive.of(context);

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

    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.aiportsOriginStream,
        builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
            if(snapshotConutriesOrigin.hasData){
                if(snapshotConutriesOrigin.data.length <= 0){
                  return Container();
                }else{
                      return CupertinoButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, 'timelineFlight',
                                      arguments: json.encode(
                                          {'pageBack': 'services', 'flight': json.encode(flight)}));
                                  // Navigator.pushReplacementNamed(context, 'timelineMap',
                                  //     arguments: json.encode(json.encode(flight["user"])));
                                },
                                padding: EdgeInsets.all(0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CardFlight(
                                          flight: flight,
                                          viewCodes: true,
                                          viewRatings: false,
                                          viewDates: true,
                                          viewPakages: true,
                                          viewButtonOption: false,
                                          tapBackground: true,
                                          functionTapBackground: null,
                                          actionSheet: null,
                                          ),
                                      FutureBuilder(
                                        future: Http().findMatchSendFlight(context: context, email: preference.prefsInternal.get('email'), id: flight["_id"]),
                                        builder: (_, AsyncSnapshot snapshot){
                                          if(snapshot.hasData){
                                            final resp = json.decode(snapshot.data);
                                            if(resp["ok"] == true){
                                              return Container(
                                                margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
                                                child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        children: [
                                                          Text('${generalText.code()}: ',
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: responsive.ip(1.6),
                                                            fontWeight: FontWeight.bold)),
                                                          Text(resp["matchDB"][0]["ad"]["code"],
                                                          style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: responsive.ip(1.6),
                                                            fontWeight: FontWeight.w300)),
                                                        ],
                                                      ),
                                              );
                                            }else{
                                              return Container();
                                            }
                                          }else if(snapshot.hasError){
                                            return Container();
                                          }else{
                                            return Container();
                                          }
                                        },
                                      ),
                                      SizedBox(height: height * 0.01),
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

  // *************************
  List<ActionSheetAction> _listaAcciones(BuildContext context, flight){
    final preference = Preferencias();

      return [
        ActionSheetAction(
            text: generalText.searchMatches(),
            defaultAction: true,
            onPressed: (){
              
               showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http.searchMatchesToFlight(
                context: context, 
                email: preference.prefsInternal.get('email'),
                departureDate: flight["departureDate"],
                destinationDate: flight["destinationDate"],
                cityDepartureAirport: flight["cityDepartureAirport"],
                cityDestinationAirport: flight["cityDestinationAirport"]
                ).then((value) {
                    // print('LA RESPUESTA DEL MACH  ${value}');
                  final valueMap = json.decode(value);
                  if(valueMap['count'] <= 0){
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.noresults()); } );
                  }else{
                     Navigator.pop(context);
                    Navigator.of(context).pop();
                    blocGeneral.changeListMyAds(valueMap['AdDB']);
                    blocGeneral.changeFlight(flight);
                    Navigator.pushNamed(context, 'list_ads', arguments: jsonEncode(flight));
                  }

                });
            },
            hasArrow: true,
          ),
           ActionSheetAction(
              text: generalText.deleteFlight(),
              defaultAction: true,
              onPressed: (){
               Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().deleteFlight(context: context, email: preference.prefsInternal.get('email'), id: flight["_id"])
                .then((value){
                  var valueMap = json.decode(value);
                  if(valueMap["ok"] == true){
                  // traigo mis anuncios para sacar los publicados y actualizar el bloc
                   Http().verMisVuelos(context: context, email: preference.prefsInternal.get('email')).then((myFlights){
                     Navigator.pop(context);
                     List<Map<String, dynamic>> flightsPublished = [];
                      for (var flight in myFlights["flightDB"]) {
                        if (flight['inTransit'] == false) {
                          flightsPublished.add(flight);
                        } else {}
                      }
                      blocGeneral.changeListMyFlights(flightsPublished);
                   });
                  }else{
                     Navigator.pop(context);
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
                    .then((_){
                      });
                  }
                });
              },
              hasArrow: true,
          ),
      ];
  }

  // *************************

  _findMatches(BuildContext context){
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
    _http.findMatchSendFlight(context: context, email: preference.prefsInternal.get('email'),id: flight["_id"]).then((value){
      final valueData = json.decode(value);
      if(valueData["ok"] == true){
        if(valueData["count"] <= 0){
          Navigator.pop(context);
          toastService.showToastCenter(context: context, text: generalText.numberRequestPending(0), durationSeconds: 3);
        }else{
          blocGeneral.changeFlight(flight);
              Navigator.pushNamed(context, 'list_ad_pending', arguments: json.encode(valueData["matchDB"]));
        }
      }else{

      }
    });
  }

}

