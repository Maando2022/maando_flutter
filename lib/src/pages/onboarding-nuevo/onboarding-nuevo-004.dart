// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingNuevo004Page extends StatelessWidget {
  const OnboardingNuevo004Page({Key key}) : super(key: key);

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
              height: height * 0.03,
            ),
            Center(child: FittedBox(child: _parrafo(context))),
            SizedBox(
              height: height * 0.00,
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
    width: MediaQuery.of(context).size.width * 0.8,
    height: MediaQuery.of(context).size.width * 0.2,
    child: Text(
        'A world of solutions where people  can help each other resolve day to day problems.',
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
      //decoration:
      // BoxDecoration(border: Border.all(width: 2, color: Colors.red)),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.45,
      child: Image.asset(
        'assets/images/onboarding/Frame-3@3x.png',
        width: MediaQuery.of(context).size.width,
      )
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
