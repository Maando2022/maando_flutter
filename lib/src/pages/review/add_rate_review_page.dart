// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/ranking_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/reviews_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/ratings.dart';


class Add_rate_review extends StatelessWidget {
  TextEditingController controladorReview = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final preference = Preferencias();
  String nombre = '';
  bool myReview = false;
  dynamic matchUpdate;
  dynamic match;

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'add_rate_review');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);


    if(matchUpdate == null){
      match = json.decode(ModalRoute.of(context).settings.arguments);
    }else{
      match = matchUpdate; 
    }

    if(match["reviews"].length > 0){
       for(var review in match["reviews"]){
          if(review["emittingUser"] == preference.prefsInternal.get('email')){
            myReview = true;
           if(blocRanking.review == null) blocRanking.changeReview(review["review"]);
           if(blocRanking.rating == null) blocRanking.changeRating(review["rating"]);
          }else{
            myReview = false;
            if(blocRanking.rating == null) blocRanking.changeRating(0);
          }
        }
    }else{
      myReview = false;
      if(blocRanking.rating == null) blocRanking.changeRating(0); 
    }




// extraemos el primer nombre si lo tiene
    if (preference.prefsInternal.get('fullName').toString().contains(' ') == true) {
      nombre = preference.prefsInternal.get('fullName').toString().split(' ')[0];
    } else {
      nombre = preference.prefsInternal.get('fullName');
    }

    return Scaffold(
        // resizeToAvoidBottomInset:
        //     false, // los widgets no cambian de tamaño de alto cuando sale el teclado
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: variableGlobal.margenPageWith(context),
                  vertical: variableGlobal.margenTopGeneral(context)),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    Column(
                      //Columna 001
                      children: <Widget>[
                        Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                iconFace1(context),
                              ],
                            ),
                            closeRateAndReview(context,
                                'assets/images/close/close button 1@3x.png'),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Row(
                          // row create ad
                          children: <Widget>[
                            Container(
                              child: Text(reviewText.rateAndReview(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(0, 0, 0, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.ip(3.5))),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        //cierre row create ad

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(reviewText.giveNameWhatHeDeserves(nombre),
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(3)),
                                textAlign: TextAlign.center),
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.03,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Ratings(context: context)),
                              ],
                            )
                          ],
                        ), //cierre row circulo verde
                      ],
                    ), //Cierra columna 001
                    // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                    Container(
                      child: Stack(
                        children: <Widget>[
                          _crearReview(responsive),
                          Positioned(
                              top: (MediaQuery.of(context).size.height >= 700.0)
                                  ? MediaQuery.of(context).size.height * 0.22
                                  : MediaQuery.of(context).size.height * 0.27,
                              child: _maximumText()),
                          // ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
                        ],
                      ),
                    ),
                    _sendReview(context, height, width, match["_id"])
                  ]),
            ),
          ),
        ));
  }




  // *************************************
    bool _validarReview() {
    bool validate = false;
    if (blocRanking.review == null) {
      validate = false;
    } else {
      if (blocRanking.review.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

  Widget _crearReview(Responsive responsive) {
    String text = (_validarReview() == false) ? reviewText.doYouWantToWrite() : '';

    controladorReview.text = (_validarReview() == false) ? '' : blocRanking.review;
    controladorReview.selection =
        TextSelection.collapsed(offset: controladorReview.text.length);

    return StreamBuilder(
        stream: blocRanking.reviewStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
              return Container(
                      child: Form(
                        key: formKey,
                        child: TextFormField(
                            textInputAction: TextInputAction.done,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: responsive.ip(2.5),
                                color: Color.fromRGBO(173, 181, 189, 1)),
                            controller: controladorReview,
                            cursorColor: Colors.deepOrange,
                            keyboardType: TextInputType.multiline,
                            maxLines: 7,
                            maxLength: 180,
                            decoration: InputDecoration(
                              alignLabelWithHint: true,
                              counterText: "",
                              labelText: text,
                              border: InputBorder.none,
                              labelStyle: TextStyle(
                                  fontSize: responsive.ip(3),
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromRGBO(173, 181, 189, 1)),
                            ),
                            onChanged: (value) => {
                                  blocRanking.changeReview(value.trim()),
                                },
                            onTap: () {
                              text = '';
                            }),
                      ),
                    );
        });
  }

  Widget toast(BuildContext context, double height, double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          toastService.showToastCenter(context: context, text: 'There is no title', durationSeconds: 4);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Center(
            child: Text('Next',
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        color: Color.fromRGBO(251, 251, 251, 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side:
                BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
      );
    });
  }

  Widget _maximumText() {
    return Row(
      children: [
        StreamBuilder(
          stream: blocRanking.reviewStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data == null) {
                return Container();
              } else {
                return Container();
              }
            } else if (snapshot.hasError) {
              return Container();
            } else {
              return Text(reviewText.maximunCharacter(),
                  style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.03),
                  textAlign: TextAlign.right);
            }
          },
        )
      ],
    );
  }

  // *****************
  Widget _sendReview(BuildContext context, double height, double width, String id) {

    return StreamBuilder(
      stream: blocRanking.reviewStream,
      builder: (BuildContext context, AsyncSnapshot snapshotReview) {

         return StreamBuilder(
          stream: blocRanking.ratingStream,
          builder: (BuildContext context, AsyncSnapshot snapshoRating) {
            return Container(
                    margin: EdgeInsets.only(top: height * 0.08),
                    child: RaisedButton(
                      onPressed: (snapshotReview.hasData && snapshoRating.data != 0) ? (){
                        
                        Http().updateCreateOrReview(
                          context: context, 
                          email: preference.prefsInternal.get('email'),
                          id: id,
                          review: blocRanking.review,
                          rating: blocRanking.rating
                          ).then((value){
                            var valueMap = json.decode(value);
                            if(valueMap["ok"] == true){
                              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, valueMap["message"]); } )
                              .then((_){
                                  blocRanking.streamNull();
                                    Navigator.pushNamed(context, 'history');
                                  });
                            }else{
                              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); });
                            }
                          });
                      } : null,
                      child: Container(
                        width: width * 0.85,
                        height: height * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(reviewText.sendReview(),
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 206, 6, 1),
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                )),
                            // page(context)
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          side: BorderSide(color: Colors.black, width: 1)),
                      elevation: 5.0,
                      color: Color.fromRGBO(33, 36, 41, 1),
                    ),
                  );
          });
      }
    );


  }
}
