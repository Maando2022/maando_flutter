// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/utils/textos/onboarding01.dart';
import 'package:maando/src/utils/textos/onboarding_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class Onboarding02Page extends StatelessWidget {
  const Onboarding02Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double miheight = MediaQuery.of(context).size.height;
    double miwidth = MediaQuery.of(context).size.width;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30.0, right: 16.0, left: 16.0),
            child: Center(
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      iconFace1(context),
                      closeOnboarding(
                          context, 'assets/images/close/close button 1@3x.png')
                    ],
                  ),
                  SizedBox(
                    height: miheight * 0.015,
                  ),
                  Text(
                    onboarding01Text.titulo_1(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(33, 36, 41, 1)),
                  ),
                  SizedBox(
                    height: miheight * 0.1,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                          width: miwidth * 0.9,
                          height: miheight * 0.7,
                          child: Image.asset(
                              'assets/images/onboarding/Group-5056@3x.png')),
                      Positioned(
                        top: MediaQuery.of(context).size.height * 0.25,
                        // left: _screenSize.width * 0.17,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Container(
                                  child: Text(
                                    onboarding01Text.subtitulo_1(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(33, 36, 41, 1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: (MediaQuery.of(context).size.height >=
                                          858)
                                      ? MediaQuery.of(context).size.height *
                                          0.06
                                      : MediaQuery.of(context).size.height *
                                          0.04),
                              Center(
                                child: Container(
                                  child: Text(
                                    onboarding01Text.subtitulo_2(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: miwidth * 0.04,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(33, 36, 41, 1)),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: miheight * 0.1,
                              ),
                              crearBotonCrearCuenta(),
                              SizedBox(
                                height: miheight * 0.03,
                              ),
                              Center(
                                child: Container(
                                  child: CupertinoButton(
                                      child: Text(
                                        onboardingText.login(),
                                        style: TextStyle(
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromRGBO(33, 36, 41, 1)),
                                      ),
                                      onPressed: () {
                                        pref.guardarOnboarding('no-onboarding');
                                        Navigator.pushReplacementNamed(context, 'login');
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: miheight * 0.01,
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Center(child: Text('Botones  Navegacion')),

                  // SizedBox(
                  //   height: width * 0.5,
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }

  // *********************

  Widget _crearEmail() {
    return Container(
      height: 48.0,
      // margin: EdgeInsets.symmetric(horizontal: 10.0),git add .
      child: TextField(
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: 'Email address',
            hintStyle: TextStyle(
              color: Color.fromRGBO(173, 181, 189, 1),
              fontSize: 14.0,
              letterSpacing: 0.07,
              fontWeight: FontWeight.w400,
            ),
            border: new OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                const Radius.circular(15.0),
              ),
            ),
          )),
    );
  }

  Widget _send() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          print('Send');
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.09,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('Send',
                  style: TextStyle(
                    color: Color.fromRGBO(255, 206, 6, 1),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  )),
              page1(context)
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(width: 0.5, color: Colors.white)),
        elevation: 5.0,
        color: Color.fromRGBO(33, 36, 41, 1),
        textColor: Colors.white,
      );
    });
  }
}
