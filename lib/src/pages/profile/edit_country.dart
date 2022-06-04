// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class EditCountry extends StatefulWidget {
  @override
  _EditCountryState createState() => _EditCountryState();
}

class _EditCountryState extends State<EditCountry> {

  final preference = new Preferencias();
  Http _http = Http();

 TextEditingController controladorInput = TextEditingController();
 String dropdownValuePais = '';
 String flag = '';
  String dropdownValueCiudad = '';
 List<String> listaPaises = [];


@override
  void initState() {
    // TODO: implement initState
    super.initState();

      for (var a in blocGeneral.aiportsDestination) {
         listaPaises.add(a["name"]);
         if(preference.prefsInternal.get('country') == ''){
           flag = '';
           preference.prefsInternal.setString('country', generalText.selectACountry());
           break;
         }
         if(a["name"] == preference.prefsInternal.get('country')){
           flag = a["flag"];
         }
      }

    // AÑADIMOS AL PRINCIPIO DE LA LISTA LAS LEYENDAS
    listaPaises.insert(0, generalText.selectACountry());

    blocEditProfile.changeCountry(preference.prefsInternal.get('country'));
    dropdownValuePais = preference.prefsInternal.get('country');
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context); 

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container();
                      }else{
                            return Scaffold(
                                    resizeToAvoidBottomInset: false,
                                    backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                                    body: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.only(
                                                      top: variableGlobal.margenTopGeneral(context),
                                                      right:
                                                          variableGlobal.margenPageWith(context),
                                                      left:
                                                          variableGlobal.margenPageWith(context)),
                                                  child: Stack(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            children: [
                                                              iconFace1(context),
                                                            ],
                                                          ),
                                                          arrwBackYellow(context, 'profile_page'),
                                                        ],
                                                      ),
                                                ),
                                                Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: height * 0.02,
                                                      vertical:
                                                          variableGlobal.margenPageWith(context)),
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                    children: <Widget>[
                                                      Text(
                                                        generalText.editCountry(),
                                                        style: TextStyle(
                                                          fontSize: responsive.ip(3.5),
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                        textAlign: TextAlign.start,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.021,
                                                      ),
                                                      Container(
                                                          width: width * 0.003,
                                                          // height: miheight * 0.005,
                                                          child: lineYellowNoti(context))
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: height * 0.042,
                                                ),
                                                _crearPais(responsive, height, width),
                                                SizedBox(
                                                  height: height * 0.021,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        _botonSend(context, responsive),
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



  // *************************************
  Widget _crearPais(Responsive responsive, double height, double width) {   
    return StreamBuilder(
        stream: blocEditProfile.countryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.09,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
            child: FormField<String>(
              builder: (FormFieldState<String> state) {
                return InputDecorator(
                  decoration: InputDecoration(
                    prefixIcon: (flag != '') ? Container(
                      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                      child: SvgPicture.network(flag, fit: BoxFit.contain, height: MediaQuery.of(context).size.width * 0.03, width: MediaQuery.of(context).size.width * 0.03,
                      )
                      ) : null,
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
                        fontWeight: FontWeight.w400,
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
                      iconSize: MediaQuery.of(context).size.width * 0.05,
                      style: TextStyle(
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5),
                        height: height * 0.002,
                        fontWeight: FontWeight.w400,
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(173, 181, 189, 1),
                      ),
                      onChanged: (String newValue) {
                        dropdownValuePais = newValue;
                        blocEditProfile.changeCountry(newValue);
                        for (var a in blocGeneral.aiportsDestination) { 
                          if(a["name"] == newValue){
                            flag = a["flag"];
                            dropdownValueCiudad = a["aiports"][0]["city"];
                            break;
                          }
                        }
                      },
                      items: listaPaises
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(value)),
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

  // *****************
   Widget _botonSend(BuildContext context, Responsive responsive) {
     return StreamBuilder(
        stream: blocEditProfile.countryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.08,
            margin: EdgeInsets.symmetric(
                horizontal: variableGlobal.margenPageWith(context), vertical: MediaQuery.of(context).size.height *  0.022),
                child: RaisedButton(
                    child: Center(
                      child: Text(
                        generalText.send(),
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            fontSize: responsive.ip(2),
                            color: Color.fromRGBO(255, 206, 6, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: BorderSide(color: Colors.black, width: 1.0)),
                    elevation: 5.0,
                    color: Color.fromRGBO(33, 36, 41, 1.0),
                    textColor: Colors.white,
                    onPressed: (snapshot.hasData && preference.prefsInternal.get('country') != blocEditProfile.country) ? (){

                       showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      _http.updateProfile(
                        context: context,
                        email: preference.prefsInternal.get('email'),
                        phone: preference.prefsInternal.get('phone'),
                        fullName: preference.prefsInternal.get('fullName'),
                        city: dropdownValueCiudad,
                        country: blocEditProfile.country,
                      ).then((user){
                        Navigator.pop(context);
                        var userMap = json.decode(user);

                        if(userMap["ok"]){
                          preference.prefsInternal.setString('country', json.decode(user)["usuarioActualizado"]["country"]);
                          preference.prefsInternal.setString('city', json.decode(user)["usuarioActualizado"]["city"]);
                          Navigator.pushNamed(context, 'profile_page');
                        }else{
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, userMap["message"]); } );
                        }

                      });
                    } : null),
              );
        });
  }
}

