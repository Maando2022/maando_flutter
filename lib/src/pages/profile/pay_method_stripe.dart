// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/recursos.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';


class PayMethodStripe extends StatefulWidget {
  @override
  _PayMethodStripeState createState() => _PayMethodStripeState();
}

class _PayMethodStripeState extends State<PayMethodStripe> {


  final preference = new Preferencias();
  Http _http = Http();
  TextEditingController controladorInputNumberAccount = TextEditingController();
  TextEditingController controladorInputBank = TextEditingController();
  TextEditingController controladorInputBic = TextEditingController();
  TextEditingController controladorInputIban = TextEditingController();
  List<Map<String, dynamic>> listTypesAccountMap = listTypesAccountStripeMap;
  dynamic userUpdate;
  dynamic user;


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    
    if(userUpdate == null){
       user = json.decode(ModalRoute.of(context).settings.arguments);
    }else{
      user = userUpdate;
    }



    if(user["pay"] == null){
       if (blocEditProfile.typeAccount == null) blocEditProfile.changeTypeAccount(listTypesAccountMap[0]);
    }else{
      if(blocEditProfile.accountNumber == null || blocEditProfile.accountNumber == '') blocEditProfile.changeAccountnumber(user["pay"]["accountNumber"]);
      if(blocEditProfile.bank == null || blocEditProfile.bank == '') blocEditProfile.changeBank(user["pay"]["bank"]);
      if(blocEditProfile.bic == null || blocEditProfile.bic == '') blocEditProfile.changeBic(user["pay"]["bic"]);
      if(blocEditProfile.iban == null || blocEditProfile.iban == '') blocEditProfile.changeIban(user["pay"]["iban"]);
      for(var typeMap in listTypesAccountMap){
        if(typeMap["code"] == user["pay"]["type"]){
           if (blocEditProfile.typeAccount == null) blocEditProfile.changeTypeAccount(typeMap);
        }
      }
    }
   
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Container(
        height: double.infinity,
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
                        arrwBackYellow(context, 'principal'),
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
                      generalText.stripeAccount(),
                      style: TextStyle(
                        fontSize: width * 0.068,
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
              _label(generalText.numberAccount(), height, width),
              _crearAccount(height, width, user),
              SizedBox(
                height: height * 0.021,
              ),
              _label(generalText.typeAccount(), height, width),
              _crearTypeAccount(height, width, user),
              SizedBox(
                height: height * 0.021,
              ),
              _label(generalText.bank(), height, width),
              _crearBank(height, width, user),
              SizedBox(
                height: height * 0.021,
              ),
              _label(generalText.codeBicOrSwitf(), height, width),
              _crearCodeBicOrSwift(height, width, user),
              SizedBox(
                height: height * 0.021,
              ),
              _label(generalText.ibanCode(), height, width),
              _crearCodeIban(height, width, user),
              SizedBox(
                height: height * 0.021,
              ),
              _botonSend(context),
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return SizedBox(height: (isKeyboardVisible) ? 350.0 : 0);
                }
              )
            ],
          ),
        ),
      ),
    );
  }

  // *************************************
  
  Widget _label(String text, double height, double width){
    return Container(
      width: width * 0.9,
      margin: EdgeInsets.only(bottom: height * 0.01),
      child: Text('$text:',
       style: TextStyle(color: Color.fromRGBO(173, 181, 189, 1), fontSize: width * 0.05)
       ),
    );
  }
  // *************************************
 bool _validarAccountNumber() {
    bool validate = false;
    if (blocEditProfile.accountNumber == null) {
      validate = false;
    } else {
      if (blocEditProfile.accountNumber.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearAccount(double height, double width, dynamic user) {
    String text = (_validarAccountNumber() == false) ? '' : blocEditProfile.accountNumber;

    controladorInputNumberAccount.text = (_validarAccountNumber() == false) ? '' : blocEditProfile.accountNumber;
    controladorInputNumberAccount.selection = TextSelection.collapsed(offset: controladorInputNumberAccount.text.length);

    return StreamBuilder(
        stream: blocEditProfile.accountNumberStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                        width: width * 0.9,
                        child: TextField(
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            controller: controladorInputNumberAccount,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              labelText: text,
                              hintText: generalText.stripeAccount(),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1),
                                fontSize: width * 0.05,
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
                              blocEditProfile.changeAccountnumber(value);
                            }),
                      );
        });
  }



  // *****************************
 Widget _crearTypeAccount(double height, double width, dynamic user) {
    return Container(
      height: height * 0.08,
      width: width * 0.9,
      child: FormField<Map<String, dynamic>>(
        builder: (FormFieldState<Map<String, dynamic>> state) {
          return InputDecorator(
            decoration: InputDecoration(
              errorStyle: TextStyle(
                color: Colors.redAccent,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600
              ),
              hintText: 'Please select city',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<Map<String, dynamic>>(
                isExpanded: true,
                value: blocEditProfile.typeAccount,
                icon: Icon(Icons.keyboard_arrow_down),
                iconSize: width * 0.05,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.05,
                  height: 0,
                  fontWeight: FontWeight.w600
                ),
                elevation: 16,
                underline: Container(
                  height: 2,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                onChanged: (Map<String, dynamic> newValue) {
                  FocusScope.of(context).requestFocus(new FocusNode());
                  blocEditProfile.changeTypeAccount(newValue);
                },
                items:
                    listTypesAccountStripeMap.map<DropdownMenuItem<Map<String, dynamic>>>((Map<String, dynamic> value) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: value,
                    child: Text(value["value"]),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }


  // *************************************
 bool _validarBank() {
    bool validate = false;
    if (blocEditProfile.bank == null) {
      validate = false;
    } else {
      if (blocEditProfile.bank.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearBank(double height, double width, dynamic user) {
    String text = (_validarBank() == false) ? '' : blocEditProfile.bank;

    controladorInputBank.text = (_validarBank() == false) ? '' : blocEditProfile.bank;
    controladorInputBank.selection = TextSelection.collapsed(offset: controladorInputBank.text.length);

    return StreamBuilder(
        stream: blocEditProfile.bankStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                        width: width * 0.9,
                        child: TextField(
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            controller: controladorInputBank,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: text,
                              hintText: generalText.bank(),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1),
                                fontSize: width * 0.05,
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
                              blocEditProfile.changeBank(value);
                            }),
                      );
        });
  }



    // *************************************
 bool _validarCodeBicOrSwift() {
    bool validate = false;
    if (blocEditProfile.bic == null) {
      validate = false;
    } else {
      if (blocEditProfile.bic.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearCodeBicOrSwift(double height, double width, dynamic user) {
    String text = (_validarCodeBicOrSwift() == false) ? '' : blocEditProfile.bic;

    controladorInputBic.text = (_validarCodeBicOrSwift() == false) ? '' : blocEditProfile.bic;
    controladorInputBic.selection = TextSelection.collapsed(offset: controladorInputBic.text.length);

    return StreamBuilder(
        stream: blocEditProfile.bicStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                        width: width * 0.9,
                        child: TextField(
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            controller: controladorInputBic,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: text,
                              hintText: generalText.codeBicOrSwitf(),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1),
                                fontSize: width * 0.05,
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
                              blocEditProfile.changeBic(value);
                            }),
                      );
        });
  }


    // *************************************
 bool _validarCodeIban() {
    bool validate = false;
    if (blocEditProfile.iban == null) {
      validate = false;
    } else {
      if (blocEditProfile.iban.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearCodeIban(double height, double width, dynamic user) {
    String text = (_validarCodeIban() == false) ? '' : blocEditProfile.iban;

    controladorInputIban.text = (_validarCodeIban() == false) ? '' : blocEditProfile.iban;
    controladorInputIban.selection = TextSelection.collapsed(offset: controladorInputIban.text.length);

    return StreamBuilder(
        stream: blocEditProfile.ibanStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                        width: width * 0.9,
                        child: TextField(
                            style: TextStyle(
                                fontSize: width * 0.05,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                            controller: controladorInputIban,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              labelText: text,
                              hintText: generalText.ibanCode(),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1),
                                fontSize: width * 0.05,
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
                              blocEditProfile.changeIban(value);
                            }),
                      );
        });
  }



  // *****************
   Widget _botonSend(BuildContext context) {
     return StreamBuilder(
        stream: blocEditProfile.formValidarStripeStream,
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
                            fontSize: MediaQuery.of(context).size.width * 0.039,
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
                      _http.updatePayMethod(
                        context: context,
                        email: preference.prefsInternal.get('email'),
                        pay: json.encode(
                          {
                            "name" : "stripe", 
                            "accountNumber" : blocEditProfile.accountNumber.trim(),
                            "type" : blocEditProfile.typeAccount["code"],
                            "bank" : blocEditProfile.bank,
                            "bic" : blocEditProfile.bic,
                            "iban" : blocEditProfile.iban
                            })
                      ).then((resp){
                        Navigator.pop(context);
                        var respMap = json.decode(resp);

                        if(respMap["ok"] == true){
                          userUpdate = respMap["usuarioActualizado"];
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, "Successfull"); } )
                          .then((_){
                                     Navigator.pushReplacementNamed(context, 'principal');
                                  });
                        }else{
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, respMap["message"]); });
                        }

                      });
                    } : null),
              );
        });
  }
}

