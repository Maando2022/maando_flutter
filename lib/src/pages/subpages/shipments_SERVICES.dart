// @dart=2.9
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/shipment_service_bloc.dart';
import 'package:maando/src/pages/subpages/shipment_SERVICE_intransit.dart';
import 'package:maando/src/pages/subpages/shipment_SERVICE_published.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/subpages_text.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/loading/success_with_title.dart';

class ShipmetsSERVICE extends StatefulWidget {

  @override
  _ShipmetsSERVICEState createState() => _ShipmetsSERVICEState();
}

class _ShipmetsSERVICEState extends State<ShipmetsSERVICE> {
  bool published = true;
  bool intransit = false;
  final preference = Preferencias();
  String published_intransit;
  // List<dynamic> flightsPublished = [];
  // List<dynamic> flightsInTransit = [];
  final blocShipmentService = blocShipmetService;
  List<Widget> flightsWidgewtPublished = [];
  List<Widget>  flightsWidgewtInTransit = [];
  String email = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = preference.prefsInternal.get('email');
    preference.obtenerPreferencias();
    published_intransit =
        preference.prefsInternal.getString('published_intransit');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    blocShipmentService.changeSesrvicePublishedIntransit([true, false]);
    

    return StreamBuilder(
      stream: blocGeneral.arrayMyFlightsStream,
      builder: (BuildContext context, snapshotMyFlight) {
        flightsWidgewtPublished = [];
        flightsWidgewtInTransit = [];

        if (snapshotMyFlight.hasData) {

            for(var miFlighy in snapshotMyFlight.data){
              if(miFlighy['state'] == 'publish' || miFlighy["state"] == 'accepted'){
                flightsWidgewtPublished.add(Shipment_SERVICE_published(flight: miFlighy));
              }else if(miFlighy['state'] == 'inTransit'){
                flightsWidgewtInTransit.add(Shipment_SERVICE_intransit(flight: miFlighy));
              }else{}
            }

          if (flightsWidgewtPublished.length <= 0 && flightsWidgewtInTransit.length <= 0) {
            return _serviseSinDatos(context);
          } else {
            return _publishedAndInTransit(context);
          }
        } else if (snapshotMyFlight.hasError) {
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
            height: MediaQuery.of(context).size.height * 0.15,
            margin: EdgeInsets.only(top: 120.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }
      },
    );
  }

  Widget _publishedAndInTransit(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.025),
      child: Column(
        children: <Widget>[
          StreamBuilder(
              stream: blocShipmentService.servicetPublishedIntransitStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      _tabPublishedInTransit(),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      (snapshot.data[0] == true)
                          ? _servicePublised(context)
                          : _serviceInTransited(context)
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return Container();
                }
              }),
        ],
      ),
    );
  }

  // **********************************

  Widget _published() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    return Container(
      height: height * 0.055,
      width: width * 0.25,
      child: CupertinoButton(
          child: Text(subPagesText.published(),
              style: TextStyle(
                  color: blocShipmentService.servicePublishedIntransit[0]
                      ? Color.fromRGBO(0, 0, 0, 1.0)
                      : Color.fromRGBO(33, 36, 41, 0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(1.5))),
          color: blocShipmentService.servicePublishedIntransit[0]
              ? Color.fromRGBO(255, 206, 6, 1.0)
              : Color.fromRGBO(234, 234, 234, 0.5),
         borderRadius:
              BorderRadius.circular(14),
          padding: EdgeInsets.symmetric(horizontal: 0.015),
          onPressed: () {
            blocShipmentService.changeSesrvicePublishedIntransit([true, false]);
          }),
    );
  }

  Widget _intransit() {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    return Container(
      height: height * 0.055,
      width: width * 0.25,
      child: CupertinoButton(
          child: Text(subPagesText.inTransit(),
              style: TextStyle(
                  color: blocShipmentService.servicePublishedIntransit[1]
                      ? Color.fromRGBO(0, 0, 0, 1.0)
                      : Color.fromRGBO(33, 36, 41, 0.5),
                  fontWeight: FontWeight.bold,
                  fontSize: responsive.ip(1.5))),
          color: blocShipmentService.servicePublishedIntransit[1]
              ? Color.fromRGBO(255, 206, 6, 1.0)
              : Color.fromRGBO(234, 234, 234, 0.5),
          borderRadius:
              BorderRadius.circular(14),
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.015),
          onPressed: () {
            blocShipmentService.changeSesrvicePublishedIntransit([false, true]);
          }),
    );
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
  Widget _servicePublised(BuildContext context) {
    return (flightsWidgewtPublished.length <= 0)
        ? _serviseSinDatos(context)
        : _servicePublish(context);
  }

  // *************************
  Widget _servicePublish(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Column(
                        children: flightsWidgewtPublished,
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.025),
                    ],
                  ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.08,
            ),
          ],
        ));
  }

  // ****************************************
  Widget _serviceInTransited(BuildContext context) {
    return (flightsWidgewtInTransit.length <= 0)
        ? _serviseSinDatos(context)
        : _serviceIntransit(context);
  }

  // *************************
  Widget _serviceIntransit(BuildContext context) {
   return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Column(
                children: (flightsWidgewtInTransit.length > 0) 
                ? flightsWidgewtInTransit
                : _serviseSinDatos(context),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025),
            ],
          );
  }

  // *********************

  Widget _serviseSinDatos(BuildContext context) {
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
                        Navigator.pushNamed(context, 'create_flight_form');
                          // if(userMap["user"]['pay'] == null){
                          //   showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.checketYourPaymentMethods());});
                          // }else{
                          //   // showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccessWithTitle(context, 'Método de cobro', userMap["user"]['pay']['name'].toString().toUpperCase());})
                          //   // .then((_){
                          //   //     Navigator.pushNamed(context, 'create_flight_form');
                          //   //   });
                          //   Navigator.pushNamed(context, 'create_flight_form');
                          // }
                      }
                    }else{
                      
                    }
                });
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.73,
        margin: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.02),
        child: Column(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.016),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
                      height: MediaQuery.of(context).size.height * 0.38,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/general/services.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.016),
            Text(subPagesText.travelingSoon(),
                style: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1.0),
                    fontSize: responsive.ip(3),
                    fontWeight: FontWeight.w400,)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(subPagesText.publisYourFlight1(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontSize: responsive.ip(1.8))),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(subPagesText.publisYourFlight2(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontSize: responsive.ip(1.8))),
                        Container(
                          alignment: Alignment.center,
                          width: responsive.ip(1.7),
                          height: responsive.ip(1.7),
                          decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: Color.fromRGBO(255, 206, 6, 1),
                          image: DecorationImage(
                            image: AssetImage('assets/images/general/floating button@3x.png'),
                            fit: BoxFit.contain,
                          )),
                        ),
                        Text(subPagesText.publishYourFlight3(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontSize: responsive.ip(1.8))),
                      ],
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.08),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
