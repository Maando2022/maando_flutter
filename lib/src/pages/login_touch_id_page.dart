// @dart=2.9
import 'dart:io';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/login_face_Touch_id_text.dart';
import 'package:maando/src/utils/textos/login_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class LoginTouchIDPage extends StatefulWidget {
  // const LoginTouchIDPage({Key key}) : super(key: key);

  @override
  _LoginTouchIDPageState createState() => _LoginTouchIDPageState();
}

class _LoginTouchIDPageState extends State<LoginTouchIDPage> {
  final _localAutentication = LocalAuthentication();
  Http _http = Http();
  final preference = Preferencias();

  bool _canCheckBiometric = false;

  String _autorizedOrNot = 'No Autorized';

  List<BiometricType> _availableBiometricType = List<BiometricType>();

  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preference.guardarOnboarding('no-onboarding');
    // devolverCiudadActual().then((value) =>
    //     {ciudad = value[0].locality, print('Esta es la cieudad $ciudad')});
    preference.obtenerPreferencias();
    preference.limpiarPreferencias();
    _autorizedNow();
  }

  @override
  Widget build(BuildContext context) {
    final blocGeneral = ProviderApp.ofGeneral(context);
    blocGeneral.tokenExpired?.cancel();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin:
                EdgeInsets.only(top: variableGlobal.margenTopGeneral(context)),
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context), left: variableGlobal.margenPageWith(context)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        iconFace1(context),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.04),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          loginFaceTouchIdText.welcomeBack(),
                          style: TextStyle(
                            fontSize: responsive.ip(3.5),
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: height * 0.03,
                        ),
                        Text(
                          loginText.joinThisAdventure(),
                          style: TextStyle(fontSize: responsive.ip(2)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: height * 0.22,
          // ),
          // ******************************

          Container(
            child: Center(
              child: Column(
                children: <Widget>[
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 115.0),
                    width: width * 0.25,
                    height: width * 0.25,
                    // padding: EdgeInsetsDirectional.only(top: 0.0),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/touch_1/icon touch ID 1@3x.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                    child: CupertinoButton(
                        child: Container(), onPressed: () => {_autorizedNow()}),
                  ),
                  SizedBox(
                    height: width * 0.09,
                  ),
                  Text(
                    loginFaceTouchIdText.loginWithTouchId(),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: responsive.ip(2)),
                  ),
                ],
              ),
            ),
          ),
          Container(
              margin: EdgeInsets.only(
                bottom: height * 0.03,
              ),
              child: _loginWithEmail(responsive, context))
        ],
      ),
    );
  }

  Widget _loginWithEmail(Responsive responsive, BuildContext context) {
    return CupertinoButton(
        child: Text(loginFaceTouchIdText.loginWithEmail(),
            style:
                TextStyle(color: Color.fromRGBO(0, 0, 0, 1.0), fontSize: responsive.ip(2))),
        color: Color.fromRGBO(255, 255, 255, 1.0),
        padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
        onPressed: () {
          Navigator.pop(context);
        });
  }

  // **************************

  Future<void> _checkBiometric() async {
    List<BiometricType> listofBiometric;
    try {
      listofBiometric = await _localAutentication.getAvailableBiometrics();
      print('Paso  ${listofBiometric}');
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      _availableBiometricType = listofBiometric;
    });
  }

  // ---------------------------

  Future<void> _autorizedNow() async {
    bool isSutorized = false;
    try {
      isSutorized = await _localAutentication.authenticateWithBiometrics(
          localizedReason: 'Please autenticate to to complete your transaction',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (!mounted) return;

    setState(() {
      if (isSutorized) {
        _autorizedOrNot = 'Authorized';

          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

          _http.findUsersFormBiometric(context: context).then((value) {
             final valueMap = json.decode(value);
             if(valueMap["ok"] == true){
               if(valueMap["count"] <= 0){
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]);})
                  .then((_) {
                    Navigator.pop(context);
                  });
                }else if(valueMap["count"] == 1){
                   _login(valueMap, 0);
                  return;
                }else{
                  Navigator.pop(context);
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (_){
                      return AlertDialog(
                        scrollable: true,
                        title: iconFace2(context),
                        actions: [
                          RaisedButton(
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: Text(generalText.cancel(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromRGBO(255, 206, 6, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.width * 0.05)),
                            ),
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(color: Colors.black, width: 1)),
                            padding: EdgeInsets.symmetric(horizontal: 15.0),
                            onPressed: () {
                               Navigator.of(context).pop();
                            })
                        ],
                        content: Container(
                          height: MediaQuery.of(context).size.height * 0.15,
                          child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: valueMap["count"],
                                itemBuilder: (context, index) {

                          return Column(
                            children: [
                              ListTile(
                                leading: FutureBuilder<dynamic>(
                                      future: firebaseStorage.obtenerAvatar(valueMap["users"][index]["email"]),
                                      builder: (BuildContext context, snapshot) {
                                        if(snapshot.hasData){
                                          return Container(
                                                width: MediaQuery.of(context).size.width * 0.09,
                                                height: MediaQuery.of(context).size.width * 0.09,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(100.0),
                                                  image: DecorationImage(
                                                        image: NetworkImage(snapshot.data),
                                                        fit: BoxFit.contain,
                                                      )
                                                ),
                                              );
                                        }else if(snapshot.hasError){
                                          return Container();
                                        }else{
                                          return Container();
                                        }
                                      }),
                                title: Text(valueMap["users"][index]["email"],
                                    style: TextStyle(
                                      color: Color.fromRGBO(173, 181, 189, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: MediaQuery.of(context).size.height * 0.021)),
                                      onTap: (){
                                        _login(valueMap, index);
                                      },
                                   ),
                            ],
                          );
                             }),
                        )

                      );
                    }
                  );
                }
             }else{
               
             }
          });
     
      } else {
        print('Todo mal >>>>>>>>>>>>>  ${isSutorized}');
        _autorizedOrNot = 'No Autorized';
      }
    });
  }

  // *********************************
  _login(valueMap, index) {
      _http.loginBiometrics(context: context, email: valueMap["users"][index]["email"]).then((valueLogin) {
        final valueMapLogin = json.decode(valueLogin);
        // print(valueLogin);
        if (valueMapLogin["ok"] == true) {
          firebaseStorage.obtenerAvatar(valueMapLogin["usuario"]["email"]).then((img)async{
            await preference.prefsInternal.setString('urlAvatar', img);
          });
          Navigator.pop(context);
          preference.saveSesion(
            email: valueMapLogin["usuario"]["email"],
            langCode: Platform.localeName.substring(0, 2),
            expire: convertirMilliSecondsToDateTime(
                    int.parse(valueMapLogin["usuario"]["last_updated_on"]))
                .toString(),
            lastActivity: new DateTime.now().toString(),
            fullName: valueMapLogin["usuario"]["name"],
            phone: valueMapLogin["usuario"]["phone"],
            country: valueMapLogin["usuario"]["country"],
            city: valueMapLogin["usuario"]["city"],
            provider: 'form',
          );
          Navigator.pushReplacementNamed(context, 'principal');
        } else {
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
        }
      });
}
  // *********************************

  Future _configurarBiometria() async {
    bool flag = true;

    if (flag) {
      bool authenticated = false;

      const androidString = const AndroidAuthMessages(
          cancelButton: 'Cancel',
          goToSettingsButton: 'Settings',
          signInTitle: 'Authenticate',
          // fingerprintHint: 'Touch the sensor',
          // fingerprintNotRecognized: 'Unrecognized footprint',
          // fingerprintSuccess: 'Recognized footprint',
          goToSettingsDescription: 'Please configure your footprint');

      const iosString = const IOSAuthMessages(
          cancelButton: 'cancel',
          goToSettingsButton: 'settings',
          goToSettingsDescription: 'Please set up your Touch ID.',
          lockOut: 'Please reenable your Face ID');

      try {
        authenticated = await _localAuthentication.authenticateWithBiometrics(
            localizedReason: 'Autentíquese para acceder.',
            useErrorDialogs: true,
            stickyAuth: true,
            androidAuthStrings: androidString,
            iOSAuthStrings: iosString);

        if ((!authenticated)) {
          exit(0);
        } else {}
      } catch (e) {
        print('Error  ====> $e');
      }

      if ((!mounted)) {
        return;
      }
    }
  }
}
