// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/login_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/http_v2/http_v2.dart';
import 'package:maando/src/services/loginApple.dart';
import 'package:maando/src/services/loginFacebook.dart';
import 'package:maando/src/services/loginGoogle.dart';
import 'package:maando/src/services/registerMaando.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/login_text.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/separadores.dart';
import 'package:maando/src/utils/responsive.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Http _http = Http();
  final preference = Preferencias();
  List<BiometricType> _availableBiometrisTypes = List<BiometricType>();
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool tieneBiometriaFaceId = false;
  bool tieneBiometriaTouchId = false;

  // ---------------

  TextEditingController controladorEmail = TextEditingController();

  TextEditingController controladorPassword = TextEditingController();
  bool obscureText = true;
  // String ciudad;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preference.guardarOnboarding('no-onboarding');
    // devolverCiudadActual().then((value) =>
    // {ciudad = value[0].locality, print('Esta es la cieudad $ciudad')});

    preference.obtenerPreferencias();
    preference.limpiarPreferencias();
    handleSignOutGoogle();
    logOutFacebook();
    blocGeneral.streamNull();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    // Future.delayed(Duration(seconds: 0), (){
    //    showDialog(context: context,
    //               barrierColor: Colors.transparent,
    //               barrierDismissible: false,
    //               builder: (BuildContext context){
    //                 return loading(context);
    //               });
    // });
    


    return WillPopScope(
       onWillPop: () async => false,
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(
                          top: variableGlobal.margenTopGeneral(context)),
                      child: Center(
                        child: iconFace1(context),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: variableGlobal.margenPageWith(context)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text(
                            loginText.login(),
                            style: TextStyle(
                              fontSize: responsive.ip(3.5),
                              fontWeight: FontWeight.bold
                            ),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Text(
                            loginText.shortDescription(),
                            style: TextStyle(fontSize: responsive.ip(2)),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.035),
                    // **************************************** BOTON DE LOGIN DE APPLE
                    Container(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    variableGlobal.margenPageWith(context)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                //  BOTON DE APPLE
                                FutureBuilder(
                                    future: _validarversion(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data == true) {
                                          return Container(
                                              child: Center(
                                                  child: 
                                                  CupertinoButton(
                                                    padding: EdgeInsets.all(0),
                                                    // minSize: 0,
                                                    onPressed: ()=>{loginApple(context)},
                                                    child: Container(
                                                        height: height * 0.07,
                                                        width: width,
                                                        decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: AssetImage('assets/images/general/apple button (bk).png'),
                                                              fit: BoxFit.fill),
                                                        ),
                                                      ),
                                                  )
                                              ));
                                        } else {
                                          return Container();
                                        }
                                      } else if (snapshot.hasError) {
                                        return Container();
                                      } else {
                                        return Container();
                                      }
                                    }),

                                SizedBox(
                                  height: height * 0.025,
                                ),

                                // ------------------------------------------------------------------->>>>>>>>>>> BOTON DE LOGIN DE GOOGLE
                                RaisedButton(
                                  elevation: 0,
                                  onPressed: () {
                                    loginGoogle(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.02),
                                    child:Container(
                                      child: Text(loginText.logintWithgoogle(),
                                        textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: responsive.ip(2))),
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(173, 181, 189, 1))),
                                  // elevation: 5.0,
                                  color: Colors.white,
                                  textColor: Colors.white,
                                ),
                                SizedBox(
                                  height: height * 0.025,
                                ),
                                // ------------------------------------------------------------------->>>>>>>>>>> BOTON DE LOGIN DE FACEBOOK
                                RaisedButton(
                                  elevation: 0,
                                  onPressed: () {
                                    _loginFacebook(context);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.symmetric(
                                        vertical: height * 0.02),
                                    child:Container(
                                      child: Text(loginText.logintWithFacebook(),
                                      textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: responsive.ip(2))),
                                    ),
                                    // textAlign: TextAlign.start,
                                  ),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          color:
                                              Color.fromRGBO(173, 181, 189, 1))),
                                  color: Colors.white,
                                  textColor: Colors.white,
                                ),
                                SizedBox(
                                  height: height * 0.025,
                                ),
                                // VALIDAMOS EL SEPARADOR
                                separador1(context),
                                SizedBox(
                                  height: height * 0.025,
                                ),
                              ],
                            ),
                          ),

                          // SizedBox(height: _keyboard),

                          _loginForm(responsive, context, height, width),
                          // SizedBox(height: 30.0),
                          SizedBox(
                            height: height * 0.04,
                          ),

                          _options(responsive),
                          // SizedBox(
                          //   height: height * 0.10,
                          // )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: height * 0.18,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: variableGlobal.margenPageWith(context)),
                  child: Material(
                    child: Row(
                      children: <Widget>[
                        CupertinoButton(
                            child: Text(loginText.dontHaveAnAccount(),
                                style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: responsive.ip(1.8))),
                            color: Color.fromRGBO(251, 251, 251, 1),
                            padding: EdgeInsets.all(0),
                            onPressed: () {
                              Navigator.pushNamed(context, 'create_account');
                            }),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Text(loginText.joinMaando(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontSize: responsive.ip(1.8)))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget _loginForm(Responsive responsive, BuildContext context, double height, double width) {
    final bloc = ProviderApp.of(context);
    final blocGeneral = ProviderApp.ofGeneral(context);
    // blocGeneral.tokenExpired?.cancel();
    return Column(
      children: <Widget>[
        _crearEmail(responsive, bloc),
        SizedBox(height: height * 0.03),
        _crearPassword(responsive, bloc, height, width),
        SizedBox(height: height * 0.03),
        _crearBotonLogin(responsive, bloc, height, width),
      ],
    );
  }

  Widget _crearEmail(Responsive responsive, LoginBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                style: TextStyle(
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                controller: controladorEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: loginText.email(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(18.0),
                    ),
                  ),
                ),
                onChanged: (value) => {bloc.changeEmail(value)}),
          );
        });
  }

  Widget _crearPassword(Responsive responsive, LoginBloc bloc, double height, double width) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
              cursorHeight: 20,
                style: TextStyle(
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                obscureText: obscureText,
                decoration: InputDecoration(

                  suffixIcon: CupertinoButton(
                      child: Icon(Icons.visibility,
                          color: Color.fromRGBO(230, 230, 230, 1)),
                      onPressed: () {
                        setState(() {
                          (obscureText == false)
                              ? obscureText = true
                              : obscureText = false;
                        });
                      }),
                  hintText: loginText.password(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(18.0),
                    ),
                  ),
                ),
                onChanged: (value) => {
                      bloc.changePassword(value),
                    }),
          );
        });
  }

  Widget _crearBotonLogin(Responsive responsive, LoginBloc bloc, double height, double width) {
    return Container(
      height: height * 0.08,
      margin: EdgeInsets.symmetric(
          horizontal: variableGlobal.margenPageWith(context)),
      child: StreamBuilder(
          stream: bloc.formValidarStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return RaisedButton(
              onPressed: snapshot.hasData ? () => _login(context, bloc) : null,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(loginText.login(),
                        style: TextStyle(
                          color: Color.fromRGBO(255, 206, 6, 1),
                          fontSize: responsive.ip(2),
                          fontWeight: FontWeight.bold,
                        )),
                    page1(context)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.black, width: 0.5)),
              // elevation: 5.0,
              color: Color.fromRGBO(33, 36, 41, 1.0),
              textColor: Colors.white,
            );
          }),
    );
  }

  Widget _options(Responsive responsive) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: variableGlobal.margenPageWith(context)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CupertinoButton(
              padding: EdgeInsets.all(0),
              child: Text(loginText.forgotYourPassword(),
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: responsive.ip(1.5))),
              //para ipad 33 ihone 15

              onPressed: () {
                Navigator.pushNamed(context, 'reset_password');
              }),
          _optionAuth(responsive)
        ],
      ),
    );
  }

  loginGoogle(BuildContext context) {
    DateTime fechaExpiracionMenos5Minutos =
        DateTime.now().add(Duration(hours: 1)).subtract(Duration(minutes: 5));
    signInWithGoogle().then((value) async {

      String emailGoogle = value["email"];
      String idToken = value["idToken"];
      String urlAvatar = value["urlAvatar"];
      User user = value["user"];

     showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      if (emailGoogle == null) {
        Navigator.pop(context);
        print('El resultado es nulo');
        return;
      } else {
        _http.loginGoogle(context: context, emailGoogle: emailGoogle).then((result) {
          final resultGoogle = json.decode(result);
          if (resultGoogle["ok"] == true) {
            _http
                .updateAvatarSocialMedia(
                    email: emailGoogle, urlAvatar: urlAvatar)
                .then((_) {});
            prefsInternal.prefsInternal.setString('urlAvatar', urlAvatar);

            Navigator.pop(context);
            preference.guardarToken(idToken);
            preference.saveSesion(
              email: resultGoogle["usuario"]["email"],
              langCode: Platform.localeName.substring(0, 2),
              expire: convertirMilliSecondsToDateTime(
                      int.parse(resultGoogle["usuario"]["last_updated_on"]))
                  .toString(),
              lastActivity: new DateTime.now().toString(),
              fullName: resultGoogle["usuario"]["name"],
              country: resultGoogle["usuario"]["country"],
              city: resultGoogle["usuario"]["city"],
              phone: resultGoogle["usuario"]["phone"],
              provider: 'google',
            );
            Navigator.pushReplacementNamed(context, 'principal');
          } else {

              HttpV2()
                  .registerGooglev2(context: context, token: idToken, uid: user.uid, email: user.email, name: user.displayName)
                  .then((value) async {
                Navigator.pop(context);
                final valueMap = json.decode(value);
                if (valueMap["ok"] == true) {
                  await _http
                      .updateAvatarSocialMedia(
                          email: user.email,
                          urlAvatar:
                              user.photoURL)
                      .then((_) {});
                  prefsInternal.prefsInternal.setString('urlAvatar',user.photoURL);
                  HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                  showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } )
                      .then((value) {
                    preference.guardarToken(idToken);
                    preference.saveSesion(
                      email: valueMap["usuarioGuardado"]
                          ["email"],
                      langCode:
                          Platform.localeName.substring(0, 2),
                      expire: convertirMilliSecondsToDateTime(
                              int.parse(
                                  valueMap["usuarioGuardado"]
                                      ["last_updated_on"]))
                          .toString(),
                      lastActivity:
                          new DateTime.now().toString(),
                      fullName: valueMap["usuarioGuardado"]["name"],
                      city: valueMap["usuarioGuardado"]["city"],
                      country: valueMap["usuarioGuardado"]["country"],
                      phone: valueMap["usuarioGuardado"]["phone"],
                      provider: 'google',
                    );
                    _http.senderEmailRegister(email: user.email,first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(
                        context, 'principal');
                  });
                } else {
                  _http
                      .eliminarUidFirebase(uid: user.uid)
                      .then((_) {});
                  
                 showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
                    .then((_) {
                    handleSignOutGoogle();
                    logOutFacebook();
                  });
                }
              });
                                // ********************************************
          }
        });
        return;
      }
    });
  }

  //  *******************************

  loginApple(BuildContext context) {
    String urlAvatarVoid = 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc';
    handleAppleSignIn().then((value) async {
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      if (value["idToken"] == null) {
        print('El resultado es nulo');
        return;
      } else {
        _http.loginApple(context: context, idToken: value["idToken"]).then((result) async {
          final resultApple = json.decode(result);
          // print('RESPUESTA  $resultApple');
          Navigator.pop(context);
          if (resultApple["ok"] == true) {
            preference.guardarToken(value["idToken"]);
            preference.saveSesion(
              email: resultApple["usuario"]["email"],
              langCode: Platform.localeName.substring(0, 2),
              expire: convertirMilliSecondsToDateTime(
                      int.parse(resultApple["usuario"]["last_updated_on"]))
                  .toString(),
              lastActivity: new DateTime.now().toString(),
              fullName: resultApple["usuario"]["name"],
              country: resultApple["usuario"]["country"],
              city: resultApple["usuario"]["city"],
              phone: resultApple["usuario"]["phone"],
              provider: 'apple',
            );
            prefsInternal.prefsInternal.setString('urlAvatar', urlAvatarVoid);
            Navigator.pushReplacementNamed(context, 'principal');
          } else {
            final user = value["user"];
            String idToken = value["idToken"];
            await user.getIdToken().then((token) {
              FirebaseMessaging.instance.getToken().then((fbToken) {
                HttpV2().registerApplev2(context: context, token: idToken, uid: user.uid).then((value) {
                  final valueMap = json.decode(value);
                  if (valueMap["ok"] == true) {
                    _http.senderEmailRegister(email: valueMap["usuarioGuardado"]["email"], first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
                    HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } )
                      .then((value) {
                      preference.guardarToken(idToken);
                      preference.saveSesion(
                        email: valueMap["usuarioGuardado"]["email"],
                        langCode: Platform.localeName.substring(0, 2),
                        expire: convertirMilliSecondsToDateTime(int.parse(valueMap["usuarioGuardado"]["last_updated_on"])).toString(),
                        lastActivity: new DateTime.now().toString(),
                        fullName: valueMap["usuarioGuardado"]["name"],
                        country: valueMap["usuarioGuardado"]["country"],
                        city: valueMap["usuarioGuardado"]["city"],
                        phone: valueMap["usuarioGuardado"]["phone"],
                        provider: 'apple',
                      );
                      prefsInternal.prefsInternal.setString('urlAvatar', urlAvatarVoid);
                      Navigator.pushReplacementNamed(context, 'principal');
                    });
                  } else {
                    _http.eliminarUidFirebase(uid: user.uid).then((_) {});
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
                    .then((_) {
                      handleSignOutGoogle();
                      logOutFacebook();
                    });
                  }
                });
                // ********************************************
              });
            });
          }
        });
        return;
      }
    });
  }

  _loginFacebook(BuildContext context) {
    DateTime fechaExpiracionMenos5Minutos =
        DateTime.now().add(Duration(hours: 1)).subtract(Duration(minutes: 5));
    signInWithFacebook().then((value) async {
       if(value == null){
         showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, "Error"); });
       }{
          String urlAvatar = value["urlAvatar"];
          String tokenFacebook = value["token"];
        
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
          
          _http.loginFacebook(context: context, tokenFacebook: tokenFacebook).then((result) async {
            final resultFacebook = json.decode(result);
            if (resultFacebook["ok"] == true) {
                      
              _http
                  .updateAvatarSocialMedia(
                      email: resultFacebook["usuario"]["email"],
                      urlAvatar: urlAvatar)
                  .then((_) {});
              prefsInternal.prefsInternal.setString('urlAvatar', urlAvatar);

              Navigator.pop(context);
              preference.guardarToken(null);
              preference.saveSesion(
                email: resultFacebook["usuario"]["email"],
                langCode: Platform.localeName.substring(0, 2),
                expire: convertirMilliSecondsToDateTime(
                        int.parse(resultFacebook["usuario"]["last_updated_on"]))
                    .toString(),
                lastActivity: new DateTime.now().toString(),
                fullName: resultFacebook["usuario"]["name"],
                country: resultFacebook["usuario"]["country"],
                city: resultFacebook["usuario"]["city"],
                phone: resultFacebook["usuario"]["phone"],
                provider: 'facebook',
              );
              Navigator.pushReplacementNamed(context, 'principal');
            } else {
                    User user = value["user"];
                    String tokenFacebook = value["tokenFacebook"];

                    await user.getIdToken().then((token) {
                      HttpV2()
                          .registerFacebookv2(
                              context: context,
                              tokenFirebase: token,
                              tokenFacebook: tokenFacebook,
                              uid: user.uid)
                          .then((value) async {
                        Navigator.pop(context);
                        final valueMap = json.decode(value);
                        if (valueMap["ok"] == true) {
                          await _http.updateAvatarSocialMedia(
                                  email: user.email,
                                  urlAvatar: user.photoURL)
                              .then((_) {});
                          prefsInternal.prefsInternal.setString('urlAvatar', user.photoURL);
                          HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } )
                          .then((value) {
                            preference.guardarToken(tokenFacebook);
                            preference.saveSesion(
                              email: valueMap["usuarioGuardado"]["email"],
                              langCode: Platform.localeName.substring(0, 2),
                              expire: convertirMilliSecondsToDateTime(int.parse(valueMap["usuarioGuardado"]["last_updated_on"])).toString(),
                              lastActivity: new DateTime.now().toString(),
                              fullName: valueMap["usuarioGuardado"]["name"],
                              country: valueMap["usuarioGuardado"]["country"],
                              city: valueMap["usuarioGuardado"]["city"],
                              phone: valueMap["usuarioGuardado"]["phone"],
                              provider: 'facebook',
                            );
                            _http.senderEmailRegister(email: valueMap["usuarioGuardado"]["email"], first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
                            Navigator.pop(context);
                            Navigator.pushReplacementNamed(
                                context, 'principal');
                          });
                        } else {
                          if (valueMap["errors"]["errors"]["email"]
                                  ["message"] ==
                              'email the email must be unique') {
                            
                              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, "Are you already registered"); })
                                .then((_) {
                              handleSignOutGoogle();
                            });
                          } else {
                            _http
                                .eliminarUidFirebase(uid: user.uid)
                                .then((_) {});
                            
                        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
                        .then((_) {
                              handleSignOutGoogle();
                            });
                          }
                        }
                      });
                    });
            }
          });
          return;
       }
    });
  }

  _login(BuildContext context, LoginBloc bloc) async {
    DateTime fechaExpiracionMenos5Minutos =
        DateTime.now().add(Duration(hours: 1)).subtract(Duration(minutes: 5));
    preference.obtenerPreferencias();
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

    loginMaando(bloc.email, bloc.password).then((value) {
      if (value.runtimeType == FirebaseAuthException) {
        print('>>>>>>>>>>>> ERRROR ${value}');
        Navigator.pop(context);
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){return loadingError(context, value.message);});
        return;
      } else {
        final user = value["user"];
        // print('>>>>>>>>>>>> ERRROR ${user.token}');
        user.getIdToken().then((token) {
          FirebaseMessaging.instance.getToken().then((fbToken) {
            _http
                .loginForm(
                   context: context,
                    email: controladorEmail.text.toLowerCase().trim(),
                    password: controladorPassword.text.trim())
                .then((value) {
              final valueMap = json.decode(value);

              print('RESPUESTA DE LOGIN ${valueMap}');

              if (valueMap['ok'] == true) {
                 preference.prefsInternal.setString('urlAvatar', valueMap['usuario']["avatar"]); 
                Navigator.pop(context);
                preference.prefsInternal
                    .setString(
                        'expire', fechaExpiracionMenos5Minutos.toString())
                    .then((_) => {});

                preference.guardarToken(token);
                preference.saveSesion(
                    email: user.email,
                    langCode: Platform.localeName.substring(0, 2),
                    expire: fechaExpiracionMenos5Minutos.toString(),
                    lastActivity: fechaExpiracionMenos5Minutos.toString(),
                    fullName: valueMap['usuario']["name"],
                    country: valueMap["usuario"]["country"],
                    city: valueMap["usuario"]["city"],
                    phone: valueMap['usuario']["phone"],
                    provider: 'form');
                // Navigator.pop(context);
                controladorEmail.text = '';
                controladorPassword.text = '';
                Navigator.pushReplacementNamed(context, 'principal');
                // -----------------------

              } else if (valueMap['code'] == 401) {
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap['message']); });
              } else if (valueMap['code'] == 404) {
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap['message']); });
              } else {
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap['message']); });
              }
            });
          });
        });
      }
    });
  }

  // ***********
  Future<void> _getListsOfBiometricTypes() async {
    List<BiometricType> listOfBiometrics;
    try {
      listOfBiometrics = await _localAuthentication.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print('Error2 ====>>>>  $e');
    }

    if (!mounted) return;

    // setState(() {
    _availableBiometrisTypes = listOfBiometrics;
    // });

    if (Platform.isIOS) {
      print('isIOS ${Platform.localeName}');
      if (_availableBiometrisTypes.contains(BiometricType.face)) {
        // Face ID.
        tieneBiometriaTouchId = false;
        tieneBiometriaFaceId = true;
      } else if (_availableBiometrisTypes.contains(BiometricType.fingerprint)) {
        // Touch ID.
      }
    } else if (Platform.isAndroid) {
      if (_availableBiometrisTypes.contains(BiometricType.fingerprint)) {
        print('isAndroid ${_availableBiometrisTypes}');
        // Touch ID.
        for (var bio in _availableBiometrisTypes) {
          if (bio == BiometricType.fingerprint) {
            tieneBiometriaTouchId = true;
            tieneBiometriaFaceId = false;
          }
        }
      }
    }
  }



  bool _isIOS13 = false;
  Future<bool> _validarversion() async {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  Widget _optionAuth(Responsive responsive) {
    return FutureBuilder(
        future: _getListsOfBiometricTypes(),
        builder: (_, AsyncSnapshot snapshot) {
          if (tieneBiometriaFaceId == true) {
            return CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text(loginText.loginFaceID(),
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontSize: responsive.ip(1.5))),
                onPressed: () {
                  Navigator.pushNamed(context, 'login_face_id');
                });
          } else if (tieneBiometriaTouchId == true) {
            return CupertinoButton(
                padding: EdgeInsets.all(0),
                child: Text(loginText.loginTouchID(),
                    style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontSize: responsive.ip(1.8))),
                onPressed: () {
                  Navigator.pushNamed(context, 'login_touch_id');
                });
          } else {
            return Container();
          }
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
