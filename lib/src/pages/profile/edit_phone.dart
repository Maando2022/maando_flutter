// @dart=2.9
import 'dart:convert';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/register_accout_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';

class EditPhone extends StatefulWidget {
  @override
  _EditPhoneState createState() => _EditPhoneState();
}

class _EditPhoneState extends State<EditPhone> {

  final preference = new Preferencias();
  Http _http = Http();
  String phoneCode = '';
 TextEditingController controladorInput = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    blocEditProfile.changePhone(preference.prefsInternal.get('phone'));

     blocGeneral.aiportsDestination.forEach((country) {
        if (preference.prefsInternal.get('country') == country["name"]) {
          phoneCode = '+(${country["indicative-code"]})';
        }
      });
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
                                                    generalText.editPhone(),
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
                                            _crearPhone(responsive, height, width),
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
  

 bool _validarPost() {
    bool validate = false;
    if (blocEditProfile.phone == null) {
      validate = false;
    } else {
      if (blocEditProfile.phone.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearPhone(Responsive responsive, double height, double width) {
    controladorInput.text = blocEditProfile.phone;

    String text = (_validarPost() == false) ? preference.prefsInternal.getString('phone') : '';

    controladorInput.text = (_validarPost() == false) ? '' : blocEditProfile.phone;
    controladorInput.selection = TextSelection.collapsed(offset: controladorInput.text.length);


    return StreamBuilder(
        stream: blocEditProfile.phoneStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  height: height * 0.08,
                  margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context), right: width * 0.02),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: height * 0.08,
                            width: width * 0.25,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(173, 181, 189, 0.2),
                              borderRadius: const BorderRadius.all(
                                            Radius.circular(8.0),
                                          ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(phoneCode,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                          fontSize: responsive.ip(2.5),
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.02, right: variableGlobal.margenPageWith(context)),
                              width: width * 0.6,
                              child: TextField(
                                  style: TextStyle(
                                      fontSize: responsive.ip(2.5),
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  controller: controladorInput,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    labelText: text,
                                    hintText: createAccountText.mobileNumber(),
                                    hintStyle: TextStyle(
                                      color: Color.fromRGBO(173, 181, 189, 1),
                                      fontSize: responsive.ip(2.5),
                                      fontWeight: FontWeight.w400,
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
                                    blocEditProfile.changePhone(value);
                                  }),
                            ),
                    ],
                  ),
                );
        });
  }

  // *****************
   Widget _botonSend(BuildContext context, Responsive responsive) {
     return StreamBuilder(
        stream: blocEditProfile.phoneStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.hasData);
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
                    onPressed: (snapshot.hasData) ? (){
                      
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      _http.updateProfile(
                        context: context,
                        email: preference.prefsInternal.get('email'),
                        phone: blocEditProfile.phone,
                        fullName: preference.prefsInternal.get('fullName'),
                        city: preference.prefsInternal.get('city'),
                        country: preference.prefsInternal.get('country'),
                      ).then((user){
                        Navigator.pop(context);
                        var userMap = json.decode(user);

                        if(userMap["ok"]){
                          preference.prefsInternal.setString('phone', json.decode(user)["usuarioActualizado"]["phone"]);
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

