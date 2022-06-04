// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';


class PayMethodPaypal extends StatefulWidget {
  @override
  _PayMethodPaypalState createState() => _PayMethodPaypalState();
}

class _PayMethodPaypalState extends State<PayMethodPaypal> {

// {
//   "name" : "paypal",
//   "accountEmail" : "4242424242424242"
// }

  final preference = new Preferencias();
  Http _http = Http();
  String phoneCode = '';
  TextEditingController controladorInputAccountPaypal = TextEditingController();
  dynamic userUpdate;
  dynamic user;


@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
   user = json.decode(ModalRoute.of(context).settings.arguments);

    if(userUpdate == null){
       user = json.decode(ModalRoute.of(context).settings.arguments);
    }else{
      user = userUpdate;
    }

    if(user["pay"] == null){
    }else if(user["pay"]["accountEmail"] == null){
    }else{
      if(blocEditProfile.accountPaypalStreamValue == false || blocEditProfile.accountPaypal == '') blocEditProfile.changeAccountPaypal(user["pay"]["accountEmail"]);
    }
    
   
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
                          generalText.paypalAccount(),
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
                  _crearAccount(responsive, height, width, user),
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
  

 bool _validarAccountPaypal() {
    bool validate = false;
    if (blocEditProfile.accountPaypalStreamValue == false) {
      validate = false;
    } else {
      if (blocEditProfile.accountPaypal.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
  Widget _crearAccount(Responsive responsive, double height, double width, dynamic user) {

    String text = (_validarAccountPaypal() == false) ? '' : blocEditProfile.accountPaypal;

    controladorInputAccountPaypal.text = (_validarAccountPaypal() == false) ? '' : blocEditProfile.accountPaypal;
    controladorInputAccountPaypal.selection = TextSelection.collapsed(offset: controladorInputAccountPaypal.text.length);


    return StreamBuilder(
        stream: blocEditProfile.accountPaypalStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                        width: width * 0.9,
                        child: TextField(
                            style: TextStyle(
                                fontSize: responsive.ip(2.5),
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            controller: controladorInputAccountPaypal,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: text,
                              hintText: generalText.paypalAccount(),
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
                              blocEditProfile.changeAccountPaypal(value);
                            }),
                      );
        });
  }

  // *****************
   Widget _botonSend(BuildContext context, Responsive responsive) {
     return StreamBuilder(
        stream: blocEditProfile.accountPaypalStream,
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
                    onPressed: (snapshot.hasData) ? (){
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      _http.updatePayMethod(
                        context: context,
                        email: preference.prefsInternal.get('email'),
                        pay: json.encode({"name" : "paypal","accountEmail" : blocEditProfile.accountPaypal.trim()})
                      ).then((res){
                        Navigator.pop(context);
                        var respMap = json.decode(res);
                        
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

