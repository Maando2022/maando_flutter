// @dart=2.9
// https://firebase.google.com/docs/cloud-messaging/http-server-ref?hl=es-419#notification-payload-support
import 'dart:convert';
import 'dart:io';
import 'package:dash_chat/dash_chat.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/chat_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/notifications_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
// https://pub.dev/packages/firebase_messaging/example

class PushNotifications {


  iniNotifications(GlobalKey<NavigatorState> context){
    FirebaseMessaging.instance.requestPermission();

    FirebaseMessaging.instance.getToken().then((token){
      print('=========== FCM ===========');
      blocNotifications.changeTokenNotification(token);
      print(blocNotifications.tokenNotification);
    });



      FirebaseMessaging.onMessage.listen((RemoteMessage noti) { 
        print('=========== Notificacion cuando la app esta abierta ===========');
        
        if(Platform.isAndroid){
          // arg = noti["data"]["message"] ?? 'no-data';
        }else{
          // arg = noti["message"]  ?? 'no-data';
        }
        // print('arg =====================   >>>>>>${noti.data["arg"]}');
        // CHAT
        Http().listMyChatsSinContext(emailEmiter: preference.prefsInternal.get('email') as String, emailDestiny: blocChat.emailDestiny)
          .then((value){
            final valueMap = json.decode(value);
            if(valueMap["ok"] == true){
              List<ChatMessage> listMessages = [];
              for(var m in valueMap["misChats"]){
                ChatUser miUsuario = ChatUser(
                  name: blocSocket.user["fullName"],
                  uid: preference.prefsInternal.get('email') as String,
                  avatar: blocSocket.user["avatar"],
                );
                ChatUser otroUsuario = ChatUser(
                  name: blocChat.fullNameDestiny,
                  uid: blocChat.emailDestiny,
                  avatar: blocChat.avatarDestiny,
                );
                listMessages.add(ChatMessage(
                  text: m["body"],
                  id: m["_id"],
                  // createdAt: convertirStringToDateTime(m["created_on"].toString()),
                  createdAt: convertirMilliSecondsToDateTime(int.parse(m["created_on"])),
                  user: (m["userEmit"]["email"] == preference.prefsInternal.get('email')) ? miUsuario : otroUsuario,
                  image: (m["image"] == '' || m["image"] == null) ? null : m["image"]
                ));
              }
              blocChat.changeChats(listMessages);
            }else{
              blocChat.changeChats([]);
            }
          });

        // PAQUETES
            Http().adsSinContext(cont: 1000).then((packages) {
            final valueMap = json.decode(packages);
            if (valueMap['ok'] == false) {
              blocGeneral.changePackages(blocGeneral.packages);
            } else {
              blocGeneral.changePackages(valueMap["adsBD"]);
            }
          });
        

      });
    

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage noti) { 
        print('=========== Notificacion cuando la app esta cerrada ===========');
        // ¡Se publicó un nuevo evento de aplicación de mensajes abiertos!
        String arg = 'no-data';
        if(Platform.isAndroid){
          // arg = noti["data"]["message"] ?? 'no-data';
        }else{
          // arg = noti["message"]  ?? 'no-data';
        }
        print('arg =====================   >>>>>>${noti.data}');

        //CHAT
        if(noti.data["page"] == 'chat'){
          Http().findUserForEmail(email: noti.data["arg"]).then((value){
            var userMap = json.decode(value);
              if(userMap["ok"] == true){
                blocChat.changeEmailDestiny(userMap["user"]["email"]);
                blocChat.changeFullNameDestiny(userMap["user"]["fullName"]);
                blocChat.changeAvatarDestiny(userMap["user"]["avatar"]);
                context.currentState.pushNamed('chat', arguments: userMap["user"]);
              }
           });
        }else{}
        
        // PAQUETES
          Http().adsSinContext(cont: 1000).then((packages) {
          final valueMap = json.decode(packages);
          if (valueMap['ok'] == false) {
            blocGeneral.changePackages(blocGeneral.packages);
          } else {
            blocGeneral.changePackages(valueMap["adsBD"]);
          }
        });
      });
  }
}

PushNotifications pushNotifications = PushNotifications();