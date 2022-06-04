// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/enviromets/url_server.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/PaypalPayment.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
  

  class DialogPaySelectMethodAd {


// LISTA  DE MÉTODOS DE PAGO
    showMaterialDialog(BuildContext context, dynamic match) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
                child: Column(
                  children: [
                    iconFace1(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(generalText.selectYourPreferredMethodOfPayment(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: responsive.ip(2.2),
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
                  ],
                ),
              ),
              content: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Stripe(),
                    Paypal()
                    
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
                    if(blocEditProfile.payMethod == null || blocEditProfile.payMethod == ''){
                      toastService.showToastCenter(context: context, text: generalText.selecAPaymentMethod(), durationSeconds: 5);
                    }else{
                      if(blocEditProfile.payMethod == 'stripe'){
                        String url = '${urlserver.url}/stripe_payment/?matchid=${match["_id"]}';
                        Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => PaypalPayPage(urlPay: url))); 
                      }else if(blocEditProfile.payMethod == 'paypal'){
                         showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                          Http().generateOrderPaypal(match["ad"]["price"].toString()).then((value){
                          
                            final valueMap = json.decode(value);
                            if(valueMap["ok"] == true){

                              String urlPay = ''; // Almacenamos la url de pago de PayPal
                              String payToken = valueMap["response"]["body"]["id"];

                            // GUARDAMOS EL PAYTOKEN EN EL USUARIO TEMPORALMENTE
                            Http().updatePayToken(preference.prefsInternal.get('email'), payToken, match["_id"], match["ad"]["_id"])
                                .then((valuePayToken){
                                  final payTokenMap = json.decode(valuePayToken);
                                  if(payTokenMap["ok"] == true){
                                    Navigator.pop(context);
                                      for(var r in valueMap["response"]["body"]["links"]){
                                        if(r["rel"] == "approve"){
                                          urlPay = r["href"];
                                          break;
                                        }
                                      }
                                      // print('--------------------     ------------ ${urlPay}');
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (BuildContext context) => PaypalPayPage(urlPay: urlPay),
                                      ));
                                      // _launchURL(urlPay);
                                    //  lastMilleResourse.createservice(valueMapResult["ad"], valueMapResult["flight"]);
                                  }
                                });
                            }else{
                              Navigator.pop(context);
                              print('Salio mal ${valueMap}');
                            }

                          });
                      }else{

                      }
                    }
                  },
                ),
              ],
            ));
    }

  }

// *************
// PAYPAL
// *************
  class Paypal extends StatefulWidget {
  
    @override
    _PaypalState createState() => _PaypalState();
  }
  
  class _PaypalState extends State<Paypal> {


    @override
    Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.centerLeft,
             children: [
               CupertinoButton(
                 padding: EdgeInsets.all(0),
                 onPressed: (){
                   setState(() {
                     blocEditProfile.changePayMethod('paypal');
                   });
                 },
                 child: Container(
                   height: MediaQuery.of(context).size.height * 0.05,
                   width: MediaQuery.of(context).size.width * 0.45,
                   // child: new SvgPicture.asset(
                   //               'assets/images/paymethods/paypal.svg',
                   //               color: Colors.white,
                   //               fit: BoxFit.contain,
                   //           ),
                   decoration: new BoxDecoration(
                     image: new DecorationImage(
                         image: new AssetImage("assets/images/paymethods/paypal.png"),
                         fit: BoxFit.fill,
                     )
                   )
                 ),
               ),
               Positioned(
               right: MediaQuery.of(context).size.width * 0.005,
               top: MediaQuery.of(context).size.width * 0.01,
               child: (blocEditProfile.payMethod == 'paypal')
                   ? selectPayMethod(context)
                   : Container())
             ],
           );
    }

      // ******************
      // ******************
    Widget selectPayMethod(BuildContext context) {
      return StreamBuilder(
            stream: blocEditProfile.payMethodStream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshopt) {
              if(snapshopt.hasData){
                if(blocEditProfile.payMethod == 'paypal'){
                  return Container(
                    width: MediaQuery.of(context).size.height * 0.015,
                    height: MediaQuery.of(context).size.height * 0.015,
                    child: Image.asset(
                      'assets/images/general/Fill-1560-2.png',
                      fit: BoxFit.contain,
                    ),
                  );
                }else{
                  return Container();
                }
              }else if(snapshopt.hasError){
                return Container();
              }else{
                return Container();
              }
            });
    }
  }



// *************
// STRIPE
// *************
 class Stripe extends StatefulWidget {

    @override
    _StripeState createState() => _StripeState();
  }
  
  class _StripeState extends State<Stripe> {

    @override
    Widget build(BuildContext context) {
      return Stack(
        alignment: Alignment.centerLeft,
             children: [
               CupertinoButton(
                 padding: EdgeInsets.all(0),
                 onPressed: (){
                   setState(() {
                     blocEditProfile.changePayMethod('stripe');
                   });
                 },
                 child: Container(
                   height: MediaQuery.of(context).size.height * 0.05,
                   width: MediaQuery.of(context).size.width * 0.45,
                  //  child: new SvgPicture.asset(
                  //                'assets/images/paymethods/stripe_logo.svg',
                  //                fit: BoxFit.contain,
                  //            ),
                  decoration: new BoxDecoration(
                     image: new DecorationImage(
                         image: new AssetImage("assets/images/paymethods/card.png"),
                         fit: BoxFit.fill,
                     )
                   )
                 ),
               ),
               Positioned(
               right: MediaQuery.of(context).size.width * 0.005,
               top: MediaQuery.of(context).size.width * 0.01,
               child: (blocEditProfile.payMethod == 'stripe')
                   ? selectPayMethod(context)
                   : Container())
             ],
           );
    }

      // ******************
    Widget selectPayMethod(BuildContext context) {
      return StreamBuilder(
            stream: blocEditProfile.payMethodStream,
            builder: (BuildContext context, AsyncSnapshot<String> snapshopt) {
              if(snapshopt.hasData){
                if(blocEditProfile.payMethod == 'stripe'){
                  return Container(
                    width: MediaQuery.of(context).size.height * 0.015,
                    height: MediaQuery.of(context).size.height * 0.015,
                    child: Image.asset(
                      'assets/images/general/Fill-1560-2.png',
                      fit: BoxFit.contain,
                    ),
                  );
                }else{
                  return Container();
                }
              }else if(snapshopt.hasError){
                return Container();
              }else{
                return Container();
              }
            });
    }
  }


    DialogPaySelectMethodAd dialogSelectPayMethodAd = DialogPaySelectMethodAd();