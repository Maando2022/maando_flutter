// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/login_face_Touch_id_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maando/src/utils/responsive.dart';

class LoginFaceIDPage extends StatefulWidget {
  // const LoginFaceIDPage({Key key}) : super(key: key);

  @override
  _LoginFaceIDPageState createState() => _LoginFaceIDPageState();
}

class _LoginFaceIDPageState extends State<LoginFaceIDPage> {
  final _localAutentication = LocalAuthentication();

  bool _canCheckBiometric = false;
  String _autorizedOrNot = 'No Autorized';
  List<BiometricType> _availableBiometricType = List<BiometricType>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final blocGeneral = ProviderApp.ofGeneral(context);
    // blocGeneral.tokenExpired?.cancel();

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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      iconFace1(context),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.0),
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
                          height: 16.6,
                        ),
                        Text(
                          loginFaceTouchIdText.shortDescription(),
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
                            'assets/images/face_1/icon face ID 1@3x.png'),
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
                    loginFaceTouchIdText.loginWithFaceId(),
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: responsive.ip(2)),
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: height * 0.258,
          // ),
          // ******************************

          Container(
              margin: EdgeInsets.only(
                //top: height * 0.035,
                // right: variableGlobal.margenPageWithFlight(context),
                //left: variableGlobal.margenPageWithFlight(context),
                bottom: height * 0.03,
                // bottom: variableGlobal.margenBotonesAbajo(context),
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
        padding: EdgeInsets.symmetric(horizontal: 15.0),
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
      var isSutorized = await _localAutentication.authenticateWithBiometrics(
          localizedReason: 'Please autenticate to to complete your transaction',
          useErrorDialogs: true,
          stickyAuth: true);
    } on PlatformException catch (e) {
      print(e);
    }

    if (!mounted) return;

    setState(() {
      if (isSutorized) {
        _autorizedOrNot = 'Authorized';
      } else {
        _autorizedOrNot = 'No Autorized';
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
