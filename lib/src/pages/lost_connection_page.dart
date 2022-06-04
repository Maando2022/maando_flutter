// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class Lost_Conecction extends StatefulWidget {
  // const Add_rate_review({Key key}) : super(key: key);
  @override
  _Lost_ConecctionState createState() => _Lost_ConecctionState();
}

class _Lost_ConecctionState extends State<Lost_Conecction> {
  TextEditingController controladorTitle = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    conectivity.conexionRestablecida(
        context, prefsInternal.prefsInternal.getString('paginaAnterior'));
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          // resizeToAvoidBottomInset:
          //     false, // los widgets no cambian de tamaño de alto cuando sale el teclado
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          body: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: variableGlobal.margenTopGeneral(context)),
              child: Column(children: <Widget>[
                // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                Column(
                  //Columna 001
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.10,
                    ),
                    Row(
                      //row de  logo
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        guy_back(context),
                      ],
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.000,
                    // ), //cierre  logo

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(generalText.allGood(),
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.035),
                            textAlign: TextAlign.center),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                        Text(generalText.oopslooksLike(),
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                //fontWeight: FontWeight.,
                                fontSize:
                                    MediaQuery.of(context).size.height * 0.028),
                            textAlign: TextAlign.center),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[reload(context, Lost_Conecction())],
                    ),
                  ],
                ), //Cierra columna 001
                // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
              ]),
            ),
          )),
    );
  }
}

// *****************
