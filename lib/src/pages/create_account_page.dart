// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/create_account_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/http_v2/http_v2.dart';
import 'package:maando/src/services/loginApple.dart';
import 'package:maando/src/services/loginFacebook.dart';
import 'package:maando/src/services/loginGoogle.dart';
import 'package:maando/src/services/registerMaando.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/recursos.dart';
import 'package:maando/src/utils/textos/login_text.dart';
import 'package:maando/src/utils/textos/register_accout_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/separadores.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maando/src/utils/responsive.dart';
import '../blocs/general_bloc.dart';

class CreatreAccountPage extends StatefulWidget {
  // const CreatreAccountPage({Key key}) : super(key: key);

  @override
  _CreatreAccountPageState createState() => _CreatreAccountPageState();
}

class _CreatreAccountPageState extends State<CreatreAccountPage> {
  Http _http = Http();
  final String serverToken = '<Server-Token>';

  TextEditingController controladorFullName = TextEditingController();
  TextEditingController controladorEmail = TextEditingController();
  TextEditingController controladorPassword = TextEditingController();
  TextEditingController controladorPhone = TextEditingController();

  List<dynamic> aiports = blocGeneral.aiportsDestination;
  List<String> listaPaises = [];
  List<String> listaCiudades = [];

  String dropdownValuePais = 'Antigua and Barbuda';
  String dropdownValueCiudad = '';
  bool obscureText = true;
  bool obscureTextConfirm = true;
  //para mantenr el boton arriba


  _ciudaPorDefecto(String pais) {
    for (int i = 0; i < aiports.length; i++) {
      if (pais == 'Antigua and Barbuda') {
        dropdownValueCiudad = aiports[i]["aiports"][0]["city"];
        break;
      } else {
        if (pais == aiports[i]["name"]) {
          listaCiudades = [];
          for (var c in aiports[i]["aiports"]) {
            listaCiudades.add(c["city"]);
          }
          dropdownValueCiudad = listaCiudades[0];
        }
      }
    }
    
    dropdownValuePais = pais;
    listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // OBTENEMOS LOS LOS PAISES CUIDADES Y AEROPUERTOS
    Http().getAiports().then((aiportsDB){          
        blocGeneral.changeAiportsOrigin(aiportsDB["contriesOrigin"]);
        blocGeneral.changeAiportsDestination(aiportsDB["contriesDestination"]);
        // listaPaises = blocGeneral.aiportsOrigin;
    });
    // OBTENEMOS LA LISTA DE PAISES
    for (var a in aiports) {
      listaPaises.add(a["name"]);
    }

     

    _ciudaPorDefecto(dropdownValuePais);

    pref.guardarOnboarding('no-onboarding');
    // devolverCiudadActual().then((value) => {ciudad = value[0].locality});
    preference.obtenerPreferencias();
    preference.limpiarPreferencias();
    handleSignOutGoogle();
    logOutFacebook();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofCreate_Account(context);
    // blocGeneral.tokenExpired?.cancel();

// VALIDAMOS CUAL ES EL PAIS SELECCIONADO Y LISTAMOS LAS CIUDADES
    listaCiudades = [];
    for (int i = 0; i < aiports.length; i++) {
      if (dropdownValuePais == aiports[i]["name"]) {
        for (var c in aiports[i]["aiports"]) {
          listaCiudades.add(c["city"]);
        }
      }
    }


    // try{
    //   if (bloc.country == null) bloc.changeCountry(listaPaises[0]);
    //   if (bloc.city == null) bloc.changeCity(listaCiudades[0]);
    // }catch(e){
    //   bloc.changeCountry(listaPaises[0]);
    //   bloc.changeCity(listaCiudades[0]);
    // }

    listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos


    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.aiportsOriginStream,
        builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
            if(snapshotConutriesOrigin.hasData){
                if(snapshotConutriesOrigin.data.length <= 0){
                  return Container();
                }else{
                      return WillPopScope(
                              onWillPop: () async => false,
                              child: Scaffold(
                                backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                                body: Stack(
                                  children: [
                                    SingleChildScrollView(
                                        child: Column(
                                      children: <Widget>[
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: variableGlobal.margenPageWith(context), vertical: height * 0.018),
                                              margin: EdgeInsets.only(
                                                  top: variableGlobal.margenTopGeneral(context)),
                                              child: Stack(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      iconFace1(context),
                                                    ],
                                                  ),
                                                  arrwBackYellowPersonalizado(context, 'login')
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.025,
                                            ),
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  horizontal: variableGlobal.margenPageWith(context)),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: <Widget>[
                                                  Text(
                                                    createAccountText.createAccount(),
                                                    style: TextStyle(
                                                      fontSize: responsive.ip(3.5),
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.025,
                                                  ),
                                                  Text(
                                                    createAccountText.shortDescription(),
                                                    style: TextStyle(fontSize: responsive.ip(2)),
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.035,
                                            ),
                                            // //*****************************************CREAR BOTON APPLE
                                            FutureBuilder(
                                                future: _validarversion(),
                                                builder: (BuildContext context, AsyncSnapshot snapshot) {
                                                  if (snapshot.hasData) {
                                                    if (snapshot.data == true) {
                                                      return Container(
                                                          margin: EdgeInsets.symmetric(
                                                              horizontal:
                                                                  variableGlobal.margenPageWith(context)),
                                                          child: Center(
                                                              child: 
                                                              CupertinoButton(
                                                                padding: EdgeInsets.all(0),
                                                                // minSize: 0,
                                                                onPressed: (){
                                                                  if (!_valueCheck) {
                                                                    toastService.showToastCenter(context: context, text: createAccountText.acceptTermsAndConditions(), durationSeconds: 4);
                                                                    return;
                                                                  }
                                                                  loginApple(context);
                                                                },
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
                                                              // AppleAuthButton(
                                                              //     onPressed: () {
                                                              //       _handleSignInApple();
                                                              //     },
                                                              //     darkMode: true,
                                                              //     height: height * 0.07,
                                                              //     width: width * 0.9,
                                                              //     style: authButtonStyle,
                                                              //     text: 'Register with Apple',
                                                              //     textStyle: TextStyle(
                                                              //       color: Colors.white,
                                                              //       fontSize: responsive.ip(2)),
                                                              //     )
                                                              // SignInWithAppleButton(
                                                              //     style: SignInWithAppleButtonStyle.whiteOutlined,
                                                              //     fontSize: responsive.ip(2),
                                                              //     height: height * 0.07,
                                                              //     borderRadius: BorderRadius.all(
                                                              //         Radius.circular(8.0)),
                                                              //     text: createAccountText.signupApple(),
                                                              //     onPressed: () {
                                                              //       _handleSignInApple();
                                                              //     })
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

                                            //*****************************************CREAR BOTON GOOGLE
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: MediaQuery.of(context).size.height * 0.02),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _crearBotonGoogle(responsive, loginText.logintWithgoogle()),
                                                ],
                                              ),
                                            ),
                                            // **********************   fin boton google
                                            SizedBox(
                                                // height: height * 0.025,
                                                ),
                                            //*****************************************CREAR BOTON FACEBOOK
                                            Container(
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: <Widget>[
                                                  _crearBotonFacebook(responsive, loginText.logintWithFacebook()),
                                                ],
                                              ),
                                            ),
                                            // **********************   fin boton FACEBOOK
                                            //  VALIDAMOS EL SEPARADOR
                                            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                                            _crearTerm(responsive),
                                            separador1(context),
                                            _createForm(responsive, context, bloc)
                                          ],
                                        ),
                                        Column(
                                          children: <Widget>[
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal: variableGlobal.margenPageWith(context),
                                              ),
                                              child: CupertinoButton(
                                                padding: EdgeInsets.all(0),
                                                onPressed: () {
                                                  Navigator.pushReplacementNamed(context, 'login');
                                                },
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    Text(createAccountText.haveAnAccont(),
                                                        style: TextStyle(
                                                            color: Color.fromRGBO(173, 181, 189, 1.0),
                                                            fontWeight: FontWeight.w400,
                                                            fontSize: responsive.ip(2))),
                                                    SizedBox(
                                                      width: width * 0.02,
                                                    ),
                                                    Text(createAccountText.login2(),
                                                        style: TextStyle(
                                                            letterSpacing: 0.07,
                                                            color: Color.fromRGBO(33, 36, 41, 1.0),
                                                            fontWeight: FontWeight.w500,
                                                            fontSize: responsive.ip(1.8))),
                                                    SizedBox(
                                                      height: height * 0.1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        _crearBotonCrearCuenta(responsive, bloc, height, width),
                                        SizedBox(height: height * 0.1),
                                      ],
                                    )),

                                    //  Seguda parte del Stack
                                  ],
                                ),
                              ),
                            );
                }
            }else if(snapshotConutriesOrigin.hasError){
                return Container();
            }else{
                 return Container(
                    margin: EdgeInsets.only(top: height * 0.4),
                    child: Center(child: CircularProgressIndicator()),
                  );
            }
          },
    );
  }

 

  Widget _createForm(Responsive responsive, BuildContext context, CreateAccountBloc bloc) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearNombre(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearEmail(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearPhone(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearPais(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearCiudad(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearPassword(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        _crearConfirmPassword(responsive, bloc),
        // SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        // _crearTerm(responsive),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
      ],
    );
  }

  Widget _crearNombre(Responsive responsive, CreateAccountBloc bloc) {
    return StreamBuilder(
        stream: bloc.fullNameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                controller: controladorFullName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                    fontSize: responsive.ip(2),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: createAccountText.fullName(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                ),
                onChanged: (value){
                  bloc.changeFullName(value);
                  listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                  }),
          );
        });
  }

  Widget _crearEmail(Responsive responsive, CreateAccountBloc bloc) {
    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                controller: controladorEmail,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: createAccountText.email(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                ),
                onChanged: (value){
                  bloc.changeEmail(value);
                  listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                  }),
          );
        });
  }

  Widget _crearPhone(Responsive responsive, CreateAccountBloc bloc) {
    return StreamBuilder(
        stream: bloc.phonedStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                controller: controladorPhone,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: createAccountText.mobileNumber(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                          color: Color.fromRGBO(173, 181, 189, 1))),
                ),
                onChanged: (value){
                  bloc.changePhone(value);
                  listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                  }),
          );
        });
  }

  Widget _crearPais(Responsive responsive, bloc) {
    return StreamBuilder(
        stream: bloc.countryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1)),
                      ),
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: responsive.ip(2.5)),
                      hintText: 'Please select country',
                      hintStyle: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5),
                        fontWeight: FontWeight.w500,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValuePais,
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(230, 230, 230, 1)),
                      iconSize: responsive.ip(2.7),
                      style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5),
                        height: 0,
                        fontWeight: FontWeight.w500,
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(173, 181, 189, 1),
                      ),
                      onChanged: (String newValue) {
                        dropdownValuePais = newValue;
                        _ciudaPorDefecto(newValue);
                        bloc.changeCountry(newValue);
                        bloc.changeCity(dropdownValueCiudad);
                        listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                      },
                      items: listaPaises
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  Widget _crearCiudad(Responsive responsive, bloc) {
    return StreamBuilder(
        stream: bloc.cityStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: responsive.ip(2.5)),
                      hintText: 'Please select city',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0))),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: dropdownValueCiudad,
                      icon: Icon(Icons.keyboard_arrow_down,
                          color: Color.fromRGBO(230, 230, 230, 1)),
                      iconSize: 19,
                      elevation: 16,
                      style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5),
                        height: 0,
                        fontWeight: FontWeight.w500,
                      ),
                      underline: Container(
                        height: 2,
                        color: Color.fromRGBO(173, 181, 189, 1),
                      ),
                      onChanged: (String newValue) {
                        dropdownValueCiudad = newValue;
                        bloc.changeCity(newValue);
                        listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                      },
                      items: listaCiudades
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          );
        });
  }

  bool _valueCheck = false;
  Widget _crearTerm(Responsive responsive) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: Row(
        children: [
          Transform.scale(
            scale: MediaQuery.of(context).size.height * 0.001,
            child: Checkbox(
                value: _valueCheck,
                activeColor: Colors.yellow,
                onChanged: (bool newValue) {
                  setState(() {
                    _valueCheck = newValue;
                    listaCiudades = listaCiudades.toSet().toList();   //  Eliminamos elementos repetidos
                  });
                  Text('Remember me');
                }),
          ),
          CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.all(0),
            onPressed: _launchURL,
            child: Row(
              children: [
                Text(
                  createAccountText.terminos1(),
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: responsive.ip(1.5)),
                ),
                Text(
                  createAccountText.terminos2(),
                  style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: responsive.ip(1.5)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _crearPassword(Responsive responsive, CreateAccountBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                obscureText: obscureText,
                style: TextStyle(
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
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
                  hintText: createAccountText.password(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                ),
                onChanged: (value) => {
                      bloc.changePassword(value),
                      listaCiudades = listaCiudades.toSet().toList()   //  Eliminamos elementos repetidos
                    }),
          );
        });
  }

  Widget _crearConfirmPassword(Responsive responsive, CreateAccountBloc bloc) {
    return StreamBuilder(
        stream: bloc.passwordConfirmStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: TextField(
                obscureText: obscureTextConfirm,
                style: TextStyle(
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: InputDecoration(
                  suffixIcon: CupertinoButton(
                      child: Icon(Icons.visibility,
                          color: Color.fromRGBO(230, 230, 230, 1)),
                      onPressed: () {
                        setState(() {
                          (obscureText == false)
                              ? obscureTextConfirm = true
                              : obscureTextConfirm = false;
                        });
                      }),
                  hintText: createAccountText.confirmPassword(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w500,
                  ),
                  errorText: snapshot.error,
                  border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(8.0),
                    ),
                  ),
                ),
                onChanged: (value) => {
                      bloc.changePasswordConfirm(value),
                      listaCiudades = listaCiudades.toSet().toList()   //  Eliminamos elementos repetidos
                    }),
          );
        });
  }

  Widget _crearBotonGoogle(Responsive responsive, String texto) {
    return RaisedButton(
       elevation: 0,
      onPressed: (){
        if (!_valueCheck) {
            toastService.showToastCenter(context: context, text: createAccountText.acceptTermsAndConditions(), durationSeconds: 4);
            return;
        }
        loginGoogle(context);
      },
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.857,
        height: MediaQuery.of(context).size.height * 0.07,
        margin: EdgeInsets.symmetric(
            horizontal: variableGlobal.margenPageWith(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(texto,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: responsive.ip(2))),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
      color: Colors.white,
      textColor: Colors.white,
    );
  }

// ******************************
  Widget _crearBotonFacebook(Responsive responsive, String texto) {
    return RaisedButton(
       elevation: 0,
      onPressed: (){
        if (!_valueCheck) {
            toastService.showToastCenter(context: context, text: createAccountText.acceptTermsAndConditions(), durationSeconds: 4);
            return;
          }
        loginFacebook(context);
      },
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.857,
        height: MediaQuery.of(context).size.height * 0.07,
        margin: EdgeInsets.symmetric(
            horizontal: variableGlobal.margenPageWith(context)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(texto,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: responsive.ip(2))),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
          side: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
      color: Colors.white,
      textColor: Colors.white,
    );
  }

  // ********************************+
  Future<bool> _validarversion() async {
    if (Platform.isIOS) {
      return true;
    } else {
      return false;
    }
  }

  Widget _crearBotonCrearCuenta(Responsive responsive, CreateAccountBloc bloc, double height, double width) {
    return StreamBuilder(
        stream: bloc.formValidarStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context)),
            child: RaisedButton(
              onPressed: (snapshot.hasData &&
                      _valueCheck == true &&
                      (bloc.password == bloc.passwordConfirm))
                  ? () => _createAccount(responsive, context, bloc)
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(createAccountText.createAccount(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 206, 6, 1.0),
                        fontSize: responsive.ip(2),
                        fontWeight: FontWeight.bold,
                      )),
                  page1(context)
                ],
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black, width: 1.0)),
              elevation: 0,
              color: Color.fromRGBO(33, 36, 41, 1.0),
              textColor: Colors.white,
            ),
          );
        });
  }

  createGoogle() {
    print('Create account Google');
  }

  createFacebook() {
    print('Create account Facebook');
  }

  _createAccount(Responsive responsive, BuildContext context, CreateAccountBloc bloc) {
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

    registerMaando(bloc.email, bloc.password).then((value) {
      if (value.runtimeType == PlatformException) {
        print('Paso en el error  $value');
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, value.message); })
            .then((valor) {
          Navigator.pop(context);
        });

        return;
      } else {
        final User user = value["user"];
        user.getIdToken().then((token) {
          FirebaseMessaging.instance.getToken().then((fbToken) {
            _http
                .createAccountForm(
                    context: context,
                    email: user.email..toLowerCase(),
                    name: bloc.fullName.trim(),
                    phone: bloc.phone.trim(),
                    country: dropdownValuePais,
                    city: dropdownValueCiudad,
                    password: bloc.password.trim(),
                    token: token,
                    fbToken: fbToken,
                    uid: user.uid)
                .then((valueMaando) {
              final valueMap = json.decode(valueMaando);
              if (valueMap["ok"] == true) {
                Navigator.pop(context);
                HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                _http.senderEmailRegister(email: bloc.email.toLowerCase(), first_name: bloc.fullName, last_name: bloc.fullName);
                preference.guardarToken(token);
                preference.saveSesion(
                    email: bloc.email.toLowerCase(),
                    country: dropdownValuePais,
                    city: dropdownValueCiudad,
                    phone: bloc.phone,
                    fullName: bloc.fullName,
                    langCode: Platform.localeName.substring(0, 2),
                    expire: DateTime.now().add(Duration(hours: 1)).toString(),
                    lastActivity: DateTime.now().toString(),
                    provider: 'form');
                    prefsInternal.prefsInternal.setString('urlAvatar', urlAvatarVoid);
                _ciudaPorDefecto(dropdownValuePais);
                Navigator.pop(context);
                Navigator.pushReplacementNamed(context, 'after_singup_page');
              } else {
                Navigator.pop(context);
                _http.eliminarUidFirebase(uid: user.uid).then((_) {});
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); });
              }
            });
          });
        });
      }
    });
  }

  //**********************************
//**********************************
//**********************************
//**********************************
//**********************************

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
        Http().loginGoogle(context: context, emailGoogle: emailGoogle).then((result) {
          final resultGoogle = json.decode(result);
          if (resultGoogle["ok"] == true) {
            Http()
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
                    .registerGooglev2(context: context, token: idToken, uid: user.uid, name: user.displayName, email: user.email)
                    .then((value) async {
                  Navigator.pop(context);
                  final valueMap = json.decode(value);
                  if (valueMap["ok"] == true) {
                    await Http()
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
                      Http().senderEmailRegister(email: user.email,first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                          context, 'principal');
                    });
                  } else {
                    Http()
                        .eliminarUidFirebase(uid: user.uid)
                        .then((_) {});
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); }).then((_) {
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

  loginApple(BuildContext context) {
    String urlAvatarVoid = 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc';

    handleAppleSignIn().then((value) async {
      String idToken = value["idToken"];

    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      if (idToken == null) {
        print('El resultado es nulo');
        return;
      } else {
        Http().loginApple(context: context, idToken: idToken).then((result) async {
          final resultApple = json.decode(result);
          // print('RESPUESTA  $resultApple');
          Navigator.pop(context);
          if (resultApple["ok"] == true) {
            preference.guardarToken(idToken);
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
                    Http().senderEmailRegister(email: valueMap["usuarioGuardado"]["email"], first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
                    HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } ).then((value) {
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
                    Http().eliminarUidFirebase(uid: user.uid).then((_) {});
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); }).then((_) {
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

  loginFacebook(BuildContext context) {
    signInWithFacebook().then((value) async {
      String urlAvatar = value["urlAvatar"];
      String tokenFacebook = value["token"];

      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      
      Http().loginFacebook(context: context, tokenFacebook: tokenFacebook).then((result) async {
        final resultFacebook = json.decode(result);
        if (resultFacebook["ok"] == true) {
                  
          Http()
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
                      await Http().updateAvatarSocialMedia(
                              email: user.email,
                              urlAvatar: user.photoURL)
                          .then((_) {});
                      prefsInternal.prefsInternal.setString('urlAvatar', user.photoURL);
                      HttpV2().enviarEmailDeRegistroAAdminstradores(email: user.email).then((resp) async {});
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } ).then((value) {
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
                        Http().senderEmailRegister(email: valueMap["usuarioGuardado"]["email"], first_name: valueMap["usuarioGuardado"]["name"], last_name: valueMap["usuarioGuardado"]["name"]);
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
                        Http()
                            .eliminarUidFirebase(uid: user.uid)
                            .then((_) {});
                        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); }).then((_) {
                          handleSignOutGoogle();
                        });
                      }
                    }
                  });
                });
        }
      });
      return;
    });
  }
}

_launchURL() async {
  const url = 'https://maando.com/terms-and-conditions/';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
