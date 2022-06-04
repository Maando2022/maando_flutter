// @dart=2.9
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class ModalListAd extends StatelessWidget {
  Http _http = Http();
  final preference = Preferencias();

  List<dynamic> listAd  = [];
  List<dynamic> listAdMatch  = [];
  Map<String, dynamic> flight;  // el vuelo a matchear
  BuildContext c;  // context de la pantalla general

  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<dynamic> listaCiudadesMap = [];
  String codeCityDeparture;
  String codeCityDestination;
  String departure;
  String destination;

  ModalListAd({@required this.flight, @required this.c});

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

    // RECUPERAMOS LA CIUDAD DEL CODIGO DE AEROPUERTO
    for (var c in listaCiudadesMap) {
      if ('${c["city"]} (${c["code"]})'== flight["cityDepartureAirport"]) {
        codeCityDeparture = c["code"];
        departure = c["city"].split('(')[0];
      }

      if ('${c["city"]} (${c["code"]})'== flight["cityDestinationAirport"]) {
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
                            return FutureBuilder(
                                    future: _http.verMisAnuncios(context: context, email: preference.prefsInternal.get('email')),
                                    // initialData: Container()
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data["ok"] == true) {

                                          listAd  = snapshot.data["adsBD"];

                                          for(var ad in listAd){
                                            print('DESINO DEL ANUNCIO ${ad["city"]}');
                                            print('DESINO DEL VUELO ${destination}');
                                            if(
                                              convertirMilliSecondsToDateTime(int.parse(ad["arrivalDate"])).year == convertirMilliSecondsToDateTime(int.parse(flight["destinationDate"])).year &&
                                              convertirMilliSecondsToDateTime(int.parse(ad["arrivalDate"])).month == convertirMilliSecondsToDateTime(int.parse(flight["destinationDate"])).month &&
                                              convertirMilliSecondsToDateTime(int.parse(ad["arrivalDate"])).day == convertirMilliSecondsToDateTime(int.parse(flight["destinationDate"])).day  &&
                                              ad["city"].trim() == destination.trim()
                                            ){
                                              listAdMatch.add(ad);
                                            }
                                          }




                                    return (listAdMatch.length <= 0 ) ? BounceInDown(
                                              // animate: true,
                                              // from: 200,
                                              // delay: Duration(milliseconds: 500),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                            color: Color.fromRGBO(251, 251, 251, 1),
                                                            border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            // boxShadow: <BoxShadow>[
                                                            //     BoxShadow(
                                                            //       color: Colors.black26,
                                                            //       blurRadius: 3.0,
                                                            //       offset: Offset(3.0, 5.0),
                                                            //       spreadRadius: 3.0
                                                            //     )
                                                            //   ]
                                                            ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    iconFace2(context),
                                                    SizedBox(height: height * 0.07,),
                                                    Text(generalText.youDoNnotHaveAdsTthatWatchThisFlight(),
                                                      textAlign: TextAlign.center,
                                                      style: TextStyle(
                                                          color: Color.fromRGBO(33, 36, 41, 1.0),
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: width * 0.05)),
                                              SizedBox(height: height * 0.1,),
                                              RaisedButton(
                                                  child: Container(
                                                    width: width * 0.4,
                                                    child: Text(generalText.cancel(),
                                                        textAlign: TextAlign.center,
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(255, 206, 6, 1.0),
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: width * 0.05)),
                                                  ),
                                                  color: Color.fromRGBO(33, 36, 41, 1.0),
                                                  shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.0),
                                                  side: BorderSide(color: Colors.black, width: 1)),
                                                  padding: EdgeInsets.symmetric(horizontal: 15.0),
                                                  onPressed: () {
                                                    blocGeneral.changeSendRequest(false);
                                                  })
                                                  ],
                                                ),
                                              ),
                                            ) :
                                            BounceInDown(
                                              // animate: true,
                                              // from: 200,
                                              // delay: Duration(milliseconds: 500),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                            color: Color.fromRGBO(234, 234, 234, 1.0),
                                                            border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
                                                            borderRadius: BorderRadius.circular(7.0),
                                                            boxShadow: <BoxShadow>[
                                                                BoxShadow(
                                                                  color: Colors.black26,
                                                                  blurRadius: 3.0,
                                                                  offset: Offset(3.0, 5.0),
                                                                  spreadRadius: 3.0
                                                                )
                                                              ]
                                                            ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(height: height * 0.05,),
                                                    iconFace2(context),
                                                    SizedBox(height: height * 0.005,),
                                                    _anunciosMachados(context, height, width, listAdMatch),
                                                  ],
                                                ),
                                              ),
                                            );
                                        }else{
                                          return Container(
                                            child: Center(child: Text('error')),
                                          );
                                        }
                                      }else if(snapshot.hasError){
                                        return Container(
                                            child: Center(child: Text('error')),
                                          );
                                      }else{
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

  Widget _anunciosMachados(BuildContext context, double height, double width, List<dynamic> ads){
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(generalText.chooseThePackageYouWantToTakeWithThisFlight(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: width * 0.05)),
            Container(
              height: height * 0.35,
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                separatorBuilder: (context, index) => Divider(
                                    color: Colors.black,
                                  ),
                    itemCount: ads.length,
                    itemBuilder: (context, index) {
                return ListTile(
                  title: Text(ads[index]["title"].toUpperCase(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05)),
                subtitle: Text('${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(ads[index]["arrivalDate"])).toString())}',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            fontWeight: FontWeight.w500,
                            fontSize: height * 0.025)),
                leading: FutureBuilder<dynamic>(
            future: firebaseStorage.obtenerImagen(ads[index]["user"]["email"], ads[index]["_id"], 1),
            builder: (BuildContext context, snapshot) {
              if(snapshot.hasData){
                return  Container(
                    height: height * 0.1,
                    width: height * 0.1,
                    child: FadeInImage(
                                        image: NetworkImage(snapshot.data),
                                        placeholder:
                                            AssetImage('assets/images/general/jar-loading.gif'),
                                        fit: BoxFit.contain,
                                        // height: 200.0,
                                      ),
                  );
              }else if(snapshot.error){
                return Container();
              }else{
                 return Container();
              }
            }),
                
                
               
                trailing: Icon(Icons.arrow_forward_ios),
                isThreeLine: false,
                onTap: (){
                  _submitRequest(context, ads[index]);
                },
                );
              },
              ),
            ),
            SizedBox(height: height * 0.005,),
             RaisedButton(
                child: Container(
                  width: width * 0.4,
                  child: Text(generalText.cancel(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 206, 6, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05)),
                ),
                color: Color.fromRGBO(33, 36, 41, 1.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black, width: 1)),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                onPressed: () {
                  blocGeneral.changeSendRequest(false);
                })
          ],
        );
  }



  _submitRequest(BuildContext context, Map<String, dynamic> ad){
        showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      _http.createMatchSendFromAd(
        context: context, 
        email: preference.prefsInternal.get('email'),
        emailAd: ad["user"]["email"],
        emailFlight: flight["user"]["email"],
        idFlight: flight["_id"],
        idAd: ad["_id"]
      ).then((value){
         Navigator.pop(c);
        final valueMap = json.decode(value);
        print(valueMap["matchCreado"]);
        blocGeneral.changeSendRequest(false);
        // print('LA RSPUESTA DEL MATCH  ${valueMap}');
        if(valueMap["ok"] == true){
           blocSocket.socket.getUserEmiter(valueMap["matchCreado"]["flight"]["user"]["email"]);   // emitimos un evento socket para el email del vuelo
           showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]);})
           .then((_){
                Navigator.pushReplacementNamed(c, 'principal', arguments: jsonEncode({"shipments": true, "service": false}));
              });
        }else{
          showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);}).then((_){
                // Navigator.pushReplacementNamed(c, 'principal', arguments: jsonEncode({"shipments": true, "service": false}));
              });
        }
      });

  }



}
