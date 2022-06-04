import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maando/src/pages/ad_form/create_ad_what_can_i_send.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
  

  class DialogWhatCanISend {


// LISTA  DE MÉTODOS DE PAGO
    showMaterialDialog(BuildContext context) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              // title: Container(
              //   child: Column(
              //     children: [
              //       Text(generalText.selectYourPreferredMethodOfPayment(),
              //         textAlign: TextAlign.left,
              //         style: TextStyle(
              //           fontSize: responsive.ip(2.2),
              //           fontWeight: FontWeight.bold,
              //           color: Colors.black)),
              //     ],
              //   ),
              // ),
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CreateAdWhatCanISend()
                  ],
                ),
              ),
              actionsPadding: EdgeInsets.all(0),
              actions: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  padding: EdgeInsets.all(0),
                  child: Text('Ok'),
                  onPressed: () {
                  },
                ),
              ],
            ));
    }

  }


DialogWhatCanISend dialogWhatCanISend = DialogWhatCanISend();