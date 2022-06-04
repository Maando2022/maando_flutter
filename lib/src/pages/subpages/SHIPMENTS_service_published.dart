// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_header.dart';
import 'package:maando/src/widgets/boton_state_ad.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';


class SHIPMENTS_service_published extends StatefulWidget {
  final dynamic adPublished;
  SHIPMENTS_service_published({@required this.adPublished});

  @override
  _SHIPMENTS_service_publishedState createState() => _SHIPMENTS_service_publishedState();
}

class _SHIPMENTS_service_publishedState extends State<SHIPMENTS_service_published> {

  Http _http = Http();

  bool published = true;

  bool intransit = false;
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

 

    return Container(
      child: Column(
        children: [
          CardAd(
              ad: widget.adPublished, 
              viewImages: true, 
              allImages: true, 
              viewButtonOption: true,
              viewCountryCity: true,
              viewDate: true,
              viewRatings: false,
              viewPrice: false,
              code: true,
              botonTitle: BotonStateAd(entity: widget.adPublished),
              actionSheet: (){
                 return  ActionSheetHeaderAd(context: context, ad: widget.adPublished, listActions: _listaAcciones(context)).sheetHeader();
              }),
           SizedBox(height: height * 0.01),
                      
        ],
      )
    );
  }

  List<ActionSheetAction> _listaAcciones(BuildContext context){
    final preference = Preferencias();

      return [
        ActionSheetAction(
            text: generalText.searchMatches(),
            defaultAction: true,
            onPressed: (){
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http.searchMatchesToAd(
                context: context, 
                email: preference.prefsInternal.get('email'),
                departureDate: widget.adPublished["departureDate"],
                arrivalDate: widget.adPublished["arrivalDate"],
                cityDeparture: widget.adPublished["cityDeparture"],
                city: widget.adPublished["city"]
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
                    blocGeneral.changeArrayFlightSearch(valueMap['flightDB']);
                    blocGeneral.changeAd(widget.adPublished);
                    Navigator.pushNamed(context, 'list_flights', arguments: jsonEncode(widget.adPublished));
                  }
                });
            },
            hasArrow: true,
          ),
          ActionSheetAction(
              text: generalText.deleteAd(),
              defaultAction: true,
              onPressed: (){
              Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().deleteAd(context: context, email: preference.prefsInternal.get('email'), id: widget.adPublished["_id"])
                .then((value){
                  var valueMap = json.decode(value);
                  Navigator.pop(context);
                  if(valueMap["ok"] == true){
                  // traigo mis anuncios para sacar los publicados y actualizar el bloc
                   Http().verMisAnuncios(context: context, email: preference.prefsInternal.get('email')).then((myAds){
                     List<Map<String, dynamic>> adsPublished = [];
                      blocGeneral.changeListMyAds(myAds["adsBD"]);
                   });
                  }else{
                    Navigator.pop(context);
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); });
                  }
                });
              },
              hasArrow: true,
            ),
      ];
  }
}

