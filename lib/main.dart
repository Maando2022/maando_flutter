// @dart=2.9
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/notifications_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/push_notificatios.dart';
import 'package:maando/src/utils/rutas.dart';
import 'src/services/shared_pref.dart';
import 'src/utils/easy_loading.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maando/src/services/mongo_db.dart';

// https://parzibyte.me/blog/2018/05/23/programar-depurar-apps-android-studio-sin-cable-usb/
// adb devices
// adb tcpip 5555
// adb connect 192.168.0.105  // casa
// adb connect 10.201.245.4 // datos
// adb disconnect 10.201.245.4

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final preference = new Preferencias();

  // mongoDB.uploadDB();

  await preference.obtenerPreferencias();
  // await preference.limpiarPreferencias();
  //preference.prefsInternal.clear();

// AQUI INICIOMOS EL ESTRAM DE PAISES CON UN ARREGLO VACIO
  blocGeneral.changeAiportsOrigin([]);
  blocGeneral.changeAiportsDestination([]);
  // OBTENEMOS LOS LOS PAISES CUIDADES Y AEROPUERTOS
  Http().getAiports().then((aiports){          
      blocGeneral.changeAiportsOrigin(aiports["contriesOrigin"]);
      blocGeneral.changeAiportsDestination(aiports["contriesDestination"]);
  });

  // la sgte linea evita el lanscape vista horizontal en toda la app
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final preference = new Preferencias();
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  initState() {
    super.initState();
    blocNotifications.pageStream.listen((page) {
      navigatorKey.currentState.pushReplacementNamed(page);
    });
  }

  _cargarImagen() async {
     final _picker = ImagePicker();
     final PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery);
     final storedImage = File(pickedFile.path);

      if (pickedFile != null) {
        Http().twMaandoPruebaImage(img: storedImage).then((value){
          print('RESPUESTA DEL LA CARGA DE LA IMAGEN  ${value}');
        });
      }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // _sendNotificationOneuser();
    // _sendNotificationMultipleUsers();

    
    CustomAnimation().customEasyLoad();
    pushNotifications.iniNotifications(navigatorKey);

    return ProviderApp(
      child: MaterialApp(
        // onGenerateRoute: (settings) {
        //   // onGenerateRoute;
        // },
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Maando',
        initialRoute: preference.paginaInicio(),
        routes: routes(),
        builder: EasyLoading.init(),
        // supportedLocales: [
        //   Locale('es', ''),
        //   Locale('en', ''),
        // ],
        theme: ThemeData(
          primaryColor: Color.fromRGBO(255, 206, 6, 1.0),
          fontFamily: 'Exprswy',
        ),
      ),
    );
  }

  _sendNotificationOneuser() {
    print('BACKGROUNG AHORA');
    Future.delayed(Duration(seconds: 10), () {
      new Http()
          .pushNotificationsOneUser(
              email: preference.prefsInternal.get('email'),
              title: 'Bienvenido a MaandoApp',
              body: 'Te has registrado ya??',
              data: {
                'message': {
                  'type': 'Success',
                  'message': 'Te han enviadomuna solicitud',
                  'page': 'noti'
                }
              },
              uiddevice: blocNotifications.tokenNotification)
          .then((resp) {
        print('RESPUESTA DE LA N OTIFICACION $resp');
      });
    });
  }

  _sendNotificationMultipleUsers() {
    print('BACKGROUNG AHORA');
    Future.delayed(Duration(seconds: 10), () {
      new Http().pushNotificationsMultipleUsers(
          email: preference.prefsInternal.get('email'),
          title: 'Bienvenido a MaandoApp a todos',
          body: 'Ustedes ya estan registrados',
          data: {
            'message': {
              'type': 'Success',
              'message': 'Te han enviadomuna solicitud',
              'page': 'noti'
            }
          },
          uiddevices: [
            blocNotifications.tokenNotification
          ]).then((resp) {
        print('RESPUESTA DE LA N OTIFICACION $resp');
      });
    });
  }
}
