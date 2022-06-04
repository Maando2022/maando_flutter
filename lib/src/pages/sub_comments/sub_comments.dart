// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notifications_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_post.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class SubComment extends StatelessWidget {



  final Map<String, dynamic> subComment;

  SubComment({@required this.subComment});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    String phoneWhatsApps = '';

    blocGeneral.aiportsOrigin.forEach((country) {
      if (this.subComment["user"]["country"] == country["name"]) {
        phoneWhatsApps = '+${country["indicative-code"]}${this.subComment["user"]["phone"]}';
      }
    });

    
    return GestureDetector(
          onLongPress: (){
              ActionSheetPost(context: context,listActions: _listaAcciones(context)).sheetHeader();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008),
            width: width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(173, 181, 189, 0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.08,
                    margin: EdgeInsets.only(top: height * 0.015, left: MediaQuery.of(context).size.width * 0.02),
                    child: CircleAvatar(
                                child: (this.subComment["user"]["avatar"] == null || this.subComment["user"]["avatar"] == '')
                                ? Text(this.subComment["user"]["name"].substring(0, 2).toUpperCase(), style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            // height: 1.6,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      )
                                : Container(),
                                backgroundImage: NetworkImage(this.subComment["user"]["avatar"]),
                              ),
                ),
                Container(
                    width: width * 0.55,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                    margin: EdgeInsets.only(left:  width * 0.015, top: height * 0.01),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: height * 0.01),
                         CupertinoButton(
                           padding: EdgeInsets.all(0),
                           minSize: 0,
                           onPressed: validateAdmin.isAdmin(preference.prefsInternal.get('email'))
                         ? () async {
                                  // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                                  String message = "";
                                  String url;
                                  if (Platform.isIOS) {
                                    url =
                                        "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                                    await canLaunch(url)
                                        ? launch(url)
                                        : print('Error al enviar mensaje de WhatsApps');
                                  } else {
                                    url =
                                        "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                                    await canLaunch(url)
                                        ? launch(url)
                                        : print('Error al enviar mensaje de WhatsApps');
                                  }
                                } : null,
                             child: Text(this.subComment["user"]["name"],
                                style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontSize: responsive.ip(1.8))),
                         ),
                         Text('${obtenerTiempoDePublicacion(this.subComment["created_on"])["number"]} ${obtenerTiempoDePublicacion(this.subComment["created_on"])["time"]}',
                              style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: responsive.ip(1.8))),
                        SizedBox(height: height * 0.005),
                         Container(
                           child: Text(this.subComment["body"],
                                    style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: responsive.ip(1.6))),
                         ),
                         SizedBox(height: height * 0.02),
                       ],
                     )
                  ),
                
              ],
            ),
          ),
        );
  }

    // *************************
List<ActionSheetAction> _listaAcciones(BuildContext context){

      return (
        preference.prefsInternal.get('email') == this.subComment["user"]["email"]||
        preference.prefsInternal.get('email') == 'davgui242011@gmail.com' ||
        preference.prefsInternal.get('email') == 'david@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'david@maando.com' ||
        preference.prefsInternal.get('email') == 'jdv@maando.com' ||
        preference.prefsInternal.get('email') == 'jdv@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'friends@maando.com' ||
        preference.prefsInternal.get('email') == 'rosanna@maando.com' ||
        preference.prefsInternal.get('email') == 'daniel@maando.com' ||
        preference.prefsInternal.get('email') == 'alia@maando.com' ||
        preference.prefsInternal.get('email') == 'milan@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'renzo@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'marcela@maando.com' ||
        preference.prefsInternal.get('email') == 'carolina@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'info@jdvgroup.co'
        )  ?
       [
        ActionSheetAction(
            text: generalText.delete(),
            defaultAction: true,
            onPressed: (){
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.pop(context);
                Http().deleteSubComment(context: context, email: preference.prefsInternal.get('email'), postId: this.subComment["post"]["_id"], commentId: this.subComment["comment"]["_id"], subCommentId: this.subComment["_id"])
                .then((value){
                  Navigator.pop(context);                 
                  if(json.decode(value)["ok"] == true){
                    if(preference.prefsInternal.get('email') != this.subComment["user"]["email"]) Http().notificationOneToken(context: context, email: this.subComment["user"]["email"], title: notificationText.maandoUpdate(), body: notificationText.yourMessageHasBeenDeletedByTheMaandoTeam(), data: {'datos': 'Aqui van los datos'});
                    for(var p in blocGeneral.posts){
                      if(json.decode(value)["post"]["_id"] == p["_id"]){
                        p = json.decode(value)["post"];
                        blocGeneral.changePosts(blocGeneral.posts);
                      }
                    } 
                  }
                });
            },
            hasArrow: true,
        ),
        ActionSheetAction(
            text: generalText.copy(),
            defaultAction: true,
            onPressed: (){
                Clipboard.setData(new ClipboardData(text: this.subComment["body"]))
                .then((_){
                  toastService.showToastCenter(context: context, text: generalText.copied(), durationSeconds: 4);
                  Navigator.pop(context);
                });
            },
            hasArrow: true,
          ),
      ] :
      [
        ActionSheetAction(
            text: generalText.copy(),
            defaultAction: true,
            onPressed: (){
                Clipboard.setData(new ClipboardData(text: this.subComment["body"]))
                .then((_){
                  toastService.showToastCenter(context: context, text: generalText.copied(), durationSeconds: 4);
                  Navigator.pop(context);
                });
            },
            hasArrow: true,
          ),
      ];
  }



}