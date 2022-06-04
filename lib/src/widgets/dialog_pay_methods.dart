import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
  

  class DialogPayMethods {


// LISTA  DE MÉTODOS DE PAGO
    showMaterialDialog(BuildContext context, dynamic user) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                child: Column(
                  children: [
                    iconFace1(context),
                    Text(generalText.youMuchHaveAApypalAccountToReceivePaymentForYourService(),
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
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Paypal(),
                    // Stripe(),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                    if(blocEditProfile.payMethod == null || blocEditProfile.payMethod == ''){
                      toastService.showToastCenter(context: context, text: generalText.selecAPaymentMethod(), durationSeconds: 5);
                    }else{
                      if(blocEditProfile.payMethod == 'paypal'){
                        Navigator.pushNamed(context, 'pay_method_paypal', arguments: json.encode(user));
                      }else if(blocEditProfile.payMethod == 'stripe'){
                        Navigator.pushNamed(context, 'pay_method_stripe', arguments: json.encode(user));
                      }else{

                      }
                    }
                  },
                ),
              ],
            ));
    }

  }

  DialogPayMethods dialogPayMethods = DialogPayMethods();




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
                 onPressed: (){
                   setState(() {
                     blocEditProfile.changePayMethod('paypal');
                   });
                 },
                 child: Container(
                     height: MediaQuery.of(context).size.height * 0.07,
                     width: MediaQuery.of(context).size.width * 0.55,
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
               right: MediaQuery.of(context).size.width * 0.03,
               top: MediaQuery.of(context).size.height * 0.01,
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
                    width: MediaQuery.of(context).size.height * 0.02,
                    height: MediaQuery.of(context).size.height * 0.02,
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
      return Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(173, 181, 189, 0.3),
          borderRadius: BorderRadius.circular(12),
        ),
         child: Stack(
           alignment: Alignment.centerLeft,
                children: [
                  CupertinoButton(
                    onPressed: (){
                      setState(() {
                        blocEditProfile.changePayMethod('stripe');
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: new SvgPicture.asset(
                                    'assets/images/paymethods/stripe_logo.svg',
                                    fit: BoxFit.contain,
                                ),
                    ),
                  ),
                  Positioned(
                  right: MediaQuery.of(context).size.width * 0.03,
                  top: MediaQuery.of(context).size.height * 0.01,
                  child: (blocEditProfile.payMethod == 'stripe')
                      ? selectPayMethod(context)
                      : Container())
                ],
              )
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
                    width: MediaQuery.of(context).size.height * 0.02,
                    height: MediaQuery.of(context).size.height * 0.02,
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