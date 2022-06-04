// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/ranking_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/logout.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/reviews_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_header.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class History extends StatefulWidget {

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  Http _http = Http();
  int cont = 5;
  ScrollController _scrollController = ScrollController();
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = preference.prefsInternal.get('email');
    blocRanking.streamNull();

     _scrollController
      ..addListener(() {
        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >= _scrollController.position.maxScrollExtent && 
          !_scrollController.position.outOfRange) { 
            // cuando llega hasta abajo
            cont = cont + 5;
             _http.history(email: email, cont: cont).then((home){
                  final valueMap = json.decode(home);
                  if (valueMap['ok'] == false) {
                      if(valueMap["authorized"] == false){
                          logout();
                          Timer(Duration(milliseconds: 100), () {
                            Navigator.pushReplacementNamed(
                                context, 'login');
                          });
                      }
                      // blocGeneral.changeHome(blocGeneral.home);
                    }else{
                      setState(() {});
                    }
                });
        }
         if (_scrollController.offset <= _scrollController.position.minScrollExtent && 
            !_scrollController.position.outOfRange) { 
                // cuando llega hasta arriba
         }  
      });
    
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'history');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Stack(
      children: <Widget>[
        Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
              margin: EdgeInsets.only(
                  top: variableGlobal.margenTopGeneral(context)),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        child: Column(children: <Widget>[
                      _encabezado(responsive, height, width),
                      SizedBox(
                         height: height * 0.01,
                      ),
                      _listHistory(context, responsive, height, width)
                    ])),
                  ]),
            ))),
      ],
    );
  }

  // *****************************
  // *****************************

  Widget _listHistory(BuildContext context, Responsive responsive, double height, double width){

    return FutureBuilder(
        future: _http.history(context: context, email: email, cont: cont),
        builder: (BuildContext, snapshot) {

          if(snapshot.hasData){
            var valueMap = json.decode(snapshot.data);

            if(valueMap["ok"]){

              if(valueMap["count"] <= 0){
                  return Center(
                          child: Container(
                            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
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
                                        fontSize: responsive.ip(3))),
                              ],
                            ),
                          ),
                        );
              }else{
                List<Widget> listaCardWidget = [];
                for (var match in valueMap["arrayMatch"]) {


                   listaCardWidget
                        .add(CardAd(
                          ad: match["ad"], 
                          viewImages: true, 
                          allImages: false, 
                          viewButtonOption: true,
                          viewCountryCity: true,
                          viewDate: true,
                          viewRatings: false,
                          viewPrice: false,
                          code: false,
                          botonTitle: BotonTitle(title: match["ad"]["title"]),
                          actionSheet: () {
                            ActionSheetHeaderAd(
                                    context: context,
                                    ad: match["ad"],
                                    listActions:
                                        _listaAccionesAd(
                                            context, match))
                                .sheetHeader();
                          }));

                }

                 return Container(
                    margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                      child: Container(
                        margin: EdgeInsets.only(bottom: variableGlobal.margenTopGeneral(context)),
                        child: Column(
                          children: listaCardWidget
                          )),
                  );
              }
  
            }else{
               return Container(
                      child: Center(child: Text('Error'),),
                  );
            }

          }if(snapshot.hasError){
             return Container(
                      child: Center(child: Text('Error'),),
                  );
          }else{
            return Container(
              margin: EdgeInsets.only(top: height * 0.3),
              child: Center(child: CircularProgressIndicator()),
            );
          }
                      });
  }
  
  // *****************************
  // *****************************

  Widget _encabezado(Responsive responsive, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: variableGlobal.margenPageWith(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: arrwBackYellowsignOut(context, (){Navigator.pushReplacementNamed(context, 'principal');})),
              SizedBox(
                width: width * 0.05,
              ),
              iconFace1(context),
              Container(
                width: width * 0.26,
              )
            ],
          ),
          SizedBox(
            height: height * 0.02,
          ),
                    Text(generalText.servicesHistory(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(3.5))),
        ],
      ),
    );
  }

List<ActionSheetAction> _listaAccionesAd(BuildContext context, match) {
    // _pr = new ProgressDialog(context);
    // final preference = Preferencias();

    return [
      ActionSheetAction(
        text: reviewText.rateAndReview(),
        defaultAction: true,
        onPressed: () {
          Navigator.pushNamed(context, 'add_rate_review', arguments: json.encode(match));
        },
        hasArrow: true,
      ),
    ];
  }



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocGeneral.changeSendRequest(false);
    // blocGeneral.changeArrayFlightSearch([]);
    blocGeneral.changeAd(null);
  }
}
