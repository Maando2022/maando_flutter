// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/shipment_service_bloc.dart';
import 'package:maando/src/pages/subpages/SHIPMENTS_service_intransit.dart';
import 'package:maando/src/pages/subpages/SHIPMENTS_service_published.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/subpages_text.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class SHIPMENTS_service extends StatefulWidget {
  const SHIPMENTS_service({Key key}) : super(key: key);

  @override
  _SHIPMENTS_serviceState createState() => _SHIPMENTS_serviceState();
}

class _SHIPMENTS_serviceState extends State<SHIPMENTS_service> {
  String email = '';
  bool published = true;
  bool intransit = false;
  final preference = Preferencias();
  final blocShipmentService = blocShipmetService;
  List<dynamic> adsPublished = [];
  List<dynamic> adsInTransit = [];
  List<SHIPMENTS_service_published> adsWidgewtPublished = [];
  List<SHIPMENTS_service_InTransit> adsWidgewtInTransit = [];

  @override
  void initState() {
    email = preference.prefsInternal.get('email');
    Future.delayed(const Duration(milliseconds: 100), () {
      preference.prefsInternal.setString('published_intransit', 'published');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    blocShipmentService.changeShipmentPublishedIntransit([true, false]);
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return StreamBuilder(
        stream: blocGeneral.arrayMyAdsStream,
        builder: (context, snapshotMyAds) {
          adsWidgewtPublished = [];
          adsWidgewtInTransit = [];

          if (snapshotMyAds.hasData) {

            for(var miAd in snapshotMyAds.data){
              if(miAd['state'] == 'publish' || miAd["state"] == 'accepted'){
                adsWidgewtPublished.add(SHIPMENTS_service_published(adPublished: miAd));
              }else if(miAd['state'] == 'inTransit'){
                adsWidgewtInTransit.add(SHIPMENTS_service_InTransit(ad: miAd));
              }else{}
            }


            if (adsWidgewtPublished.length <= 0 && adsWidgewtInTransit.length <= 0) {
              return _shipmentSinDatos();

            } else {
              return _publishedAndInTransit();
            }
          } else if (snapshotMyAds.hasError) {
           return Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(generalText.errorSystemTryEnterngAgain(),
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
          } else {
            return Container(
              margin: EdgeInsets.only(top: 100.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  // ******************************************
  Widget _publishedAndInTransit() {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025),
        child: StreamBuilder(
            stream: blocShipmentService.shipmentPublishedIntransitStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: <Widget>[
                    _tabPublishedInTransit(),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.04,
                    ),
                    (snapshot.data[0] == true)
                        ? _shipmentPublised()
                        : _shipmentIntransit()
                  ],
                );
              } else if (snapshot.hasError) {
                return Container(
                  child: Center(
                    child: Text(
                      generalText.errorSystemTryEnterngAgain(),
                      style: TextStyle(
                          fontSize:MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(230, 232, 235, 1)),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }));
  }
  // ******************************************

  Widget _tabPublishedInTransit() {
    return Row(
      children: <Widget>[
        _published(),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.015,
        ),
        _intransit()
      ],
    );
  }

  // ****************************************

  Widget _shipmentPublised() {
    return (adsWidgewtPublished.length <= 0)
        ? _shipmentSinDatos()
        : _shipmentPublish();
  }

  // *************************

  Widget _shipmentPublish() {
    return Container(
        child: Column(
      children: <Widget>[
        Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Column(
                    children: adsWidgewtPublished,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                ],
              ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.08,
        ),
      ],
    ));
  }
  // *************************

  Widget _shipmentIntransit() {
    return Container(
        child: Column(
      children: <Widget>[
        (adsWidgewtInTransit.length > 0)
            ? Column(
                children: <Widget>[
                  Column(
                    children: adsWidgewtInTransit,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.1),
                ],
              )
            : _shipmentSinDatos(),
        SizedBox(
          height: 80.0,
        ),
      ],
    ));
  }
  // *************************

  Widget _published() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
     final Responsive responsive = Responsive.of(context);
    return StreamBuilder<List<bool>>(
        stream: blocShipmentService.shipmentPublishedIntransitStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: height * 0.055,
              width: width * 0.25,
              child: CupertinoButton(
                  child: Text(subPagesText.published(),
                      style: TextStyle(
                          color: snapshot.data[0]
                              ? Color.fromRGBO(0, 0, 0, 1.0)
                              : Color.fromRGBO(33, 36, 41, 0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(1.5))),
                  color: snapshot.data[0]
                      ? Color.fromRGBO(255, 206, 6, 1.0)
                      : Color.fromRGBO(234, 234, 234, 0.5),
                  borderRadius: BorderRadius.circular(14),
                  padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.015),
                  onPressed: () {
                    blocShipmentService
                        .changeShipmentPublishedIntransit([true, false]);
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

// ******************************************

  Widget _intransit() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    return StreamBuilder<List<bool>>(
        stream: blocShipmentService.shipmentPublishedIntransitStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Container(
              height: height * 0.055,
              width: width * 0.25,
              child: CupertinoButton(
                  child: Text(subPagesText.inTransit(),
                      style: TextStyle(
                          color: snapshot.data[1]
                              ? Color.fromRGBO(0, 0, 0, 1.0)
                              : Color.fromRGBO(33, 36, 41, 0.5),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(1.5))),
                  color: snapshot.data[1]
                      ? Color.fromRGBO(255, 206, 6, 1.0)
                      : Color.fromRGBO(234, 234, 234, 0.5),
                  borderRadius:
              BorderRadius.circular(14),
                  padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width * 0.015),
                  onPressed: () {
                    blocShipmentService
                        .changeShipmentPublishedIntransit([false, true]);
                  }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  // ****************************************
  Widget _shipmentSinDatos() {
    final Responsive  responsive = Responsive.of(context);
    return GestureDetector(
      onTap: (){
         showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
               Http().findUserForEmail(email: preference.prefsInternal.getString('email'))
                  .then((user){
                    Navigator.pop(context);
                    final userMap = json.decode(user);
                    if(userMap["ok"] == true){
                      if(userMap["user"]["phone"]==null || userMap["user"]["phone"]==''){
                        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.updateYourProfile());});
                      }else{
                        Navigator.pushNamed(context, 'create_ad_title_date_destination');
                      }
                    }else{
                      
                    }
                });
      },
      child: Container(
          height: MediaQuery.of(context).size.height * 0.73,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.04),
          child: StreamBuilder(
              stream: blocShipmentService.shipmentPublishedIntransitStream,
              builder: (context, snapshot) {
                return Column(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.38,
                      padding: EdgeInsetsDirectional.only(top: 0.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/images/general/shipments 1@3x.png'),
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.028,
                    ),
                    Container(
                      child: Text(
                        subPagesText.shippingPackageSoon(),
                        style: TextStyle(
                            fontSize: responsive.ip(3),
                            fontWeight: FontWeight.w400,
                            color: Color.fromRGBO(173, 181, 189, 1)),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Column(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(subPagesText.createYourFist1(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(33, 36, 41, 1.0),
                                        fontSize:  responsive.ip(1.8))),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(subPagesText.createYourFist2(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(33, 36, 41, 1.0),
                                        fontSize:   responsive.ip(1.8))),
                                Container(
                                  alignment: Alignment.center,
                                  width: responsive.ip(1.7),
                                  height: responsive.ip(1.7),
                                  decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: Color.fromRGBO(255, 206, 6, 1),
                                        image: DecorationImage(
                                          image: AssetImage('assets/images/general/floating button@3x.png'),
                                          fit: BoxFit.contain,
                                        )),
                                ),
                                Text(subPagesText.createYourFist3(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Color.fromRGBO(33, 36, 41, 1.0),
                                        fontSize:  responsive.ip(1.8))),
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.08),
                      ],
                    )
                  ],
                );
              })),
    );
  }
}
