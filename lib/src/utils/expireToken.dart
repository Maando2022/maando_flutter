// @dart=2.9
import 'dart:async';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/alertas.dart';
import 'package:maando/src/services/loginFacebook.dart';
import 'package:maando/src/services/shared_pref.dart';

bool vistoAlert = false;
final preference = new Preferencias();
Timer cronometroFuture;
listenExpires({BuildContext context, String cancel}) {
  final bloc = ProviderApp.ofGeneral(context);

  var f = DateFormat('yyyy-MM-dd hh:mm');
  DateTime fechaExpiracionMenos5Minutos =
      DateTime.parse(preference.prefsInternal.getString('expire'));

  if (preference.prefsInternal.getString('expire') != null) {
    cronometroFuture = Timer.periodic(Duration(minutes: 4), (Timer timer) {
      print(
          'minutos de expiracion  ====>  ${fechaExpiracionMenos5Minutos.difference(DateTime.now()).inMinutes}');

      if (fechaExpiracionMenos5Minutos.difference(DateTime.now()).inMinutes <=
              5 &&
          preference.prefsInternal.getString('email') != null) {
        if (vistoAlert == false) {
          Timer(Duration(minutes: 5), () {
            // logOut();
            // logOutFacebook();
            Navigator.pushReplacementNamed(context, 'login');
          });

          vistoAlert = true;
          alertExpiredToken(
              context: context,
              title: 'Your token will expire in 5 minutes',
              defaultType: OkCancelAlertDefaultType.ok);
          cronometroFuture.cancel();
          return;
        }
      }
    });
    bloc.changeTokenExpired(cronometroFuture);
  }
}
