// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/logout.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/WebViewStore.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_header.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/card_flight.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/gestiona_tus_notificaciones.dart';
import 'package:maando/src/widgets/loading/popup/chat_de_colaboracion.dart';
import 'package:maando/src/widgets/loading/popup/crea_tu_anuncio.dart';
import 'package:maando/src/widgets/loading/popup/publica_tu_vuelo.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final preference = Preferencias();
  ScrollController _scrollController = ScrollController();
  Http _http = Http();
  String nombre = '';
  String email = '';
  String urlAvatar = '';
  int contTrips = 20;
  int contPackages = 20;
  bool leerMas = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    email = preference.prefsInternal.get('email');
    // RECUPEREAMOS EL HOME Y LO GUARDAMOS EN UN BLOC
    _http.ads(context: context, cont: contPackages).then((packages) {
      final valueMap = json.decode(packages);
      if (valueMap['ok'] == false) {
        blocGeneral.changePackages(blocGeneral.packages);
      } else {
        blocGeneral.changePackages(valueMap["adsBD"]);
      }
    });
    _http.flights(context: context, cont: contTrips).then((trips) {
      final valueMap = json.decode(trips);
      if (valueMap['ok'] == false) {
        blocGeneral.changeTrips(blocGeneral.trips);
      } else {
        blocGeneral.changeTrips(valueMap["flightsBD"]);
      }
    });
    _http.getProductsAmazonAssociates().then((products) {
      blocGeneral.changeStore(products["products"]);
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
          _http.ads(context: context, cont: contPackages).then((packages) {
            Navigator.pop(context);
            final valueMap = json.decode(packages);
            if (valueMap['ok'] == false) {
              blocGeneral.changePackages(blocGeneral.packages);
            } else {
              blocGeneral.changePackages(valueMap["adsBD"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });

      //===== SCROLL PARA LOS VIAJES
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
          contTrips = contTrips + 20;
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
          _http.flights(context: context, cont: contTrips).then((trips) {
            Navigator.pop(context);
            final valueMap = json.decode(trips);
            if (valueMap['ok'] == false) {
              blocGeneral.changeTrips(blocGeneral.trips);
            } else {
              blocGeneral.changeTrips(valueMap["flightsBD"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });

      // LOS PRODUCTOS D ELA TIENDA


      // VALIDAMOS LA PLATAFORMA DE ANDROID Y MANDAMOS LA VENTANA MODAL AVISANDO AL USUARIO DE LOS PERMISOS DE GELOCALIZACION
      // if (Platform.isAndroid) {
      //   Future.delayed(Duration(seconds: 3), (){
      //     if(preference.obtenerModaLocationInTheBackground() == false || preference.obtenerModaLocationInTheBackground() == null){
      //       dialogPermissions.showPermissionLocationDialog(context, ''); 
      //     }
      //     preference.guardarModaLocationInTheBackground();

      //   });
      // }
      try{
        if(blocGeneral.homeStore == null){
          blocGeneral.changeHomeStore('trips');
        }else{
          blocGeneral.changeHomeStore(blocGeneral.homeStore);
        }
      }catch(e){
        blocGeneral.changeHomeStore('trips');
      }
  
      if(prefsInternal.prefsInternal.getString('popup') == null){
            Future.delayed(Duration(milliseconds: 100), () {
              showDialog(context: context, barrierColor: Colors.black.withOpacity(0.7), barrierDismissible: true, builder: (BuildContext context){ return popupCreaTuAnuncio(context, 'Este es un error del sevidor, servidor servidor servidos');}).
                  then((value){

                    showDialog(context: context, barrierColor: Colors.black.withOpacity(0.7), barrierDismissible: true, builder: (BuildContext context){ return popupPublicaTuVuelo(context, 'Este es un error del sevidor, servidor servidor servidos');}).
                      then((value){

                        showDialog(context: context, barrierColor: Colors.black.withOpacity(0.7), barrierDismissible: true, builder: (BuildContext context){ return popupChatDeColaboracion(context, 'Este es un error del sevidor, servidor servidor servidos');}).
                          then((value){
                            
                            showDialog(context: context, barrierColor: Colors.black.withOpacity(0.7), barrierDismissible: true, builder: (BuildContext context){ return popupGestionaTusNotificaciones(context, 'Este es un error del sevidor, servidor servidor servidos');}).
                              then((value){
                                preference.prefsInternal.setString('popup', 'popup');
                              });
                          });
                      });
                  });
        });
      }

  }

  @override
  Widget build(BuildContext context) {
    // listenExpires(context: context);
    final preference = Preferencias();
    urlAvatar = preference.prefsInternal.get('urlAvatar');
    // nombre = preference.prefsInternal.get('fullName');

// extraemos el primer nombre si lo tiene
    if (preference.prefsInternal.get('fullName').toString().contains(' ') == true) {
      nombre = preference.prefsInternal.get('fullName').toString()..split(' ')[0];
    } else {
      nombre = preference.prefsInternal.get('fullName');
    }
    List<dynamic> listaTargetas = [];
    preference.obtenerPreferencias();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);


  


    return WillPopScope(
      onWillPop: () async {blocGeneral.changeHomeStore('trips'); return false;},
      child: Stack(
        children: <Widget>[
          Scaffold(
              backgroundColor: Color.fromRGBO(251, 251, 251, 1),
              body: Container(
                height: double.infinity,
                child: SingleChildScrollView(
                    controller: _scrollController,
                    dragStartBehavior: DragStartBehavior.start,
                    clipBehavior: Clip.hardEdge,
                    child: Column(children: <Widget>[
                      StreamBuilder(
                        stream: blocGeneral.homeStoreStream,
                        builder: (_, AsyncSnapshot snapchot){
                          if(snapchot.hasData){
                            return _content(height, width, responsive, listaTargetas);
                          }else if(snapchot.hasError){
                            return Container();
                          }else{
                            return Container();
                          }
                        },
                      )
                    ])),
              )),
        ],
      ),
    );
  }



  // ****************
  // ****************
  Widget _content(double height, double width, Responsive responsive, List<dynamic> listaTargetas){
    if(blocGeneral.homeStore == 'trips'){
      return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.13),
                Container(
                  margin: EdgeInsets.only(
                      left: variableGlobal.margenPageWith(context)),
                  child: Row(   //   ----------- VIAJES
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              blocGeneral.changeHomeStore('trips');
                            },
                            child: Container(
                              child: Text(
                                generalText.trips(),
                                style: TextStyle(
                                  color: Colors.black,
                                    fontSize: responsive.ip(3.2),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                            child: lineYellowShipmentSevice(context)),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                blocGeneral.changeHomeStore('packages');
                              },
                              child: Container(
                                child: Text(
                                  generalText.packages(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(230, 232, 235, 1.0),
                                      fontSize: responsive.ip(3.2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                            padding: EdgeInsets.only(left: width * 0.05),
                            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)))
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     CupertinoButton(
                      //       minSize: 0,
                      //       padding: EdgeInsets.only(left: width * 0.05),
                      //       onPressed: (){
                      //           blocGeneral.changeHomeStore('store');
                      //       },
                      //       child: Container(
                      //         child: Text(
                      //           generalText.store(),
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(230, 232, 235, 1.0),
                      //               fontSize: responsive.ip(3.2),
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: height * 0.03,
                      //     ),
                      //     Container(
                      //       padding: EdgeInsets.only(left: width * 0.05),
                      //       margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)))
                      //   ],
                      // ),
                    ],
                  ),
                ),
                // ------------------------------------------------------------
                StreamBuilder<dynamic>(
                    stream: blocGeneral.tripsStream,
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
                          listaCardWidget.add(
                            GestureDetector(
                              onTap: (validateAdmin.isAdmin(preference.prefsInternal.get('email')) == true)
                              ? () {ActionSheetHeaderFlight(context: context, flight: card, listActions: _listaAccionesFlight(context, card)).sheetHeader();}
                              : (){
                                  blocGeneral.changeArgPage(card);
                                  Navigator.pushNamed(context, 'detail_flight_home');
                                },
                              child: CardFlight(
                                  flight: card,
                                  viewCodes: true,
                                  viewRatings: false,
                                  viewDates: true,
                                  viewPakages: true,
                                  viewButtonOption: true,
                                  tapBackground: false,
                                  functionTapBackground: null,
                                  actionSheet: () {
                                    ActionSheetHeaderFlight(
                                            context: context,
                                            flight: card,
                                            listActions:
                                                _listaAccionesFlight(
                                                    context, card))
                                        .sheetHeader();
                                  }),
                            ));
                        }

                        if (listaCardWidget.length <= 0) {
                          return Column(
                            children: [
                               SizedBox(
                                    height: height * 0.03,
                                  ),
                                 _seachTrips(responsive),
                              Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: height * 0.2),
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
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                              SizedBox(
                                height: height * 0.03,
                              ),
                              _seachTrips(responsive),
                              Container(
                                margin:
                                    EdgeInsets.only(top: height * 0.02),
                                child: Column(
                                  children: listaCardWidget,
                                ),
                              ),
                            ],
                          );
                        }
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: height * 0.2),
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      }
                    }),
                // ------------------------------------------------------------
                SizedBox(height: height* 0.1),
              ]);
    }else if(blocGeneral.homeStore == 'packages'){
      return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.13),
                Container(
                  margin: EdgeInsets.only(
                      left: variableGlobal.margenPageWith(context)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              blocGeneral.changeHomeStore('trips');
                            },
                            child: Container(
                              child: Text(
                                generalText.trips(),
                                style: TextStyle(
                                  color: Color.fromRGBO(230, 232, 235, 1.0),
                                    fontSize: responsive.ip(3.2),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.19,
                            ),)
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                blocGeneral.changeHomeStore('packages');
                              },
                              child: Container(
                                child: Text(
                                  generalText.packages(),
                                  style: TextStyle(
                                    color: Colors.black,
                                      fontSize: responsive.ip(3.2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                              child: lineYellowShipmentSevice(context))
                          ],
                        ),
                      ),
                      // Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: <Widget>[
                      //     CupertinoButton(
                      //       minSize: 0,
                      //       padding: EdgeInsets.only(left: width * 0.05),
                      //       onPressed: (){
                      //         blocGeneral.changeHomeStore('store');
                      //       },
                      //       child: Container(
                      //         child: Text(
                      //           generalText.store(),
                      //           style: TextStyle(
                      //             color: Color.fromRGBO(230, 232, 235, 1.0),
                      //               fontSize: responsive.ip(3.2),
                      //               fontWeight: FontWeight.bold),
                      //         ),
                      //       ),
                      //     ),
                      //     SizedBox(
                      //       height: height * 0.03,
                      //     ),
                      //      Container(
                      //       padding: EdgeInsets.only(left: width * 0.05),
                      //       margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                      //       child: Container())
                      //   ],
                      // ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                StreamBuilder<dynamic>(
                    stream: blocGeneral.packagesStream,
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
                          listaCardWidget.add(
                            GestureDetector(
                              onTap: (validateAdmin.isAdmin(preference.prefsInternal.get('email')) == true) 
                              ? () {
                                ActionSheetHeaderAd(context: context, ad: card, listActions: _listaAccionesAd(context, card))
                                    .sheetHeader();
                              } : (){Navigator.pushNamed(context, 'ad_detail', arguments: json.encode(card));},
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                                child: CardAd(
                                    ad: card,
                                    viewImages: true,
                                    allImages: false,
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
                                    }),
                              ),
                            ));
                        }

                        if (listaCardWidget.length <= 0) {
                          return Column(
                            children: [
                               SizedBox(
                                height: height * 0.03,
                              ),
                              _seachPackage(responsive),
                              Center(
                                child: Container(
                                  margin:
                                      EdgeInsets.only(top: height * 0.2),
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
                              ),
                            ],
                          );
                        } else {
                          return Column(
                            children: [
                               SizedBox(
                                height: height * 0.03,
                              ),
                              _seachPackage(responsive),
                              Container(
                                margin:
                                    EdgeInsets.only(top: height * 0.02, bottom: height * 0.15),
                                child: Column(
                                  children: listaCardWidget,
                                ),
                              ),
                            ],
                          );
                        }
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: height * 0.2),
                          child: Center(
                              child: CircularProgressIndicator()),
                        );
                      }
                }),
              ]);
    }else if(blocGeneral.homeStore == 'store'){
      return Container();
      return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: height * 0.13),
                Container(
                  margin: EdgeInsets.only(
                      left: variableGlobal.margenPageWith(context)),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.all(0),
                            onPressed: (){
                              blocGeneral.changeHomeStore('trips');
                            },
                            child: Container(
                              child: Text(
                                generalText.trips(),
                                style: TextStyle(
                                  color: Color.fromRGBO(230, 232, 235, 1.0),
                                    fontSize: responsive.ip(3.2),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.19,
                            ),)
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(left: width * 0.05),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CupertinoButton(
                              minSize: 0,
                              padding: EdgeInsets.all(0),
                              onPressed: (){
                                blocGeneral.changeHomeStore('packages');
                              },
                              child: Container(
                                child: Text(
                                  generalText.packages(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(230, 232, 235, 1.0),
                                      fontSize: responsive.ip(3.2),
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: height * 0.03,
                            ),
                            Container(
                              margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                              child: Container())
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          CupertinoButton(
                            minSize: 0,
                            padding: EdgeInsets.only(left: width * 0.05),
                            onPressed: (){
                              blocGeneral.changeHomeStore('store');
                            },
                            child: Container(
                              child: Text(
                                generalText.store(),
                                style: TextStyle(
                                  color: Colors.black,
                                    fontSize: responsive.ip(3.2),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                           Container(
                            padding: EdgeInsets.only(left: width * 0.05),
                            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
                            child: lineYellowShipmentSevice(context))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.115),
                  padding: EdgeInsets.all(width * 0.03),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(255, 206, 6, 1.0),
                  ),
                  child: Center(
                    child: 
                    RichText(text: TextSpan(
                                  text: shortString(generalText.makeYourPurchasesThrough(), (leerMas == false) ? 41 : generalText.makeYourPurchasesThrough().length),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontSize: responsive.ip(1.7)
                                  ),
                                  children: [
                                    (leerMas == false) ? 
                                    TextSpan(
                                      recognizer: new TapGestureRecognizer()..onTap = (){
                                       setState(() {
                                         leerMas = !leerMas;
                                       });
                                      },
                                      text: '   ${postText.readMore()}',
                                      style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                          color: Colors.blue,
                                          fontSize: responsive.ip(1.7)
                                      )
                                    ) : 
                                    TextSpan(
                                      recognizer: new TapGestureRecognizer()..onTap = (){
                                       setState(() {
                                         leerMas = !leerMas;
                                       });
                                      },
                                      text: '\n${postText.readLees()}',
                                      style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                          color: Colors.blue,
                                          fontSize: responsive.ip(1.8)
                                      )
                                    )
                                  ]
                                )
                              )

                  ),
                ),
                SizedBox(height: height * 0.01),
                CupertinoButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () async {
                      // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                      String message = "";
                      String url;
                      if (Platform.isIOS) {
                        url =
                            "whatsapp://send?phone=+19148551834&text=${Uri.encodeFull(message)}";
                        await canLaunch(url)
                            ? launch(url)
                            : print('Error al enviar mensaje de WhatsApps');
                      } else {
                          url =
                            "whatsapp://send?phone=+19148551834&text=${Uri.encodeFull(message)}";
                           await canLaunch(url)
                           ? launch(url)
                            : print('Error al enviar mensaje de WhatsApps');
                      }
                    },
                    child: Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.115),
                    padding: EdgeInsets.all(width * 0.03),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.black
                    ),
                    child: Center(
                      child: Text(generalText.checkHereTheShippingRateBeforeMakingTheurPchase(),
                                      textAlign: TextAlign.left,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300,
                                              color: Color.fromRGBO(255, 206, 6, 1.0),
                                              fontSize: responsive.ip(1.8))),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.03),
                _seachStore(height, width, responsive),
                // SizedBox(height: height * 0.01),
                StreamBuilder(
                        stream: blocGeneral.storeStream,
                        builder: (_, AsyncSnapshot snapshot){
                          if(snapshot.hasData){
                            final valueData = snapshot.data;
                            List<Widget> productsWidget = [];
                            int contProduct = 0;
                            for(int i = contProduct; i<valueData.length / 2; i++){
                              String img1 = '';
                              String img2 = '';
                               try{
                                 img1 = valueData[contProduct]["image"];
                               }
                               catch(e){
                                 img1 = '';
                               }
                               try{
                                 img2 = valueData[contProduct+1]["image"];
                               }
                               catch(e){
                                 img2 = '';
                               }

                                productsWidget.add(
                                  _rowPairCardStore(height, width, responsive, 
                                  (img1 != '') ? _cardStore(height, width, responsive, valueData[contProduct]["image"], valueData[contProduct]["title"], valueData[contProduct]["price"], valueData[contProduct]["url"]) : _cardStoreVacio(height, width, responsive), 
                                  (img2 != '') ? _cardStore(height, width, responsive, valueData[contProduct+1]["image"], valueData[contProduct+1]["title"], valueData[contProduct+1]["price"], valueData[contProduct+1]["url"]) : _cardStoreVacio(height, width, responsive))
                                );
                                contProduct = contProduct + 2;
                            }

                            productsWidget.add(SizedBox(height: height * 0.03,));
                            
                            return Container(
                                    margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                                    child: Column(
                                      children: productsWidget
                                    )
                                    );
                          }else if(snapshot.hasError){
                            return Container();
                          }else{
                            return Container(
                                      margin: EdgeInsets.only(top: height * 0.2),
                                      child: Center(
                                          child: CircularProgressIndicator()),
                                    );
                          }
                        },
                ),
                SizedBox(height: height* 0.1),
              ]);
    }else{
      return Container();
    }
  }

  // *************************
  List<ActionSheetAction> _listaAccionesAd(BuildContext context, ad) {
    if(validateAdmin.isAdmin(preference.prefsInternal.get('email')) == true){
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
          text: generalText.deleteAd(),
          defaultAction: true,
          onPressed: () {
            Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().deleteAd(context: context, email: preference.prefsInternal.get('email'), id: ad["_id"])
                .then((value){
                  var valueMap = json.decode(value);
                  if(valueMap["ok"] == true){
                  Navigator.pop(context);
                   _http.ads(context: context, cont: contPackages).then((packages) {
                      final valueMapPackages = json.decode(packages);
                      if (valueMapPackages['ok'] == true) {
                        blocGeneral.changePackages(valueMapPackages["adsBD"]);
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
    }else{
      return [
        ActionSheetAction(
          text: generalText.seeDetail(),
          defaultAction: true,
          onPressed: () {
            Navigator.pushNamed(context, 'ad_detail', arguments: json.encode(ad));
          },
          hasArrow: true,
        ),
      ];
    }
  }

  List<ActionSheetAction> _listaAccionesFlight(BuildContext context, flight) {
    if(validateAdmin.isAdmin(preference.prefsInternal.get('email')) == true){
      return [
        ActionSheetAction(
          text: generalText.seeDetail(),
          defaultAction: true,
          onPressed: () {
            blocGeneral.changeArgPage(flight);
            Navigator.pushNamed(context, 'detail_flight_home');
            // SE DEBE CREA UN DETALLE DE VUELO QUE DEVUELVA A HOME
          },
          hasArrow: true,
        ),
        ActionSheetAction(
          text: generalText.deleteFlight(),
          defaultAction: true,
          onPressed: () {
            Navigator.pop(context);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              Http().deleteFlight(context: context, email: preference.prefsInternal.get('email'), id: flight["_id"])
                .then((value){
                  var valueMap = json.decode(value);
                  if(valueMap["ok"] == true){
                   _http.flights(context: context, cont: contTrips).then((trips) {
                      final valueMapTrips = json.decode(trips);
                      if (valueMapTrips['ok'] == true) {
                        blocGeneral.changeTrips(valueMapTrips["flightsBD"]);
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
    }else{
      return [
        ActionSheetAction(
          text: generalText.seeDetail(),
          defaultAction: true,
          onPressed: () {
            blocGeneral.changeArgPage(flight);
            Navigator.pushNamed(context, 'detail_flight_home');
            // SE DEBE CREA UN DETALLE DE VUELO QUE DEVUELVA A HOME
          },
          hasArrow: true,
        ),
      ];
    }

  }


  Widget _cardStore(double height, double width, Responsive responsive, String urlImg, String title, String price, String url){
    final oCcy = new NumberFormat("#,##0.00", "en_US");

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => WebViewStorePage(url: url),
                      ));
                    },  
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                            height: width * 0.37,
                            width: width * 0.37,
                            margin: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(230, 232, 235, 1.0),
                              borderRadius: BorderRadius.circular(12),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Color.fromRGBO(230, 232, 235, 1.0),
                                                  blurRadius: 2,
                                                  offset: Offset(0, 2), // Shadow position
                                                ),
                                              ],
                            ),
                          ),
                        Column(
                          children: [
                            Container(
                                height: height * 0.08,
                                width: width * 0.3,
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(230, 232, 235, 1.0),
                                  borderRadius: BorderRadius.circular(16),
                                  // image: DecorationImage(
                                  //       image: AssetImage(urlImg),
                                  //       fit: BoxFit.contain)
                                  image: DecorationImage(image: NetworkImage(urlImg),
                                            fit: BoxFit.contain)
                                  ),
                              ),
                              SizedBox(height: height * 0.01),
                              textExpanded(
                                title, 
                                width * 0.33,
                                responsive.ip(1.3),
                                Colors.black,
                                FontWeight.w400,
                                TextAlign.left
                              ),
                              Container(
                                width: width * 0.33,
                                child: RichText(
                                text: TextSpan(
                                  text: '${adsText.price()}: ',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(177, 39, 77, 1),
                                        fontSize: responsive.ip(1.3)
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'USD ${oCcy.format(double.parse(price))}',
                                      style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: responsive.ip(1.3)
                                      )
                                    )
                                  ]
                                )
                              ),
                              ),
                          ],
                        )
                      ],
                    ),
                  );
          
                }


  Widget _cardStoreVacio(double height, double width, Responsive responsive){
      final oCcy = new NumberFormat("#,##0.00", "en_US");
          return Container(
            height: height * 0.2,
            width: width * 0.35,
                    padding: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.04),
                  margin: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: width * 0.01),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                                child: Container(
                    height: height * 0.13,
                    width: width * 0.35,
                    // child: Image.network(urlImg,
                    // height: height * 0.15,
                    // width: width * 0.3,
                    // fit: BoxFit.contain),
                  ),
                ),
                Positioned(
                  bottom: height * 0.0,
                        child: Column(
                          children: [
                            Container(
                                width: width * 0.37,
                                margin: EdgeInsets.all(width * 0.01),
                                child: Text('',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                        color: Colors.black,
                                          fontSize: responsive.ip(1.5),
                                          fontWeight: FontWeight.bold),
                                      ),
                            ),
                            Container(
                                width: width * 0.37,
                              //  margin: EdgeInsets.all(width * 0.005),
                                child: Text('',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                        color: Colors.black,
                                          fontSize: responsive.ip(1.5),
                                          fontWeight: FontWeight.bold),
                                      ),
                            ),
                          ],
                        ),
                )
              ],
            ),
          );
    }
              
  Widget _rowPairCardStore(double height, double width, Responsive responsive, Widget p1, Widget p2){
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          p1, p2
        ],
      ),
    );
  }
              

 TextEditingController controladorSearchTrips = TextEditingController();
  Widget _seachTrips(Responsive responsive) {
    String text =
        (_validarSearchTrips() == false) ? generalText.search() : '';
    if(blocAdmin.searchTripStreamValue != false) controladorSearchTrips.text = (_validarSearchTrips() == false) ? blocAdmin.searchTrip : blocAdmin.searchTrip;
    controladorSearchTrips.selection = TextSelection.collapsed(offset: controladorSearchTrips.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: blocAdmin.searchTripStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorSearchTrips,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: responsive.ip(1)),
                labelText: text,
                // border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                // border: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                // enabledBorder: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                // disabledBorder: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                errorText: snapshot.error),
                onChanged: (value){

                   if(value.trim().length <=0){
                    _http.flights(context: context, cont: contTrips).then((trips) {
                      final valueMap = json.decode(trips);
                      if (valueMap['ok'] == false) {
                        blocGeneral.changeTrips(blocGeneral.trips);
                      } else {
                        blocGeneral.changeTrips(valueMap["flightsBD"]);
                      }
                    });
                  }
    
                  _http.searchFlight(value.trim())
                            .then((users) {
                          final valueMap = json.decode(users);
                          if (valueMap['ok'] == false) {
                            blocGeneral.changeTrips(blocGeneral.trips);
                          } else {
                            blocGeneral.changeTrips(valueMap["flights"]);
                          }
                        });
                },
                onTap: () {
                  text = '';
                }),
          );
        });
  }


 TextEditingController controladorSearchPackage = TextEditingController();
  Widget _seachPackage(Responsive responsive) {
    String text =
        (_validarSearchPackage() == false) ? generalText.search() : '';
    if(blocAdmin.searchPackageStreamValue != false) controladorSearchPackage.text = (_validarSearchPackage() == false) ? blocAdmin.searchPackage : blocAdmin.searchPackage;
    controladorSearchPackage.selection = TextSelection.collapsed(offset: controladorSearchPackage.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: blocAdmin.searchPackageStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorSearchPackage,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: responsive.ip(1)),
                labelText: text,
                // border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error),
                onChanged: (value){
                  if(value.trim().length <=0){
                     _http.ads(context: context, cont: contPackages).then((packages) {
                      final valueMap = json.decode(packages);
                      if (valueMap['ok'] == false) {
                        blocGeneral.changePackages(blocGeneral.packages);
                      } else {
                        blocGeneral.changePackages(valueMap["adsBD"]);
                      }
                    });
                  }
                  _http.searchAds(value.trim())
                            .then((ads) {
                          final valueMap = json.decode(ads);
                          if (valueMap['ok'] == false) {
                            blocGeneral.changePackages(blocGeneral.packages);
                          } else {
                            blocGeneral.changePackages(valueMap["ads"]);
                          }
                        });
                },
                onTap: () {
                  text = '';
                }),
          );
        });
  }


 TextEditingController controladorSearchStore = TextEditingController();
  Widget _seachStore(double height, double width, Responsive responsive) {
    String text =
        (_validarSearchStore() == false) ? generalText.search() : '';
    if(blocAdmin.searchStoreStreamValue != false) controladorSearchStore.text = (_validarSearchStore() == false) ? blocAdmin.searchPackage : blocAdmin.searchPackage;
    controladorSearchStore.selection = TextSelection.collapsed(offset: controladorSearchStore.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(stream: blocAdmin.searchStoreStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.115),
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorSearchStore,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: responsive.ip(1)),
                labelText: text,
                // border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                // border: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                // enabledBorder: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                // disabledBorder: const OutlineInputBorder(
                //   borderRadius: const BorderRadius.all(
                //     Radius.circular(15.0),
                //   ),
                //   borderSide: const BorderSide(
                //       color: Color.fromRGBO(173, 181, 189, 1)),
                // ),
                errorText: snapshot.error),
                onChanged: (value){
                  _http.searchStore(value.trim())
                            .then((store) {
                          final valueMap = json.decode(store);
                          // print(valueMap);
                          if (valueMap['ok'] == false) {
                            blocGeneral.changeStore(blocGeneral.store);
                          } else {
                            blocGeneral.changeStore(valueMap["store"]);
                          }
                        });
                },
                onTap: () {
                  text = '';
                }),
          );
        });
  }

  bool _validarSearchTrips() {
    bool validate = false;
    try{
      if (blocAdmin.searchTripStreamValue == false) {
          validate = false;
      } else {
        if (blocAdmin.searchTrip.length <= 0) {
          validate = false;
        } else {
          validate = true;
        }
      }
    }catch(e){
      validate = false;
    }
    return validate;
  }
  
  bool _validarSearchPackage() {
    bool validate = false;
    try{
      if (blocAdmin.searchPackageStreamValue == false) {
          validate = false;
      } else {
        if (blocAdmin.searchPackage.length <= 0) {
          validate = false;
        } else {
          validate = true;
        }
      }
    }catch(e){
      validate = false;
    }
    return validate;
  }

  bool _validarSearchStore() {
    bool validate = false;
    try{
      if (blocAdmin.searchStoreStreamValue == false) {
          validate = false;
      } else {
        if (blocAdmin.searchStore.length <= 0) {
          validate = false;
        } else {
          validate = true;
        }
      }
    }catch(e){
      validate = false;
    }
    return validate;
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}

