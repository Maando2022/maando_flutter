// @dart=2.9
import 'dart:convert';
import 'package:maando/src/blocs/admin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/card_flight.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maando/src/utils/responsive.dart';

class Flight extends StatefulWidget {
  
  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {

  int _tab = 1;


  @override
    void initState() {
      // TODO: implement initState
      super.initState();
          blocAdmin.changeAd(blocAdmin.match["ad"]);
          blocAdmin.changeFlight(blocAdmin.match["flight"]);
    }


  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            SizedBox( height: height * 0.01),
            Container(
              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
              width: width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _tabAd(responsive, height, width),
                      SizedBox(
                        width: width * 0.03,
                      ),
                      _tabFlight(responsive, height, width),
                    ],
                  ),
                   _position(context, blocAdmin.ad["user"]),
                ],
              ),
            ),
            SizedBox( height: height * 0.05),
            (_tab == 1) ? _userAd(responsive, height, width) : _userFlight(responsive, height, width),
            _dataPay(height, width, responsive),
            SizedBox(height: height * 0.05),
                                    
                                    
                            
          ],
        ),
      ),
    );
    
  }
    // ********************
      Widget _appBar() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        margin: EdgeInsets.only(
          left: variableGlobal.margenPageWith(context),
          right: variableGlobal.margenPageWith(context),
          top: variableGlobal.margenTopGeneral(context),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconFace1(context),
              ],
            ),
            arrwBackYellowPersonalizado(context, 'admin'),
          ],
        ));
  }   
  // ************************************************
  // ************************************************
  Widget _userAd(Responsive responsive, double height, double width){
    return Container( margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: Column(
                          children: [
                            _avatar(context, responsive, blocAdmin.ad["user"]),
                            SizedBox( height: height * 0.05),
                            Row(
                              children: [
                                Text('${adminText.code()}: ',
                                style: TextStyle(
                                  fontSize: responsive.ip(2.5),
                                  fontWeight: FontWeight.bold)),
                                Text(blocAdmin.ad["code"],
                                  style: TextStyle(
                                    fontSize: responsive.ip(2.5),
                                    fontWeight: FontWeight.w400)),
                              ],
                            ),
                            SizedBox( height: height * 0.01),
                            CardAd(ad: blocAdmin.ad,
                                        viewImages: true,
                                        allImages: true,
                                        viewButtonOption: false,
                                        viewCountryCity: true,
                                        viewDate: true,
                                        viewRatings: false,
                                        viewPrice: true,
                                        code: true,
                                        botonTitle: BotonTitle(title: blocAdmin.ad['title']),
                                        actionSheet: null),
                            SizedBox( height: height * 0.01),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${adsText.deliveryAddress()}: ',
                                  style: TextStyle(
                                        fontSize: responsive.ip(1.8),
                                        // height: 1.6,
                                        fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                  ),
                                Container(
                                   width: width * 0.5,
                                  child: Text(blocAdmin.ad["delivery"],
                                    style: TextStyle(
                                          fontSize: responsive.ip(1.8),
                                          color: Color.fromRGBO(173, 181, 189, 1),
                                          fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                    ),
                                ),
                              ],
                            ),
                             SizedBox( height: height * 0.01),
                          ],
                        ));
  }

    // ************************************************
    // 
  Widget _position(BuildContext context, dynamic user) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      width: MediaQuery.of(context).size.height * 0.04,

      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Image.asset('assets/images/general/maps.png', fit: BoxFit.contain),
        onPressed: () {
          Navigator.pushNamed(context, 'flight_map', arguments: json.encode({'user': user, 'flight': blocAdmin.flight}));
        },
      ),
    );
  }
  // ************************************************
  Widget _userFlight(Responsive responsive, double height, double width){
    return Container( margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
              child: Column(
                      children: [
                        _avatar(context, responsive, blocAdmin.flight["user"]),
                          SizedBox( height: height * 0.05),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('${flightText.numberFlight()}: ',
                                      style: TextStyle(
                                        fontSize: responsive.ip(2),
                                        fontWeight: FontWeight.bold)),
                                      Text(blocAdmin.flight["flightNumber"],
                                        style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                    SizedBox( height: height * 0.01),
                                  Row(
                                    children: [
                                      Text('${flightText.reservationCode()}: ',
                                      style: TextStyle(
                                        fontSize: responsive.ip(2),
                                        fontWeight: FontWeight.bold)),
                                      Text(blocAdmin.flight["reservationCode"],
                                        style: TextStyle(
                                          fontSize: responsive.ip(2),
                                          fontWeight: FontWeight.w400)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox( height: height * 0.01),
                              CardFlight(
                                    flight: blocAdmin.flight,
                                    viewCodes: true,
                                    viewRatings: false,
                                    viewDates: true,
                                    viewPakages: true,
                                    viewButtonOption: false,
                                    tapBackground: false,
                                    functionTapBackground: null,
                                    actionSheet: null),
                              SizedBox( height: height * 0.05),
                      ],
                    ));
  }


  // *************************
  Widget _avatar(BuildContext contex, Responsive responsive,  dynamic user){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          height: MediaQuery.of(context).size.width * 0.25,
          child: CircleAvatar(
            backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
            child: (user["avatar"] == null || user["avatar"] == '')
            ? Text(user["name"].substring(0, 2).toUpperCase(), style: TextStyle(
                                              fontSize: responsive.ip(2.5),
                                              // height: 1.6,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.start,
                                        )
            : Container(),
            backgroundImage: NetworkImage(user["avatar"]),
          ),
        ),
        SizedBox( height: MediaQuery.of(context).size.height * 0.01),
         Text(user["name"],
              textAlign: TextAlign.center,
              style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontWeight: FontWeight.w400,
                      fontSize: responsive.ip(2.5)),
            ),
        SizedBox( height: MediaQuery.of(context).size.height * 0.01),
         Text(user["email"],
              textAlign: TextAlign.center,
              style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(2)),
            ),
      ],
    );
  }


  // ******************************
  Widget _tabAd(Responsive responsive, double height, double width) {
       return Container(
              height: height * 0.055,
              width: width * 0.25,
              child: CupertinoButton(
                  child: Text(generalText.ad(),
                      style: TextStyle(
                    color: (_tab == 1)
                        ? Color.fromRGBO(33, 36, 41, 0.5)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(1.5))),
                  color: (_tab == 1)
            ? Color.fromRGBO(255, 206, 6, 1.0)
            : Color.fromRGBO(234, 234, 234, 0.5),
                  borderRadius:
              BorderRadius.circular(14),
                  padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width * 0.015),
                  onPressed: () {
                    setState(() {
                      _tab = 1;
                    });
                  }),
            );
  }

  Widget _tabFlight(Responsive responsive, double height, double width) {
    return Container(
              height: height * 0.055,
              width: width * 0.25,
              child: CupertinoButton(
                  child: Text(generalText.flight(),
                      style: TextStyle(
                    color: (_tab == 2)
                        ? Color.fromRGBO(33, 36, 41, 0.5)
                        : Color.fromRGBO(0, 0, 0, 1.0),
                    fontWeight: FontWeight.bold,
                    fontSize: responsive.ip(1.5))),
                  color: (_tab == 2)
            ? Color.fromRGBO(255, 206, 6, 1.0)
            : Color.fromRGBO(234, 234, 234, 0.5),
                  borderRadius:
              BorderRadius.circular(14),
                  padding: EdgeInsets.symmetric( horizontal: MediaQuery.of(context).size.width * 0.015),
                  onPressed: () {
                    setState(() {
                      _tab = 2;
                    });
                  }),
            );
  }




  Widget _call(BuildContext context, String phoneCode){
    return Container(
       height: MediaQuery.of(context).size.height * 0.05,
       width: MediaQuery.of(context).size.height * 0.05,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Icon(Icons.phone, color: Color.fromRGBO(255, 206, 6, 1), size: MediaQuery.of(context).size.height * 0.08),
        onPressed: (){
          launch('tel://$phoneCode');
        },
      ),
    );
  }


  Widget _dataPay(double height, double width, Responsive responsive){
    if(blocAdmin.ad["pay"] == null){
      return Container();
    }else{
         return (blocAdmin.ad["pay"]["dataPay"]["method"] == 'paypal') ? 
    Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${generalText.paypalAccount()}: ',
                style: TextStyle(
                      fontSize: responsive.ip(1.8),
                      // height: 1.6,
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
              Text('${blocAdmin.ad["pay"]["dataPay"]["key"]["body"]["payer"]["email_address"]}',
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontSize: responsive.ip(1.8),
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
            ],
          ),
          Row(
            children: [
              Text('Payet_id: ',
                style: TextStyle(
                      fontSize: responsive.ip(1.8),
                      // height: 1.6,
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
              Text('${blocAdmin.ad["pay"]["dataPay"]["key"]["body"]["payer"]["payer_id"]}',
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontSize: responsive.ip(1.8),
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
            ],
          )
        ],
      ),
    ): 
    Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('${generalText.paymentMethods()}: ',
                style: TextStyle(
                      fontSize: responsive.ip(1.8),
                      // height: 1.6,
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
              Text('${blocAdmin.ad["pay"]["dataPay"]["method"]}',
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontSize: responsive.ip(1.8),
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
            ],
          ),
          Row(
            children: [
              Text('Payet_id: ',
                style: TextStyle(
                      fontSize: responsive.ip(1.8),
                      // height: 1.6,
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
              Text('${blocAdmin.ad["pay"]["dataPay"]["key"]["paymentIntent"]["id"]}',
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontSize: responsive.ip(1.8),
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
            ],
          )
        ],
      ),
    );
   }
  }

@override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    blocAdmin.changeAd(null);
    blocAdmin.changeFlight(null);
  }
}