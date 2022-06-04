// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/lanzamiento_text.dart';
import 'package:maando/src/utils/textos/onboarding_text.dart';
import 'package:maando/src/utils/textos/reviews_text.dart';
import 'package:maando/src/widgets/iconos.dart';


final blocNavigator = blocGeneral;
final pref = Preferencias();
Widget close(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushReplacementNamed(context, 'principal')
            }),
  );
}

Widget closeRateAndReview(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushNamed(context, 'history')
            }),
  );
}

Widget closeCreatePost(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushNamed(context, 'post')
            }),
  );
}

Widget closeFlightForm(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": false, "service": true}))
            }),
  );
}

Widget closeWhatCanIBring(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () =>
            {Navigator.pushNamed(context, 'create_flight_form')}),
  );
}

Widget closeWhatCanISend(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () =>
            {Navigator.pushNamed(context, 'create_ad_title_date_destination')}),
  );
}

Widget closeSearch(BuildContext context, imagen, page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () {
          if (page == 'home') {
            blocNavigator.homePrincipal();
            Navigator.pushReplacementNamed(context, 'principal');
          } else if (page == 'shipments') {
            blocNavigator.shipmentPrincipal();
            Navigator.pushReplacementNamed(context, 'principal',
                arguments: jsonEncode({"shipments": true, "service": false}));
          } else if (page == 'service') {
            blocNavigator.servicePrincipal();
            Navigator.pushReplacementNamed(context, 'principal',
                arguments: jsonEncode({"shipments": false, "service": true}));
          } else {
            blocNavigator.homePrincipal();
            Navigator.pushReplacementNamed(context, 'principal');
          }
        }),
  );
}

Widget closeOnboarding(BuildContext context, imagen) {
  final Responsive responsive = Responsive.of(context);
  return CupertinoButton(
    padding: EdgeInsets.all(0),
      child: Container(
        padding: EdgeInsets.all(responsive.ip(0.5)),
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromRGBO(173, 181, 189, 1)),
          borderRadius: BorderRadius.circular(6)
        ),
        child: Text('Skip',
        textAlign: TextAlign.start,
                  style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(2))),
      ),
      onPressed: () => {
            blocNavigator.shipmentPrincipal(),
            Navigator.pushReplacementNamed(context, 'create_account')
          });
}

Widget closenoti(BuildContext context, imagen, String bageBack) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              Navigator.pushNamed(context, bageBack)
            }),
  );
}

Widget closeAd(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.contain,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.shipmentPrincipal(),
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}))
            }),
  );
}

Widget closeFlight(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.shipmentPrincipal(),
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": false, "service": true}))
            }),
  );
}

Widget close2(BuildContext context, imagen) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.03,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushReplacementNamed(context, 'shipments_service_page',
                  arguments: jsonEncode({"shipments": false, "service": true}))
            }),
  );
}

Widget backFlight(BuildContext context, imagen, String page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.contain,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushNamed(context, page)
            }),
  );
}

// **********

Widget backAd(BuildContext context, imagen, String page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.servicePrincipal(),
              Navigator.pushNamed(context, page)
            }),
  );
}

Widget arrwBackYellow(BuildContext context, String page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(
          padding: EdgeInsetsDirectional.only(top: 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/general/icon - arrow back 1@3x.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        onPressed: () => {Navigator.pushNamed(context, page)}),
  );
}

Widget arrwBackYellowDetailFlightMatch(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(
          width: 22.0,
          height: 22.0,
          padding: EdgeInsetsDirectional.only(top: 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/general/icon - arrow back 1@3x.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        onPressed: () => {
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}))
            }),
  );
}

Widget arrwBackYellowPersonalizado(BuildContext context, String page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Container(),
        onPressed: () => {Navigator.pushNamed(context, page)}),
  );
}

Widget arrwBackYellowsignOut(BuildContext context, Function f) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(child: Container(), onPressed: () => {f()}),
  );
}

Widget arrwBackYellowShipmentSERVICE(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.shipmentPrincipal(),
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": false, "service": true}))
            }),
  );
}

Widget arrwBackYellowSHIPMENTSservice(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {
              blocNavigator.shipmentPrincipal(),
              Navigator.pushReplacementNamed(context, 'principal',
                  arguments: jsonEncode({"shipments": true, "service": false}))
            }),
  );
}

//*************************************** */
Widget arrwBackWorld(BuildContext context, page) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.03,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () {
          if (page == 'principal') {
            blocNavigator.homePrincipal();
            Navigator.pushReplacementNamed(context, 'principal');
          } else {
            Navigator.pushReplacementNamed(context, page);
          }
        }),
  );
}

// *************************************

Widget crearBotonCrearCuenta() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        pref.guardarOnboarding('no-onboarding');
        Navigator.pushReplacementNamed(context, 'create_account');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        height: MediaQuery.of(context).size.height * 0.08,
        margin: EdgeInsets.symmetric(
            horizontal: variableGlobal.margenPageWith(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(onboardingText.createAccount(),
                style: TextStyle(
                  color: Color.fromRGBO(255, 206, 6, 1),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
                )),
            page2(context)
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 0.5, color: Colors.black)),
      elevation: 5.0,
      color: Color.fromRGBO(33, 36, 41, 1),
      textColor: Colors.yellow,
    );
  });
}

// *************************************

Widget send() {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        print('Send');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.09,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text('Create account',
                style: TextStyle(
                  color: Color.fromRGBO(255, 206, 6, 1),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                )),
            page1(context)
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 0.5, color: Colors.white)),
      elevation: 5.0,
      color: Color.fromRGBO(33, 36, 41, 1),
      textColor: Colors.white,
    );
  });
}

// *************************************

Widget progeressOnboardong1(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        progress('assets/images/onboarding/line-8-stroke.png', 35.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0)
      ],
    ),
  );
}

// *************************************

Widget progeressOnboardong2(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/line-8-stroke.png', 35.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0)
      ],
    ),
  );
}

// *************************************

Widget progeressOnboardong3(BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/Ellipse 2@3x.png', 15.0, 15.0),
        SizedBox(
          width: 10.0,
        ),
        progress('assets/images/onboarding/line-8-stroke.png', 35.0, 15.0)
      ],
    ),
  );
}

// *************************************

Widget faceId(BuildContext context, imagen) {
  return Container(
    width: 24.0,
    height: 24.0,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(imagen),
        fit: BoxFit.contain,
      ),
    ),
    child: CupertinoButton(
        child: Container(),
        onPressed: () => {print('Aqui se hace el login por face')}),
  );
}
// *************************************

Widget notification(BuildContext context, String pageBack) {
  blocSocket.socket.getUserEmiter(preference.prefsInternal.get('email'));
  final Responsive  responsive = Responsive.of(context);
  return Container(
    child: CupertinoButton(
      onPressed: () {
        Navigator.pushNamed(context, 'notification', arguments: pageBack);
      },
      minSize: 0,
      padding: EdgeInsets.all(0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(MediaQuery.of(context).size.height * 0.01),
            width: variableGlobal.iconsAppBar(context),
            height: variableGlobal.iconsAppBar(context),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/general/NOTIFICATIONS.png'),
                fit: BoxFit.contain,
              ),
            ),
            child: Container()
            // SvgPicture.asset('assets/images/general/NOTIFICATIONS- 2 .svg',
            //            color: Colors.black,
            //            fit: BoxFit.contain, height: MediaQuery.of(context).size.width * 0.1, 
            //            width: MediaQuery.of(context).size.width * 0.1),
          ),
          Positioned(
            // left: variableGlobal.positionetNotifications(context)['left'],
            // bottom: variableGlobal.positionetNotifications(context)['bottom'],
            left: responsive.ip(1.7),
            top: responsive.ip(0),
            child: StreamBuilder(
                stream: blocSocket.userStream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    var valueMap = snapshot.data;
                    // print('LOS MENSAGES    ${valueMap["messages"]}');
                    if (valueMap != null) {
                      List<dynamic> lengthMessagesView = [];
                      for (var m in valueMap["messages"]) {
                        if (m['view'] == false) {
                          lengthMessagesView.add(m);
                        }
                      }

                      if(lengthMessagesView.length > 0){
                          return Container(
                            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.009),
                            decoration: BoxDecoration(
                                // border: Border.all(color: Colors.white, width: 2),
                                shape: BoxShape.circle,
                                color: Colors.red),
                            child: Center(
                                child: Text(
                              '${lengthMessagesView.length}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: responsive.ip(1.1)),
                            )),
                          );
                      }else{
                        return Container();
                      }
                      } else {
                        return Container();
                      }
                    } else if(snapshot.hasError) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.05,
                        height: MediaQuery.of(context).size.width * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.red),
                      );
                    }else {
                    return Container();
                  }
                }),
          )
        ],
      ),
    ),
  );
}

// *************************************

Widget notiworld(BuildContext context) {
  return Container(
    width: variableGlobal.iconsAppBar(context),
    height: variableGlobal.iconsAppBar(context),
    decoration: BoxDecoration(
      image: DecorationImage(
        
        image: AssetImage('assets/images/general/Posts.png'),
        fit: BoxFit.contain,
      ),
    ),
    child: CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.all(0),
        child: Container(),
        onPressed: () => {
          Navigator.pushNamed(context, 'post2')
          // Navigator.of(context).push(MaterialPageRoute(
          // builder: (BuildContext context) => WebViewChatPage(url: 'https://tawk.to/chat/6140ba6cd326717cb6816b90/1ffidgdol')))
        }),
  );
}

// *************************************

Widget notiworldLanzamiento(BuildContext context) {
  return Container(
    // margin: EdgeInsets.symmetric(horizontal: 115.0),
    width: MediaQuery.of(context).size.width * 0.07,
    height: MediaQuery.of(context).size.width * 0.07,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - userx.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

/*************************************** */
Widget notilogout(BuildContext context, miwidth) {
  return Container(
    width: miwidth * 0.25,
    // height: miwidth * 0.2,
    child: GestureDetector(
      child: Text(lanzamientoText.logout(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Color.fromRGBO(255, 206, 6, 1),
            fontSize: miwidth * 0.04,
            fontWeight: FontWeight.bold,
          )),
      onTap: () {
        Navigator.pushReplacementNamed(context, 'onboarding');
      },
    ),
  );
}

//****************************************** */
Widget notiacces(BuildContext context, miwidth) {
  return Container(
    width: miwidth * 0.5,
    // height: miwidth * 0.2,
    child: GestureDetector(
      child: Text(lanzamientoText.admina(),
          textAlign: TextAlign.end,
          style: TextStyle(
            color: Color.fromRGBO(255, 206, 6, 1),
            fontSize: miwidth * 0.04,
            fontWeight: FontWeight.bold,
          )),
      onTap: () {
        Navigator.pushReplacementNamed(context, 'principal');
      },
    ),
  );
}
// *************************************

Widget home(BuildContext context) {
  return StreamBuilder<List<bool>>(
      stream: blocNavigator.navigationStream,
      builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshopt) {
        if (snapshopt.hasData) {
          if (snapshopt.data[0] == true) {
            return Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.008,
                  left:  MediaQuery.of(context).size.width * 0.08),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width * 0.075,
                    height: MediaQuery.of(context).size.width * 0.075,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/general/icon-home-selected@3x.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: CupertinoButton(
                        child: Container(),
                        onPressed: () {
                          // blocNavigator.homePrincipal();
                        }),
                  ),
                  Material(
                      type: MaterialType.transparency,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.017,
                            left: MediaQuery.of(context).size.width * 0.029),
                        child: Text(
                          '.',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.07,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ))
                ],
              ),
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              margin: EdgeInsets.only(left:  MediaQuery.of(context).size.width * 0.08),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/general/icon-home-2@3x.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: CupertinoButton(
                  child: Container(),
                  onPressed: () {
                    blocNavigator.homePrincipal();
                  }),
            );
          }
        } else {
          return Container();
        }
      });
}
// *************************************

Widget megafono(BuildContext context) {
  return StreamBuilder<List<bool>>(
      stream: blocNavigator.navigationStream,
      builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshopt) {
        if (snapshopt.hasData) {
          if (snapshopt.data[1] == true) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  width: MediaQuery.of(context).size.width * 0.075,
                  height: MediaQuery.of(context).size.width * 0.075,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/general/megafono2_3@3x.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: CupertinoButton(
                      child: Container(),
                      onPressed: () {
                        // blocNavigator.shipmentPrincipal();
                      }),
                ),
                Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.026,
                          left: MediaQuery.of(context).size.width * 0.029),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ))
              ],
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              margin: EdgeInsets.only(bottom: 3.0),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/general/megafono2_3@3x.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: CupertinoButton(
                  child: Container(),
                  onPressed: () {
                    blocNavigator.shipmentPrincipal();
                  }),
            );
          }
        } else {
          return Container();
        }
      });
}
// *************************************

Widget box(BuildContext context) {
  return StreamBuilder<List<bool>>(
      stream: blocNavigator.navigationStream,
      builder: (BuildContext context, AsyncSnapshot<List<bool>> snapshopt) {
        if (snapshopt.hasData) {
          if (snapshopt.data[2] == true) {
            return Stack(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.008, right:  MediaQuery.of(context).size.width * 0.08),
                  width: MediaQuery.of(context).size.width * 0.075,
                  height: MediaQuery.of(context).size.width * 0.075,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image:
                          AssetImage('assets/images/general/icon-box-1@3x.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                  child: CupertinoButton(
                      child: Container(),
                      onPressed: () {
                        // blocNavigator.servicePrincipal();
                      }),
                ),
                Material(
                    type: MaterialType.transparency,
                    child: Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.026,
                          left: MediaQuery.of(context).size.width * 0.029),
                      child: Text(
                        '.',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.07,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ))
              ],
            );
          } else {
            return Container(
              width: MediaQuery.of(context).size.width * 0.075,
              height: MediaQuery.of(context).size.width * 0.075,
              margin: EdgeInsets.only(right:  MediaQuery.of(context).size.width * 0.08),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      'assets/images/general/icon box -  unselected@2x.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: CupertinoButton(
                  child: Container(),
                  onPressed: () {
                    blocNavigator.servicePrincipal();
                  }),
            );
          }
        } else {
          return Container();
        }
      });
}
// *************************************

Widget search(BuildContext context, String page) {
  return Container(
    width: variableGlobal.iconsAppBar(context),
    height: variableGlobal.iconsAppBar(context),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/SEARCH 2.png'),
        fit: BoxFit.contain,
      ),
    ),
    child: CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.all(0),
        child: Container(
          width: variableGlobal.iconsAppBar(context),
            height: variableGlobal.iconsAppBar(context),
          child: SvgPicture.asset('assets/images/general/SEARCH.svg',
                       fit: BoxFit.contain, height: MediaQuery.of(context).size.width * 0.1, 
                       width: MediaQuery.of(context).size.width * 0.1),
        ),
        onPressed: () {
          Navigator.pushNamed(context, 'search_9_4',
              arguments: page);
        }),
  );
}

// ******************************************
Widget botonTresPuntosGrises(BuildContext context, double minSize, Function f) {
  return CupertinoButton(
    onPressed: f,
    padding: EdgeInsets.all(0),
    minSize: minSize,
    child: Container(
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width * 0.012,
            height: MediaQuery.of(context).size.width * 0.012,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(173, 181, 189, 1.0)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.012,
            height: MediaQuery.of(context).size.width * 0.012,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(173, 181, 189, 1.0)),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.012,
            height: MediaQuery.of(context).size.width * 0.012,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100.0),
                color: Color.fromRGBO(173, 181, 189, 1.0)),
          ),
        ],
      ),
    ),
  );
}

Widget botonMAS(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(right: 20.0, top: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          backgroundColor: Color.fromRGBO(255, 206, 6, 1),
          tooltip: 'Increment Counter',
          child: Text('+',
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1),
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              )),
          onPressed: () {
            print('MAS');
          },
        ),
      ],
    ),
  );
}

// *************************************
Widget boton_plus_square(BuildContext context, Function funcion) {
  return CupertinoButton(
    padding: EdgeInsets.all(0),
    onPressed: funcion,
    child: Container(
      width: MediaQuery.of(context).size.height * 0.067,
      height: MediaQuery.of(context).size.height * 0.067,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 206, 6, 1),
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.height * 0.022)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('+',
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1),
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    ),
  );
}

//********************************** */
Widget boton_plus_square_shipment_servise(
    BuildContext context, Function funcion) {
  return CupertinoButton(
    padding: EdgeInsets.all(0),
    onPressed: funcion,
    child: Container(
      width: MediaQuery.of(context).size.height * 0.067,
      height: MediaQuery.of(context).size.height * 0.067,
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 206, 6, 1),
          borderRadius: BorderRadius.circular(
              MediaQuery.of(context).size.height * 0.025),
              image: DecorationImage(
                image: AssetImage('assets/images/general/floating button@3x.png'),
                fit: BoxFit.contain,
              )),
    ),
  );
}

//********************************** */
Widget boton_plus_square_yellow(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(right: 20.0, top: 15.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          tooltip: 'Increment Counter',
          child: Text('+',
              style: TextStyle(
                color: Color.fromRGBO(255, 206, 6, 1),
                fontSize: 50.0,
                fontWeight: FontWeight.bold,
              )),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: BorderSide(
                  width: 5.0, color: Color.fromRGBO(255, 206, 6, 1))),
          onPressed: () {
            print('MAS');
          },
        ),
      ],
    ),
  );
}

//************************************ */

Widget next(BuildContext context, String page) {
  final Responsive responsive = Responsive.of(context);
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        Navigator.pushNamed(
          context,
          page,
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.07,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text(generalText.next(),
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 0.5),
                fontSize: responsive.ip(2),
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    );
  });
}

//********************************************** */
Widget send2(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //       type: PageTransitionType.rightToLeft,
        //       duration: Duration(milliseconds: 500),
        //       child: page,
        //       inheritTheme: true,
        //       ctx: context),
        // );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: 160,
        height: 48,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text('Send',
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1.0),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      color: Color.fromRGBO(255, 206, 6, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    );
  });
}

// *************************************
Widget nextpublishAd(BuildContext context, String page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Center(
          child: Text(generalText.publish(),
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 0.5),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    );
  });
}

// *************************************
Widget nextpublishFlight(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {},
      child: Container(
        width: MediaQuery.of(context).size.width * 0.35,
        height: MediaQuery.of(context).size.height * 0.07,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text(generalText.publish(),
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 0.5),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    );
  });
}
//************************************ */

Widget back(BuildContext context, Widget page) {
  final Responsive responsive = Responsive.of(context);
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.19,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Center(
          child: Text(generalText.back(),
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 0.5),
                fontSize: responsive.ip(2),
                fontWeight: FontWeight.w500,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(33, 36, 41, 1))),
    );
  });
}

//*************************************************************** */
Widget backrequest(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Container(
        // width: 74,
        // height: 48,
        //
        margin: EdgeInsets.fromLTRB(
            12.0, 0.0, 12.0, MediaQuery.of(context).size.height * 0.01),
        // width: MediaQuery.of(context).size.width * 0.13,
        // height: MediaQuery.of(context).size.height * 0.07,
        child: Center(
          child: Text('Reject',
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 0.5),
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1.0),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(15.0),
      //   // side: BorderSide(width: 1.5, color: Color.fromRGBO(33, 36, 41, 1)
      //   // )
      // ),
    );
  });
}

//************************************************************* */
Widget back2(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Container(
        width: 100,
        height: 48,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text('Cancel',
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1.0),
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(33, 36, 41, 1))),
    );
  });
}

//***********************************************
Widget back_to_home(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        blocNavigator.homePrincipal();
        Navigator.pushReplacementNamed(context, 'principal');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.300,
        height: MediaQuery.of(context).size.height * 0.070,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text(reviewText.backToHome(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1.0),
                fontSize: 16.0,
                fontWeight: FontWeight.normal,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(33, 36, 41, 1))),
    );
  });
}

//*************************************************** */
Widget reload(BuildContext context, Widget page) {
  return StreamBuilder(builder: (BuildContext context, AsyncSnapshot snapshot) {
    return RaisedButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.250,
        height: MediaQuery.of(context).size.height * 0.070,
        // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
        child: Center(
          child: Text(generalText.reload(),
              style: TextStyle(
                color: Color.fromRGBO(33, 36, 41, 1.0),
                fontSize: MediaQuery.of(context).size.width * 0.050,
                fontWeight: FontWeight.normal,
              )),
        ),
      ),
      color: Color.fromRGBO(251, 251, 251, 1),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: BorderSide(width: 1.5, color: Color.fromRGBO(33, 36, 41, 1))),
    );
  });
}

/**************************************************** */
Widget circuloVerde(BuildContext context, int from, int to) {
final Responsive responsive = Responsive.of(context);
  return Container(
    width: MediaQuery.of(context).size.height * 0.08,
    height: MediaQuery.of(context).size.height * 0.08,
    child: Center(
        child: Text('$from ${generalText.of()} $to',
            style: TextStyle(
                color: Color.fromRGBO(0, 0, 0, 1.0),
                fontWeight: FontWeight.bold,
                fontSize: responsive.ip(1.5)))),
    decoration: BoxDecoration(
        border:
            Border.all(color: Color.fromRGBO(45, 222, 152, 1.0), width: 3.0),
        borderRadius: BorderRadius.circular(100.0)),
  );
}

//********************************************** */

Widget entrepreneur(
  BuildContext context,
) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.15,
    height: MediaQuery.of(context).size.width * 0.15,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/mundo@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

List<String> listaImagenes = [];
List<String> uploadImgs(List<File> files, String id, BuildContext context) {
  if (files.length == 0) {
    return [];
  } else if (files.length == 1) {
    firebaseStorage
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      Future.delayed(const Duration(milliseconds: 5000), () {
        firebaseStorage
            .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
            .then((urlImagen1) {
          listaImagenes.add(urlImagen1);
        });
      });
    });
    return [];
  } else if (files.length == 2) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        Future.delayed(const Duration(milliseconds: 10000), () {
          firebaseStorage
              .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
              .then((urlImagen1) {
            ;
            listaImagenes.add(urlImagen1);
          });
          firebaseStorage
              .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 2)
              .then((urlImagen2) {
            listaImagenes.add(urlImagen2);
          });
        });
      });
    });
    return [];
  } else if (files.length == 3) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          Future.delayed(const Duration(milliseconds: 10000), () {
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
                .then((urlImagen1) {
              listaImagenes.add(urlImagen1);
            });
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 2)
                .then((urlImagen2) {
              listaImagenes.add(urlImagen2);
            });
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 3)
                .then((urlImagen3) {
              listaImagenes.add(urlImagen3);
            });
          });
        });
      });
    });
    return [];
  } else if (files.length == 4) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          firebaseStorage //  ============>>>>>  img4
              .subirImagen(
                  files[3],
                  '${prefsInternal.prefsInternal.get('email')}/$id/${4.toString()}',
                  context)
              .then((img4) {
            Future.delayed(const Duration(milliseconds: 10000), () {
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 1)
                  .then((urlImagen1) {
                listaImagenes.add(urlImagen1);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 2)
                  .then((urlImagen2) {
                listaImagenes.add(urlImagen2);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 3)
                  .then((urlImagen3) {
                listaImagenes.add(urlImagen3);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 4)
                  .then((urlImagen4) {
                listaImagenes.add(urlImagen4);
              });
            });
          });
        });
      });
    });
    return [];
  } else if (files.length == 5) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          firebaseStorage //  ============>>>>>  img4
              .subirImagen(
                  files[3],
                  '${prefsInternal.prefsInternal.get('email')}/$id/${4.toString()}',
                  context)
              .then((img4) {
            firebaseStorage //  ============>>>>>  img5
                .subirImagen(
                    files[4],
                    '${prefsInternal.prefsInternal.get('email')}/$id/${5.toString()}',
                    context)
                .then((img5) {
              Future.delayed(const Duration(milliseconds: 10000), () {
                firebaseStorage
                    .obtenerImagen(
                        prefsInternal.prefsInternal.get('email'), id, 1)
                    .then((urlImagen1) {
                  listaImagenes.add(urlImagen1);
                });
                firebaseStorage
                    .obtenerImagen(
                        prefsInternal.prefsInternal.get('email'), id, 2)
                    .then((urlImagen2) {
                  listaImagenes.add(urlImagen2);
                });
                firebaseStorage
                    .obtenerImagen(
                        prefsInternal.prefsInternal.get('email'), id, 3)
                    .then((urlImagen3) {
                  listaImagenes.add(urlImagen3);
                });
                firebaseStorage
                    .obtenerImagen(
                        prefsInternal.prefsInternal.get('email'), id, 4)
                    .then((urlImagen4) {
                  listaImagenes.add(urlImagen4);
                });
                firebaseStorage
                    .obtenerImagen(
                        prefsInternal.prefsInternal.get('email'), id, 5)
                    .then((urlImagen5) {
                  listaImagenes.add(urlImagen5);
                });
              });
            });
          });
        });
      });
    });
    return [];
  } else {
    return [];
  }
}
