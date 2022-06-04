// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/globals.dart';

class CardAdMatch extends StatefulWidget {
  // const CardAd({Key key}) : super(key: key);
  String ad;

  CardAdMatch({@required this.ad});

  @override
  _CardAdMatchState createState() => _CardAdMatchState();
}

class _CardAdMatchState extends State<CardAdMatch> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    dynamic ad = json.decode(widget.ad);

    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01, horizontal: 0.01),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Color.fromRGBO(33, 36, 41, 0.2),
              blurRadius: 1.0,
              offset: Offset(0.0, 1.0))
        ],
        color: Color.fromRGBO(251, 251, 251, 1),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.04,
          ),
          _image(height, width, ad),
          SizedBox(
            height: height * 0.025,
          ),
          _contryCity(context, height, width, ad),
          SizedBox(
            height: height * 0.025,
          ),
          _datetime(context, height, width, ad),
          SizedBox(
            height: height * 0.025,
          ),
          SizedBox(
            height: height * 0.04,
          ),
        ],
      ),
    );
  }

  Widget _image(double height, double width, ad) {
    return Container(
      child: Stack(
        children: <Widget>[
          FutureBuilder<dynamic>(
              future: firebaseStorage.obtenerImagen(
                  ad["user"]["email"], ad["_id"], 1),
              builder: (BuildContext context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                    width: double.infinity,
                    height: height * 0.3,
                    // padding: EdgeInsetsDirectional.only(top: 0.0),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 232, 235, 1),
                    ),
                    child: Container(
                      color: Color.fromRGBO(230, 232, 235, 1),
                      child: FadeInImage(
                        image: NetworkImage(snapshot.data),
                        placeholder:
                            AssetImage('assets/images/general/jar-loading.gif'),
                        fit: BoxFit.contain,
                        // height: 200.0,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Container();
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: 100.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              }),
          Container(
            height: height * 0.045,
            width: width * 0.27,
            margin: EdgeInsets.only(top: height * 0.01, left: width * 0.05),
            child: CupertinoButton(
                child: Container(
                  child: Text(ad["title"].toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: variableGlobal.tamanoLabecardAd(context))),
                ),
                color: Color.fromRGBO(255, 206, 6, 1.0),
                borderRadius: BorderRadius.circular(4.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                onPressed: () {
                  Navigator.pushNamed(context, 'detail_ad_match',
                      arguments: widget.ad);
                }),
          ),
        ],
      ),
    );
  }

  // ************************************
  Widget _contryCity(BuildContext context, double height, double width, ad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Container(
          //  width: MediaQuery.of(context).size.width * 0.8,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                  Widget>[
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(generalText.country(),
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1.0),
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.03)),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: Text(ad["country"],
                      style: TextStyle(
                          color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03)),
                ),
              ],
            ),
          )
        ]),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
          Text(generalText.city(),
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1.0),
                  fontWeight: FontWeight.w600,
                  fontSize: MediaQuery.of(context).size.width * 0.03)),
          Container(
            width: MediaQuery.of(context).size.width * 0.3,
            child: Row(
              children: [
                Expanded(
                  child: Text(ad["city"],
                      style: TextStyle(
                          color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.03)),
                ),
              ],
            ),
          )
        ])
      ])),
    );
  }

  // *************************
  Widget _datetime(BuildContext context, double height, double width, ad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(generalText.dateToDeliver(),
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize:
                                MediaQuery.of(context).size.width * 0.03)),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: <Widget>[
                        date(context),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text(
                            '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(ad["arrivalDate"])).toString())}',
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03))
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
