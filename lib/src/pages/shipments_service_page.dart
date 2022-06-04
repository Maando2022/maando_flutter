// @dart=2.9
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/shipment_service_bloc.dart';
import 'package:maando/src/pages/subpages/SHIPMENTS_service.dart';
import 'package:maando/src/pages/subpages/shipments_SERVICES.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/subpages_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/loading/success_with_title.dart';


class ShipmentsServivesPage extends StatefulWidget {
  // const ShipmentsPage({Key key}) : super(key: key);

  bool shipments;
  bool service;

  ShipmentsServivesPage({@required this.shipments, @required this.service});
  @override
  _ShipmentsServivesPageState createState() => _ShipmentsServivesPageState();
}

class _ShipmentsServivesPageState extends State<ShipmentsServivesPage> {
  final preference = Preferencias();
  final blocShipmentService = blocShipmetService;
  ScrollController _scrollController = ScrollController();

  String nombre = '';
  String urlAvatar = '';

  Http _http = Http();


 @override
   void initState() {
     // TODO: implement initState
     super.initState();
         _scrollController..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 100), (){
          blocGeneral.changeViewNavBar(true);
        });
    });
   }


  @override
  Widget build(BuildContext context) {
    blocShipmentService
        .changeShipmentService([widget.shipments, widget.service]);

    preference.obtenerPreferencias();

    nombre = preference.prefsInternal.get('fullName');
    urlAvatar = preference.prefsInternal.get('urlAvatar');
    // nombre = preference.prefsInternal.get('fullName');

// extraemos el primer nombre si lo tiene
    if (preference.prefsInternal.get('fullName').toString().contains(' ') == true) {
      nombre = preference.prefsInternal.get('fullName').toString().split(' ')[0];
    } else {
      nombre = preference.prefsInternal.get('fullName');
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);
    return Stack(
      children: <Widget>[
        _scafol1(height, width, responsive),
          Positioned(bottom: height * 0.13, right: variableGlobal.margenPageWith(context),
            child: boton_plus_square_shipment_servise(context, () {
              if(blocShipmentService.shipmentService[0]){
                 showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
               _http.findUserForEmail(email: preference.prefsInternal.getString('email'))
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
              }else{
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
               _http.findUserForEmail(email: preference.prefsInternal.getString('email'))
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
              }
            }),
          ),
      ],
    );
  }

// **********************************  NORMAL
  Widget _scafol1(double height, double width, Responsive responsive) {
    return Stack(
      children: [
        Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
              controller: _scrollController,
                child: Stack(
              children: <Widget>[
                Stack(children: <Widget>[
                  StreamBuilder(
                      stream: blocShipmentService.shipmentServiceStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Column(
                              children: <Widget>[
                                SizedBox(height: height * 0.13),
                                Container(
                                  width: width,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      _shipments(context, responsive),
                                      SizedBox(
                                        width: width * 0.07,
                                      ),
                                      _services(context, responsive)
                                    ],
                                  ),
                                ),
                                SizedBox(height: height * 0.025),
                                snapshot.data[0]
                                    ? SHIPMENTS_service()
                                    : ShipmetsSERVICE(),
                              ]);
                        } else {
                          return Container();
                        }
                      }),
                ]),
              ],
            ))),
      ],
    );
  }

  Widget _shipments(BuildContext context, Responsive responsive) {
    return Container(
      margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              child: StreamBuilder(
                  stream: blocShipmentService.shipmentServiceStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Text(subPagesText.sending(),
                          style: TextStyle(
                              color: snapshot.data[0]
                                  ? Color.fromRGBO(0, 0, 0, 1.0)
                                  : Color.fromRGBO(230, 232, 235, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(3.5)));
                    } else {
                      return Container();
                    }
                  }),
              onTap: () {
                blocNavigator.shipmentPrincipal();
                blocShipmentService.changeShipmentService([true, false]);
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
               margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
              child: _mostrarLineYellow(
                  blocShipmentService.shipmentService[0], context))
        ],
      ),
    );
  }

  Widget _services(BuildContext context,Responsive responsive) {
    return Container(
      margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          StreamBuilder(
              stream: blocShipmentService.shipmentServiceStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GestureDetector(
                      child: Text(subPagesText.taking(),
                          style: TextStyle(
                              color: snapshot.data[1]
                                  ? Color.fromRGBO(0, 0, 0, 1.0)
                                  : Color.fromRGBO(230, 232, 235, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: responsive.ip(3.5))),
                      onTap: () {
                        blocNavigator.servicePrincipal();
                        blocShipmentService
                            .changeShipmentService([false, true]);
                      });
                } else {
                  return Container();
                }
              }),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
          ),
          Container(
              margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.05),
              child: _mostrarLineYellow(
                  blocShipmentService.shipmentService[1], context))
        ],
      ),
    );
  }

  Widget _mostrarLineYellow(bool mostrar, BuildContext context) {
    if (mostrar) {
      return Container(
          margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
          child: lineYellowShipmentSevice(context));
    } else {
      return Container();
    }
  }
}
