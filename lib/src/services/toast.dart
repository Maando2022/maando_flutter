
   
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maando/src/utils/responsive.dart';



class ToastService {
  
   showToastCenter({@required context, @required text, @required durationSeconds}){
     final Responsive responsive = Responsive.of(context);
     Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: durationSeconds,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: responsive.ip(2),
    );
   }

 }

 ToastService toastService = ToastService();