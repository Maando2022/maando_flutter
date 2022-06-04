// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';

class BotonStateFlight extends StatefulWidget {
  final Map<String, dynamic> entity;
  BotonStateFlight({@required this.entity});

  @override
  _BotonStateFlightState createState() => _BotonStateFlightState();
}

class _BotonStateFlightState extends State<BotonStateFlight> {
  Http _http = Http();
  Timer cronometroFuture;
  bool colorPreAceptado = false;


  @override
  void initState() {
    super.initState();
    colorPreaceptadoF();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return FutureBuilder(
        future: _http.findMatchSendFlight(context: context, email: preference.prefsInternal.get('email'),id: widget.entity["_id"]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final valueData = json.decode(snapshot.data);
            // print('El estado del anuncio ${valueData}');
            
            if(valueData["ok"] == true){
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          onPressed:() => (valueData["count"] <= 0) ? null : _seePengingAd(valueData["matchDB"], widget.entity),
                          padding: EdgeInsets.all(0),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: width * 0.035,),
                            padding: EdgeInsets.all(width * 0.005),
                            height: height * 0.063,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                              color: colorBoton(valueData["count"]),
                            borderRadius: BorderRadius.circular(14.0)
                            ),
                            child: Center(child: Text(generalText.numberRequestPending(valueData["count"]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.03))),
                          ),
                        ),
                      ],
                    );
            }else{
              return Container();
            }
          }else if(snapshot.hasError){
             return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoButton(
                    onPressed: null,
                    padding: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.all(width * 0.005),
                      margin: EdgeInsets.symmetric(horizontal: width * 0.035,),
                      height: height * 0.063,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 206, 6, 1),
                      borderRadius: BorderRadius.circular(14.0)
                      ),
                      child: Center(child: Text(generalText.errorLoadingState(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: variableGlobal.tamanoLabecardAd(context)))),
                    ),
                  ),
                ],
              );
          }else{
            return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CupertinoButton(
                    onPressed: null,
                    padding: EdgeInsets.all(0),
                    child: Container(
                      padding: EdgeInsets.all(width * 0.005),
                      margin: EdgeInsets.symmetric(horizontal: width * 0.035,),
                      height: height * 0.063,
                      width: width * 0.3,
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(173, 181, 189, 1),
                      borderRadius: BorderRadius.circular(14.0)
                      ),
                      child: Center(child: Text(generalText.loadingStatus(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: variableGlobal.tamanoLabecardAd(context)))),
                    ),
                  ),
                ],
              );
          }


        });

  }


  colorPreaceptadoF() async {
    cronometroFuture = new Timer.periodic(Duration(milliseconds: 500), (Timer timer) {
      colorPreAceptado = !colorPreAceptado;
        setState(() {
        });
    });
  }

  Color colorBoton(int numero){
    if(numero <= 0){
      colorPreAceptado = false;
      cronometroFuture.cancel();
      return Color.fromRGBO(173, 181, 189, 1);
    }else{
      if(colorPreAceptado == true){
        return Color.fromRGBO(45, 222, 152, 1);
      }else{
        return Color.fromRGBO(251, 251, 251, 1);
      }
    }
  }




_seePengingAd(List<dynamic> adPending, entity){
  blocGeneral.changeFlight(entity);
  Navigator.pushNamed(context, 'list_ad_pending', arguments: json.encode(adPending));
}

 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cronometroFuture.cancel();
  }

}

