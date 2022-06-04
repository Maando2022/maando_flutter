import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_header.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';

class UnapprovePpackages extends StatefulWidget {
  @override
  State<UnapprovePpackages> createState() => _UnapprovePpackagesState();
}

class _UnapprovePpackagesState extends State<UnapprovePpackages> {
  List<dynamic> listaTargetas = [];
   ScrollController _scrollController = ScrollController();
   int contPackages = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Http().adsNotApproved(context: context, cont: contPackages).then((packages) {
      final valueMap = json.decode(packages);
      if (valueMap['ok'] == false) {
        blocGeneral.changePackagesNotApproved(blocGeneral.packagesNotApprved);
      } else {
        blocGeneral.changePackagesNotApproved(valueMap["adsBD"]);
      }
    });


    //===== SCROLL PARA LOS PAQUETES
    _scrollController
      ..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 100), () {
          blocGeneral.changeViewNavBar(true);
        });

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta abajo
          contPackages = contPackages + 20;
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
          Http().adsNotApproved(context: context, cont: contPackages).then((packages) {
            Navigator.pop(context);
            final valueMap = json.decode(packages);
            if (valueMap['ok'] == false) {
              blocGeneral.changePackagesNotApproved(blocGeneral.packagesNotApprved);
            } else {
              blocGeneral.changePackagesNotApproved(valueMap["adsBD"]);
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
                      if(snapshotConutriesOrigin.data!.length <= 0){
                        return Container();
                      }else{
                   return StreamBuilder<dynamic>(
                    stream: blocGeneral.packagesNotApprovedStream,
                    builder: (BuildContext context, snapshot) {
                      if (snapshot.hasError) {
                        return Container(
                          child: Center(
                            child: Text(
                              'Error loading data',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        );
                      } else if (snapshot.hasData) {
                        final valueMap = snapshot.data;
                        List<Widget> listaCardWidget = [];

                        listaTargetas = valueMap;

                        for (var card in valueMap) {
                            listaCardWidget.add(Container(
                              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                              child: CardAd(
                                  ad: card,
                                  viewImages: true,
                                  allImages: true,
                                  viewButtonOption: true,
                                  viewCountryCity: true,
                                  viewDate: true,
                                  viewRatings: false,
                                  viewPrice: false,
                                  code: false,
                                  botonTitle: BotonTitle(title: card["title"]),
                                  actionSheet: () {
                                    ActionSheetHeaderAd(
                                            context: context,
                                            ad: card,
                                            listActions:
                                                _listaAccionesAd(
                                                    context, card))
                                        .sheetHeader();
                                  }
                                  ),
                            ));
                        }

                        if (listaCardWidget.length <= 0) {
                          return Center(
                            child: Container(
                              margin: EdgeInsets.only(top: height * 0.2),
                              child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Text(generalText.weWillGetItThereFast(),
                                  textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(0, 0, 0, 1.0),
                                          fontSize: responsive.ip(3))),
                                ],
                              ),
                            ),
                          );
                        } else {
                          return Container(
                            height: responsive.ip(67),
                            child: SingleChildScrollView(
                              controller: _scrollController,
                              child: Column(
                                children: listaCardWidget,
                              ),
                            ),
                          );
                        }
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: height * 0.2),
                          child: Center(
                              child: CircularProgressIndicator()),
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


   // *************************
  List<ActionSheetAction> _listaAccionesAd(BuildContext context, ad) {
    return [
        ActionSheetAction(
          text: generalText.seeDetail(),
          defaultAction: true,
          onPressed: () {
            Navigator.pushNamed(context, 'ad_detail', arguments: json.encode(ad));
          },
          hasArrow: true,
        ),
        ActionSheetAction(
          text: generalText.approveRequest(),
          defaultAction: true,
          onPressed: () {
            Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().approveAd(context: context, id: ad["_id"])
                .then((value){
                  // print('RESPUESTA DEL SERVIDOR >>>>>> ${value}');
                  var valueMap = json.decode(value);
                  if(valueMap["ok"] == true){
                  Http().notificationOneToken(context: context, email: ad["user"]["email"], title: 'Maando Notifications', body: generalText.yourShippingRequestHasBeenApproved(title: ad["title"]), data: {'datos': 'Aqui van los datos'});
                  Navigator.pop(context);
                   Http().adsNotApproved(context: context, cont: contPackages).then((packages) {
                      final valueMapPackages = json.decode(packages);
                      if (valueMapPackages['ok'] == true) {
                        blocGeneral.changePackagesNotApproved(valueMapPackages["adsBD"]);
                      } else {
                        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
                      }
                    });
                  }else{
                    Navigator.pop(context);
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); });
                  }
                });
          },
          hasArrow: true,
        ),
        ActionSheetAction(
          text: generalText.deleteAd(),
          defaultAction: true,
          onPressed: () {
            Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().deleteAd(context: context, email: preference.prefsInternal.get('email') as String, id: ad["_id"])
                .then((value){
                  var valueMap = json.decode(value);
                  if(valueMap["ok"] == true){
                    print('FUE ELIMINADO >>>>>>>>>>>>>>>>>>>>>>>>>>');
                   Http().notificationOneToken(context: context, email: ad["user"]["email"], title: 'Maando Notifications', body: generalText.yourShippingRequestHasNotBeenApproved(title: ad["title"]), data: {'datos': 'Aqui van los datos'});
                   Navigator.pop(context);
                   Http().adsNotApproved(context: context, cont: contPackages).then((packages) {
                      final valueMapPackages = json.decode(packages);
                      if (valueMapPackages['ok'] == true) {
                        blocGeneral.changePackagesNotApproved(valueMapPackages["adsBD"]);
                      } else {

                      }
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