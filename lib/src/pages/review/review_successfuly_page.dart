import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/reviews_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class Review_Successfuly extends StatefulWidget {
  // const Add_rate_review({Key key}) : super(key: key);
  @override
  _Review_SuccessfulyState createState() => _Review_SuccessfulyState();
}

class _Review_SuccessfulyState extends State<Review_Successfuly> {
  TextEditingController controladorTitle = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'review_successfuly');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
                  Row(
                    //row de  logo
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      iconFace1(context),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  ), //cierre  logo

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(reviewText.yourReviewSuccessfilly(),
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  MediaQuery.of(context).size.height * 0.035),
                          textAlign: TextAlign.center),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      back_to_home(context, Review_Successfuly())
                    ],
                  ),
                ],
              ), //Cierra columna 001
              // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            ]),
          ),
        ));
  }
}

// *****************
