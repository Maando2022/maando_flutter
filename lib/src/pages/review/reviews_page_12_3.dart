// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/reviews_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class Reviews_page_12_3 extends StatefulWidget {
  Reviews_page_12_3({Key key}) : super(key: key);

  @override
  _Reviews_page_12_3State createState() => _Reviews_page_12_3State();
}

class _Reviews_page_12_3State extends State<Reviews_page_12_3> {
  List<Widget> reviews;
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'reviews_12_3');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final String emailUser = ModalRoute.of(context).settings.arguments;
    final Responsive  responsive = Responsive.of(context);

    return Container(
      height: double.infinity,
      child: Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          body: SingleChildScrollView(
            child: Container(
                  margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: variableGlobal.margenTopGeneral(context),
                  ),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                        // margin: EdgeInsets.only(top: height * 0.02),
                        child: Column(children: <Widget>[
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              iconFace1(context),
                            ],
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              // alignment: Alignment.center,
                              children: [
                                arrwBackYellowPersonalizado(context, 'principal'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox( height: 16.0),
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(reviewText.reviews(),
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(3.5),)),
                          ),
                        ],
                          ),
                          SizedBox(
                        height: 10.0,
                          ),
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[],
                          ),
                          Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                            child: Text(reviewText.shortDescription(),
                                style: TextStyle(
                                    letterSpacing: 0.07,
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.ip(1.8),)),
                          ),
                        ],
                          ),
                          SizedBox(
                            height: 16.5,
                          ),
                          FutureBuilder(
                          future: Http().findMatchForEmailOfFlight(context: context, email: emailUser),
                          builder: (BuildContext context, snapshot) {
                            if (snapshot.hasData) {
                              reviews = [];
                              var valueMap = json.decode(snapshot.data);
                              if (valueMap["ok"] == true) {
                                for (var match in valueMap["arrayMatch"]) {
                                  for(var review in match["reviews"]){
                                    reviews.add(Review(
                                      emittingUser: review["emittingUser"],
                                      ranking: review["rating"],
                                      review: review["review"],
                                      created_on: review["created_on"],
                                    ));
                                  }
                                }
                                if(reviews.length <=0){
                                      return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(generalText.weWillGetItThereFast(),
                                              textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1.0),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05)),
                                            ],
                                          ),
                                        ),
                                      );
                                }else{
                                  return Container(
                                    child: Column(
                                      children: reviews,
                                    ),
                                  );
                                }
                              } else {
                                return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(generalText.weWillGetItThereFast(),
                                              textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1.0),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05)),
                                            ],
                                          ),
                                        ),
                                      );
                              }
                            } else if (snapshot.hasError) {
                              return Center(
                                        child: Container(
                                          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(reviewText.errorLoadingReview(),
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          0, 0, 0, 1.0),
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.05)),
                                            ],
                                          ),
                                        ),
                                      );
                            } else {
                              return Container(
                                    margin: EdgeInsets.only(top: height * 0.2),
                                    child: Center(
                                        child: CircularProgressIndicator()),
                              );
                            }
                          })
                        ])),
                  ]),
            ),
          )),
    );
  }
}

class Review extends StatelessWidget {
  // const Review({Key key}) : super(key: key);

  final String emittingUser;
  final int ranking;
  final String review;
  final String created_on;

  Review(
      {@required this.emittingUser, @required this.ranking, @required this.review, @required this.created_on});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);


    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FutureBuilder<dynamic>(
                    future: Http().findUserForEmail(email: this.emittingUser),
                    builder: (BuildContext context, snapshotUser) {
                      if(snapshotUser.hasData){
                        var userMap = json.decode(snapshotUser.data);

                        String nombre = '';
                        if(userMap["ok"] == true){
                          if (userMap["user"]["name"]?.contains(' ') == true) {
                          nombre = userMap["user"]["name"]?.split(' ')[0];
                        } else {
                          nombre = userMap["user"]["name"];
                        }

                          return Row(
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width * 0.07,
                                          height: MediaQuery.of(context).size.width * 0.07,
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                              child: (userMap["user"]["avatar"] == '' || userMap["user"]["avatar"] == null) ? 
                                              Text(userMap["user"]["name"].toString().substring(0, 2).toUpperCase(), 
                                              style: TextStyle(
                                                        fontSize: MediaQuery.of(context).size.width * 0.045,
                                                        // height: 1.6,
                                                        fontWeight: FontWeight.bold),
                                                    textAlign: TextAlign.start,
                                              ) :
                                              Container(),
                                              backgroundImage: NetworkImage(userMap["user"]["avatar"]),
                                            )
                                        ),
                                        SizedBox(
                                          width: width * 0.04,
                                        ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            nombre,
                                            textAlign: TextAlign.start,
                                            style: TextStyle(
                                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: responsive.ip(1.8))
                                          ),
                                          Text('${obtenerTiempoDePublicacion(created_on)["number"]} ${obtenerTiempoDePublicacion(created_on)["time"]}', textAlign: TextAlign.start,
                                            style: TextStyle(
                                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: responsive.ip(1.5)))
                                        ],
                                      ),
                                      
                                  ],
                                );
                        }else{
                          return Container();
                        }
                      }else if(snapshotUser.hasError){
                        return Container();
                      }else{
                        return Container();
                      }

                    }),
              ratings(context, ranking),
            ],
          ),
          Container(
              width: width,
              margin: EdgeInsets.only(top: height * 0.02, bottom: height * 0.02, left: width * 0.115),
              child: Text(review,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              letterSpacing: 0.07,
                              color: Color.fromRGBO(33, 36, 41, 1.0),
                              fontWeight: FontWeight.normal,
                              fontSize: responsive.ip(1.8)))),
        ],
      ),
    );
  }
}
