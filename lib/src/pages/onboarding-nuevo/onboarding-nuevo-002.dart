// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingNuevo002Page extends StatelessWidget {
  const OnboardingNuevo002Page({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onDoubleTap: () {
        Navigator.pushReplacementNamed(context, 'omb_new_003');
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 208, 5, 1),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center
          // textDirection: TextDirection.ltr,
          children: <Widget>[
            SizedBox(
              height: height * 0.15,
            ),
            Center(child: _logo(context)),
            SizedBox(
              height: height * 0.04,
            ),
            Center(child: FittedBox(child: _parrafo(context))),
            SizedBox(
              height: height * 0.01,
            ),
            Center(child: _imagen_ppal(context)),
            SizedBox(
              height: height * 0.015,
            ),
            Center(child: _footer(context)),
          ],
        ),
      ),
    );
  }
}

Widget _logo(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.1,
      child:
          Image.asset('assets/images/onboarding/icon maando - white 1@3x.png')
      // EdgeInsets.symmetric(
      //     horizontal: variableGlobal.margenPageWithLoginCreateAccount(context)),

      );
}

Widget _parrafo(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.7,
    height: MediaQuery.of(context).size.width * 0.3,
    child: Text(
        'A platform designed to connect friends and entrepreneurs and help each other send packages from one place to another.',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Color.fromRGBO(33, 36, 41, 1),
          fontSize: (MediaQuery.of(context).size.width > 1000)
              ? MediaQuery.of(context).size.width * 0.03
              : 20,
          fontWeight: FontWeight.bold,
        )),
    // EdgeInsets.symmetric(
    //     horizontal: variableGlobal.margenPageWithLoginCreateAccount(context)),
  );
}

Widget _imagen_ppal(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      height: (MediaQuery.of(context).size.width > 1000)
          ? MediaQuery.of(context).size.height * 0.36
          : MediaQuery.of(context).size.height * 0.45,
      child: Image.asset('assets/images/onboarding/Group@3x.png')
      // EdgeInsets.symmetric(
      //     horizontal: variableGlobal.margenPageWithLoginCreateAccount(context)),

      );
}

Widget _footer(BuildContext context) {
  return Container(
      width: MediaQuery.of(context).size.width * 0.3,
      height: MediaQuery.of(context).size.width * 0.1,
      child: Image.asset('assets/images/onboarding/maando-logo@3x.png')
      // EdgeInsets.symmetric(
      //     horizontal: variableGlobal.margenPageWithLoginCreateAccount(context)),

      );
}

// *********************
