// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';

class SHIPMENTS_service_InTransit extends StatelessWidget {


  dynamic ad;
  String destination;
  String adTitle;

  SHIPMENTS_service_InTransit(
      {@required this.ad});

  @override
  Widget build(BuildContext context) {
    return _adsConDatos(context);
  }

// ***************************
  Widget _adsConDatos(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    
    return CupertinoButton(
      onPressed: (){
         Navigator.pushReplacementNamed(context, 'timelineAd', arguments: json.encode({'pageBack': 'shipments', 'flight': json.encode(ad["flight"])}));
        // Navigator.pushNamed(context, 'timelineMap', arguments: json.encode(ad["flight"]["user"]));
      },
      child: Container(
        child: Row(
          children: <Widget>[
            FutureBuilder<dynamic>(
              future: firebaseStorage.obtenerImagen(this.ad["user"]["email"], ad["_id"], 1),
              builder: (BuildContext context, snapshot) {
                if(snapshot.hasData){
                  return Container(
                            width: width * 0.25,
                            height: width * 0.25,
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
                }else if(snapshot.hasError){
                  return Container();
                }else{
                  return Container(
                    // margin: EdgeInsets.only(top: height * 0.25),
                    child: Center(
                        child: CircularProgressIndicator()),
                  );
                }
              }),
            Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      boxYellow(height, width),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(ad["title"],
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04))
                    ],
                  ),
                  SizedBox(
                        width: width * 0.02,
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(generalText.destination(),
                      style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1.0),
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                  SizedBox(
                   height: height * 0.005,
                  ),
                  Row(
                    children: <Widget>[
                      position(height, width),
                      SizedBox(
                        width: width * 0.02,
                      ),
                      Text(ad["city"],
                          style: TextStyle(
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontWeight: FontWeight.bold,
                              fontSize: width * 0.04))
                    ],
                  ),
                  SizedBox(
                   height: height * 0.005,
                  ),
                  FutureBuilder(
                    future: Http().findMatchSendAd(context: context, email: preference.prefsInternal.get('email'), id: ad["_id"]),
                    builder: (_, AsyncSnapshot snapshot){
                      if(snapshot.hasData){
                        final resp = json.decode(snapshot.data);
                        if(resp["ok"] == true){
                          return Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('${generalText.code()}: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.ip(1.8),
                                      fontWeight: FontWeight.bold)),
                                    Text(resp["matchDB"][0]["ad"]["code"],
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: responsive.ip(1.8),
                                      fontWeight: FontWeight.w300)),
                                  ],
                                );
                        }else{
                          return Container();
                        }
                      }else if(snapshot.hasError){
                        return Container();
                      }else{
                        return Container();
                      }
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100.0,
            ),
          ],
        ),
      ),
    );
  }
}
