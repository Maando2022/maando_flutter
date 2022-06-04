// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/reset_password_bloc.dart';
import 'package:maando/src/services/registerMaando.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/login_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class ResetPasswordPage extends StatefulWidget {
  // const ResetPasswordPage({Key key}) : super(key: key);

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController controladorEmail = TextEditingController();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: SingleChildScrollView(
    child: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: width * 0.03,
                right: height * 0.018,
                top: variableGlobal.margenTopGeneral(context)),
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: arrwBackYellowPersonalizado(context, 'login'),
                      ),
                      iconFace1(context),
                      Container(
                        width: width * 0.07,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.025,
                  ),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text(
                          'Reset password',
                          style: TextStyle(
                            fontSize: width * 0.1,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(
                          height: height * 0.025,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              loginText.joinThisAdventure(),
                              style: TextStyle(fontSize: width * 0.04),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.05,
                        ),
                        Container(
                          child: _crearEmail(),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(
                  //   height: width * 0.5,
                  // ),
                ],
              ),
            ),
          ),
          Positioned(
            width: width,
            bottom: height * 0.0,
            child: Container(
              margin:
                  EdgeInsets.only(bottom: height * 0.06, right: variableGlobal.margenPageWith(context), left: variableGlobal.margenPageWith(context)),
              child: _send(),
            ),
          ),
        ],
      ),
    ),
      ),
    );
  }


  Widget _crearEmail() {
    return StreamBuilder(
        stream: blocResetPassword.emailStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            child: TextField(
                controller: controladorEmail,
                keyboardType: TextInputType.emailAddress,
                 style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w600,
                    color: Colors.black),
                decoration: InputDecoration(
                  hintText: loginText.email(),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: MediaQuery.of(context).size.width * 0.05,
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
                onChanged: (value) => {blocResetPassword.changeEmail(value)}),
          );
        });
  }

  Widget _send() {
    blocResetPassword.changePassword('123456');
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      child: StreamBuilder(
          stream: blocResetPassword.formValidarStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return RaisedButton(
              onPressed: snapshot.hasData
                  ? () => resetpassword(blocResetPassword.email, context)
                  : null,
              child: Container(
                height: 65.0,
                margin: EdgeInsets.symmetric(
                    horizontal: variableGlobal.margenPageWith(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Send',
                        style: TextStyle(
                          color: Color.fromRGBO(255, 206, 6, 1),
                          fontSize: MediaQuery.of(context).size.width * 0.05,
                          fontWeight: FontWeight.bold,
                        )),
                    page1(context)
                  ],
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  side: BorderSide(color: Colors.black, width: 0.5)),
              elevation: 5.0,
              color: Color.fromRGBO(33, 36, 41, 1),
              textColor: Colors.white,
            );
          }),
    );
  }
}
