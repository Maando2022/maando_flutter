// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/complete_register_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/register_accout_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/separadores.dart';

class CompleteRegistrationPage extends StatefulWidget {


  @override
  _CompleteRegistrationPageState createState() => _CompleteRegistrationPageState();
}

class _CompleteRegistrationPageState extends State<CompleteRegistrationPage> {
  Http _http = Http();
  String email;
  String fullName;
  String provider;
  final String serverToken = '<Server-Token>';

  TextEditingController controladorFullName = TextEditingController();
  TextEditingController controladorEmail = TextEditingController();
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
    for(int i = 0;  i < aiports.length; i++){
      if(pais == 'Antigua and Barbuda'){
        dropdownValueCiudad = aiports[i]["aiports"][0]["city"];
        break;
      }else{
          if(pais == aiports[i]["name"]){
            listaCiudades = [];
            for(var c in aiports[i]["aiports"]){
             listaCiudades.add(c["city"]);
            }
            dropdownValueCiudad = listaCiudades[0];
          }
      }
    }
    dropdownValuePais = pais;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // OBTENEMOS LA LISTA DE PAISES
    for(var a in aiports){
      listaPaises.add(a["name"]);
    }

    _ciudaPorDefecto(dropdownValuePais);
    pref.guardarOnboarding('no-onboarding');
    // devolverCiudadActual().then((value) => {ciudad = value[0].locality});
    preference.obtenerPreferencias();

    email = pref.prefsInternal.get("email");
    fullName = pref.prefsInternal.get("fullName");
    provider = pref.prefsInternal.get("provider");
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofCompleteRegister(context);
       
    bloc.changeFullName(fullName);
    bloc.changeEmail(email);

    // VALIDAMOS CUAL ES EL PAIS SELECCIONADO Y LISTAMOS LAS CIUDADES
    listaCiudades = [];
    for(int i = 0;  i < aiports.length; i++){
      if(dropdownValuePais == aiports[i]["name"]){
        for(var c in aiports[i]["aiports"]){
         listaCiudades.add(c["city"]);
        }
      }
    }
    if(bloc.country == null)  bloc.changeCountry(listaPaises[0]);
    if(bloc.city == null)  bloc.changeCity(listaCiudades[0]);

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container();
                      }else{
                            return Scaffold(
                              backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                              body: Stack(
                                children: [
                                  SingleChildScrollView(
                                      child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: variableGlobal.margenTopGeneral(context),
                                                left: MediaQuery.of(context).size.width * 0.05,
                                                right: MediaQuery.of(context).size.width * 0.05),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                arrwBackYellowsignOut(context, (){
                                                  showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                                                  _http.signOut(email: preference.prefsInternal.get('email')).then((value){
                                                      var valueMap = json.decode(value);
                                                      //  print('FIN DE LA SESION =============<>>>>>>  $valueMap');
                                                      if(valueMap["ok"] == true){
                                                          Navigator.pushReplacementNamed(context, 'login').then((_){
                                                          Navigator.pop(context);
                                                          });
                                                      }else{
                                                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
                                                            .then((value) {
                                                              Navigator.pop(context);
                                                            });
                                                      }
                                                    });
                                                }),
                                                iconFace1(context),
                                                Container(
                                                  width: MediaQuery.of(context).size.width * 0.1,
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 16.6,
                                          ),
                                          Container(
                                            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: <Widget>[
                                                Text(
                                                  createAccountText.completeRegistration(),
                                                  style: TextStyle(
                                                    fontSize: responsive.ip(3.5),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ],
                                            ),
                                          ),
                                          _createForm(responsive, context, bloc)
                                        ],
                                      ),
                                      SizedBox(
                                        height: 0.0,
                                      ),
                                    
                                      _crearBotonCompletarRegistro(responsive, bloc, height, width),
                                      SizedBox(height: 30.0),
                                    ],
                                  )),

                                  //  Seguda parte del Stack
                                ],
                              ),
                            );
                      }
                  }else if(snapshotConutriesOrigin.hasError){
                      return Container();
                  }else{
                      return Container();
                  }
                },
          );
  }



  Widget _createForm(Responsive responsive, BuildContext context, CompleteRegisterBloc bloc) {
    return Column(
      children: <Widget>[
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        separador1(context),
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
      ],
    );
  }

  Widget _crearNombre(Responsive responsive, CompleteRegisterBloc bloc) {
  String text = (_validarNombre(bloc) == false) ? createAccountText.fullName() : bloc.fullName;

    return StreamBuilder(
        stream: bloc.fullNameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: TextField(
              enabled: !_validarNombre(bloc),
                controller: controladorFullName,
                keyboardType: TextInputType.text,
                style: TextStyle(
                fontSize: responsive.ip(2),
                fontWeight: FontWeight.w600,
                color: Colors.black),
                decoration: InputDecoration(
                  hintText: text,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2),
                    letterSpacing: 0.07,
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
                  FocusScope.of(context).requestFocus(new FocusNode());
                  bloc.changeFullName(value.trim());
                }),
          );
        });
  }

  Widget _crearEmail(Responsive responsive, CompleteRegisterBloc bloc) {
      String text = (_validarEmail(bloc) == false) ? createAccountText.fullName() : bloc.email;

    return StreamBuilder(
        stream: bloc.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: TextField(
                enabled: !_validarEmail(bloc),
                controller: controladorEmail,
                keyboardType: TextInputType.emailAddress,
                style: TextStyle(
                fontSize: responsive.ip(2),
                fontWeight: FontWeight.w600,
                color: Colors.black),
                decoration: InputDecoration(
                  hintText: text,
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(2),
                    letterSpacing: 0.07,
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
                onChanged: (value) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  bloc.changeEmail(value);
                }),
          );
        });
  }

  Widget _crearPhone(Responsive responsive, CompleteRegisterBloc bloc) {
    return StreamBuilder(
        stream: bloc.phonedStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
            child: TextField(
                controller: controladorPhone,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                fontSize: responsive.ip(2),
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
                    fontSize: responsive.ip(2),
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
                onChanged: (value) {
                  bloc.changePhone(value.trim());
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
                margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            borderSide:
                                const BorderSide(color: Color.fromRGBO(173, 181, 189, 1)),
                          ),
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: responsive.ip(2)),
                          hintText: 'Please select country',
                          hintStyle: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1),
                            fontSize: responsive.ip(2),
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
                          iconSize: MediaQuery.of(context).size.width* 0.05,
                          style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1),
                            fontSize: responsive.ip(2),
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
                          },
                          items: listaPaises.map<DropdownMenuItem<String>>((String value) {
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
                margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: FormField<String>(
                  builder: (FormFieldState<String> state) {
                    return InputDecorator(
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent, fontSize: responsive.ip(2)),
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
                            fontSize: responsive.ip(2),
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





  Widget _crearBotonCompletarRegistro(Responsive responsive, CompleteRegisterBloc bloc, double height, double width) {
    return StreamBuilder(
        stream: bloc.formValidarStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return RaisedButton(
            onPressed: (snapshot.hasData)
                ? () => _completarRegistro(context, bloc)
                : null,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
              width:  MediaQuery.of(context).size.width * 0.747,
              height: height * 0.08, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(createAccountText.completeRegistration(),
                      style: TextStyle(
                        color: Color.fromRGBO(255, 206, 6, 1.0),
                        fontSize: responsive.ip(2),
                        fontWeight: FontWeight.bold,
                      )),
                  page1(context)
                ],
              ),
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
                side: BorderSide(color: Colors.black, width: 1.0)),
            elevation: 5.0,
            color: Color.fromRGBO(33, 36, 41, 1.0),
            textColor: Colors.white,
          );
        });
  }

  createGoogle() {
    print('Create account Google');
  }

  createFacebook() {
    print('Create account Facebook');
  }

  _completarRegistro(BuildContext context, CompleteRegisterBloc bloc) {
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

    _http.completarRegistro(
      context: context,
      email: bloc.email, 
      name: bloc.fullName, 
      phone: bloc.phone, 
      country: dropdownValuePais, 
      city: dropdownValueCiudad ).then((value){
        final valueMap = jsonDecode(value);
         print('RESPUESTA ====>>>>  ${valueMap}');
        if(valueMap["ok"] == false){
          Navigator.pop(context);
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); })
            .then((valor) {

          });
        }else{
          Navigator.pop(context);
          preference.saveSesion(
            email: valueMap["userSave"]["email"],
            langCode: Platform.localeName.substring(0, 2),
            expire: convertirMilliSecondsToDateTime(int.parse(valueMap["userSave"]["last_updated_on"])).toString(),
            lastActivity: new DateTime.now().toString(),
            fullName: valueMap["userSave"]["name"],
            country: valueMap["userSave"]["country"],
            city: valueMap["userSave"]["city"],
            phone: valueMap["userSave"]["phone"],
            provider: valueMap["userSave"]["provider"],
          );
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } ).then((_){
                Navigator.pushReplacementNamed(context, 'after_singup_page');
              });
        }
      });
  }


  // *****************************   VALIDACIONES
   bool _validarNombre(CompleteRegisterBloc bloc) {
    bool validate = false;
    if (bloc.fullName == null) {
      validate = false;
    } else {
      if (bloc.fullName.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

   bool _validarEmail(CompleteRegisterBloc bloc) {
    bool validate = false;
    if (bloc.email == null) {
      validate = false;
    } else {
      if (bloc.email.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
}
