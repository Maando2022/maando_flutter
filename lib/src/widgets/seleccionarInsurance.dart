import 'package:flutter/material.dart';

Widget seleccionaInsurance(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.02,
    height: MediaQuery.of(context).size.height * 0.02,
    child: Image.asset(
      'assets/images/general/Fill-1560-2.png',
      fit: BoxFit.contain,
    ),
  );
}
