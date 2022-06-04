// https://medium.com/flutterdevs/custom-dialog-in-flutter-7ca5c2a8d33a
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/utils/responsive.dart';



Widget popupGestionaTusNotificaciones(context, text){  
  return PopupGestionaTusNotificaciones();
}


class PopupGestionaTusNotificaciones extends StatelessWidget{


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      onPressed: (){
        Navigator.pop(context);
      },
      child: Container(
        // height: height,
        // width: width,
        padding: EdgeInsets.only(bottom: height * 0.1),
        child: Image.asset('assets/images/popup/${Platform.localeName.substring(0, 2)}/gestiona_tus_notificaciones.png', fit: BoxFit.cover,)
        )
      );
  }
}
