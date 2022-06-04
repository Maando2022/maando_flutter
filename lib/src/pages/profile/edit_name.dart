// @dart=2.9
import 'dart:convert';
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

class EditName extends StatefulWidget {
  @override
  _EditNameState createState() => _EditNameState();
}

class _EditNameState extends State<EditName> {

  final preference = new Preferencias();
  Http _http = Http();
 TextEditingController controladorInput = TextEditingController();


@override
  void initState() {
    // TODO: implement initState
    super.initState();

    blocEditProfile.changeFullName(preference.prefsInternal.get('fullName'));
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
   
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
                          generalText.editName(),
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
                  _crearName(responsive, height, width),
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



  // *************************************
  

 bool _validarPost() {
    bool validate = false;
    if (blocEditProfile.fullName == null) {
      validate = false;
    } else {
      if (blocEditProfile.fullName.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearName(Responsive responsive, double height, double width) {
    controladorInput.text = blocEditProfile.fullName;

    String text = (_validarPost() == false) ? preference.prefsInternal.getString('fullName') : '';

    controladorInput.text = (_validarPost() == false) ? '' : blocEditProfile.fullName;
    controladorInput.selection = TextSelection.collapsed(offset: controladorInput.text.length);


    return StreamBuilder(
        stream: blocEditProfile.fullNameStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                  height: height * 0.08,
                  child: Container(
                    margin: EdgeInsets.only(left: width * 0.02, right: variableGlobal.margenPageWith(context)),
                          width: width * 0.9,
                          child: TextField(
                              style: TextStyle(
                                  fontSize: responsive.ip(2.5),
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black),
                              controller: controladorInput,
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                labelText: text,
                                hintText: createAccountText.fullName(),
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
                                blocEditProfile.changeFullName(value);
                              }),
                        ),
                );
        });
  }

  // *****************
   Widget _botonSend(BuildContext context, Responsive responsive) {
     return StreamBuilder(
        stream: blocEditProfile.fullNameStream,
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
                        phone: preference.prefsInternal.get('phone'),
                        fullName: blocEditProfile.fullName.trim(),
                        city: preference.prefsInternal.get('city'),
                        country: preference.prefsInternal.get('country'),
                      ).then((user){
                        Navigator.pop(context);
                        var userMap = json.decode(user);

                        if(userMap["ok"]){
                          preference.prefsInternal.setString('fullName', json.decode(user)["usuarioActualizado"]["name"]);
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

