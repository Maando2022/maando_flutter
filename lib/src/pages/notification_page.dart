// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notification_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:maando/src/utils/responsive.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {

final preference = new Preferencias();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double miheight = MediaQuery.of(context).size.height;
    double miwidth = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    String pageBack = ModalRoute.of(context).settings.arguments;
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: variableGlobal.margenTopGeneral(context),
                  right:
                      variableGlobal.margenPageWith(context),
                  left:
                      variableGlobal.margenPageWith(context)),
              child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                      closenoti(context, 'assets/images/close/close button 1@3x.png', pageBack),
                    ],
                  ),
            ),

            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: miheight * 0.02,
                  vertical:
                      variableGlobal.margenPageWithLoginCreateAccount(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    notificationText.notifications(),
                    style: TextStyle(
                      fontSize: responsive.ip(3.5),
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: miheight * 0.021,
                  ),
                  Container(
                      width: miwidth * 0.003,
                      // height: miheight * 0.005,
                      child: lineYellowNoti(context))
                ],
              ),
            ),
            // *****************************+++ NOTIFICACIONES

            StreamBuilder(
                      stream: blocSocket.userStream,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          // print('EL USUARIO ==========================================>>>>  ${snapshot.data["messages"].length}');
                          final valueMap = snapshot.data["messages"];


                            if(valueMap.length > 0){

                                List<Notification> listNotifications = [];

                                for(var m in valueMap)  {
                                  listNotifications.add(
                                  
                                    // firebaseStorage.obtenerAvatar(m["emittingUser"]
                                    Notification(
                                        emittingUser: m["emittingUser"],
                                        img: Http().findAvatarUserGoogleFacebook(context: context, email: m["emittingUser"]),
                                        title: m["message"],
                                        date: formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(m["created_on"])).toString()),
                                        view: m["view"],
                                        type: m["type"],
                                        id: m["id"]));
                                }

                                return Column(
                                    children: listNotifications.reversed.toList()
                                );
                            }else{
                              return Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
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
                            }

                        }else if(snapshot.hasError){
                          return Container();
                        }else{
                         return Container(
                            margin: EdgeInsets.only(top: 100.0),
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      })

          ],
        ),
      ),
    );
  }
}

class Notification extends StatefulWidget {

  String emittingUser;
  Future<dynamic> img;
  String title;
  String date;
  bool view;
  String type;
  String id;

  Notification(
    {
      @required this.emittingUser, 
      @required this.img, 
      @required this.title, 
      @required this.date, 
      @required this.view,
      @required this.type,
      @required this.id
    });

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  Http _http = Http();

  @override
  Widget build(BuildContext context) {
    double miheight = MediaQuery.of(context).size.height;
    double miwidth = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
      color: (widget.view == false) ? Color.fromRGBO(255, 206, 6, 0.25) : null ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
                 CupertinoButton(
                   padding: EdgeInsets.all(0),
                   onPressed: (){
                     _viewNotification(context);
                   },
                   child: FutureBuilder<dynamic>(
                    future: widget.img,
                    builder: (BuildContext context, snapshot) {
                      if(snapshot.hasData){
                        return  
                        Container(
                          width: miwidth * 0.13,
                          height: miwidth * 0.13,
                          child: CircleAvatar(
                            child: (snapshot.data == null || snapshot.data == '')
                            ? FutureBuilder(future: _http.findUserForEmail(email: widget.emittingUser),
                                             builder: (BuildContext context, snapshotUser) {
                                                 if(snapshotUser.hasData){
                                                   return Text(json.decode(snapshotUser.data)["user"]["name"].toString().substring(0, 2).toUpperCase(), style: TextStyle(
                                                              fontSize: responsive.ip(2.5),
                                                              fontWeight: FontWeight.bold),
                                                          textAlign: TextAlign.start,
                                                        );
                                                 }else if(snapshotUser.hasError){
                                                    return Container();
                                                  }else{
                                                    return  Container();
                                                  }
                                             })
                            : Container(),
                            backgroundImage: NetworkImage(snapshot.data),
                          ),
                        );
                      }else if(snapshot.hasError){
                        return Container(
                          width: miwidth * 0.13,
                          height: miwidth * 0.13,
                        );
                      }else{
                        return  Container(
                          width: miwidth * 0.13,
                          height: miwidth * 0.13,
                          child: CircleAvatar(),
                        );
                      }
                }),
                 ),
                SizedBox(width:  miwidth * 0.03),
                CupertinoButton(
                   padding: EdgeInsets.all(0),
                  onPressed: (){
                    _viewNotification(context);
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width:  miwidth * 0.6,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.title, 
                                 style: TextStyle(
                                          fontSize: responsive.ip(1.8),
                                          height: 1.6,
                                          fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.start,
                              ),
                              SizedBox(
                                height: miheight * 0.01,
                              ),
                              Text(
                                widget.date,
                                style: TextStyle(
                                    height: miheight * 0.0020,
                                    fontSize: responsive.ip(1.6),
                                    color: Color.fromRGBO(173, 181, 189, 1)),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width:  miwidth * 0.05),
                        botonTresPuntosGrises(context, miwidth * 0.09, (){
                          PlatformActionSheet().displaySheet(
                          title: Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.02,
                                ),
                                iconFace1(context),
                                Column(
                                  children: [
                                    SizedBox(
                                      height: MediaQuery.of(context).size.height * 0.02,
                                    ),
                                    Text(generalText.options(),
                                            style: TextStyle(
                                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: responsive.ip(3))),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.03,
                                  )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          context: context,
                          actions: _listaAcciones(context, widget.id));
                        })
                      ],
                    ),
                  ),
                )
        ],
      ),
    );
  }

  List<ActionSheetAction> _listaAcciones(BuildContext context, String idMessage){

    final preference = Preferencias();

      return [
        ActionSheetAction(
            text:  generalText.viewNotification(),
            defaultAction: true,
            onPressed: (){
               _viewNotification(context);
            },
            hasArrow: true,
          ),
          ActionSheetAction(
            text: generalText.delete(),
            defaultAction: true,
            onPressed: (){
               showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http.deleteMessageUser(context: context, email: preference.prefsInternal.get('email'), idMessage: widget.id
                ).then((value) {
                  // AQUI SE DEBE ACTUALIZAR LA PAGINA
                    // print('LA RESPUESTA DEL MACH  ${value}');
                  final valueMap = json.decode(value);
                  if(valueMap['ok'] == true){
                    blocSocket.socket.getUserEmiter(preference.prefsInternal.get('email'));
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }else{
                    Navigator.pop(context);
                    Navigator.pop(context);
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
                  }

                });
            },
            hasArrow: true,
          ),
      ];
  }

  _viewNotification(BuildContext context){
     if(widget.view == false){
            _http.viewMessageUser(context: context, email: preference.prefsInternal.get('email'), idMessage: widget.id
        ).then((value) {
          // AQUI SE DEBE ACTUALIZAR LA PAGINA
          final valueMap = json.decode(value);
          if(valueMap['ok'] == true){
            if(widget.type == 'SHIPMENTServicePublish'){
               blocNavigator.shipmentPrincipal();
                  Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}));
            }else if(widget.type == 'ShipmentSERVICEPublish'){
              blocNavigator.servicePrincipal();
                  Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": false, "service": true}));
            }else{
               Navigator.pushReplacementNamed(context, 'principal');
            }
          }else{
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
          }

        });
      }else{
        // Navigator.pop(context);
        if(widget.type == 'SHIPMENTServicePublish'){
               blocNavigator.shipmentPrincipal();
                  Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}));
            }else if(widget.type == 'ShipmentSERVICEPublish'){
              blocNavigator.servicePrincipal();
                  Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": false, "service": true}));
            }else{
               Navigator.pushReplacementNamed(context, 'principal');
            }
      }          
  }
}