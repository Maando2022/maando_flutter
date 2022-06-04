// @dart=2.9
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class ModalConfirmSubmitRequestAd extends StatelessWidget {
  Http _http = Http();
  final preference = Preferencias();


  Map<String, dynamic> flight;  // el vuelo a matchear
  Map<String, dynamic> ad;  // el ad a matchear
  BuildContext c ;  // el ad a matchear

  ModalConfirmSubmitRequestAd({@required this.flight, @required this.ad, @required this.c});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return BounceInDown(
      // animate: true,
      // from: 200,
      // delay: Duration(milliseconds: 500),
      child: Column(
        children: [
          Container(
            height: height * 0.5,
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
                iconFace1(context),
                SizedBox(height: height * 0.02,),
                Container(
                  child: Center(
                    child: Text(generalText.confirmSubmirRequestFlight(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.05)),
                  )),
              SizedBox(height: height * 0.05,),
               RaisedButton(
                child: Container(
                  width: width * 0.4,
                  child: Text(generalText.submit(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                           color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.05)),
                ),
                color: Color.fromRGBO(255, 206, 6, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black, width: 1)),
                onPressed: () {
                  blocGeneral.changeSendRequest(false);
                   _submitRequest(context, flight, ad);
                }),
              SizedBox(height: height * 0.01,),
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
        ],
      ),
    );
  }


  // ***************************
    _submitRequest(BuildContext context,  Map<String, dynamic> flight, Map<String, dynamic> ad){
       showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      _http.createMatchSendFromFlight(
        context: context, 
        email: preference.prefsInternal.get('email'),
        emailAd: ad["user"]["email"],
        emailFlight: flight["user"]["email"],
        idFlight: flight["_id"],
        idAd: ad["_id"]
      ).then((value){

         showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
        final valueMap = json.decode(value);
        blocGeneral.changeSendRequest(false);
        // print('LA RSPUESTA DEL MATCH  ${valueMap}');
        if(valueMap["ok"] == true){
           blocSocket.socket.getUserEmiter(valueMap["matchCreado"]["ad"]["user"]["email"]);   // emitimos un evento socket para el email del anuncio
           Navigator.pop(c);
           showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]);})
           .then((_){
                Navigator.pushReplacementNamed(c, 'principal', arguments: jsonEncode({"shipments": false, "service": true}));
              });
        }else{
          Navigator.pop(c);
          showDialog(context: c, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);})
          .then((_){
                Navigator.pushReplacementNamed(c, 'principal', arguments: jsonEncode({"shipments": false, "service": true}));
              });
        }
      });

  }

}
