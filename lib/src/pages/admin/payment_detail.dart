// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_flight.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentDetail extends StatefulWidget {
  
  @override
  _PaymentDetailState createState() => _PaymentDetailState();
}

class _PaymentDetailState extends State<PaymentDetail> {

  Http _http = Http();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    String phoneCode = json.decode(ModalRoute.of(context).settings.arguments)["phoneCode"];
    String phoneWhatsApps = json.decode(ModalRoute.of(context).settings.arguments)["phoneWhatsApps"];
    
    return  Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            SizedBox( height: height * 0.05),
            _avatar(context, blocAdmin.payment["flight"]["user"]),
            SizedBox( height: height * 0.05),
           Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
                _active(context),
                _pay(context, blocAdmin.payment["flight"]["user"]),
                SizedBox( height: height * 0.04),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _whatapps(context, blocAdmin.payment["flight"]["user"], phoneWhatsApps),
                      SizedBox( width: width * 0.2),
                      _call(context, phoneWhatsApps),
                    ],
                  ),
                SizedBox( height: height * 0.04),
                _ad(context, blocAdmin.payment["ad"]),
                Container(
                   margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                  child: CardFlight(
                      flight: blocAdmin.payment["flight"],
                      viewCodes: true,
                      viewRatings: false,
                      viewDates: true,
                      viewPakages: true,
                      viewButtonOption: false,
                      tapBackground: false,
                      functionTapBackground: null,
                      actionSheet: null),
                ),
                SizedBox( height: height * 0.01),
                _dataPay(height, width, responsive),
                SizedBox( height: height * 0.2),
             ],
           ),
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

  // *************************
  Widget _avatar(BuildContext contex, dynamic user){
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.35,
          child: CircleAvatar(
            child: (user["avatar"] == null || user["avatar"] == '')
            ? Text(user["name"].substring(0, 2).toUpperCase(), style: TextStyle(
                                              fontSize: MediaQuery.of(context).size.width * 0.1,
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
                      fontSize: MediaQuery.of(context).size.width * 0.05),
            ),
        SizedBox( height: MediaQuery.of(context).size.height * 0.01),
         Text(user["email"],
              textAlign: TextAlign.center,
              style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.width * 0.045),
            ),
      ],
    );
  }


  // ******************************
  Widget _active(BuildContext context){
     return Container(
              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox( width: MediaQuery.of(context).size.width * 0.01),
                  Text((blocAdmin.payment["stateFlight"] == 'request_paidFlight' ? adminText.isPaid() : adminText.noPaid()),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width * 0.045)),
                  StreamBuilder(
                    stream: blocAdmin.paymentStream,
                    // ignore: missing_return
                    builder: (BuildContext context, snapshotPayment) {
                      if(snapshotPayment.hasData){
                        return Switch(
                                    value: (snapshotPayment.data["stateFlight"] == 'request_paidFlight'),
                                    onChanged: (value) {
                                      _http.markMatchAsPaid(context: context, email: preference.prefsInternal.get('email'), idMatch: blocAdmin.payment["_id"])
                                      .then((payment) {
                                          final valueMap = json.decode(payment);
                                          if (valueMap['ok'] == false) {
                                          } else {
                                           if(blocAdmin.payment["stateFlight"] == 'request_sendFlight' || blocAdmin.payment["stateFlight"] == 'request_acceptedFlight'){
                                             blocAdmin.payment["stateFlight"] = 'request_paidFlight';
                                           }else{
                                             blocAdmin.payment["stateFlight"] = 'request_sendFlight';
                                           }
                                            blocAdmin.changePayment(blocAdmin.payment);
                                          }
                                        });
                                    },
                                    activeTrackColor: Color.fromRGBO(255, 206, 6, 1),
                                    activeColor: Color.fromRGBO(255, 206, 6, 0.5),
                                  );
                      }else if(snapshotPayment.hasError){
                        return Container();
                      }else{
                        return Container();
                      }
                    })

                  ],
                ),
              );
     
  }


  // ******************************
  Widget _pay(BuildContext context, dynamic user){


      if(user["pay"] == null){
        return Container();
      }else{
        if(user["pay"]["name"] == 'paypal'){
               return Container(
              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: Row(
                  children: [
                    Text('Paypal: '),
                    Text(user["pay"]["accountEmail"]),
                  ],
                ),
              );
        }else{
          return Container(
              margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text('Stripe')
                      ],
                    ),
                    Row(
                      children: [
                        Text('${generalText.numberAccount()}: '),
                        Text('${user["pay"]["accountNumber"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${generalText.typeAccount()}: '),
                        Text('${user["pay"]["type"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${generalText.back()}: '),
                        Text('${user["pay"]["bank"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${generalText.codeBicOrSwitf()}: '),
                        Text('${user["pay"]["bic"]}'),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${generalText.ibanCode()}: '),
                        Text('${user["pay"]["iban"]}'),
                      ],
                    ),
                  ],
                ),
              );
        }
      }
     
  }
 
  // ******************************
  Widget _whatapps(BuildContext context, dynamic user, String phoneWhatsApps){
   
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
       decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/images/general/whatapps.jfif'), fit: BoxFit.contain),
        ),
      child: MaterialButton(onPressed: () async {
                // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                String message =
                    "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}";
                String url;
                if (Platform.isIOS) {
                  url =
                      "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                              await canLaunch(url)
                    ? launch(url)
                    : print('Error al enviar mensaje de WhatsApps');
                } else {
                  url =
                      "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                              await canLaunch(url)
                    ? launch(url)
                    : print('Error al enviar mensaje de WhatsApps');
                }
        }),
    );
  }


  Widget _call(BuildContext context, String phoneWhatsApps){
    return Container(
       height: MediaQuery.of(context).size.height * 0.05,
       width: MediaQuery.of(context).size.height * 0.05,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Icon(Icons.phone, color: Color.fromRGBO(255, 206, 6, 1), size: MediaQuery.of(context).size.height * 0.08),
        onPressed: (){
          launch('tel://$phoneWhatsApps');
        },
      ),
    );
  }

  // ******************************
  Widget _ad(context, ad){
    return Container(
       margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
      child: Text(ad["title"],
          style: TextStyle(
                   color: Color.fromRGBO(173, 181, 189, 1),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.06),
        ),
    );
  }
  // ******************************

  Widget _dataPay(double height, double width, Responsive responsive){
    return Container(
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
              Text('${blocAdmin.payment["flight"]["user"]["pay"]["accountEmail"]}',
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontSize: responsive.ip(1.8),
                      fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                ),
            ],
          ),
          // Row(
          //   children: [
          //     Text('${generalText.paypalAccount()}: ',
          //       style: TextStyle(
          //             fontSize: responsive.ip(1.8),
          //             // height: 1.6,
          //             fontWeight: FontWeight.bold),
          //             textAlign: TextAlign.start,
          //       ),
          //     Text('${blocAdmin.payment["flight"]["user"]["pay"]["accountEmail"]}',
          //       style: TextStyle(
          //             color: Color.fromRGBO(173, 181, 189, 1),
          //             fontSize: responsive.ip(1.8),
          //             fontWeight: FontWeight.bold),
          //             textAlign: TextAlign.start,
          //       ),
          //   ],
          // )
        ],
      ),
    );
  }
}