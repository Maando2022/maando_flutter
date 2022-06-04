// @dart=2.9

// https://pub.dev/packages/animate_do
// https://pub.dev/packages/page_transition/

// *****
// https://pub.dev/packages/flutter_braintree
// android:launchMode="singleTop"   la que estaba antes en el manifest
// *****

// flutter run --profile   ===>>>   para ejecutar en modo profile (generar lelease apk)

// flutter pub cache repair    =====>>>>>   cuando no ejecuta la app en start debugging
// deviceId------>>>  https://pub.dev/packages/device_info

// DAVID huawei p20 5.8 pulgadas
// Media query with vertical => 680
// Media query with horizontal => 360
// +++++

// Kike Huawei Pequeño 5.0 pulgadas
// Media query with vertical => 598
// Media query with horizontal => 360
// +++++

//telefono huawei p30 pantalla 6.15 pulgadas
//vertical width 423.5294196844927 height 858.03
//horizontal width  826.66 heigh 423.52
//iphone 10 pantalla 5.8 pulgada
//alto 812
//ancho 375

// imei de huawei p9 lite kike  =====>>>>> 863166036671514 android 8.0.0 Api 26
// imei de iphone =====>>>>> 354863093183781 - BE342BCC-CA83-42AE-9B80-DD7B0D1FF637
// imei David hawei mate 10 life  ===>>> 866225033458759
// imei p30 lite kike  867511043877941 android 10.0.0 Api 29





// SCROLLL   https://stackoverflow.com/questions/56071731/scrollcontroller-how-can-i-detect-scroll-start-stop-and-scrolling

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maando/src/blocs/login_bloc.dart';
import 'package:maando/src/widgets/iconos.dart';


// Para prevenir el uso del boton back
@override
Widget build(BuildContext context) {
  return new WillPopScope(
    onWillPop: () async => false,
    child: new Scaffold(
      appBar: new AppBar(
        title: new Text("data"),
        leading: new IconButton(
          icon: new Icon(Icons.ac_unit),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
    ),
  );
}

String urlAvatarVoid = 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc';

// ****************************************************
// Base de un staless widget
class Page extends StatelessWidget {
  const Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Color.fromRGBO(251, 251, 251, 1),
            body: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 30.0),
                      child: Center(
                          child: Column(children: <Widget>[
                        iconFace1(context),
                      ])))
                ]))));
  }
}

// ************************************************

Widget funtion(LoginBloc bloc) {
  return StreamBuilder(
      stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container();
      });
}

// Ordenar por fecha
// listaTargetas.sort((a, b) {
//     var adate = a[
//         'departureDT']; //before -> var adate = a.expiry;
//     var bdate = b[
//         'departureDT']; //before -> var bdate = b.expiry;
//     return adate.compareTo(
//         bdate); //to get the order other way just switch `adate & bdate`
//   });

// ******************************************
// Tipos de cuentas bancarias (STRIPE)
 List<Map<String, dynamic>> listTypesAccountStripeMap = [
      {
        'code': 'savings',
        'value': 'Savings account',
      }, 
      {
        'code': 'current',
        'value': 'Current account',
      }, 
    ];
// ******************************************

// ******************************************
Future<dynamic> combosApi() async {
  return Future.delayed(Duration(milliseconds: 1000), () {
    return {
      "error": false,
      "data": {
        "packageType": [
          {"code": "Package-Handybag", "description": "Handybag"},
          {"code": "Package-Compact", "description": "Compact"}
        ],
        "elements": [
          {"code": "Element-Perfum", "description": "Perfum"},
          {"code": "Element-Watch", "description": "Watch"},
          {"code": "Element-Mobile", "description": "Mobile"},
          {"code": "Element-Tablet", "description": "Tablet"},
          {"code": "Element-Makeup", "description": "Makeup"},
          {"code": "Element-Clothes", "description": "Clothes"},
          {"code": "Element-Books", "description": "Books"},
          {"code": "Element-Documents", "description": "Documents"},
          {"code": "Element-PairShoes", "description": "Pair of shoes"}
        ],
        "offerStatus": [
          {"code": "Offer-Accept", "description": "Offer accepted"},
          {"code": "Offer-Offer", "description": "Offer"},
          {"code": "Offer-Reject", "description": "Offer rejected"}
        ],
        "insurance": [
          {"code": "Insurance-Basic", "description": "Basic", "price": "1.35"},
          {
            "code": "Insurance-Normal",
            "description": "Normal",
            "price": "2.67"
          },
          {
            "code": "Insurance-Premium",
            "description": "Premium",
            "price": "5.34"
          },
          {"code": "Insurance-Free", "description": "Free", "price": "0.00"}
        ]
      },
      "code": 200,
      "message": "success",
      "status": "success"
    };
  });
}

// ******************************************
Future<dynamic> itemsCanIBringApi() async {
  return Future.delayed(Duration(milliseconds: 2000), () {
    return {
      "ok": true,
      "count": 3,
      "itemsToBring": [
        {
          "name": 'Aerosol Insecticide',
          "carryOnBags": 'No',
          "checkedBags": 'Yes (Special Instructions)',
          "index": 0,
          "description": ''
        },
        {
          "name": 'Air Mattress with Built-in Pump',
          "carryOnBags": 'Yes (Special Instructions)',
          "checkedBags": 'Yes',
          "index": 1,
          "description": ''
        },
        {
          "name": 'Airbrush Make-up Machine',
          "carryOnBags": 'Yes',
          "checkedBags": 'Yes',
          "index": 2,
          "description": ''
        },
    ]
    };
  });
}

      dynamic flightResourse = {
        "_id" : "60d537946c6efd5d905c3113",
        "elementsCompact" : [ 
            {
                "code" : "Element-Documents",
                "name" : "Documents",
                "select" : true,
                "high" : 0,
                "width" : 0,
                "long" : 0,
                "weight" : 0
            }
        ],
        "elementsHandybag" : [],
        "type" : "flight",
        "emailSender" : "",
        "user" : "af034d38-5bef-4706-aa9c-7110f5a2adbc",
        "ad" : null,
        "cityDepartureAirport" : "Bogota (BOG)",
        "cityDestinationAirport" : "Cartagena (CTG)",
        "departureDate" : "1625011200000",
        "destinationDate" : "1625054400000",
        "flightNumber" : "0000",
        "reservationCode" : "000",
        "typePackageCompact" : true,
        "typePackageHandybag" : false,
        "insurance" : "Free",
        "state" : "publish",
        "statusFlight" : {
          "atTheFrontDoor": {"value": false, "date": "1624586133549"},
          "takingOff": {"value": false, "date": "1624586133549"},
          "landing": {"value": true, "date": "1624586133549"},
          "atTheExitDoor": {"value": false, "date": "1624586133549"},
          "delivered": {"value": false, "date": "1624586133549"},
        },
        "code" : "110323",
        "data" : null,
        "pay" : null,
        "active" : true,
        "created_on" : "1624586133549",
        "last_updated_on" : "1624586256686",
        "__v" : 0
    };
