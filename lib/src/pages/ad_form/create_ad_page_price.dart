// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/pages/ad_form/create_ad_images2.dart';
import 'dart:io' show Platform;
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class CreateAdPrice extends StatefulWidget {
  const CreateAdPrice({Key key}) : super(key: key);

  @override
  _CreateAdPriceState createState() => _CreateAdPriceState();
}

class _CreateAdPriceState extends State<CreateAdPrice> {
  TextEditingController controladorPrice = TextEditingController();

  final formKey = GlobalKey<FormState>();
  double _keyboard = 0;
  bool verEjemplo = false;

  @protected
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_price');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final bloc = ProviderApp.ofAdForm(context);
    final Responsive responsive = Responsive.of(context);

    return Scaffold(
        resizeToAvoidBottomInset:
            false, // los widgets no cambian de tamaño de alto cuando sale el teclado
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: Stack(
          children: [
            // **********************************************************
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(
                  top: width * 0.6,
                  right: variableGlobal.margenPageWith(context),
                  left: variableGlobal.margenPageWith(context)),
              child: SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
        
                              (!verEjemplo)
                                  ? Container(
                                      child: Column(children: <Widget>[
                                      Text(adsText.enterPriceLegend(),
                                          style: TextStyle(
                                              color:
                                                  Color.fromRGBO(33, 36, 41, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context).size.height * 0.025),
                                          textAlign: TextAlign.left),
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height * 0.03,
                                      ),
                                    ]))
                                  : Container(),
                              _createPrice(bloc),
                              KeyboardVisibilityBuilder(
                                builder: (context, isKeyboardVisible) {
                                  return SizedBox(height: (isKeyboardVisible) ? 200.0 : 0);
                                }
                              )
                            ],
                          ),
                        ),
                      ]),
                ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03)
                  ],
                ),
              ),
            ),
            // *********************************************
            Container(
              margin: EdgeInsets.only(
                left: variableGlobal.margenPageWith(context),
                right: variableGlobal.margenPageWith(context),
                top: variableGlobal.margenPageWithFlightTop(context),
              ),
              child: Column(
                //Columna 001
                children: <Widget>[
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                      closeAd(context,
                          'assets/images/close/close button 1@3x.png'),
                    ],
                  ), //cierre de boton cerra y logo
                  SizedBox(
                    height: height * 0.02,
                  ),

                  Row(
                    // row create ad
                    children: <Widget>[
                      Container(
                        child: Text(adsText.titulo_1(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3.5))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  //cierre row create ad

                  Row(
                    //row de circulo verde
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      circuloVerde(context, 3, 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(adsText.price(),
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.07)),
                          Text(
                               '${generalText.next()}: ${adsText.adReadyForPublish()}',
                              style: TextStyle(
                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                  fontWeight: FontWeight.w500,
                                 fontSize: width * 0.04))
                        ],
                      )
                    ],
                  ),//cierre row circulo verde
                ],
              ),
            ),
            Positioned(
              width: width,
                    top: variableGlobal.topNavigation(context),
                    child: Container(
                      margin: EdgeInsets.only(
                        left: variableGlobal.margenPageWith(context),
                        right: variableGlobal.margenPageWith(context),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          back(context, CreateAdImages2()),
                        StreamBuilder<String> (
                        stream: bloc.priceStream,
                        builder:
                            (BuildContext context, AsyncSnapshot<String> snapshot) {
                          if (snapshot.hasData) {
                            if(int.parse(snapshot.data) < 30){
                              return toastMenoaA30(context, responsive, height, width);
                            }else{
                              return next(context, 'create_ad_resume');
                            }
                          } else {
                              return toast(context, responsive, height, width);
                          }
                        })
                        ],
                      ),
                    ),
            )
          ],
        ));
  }

  bool _validarPrice(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.priceStreamHasValue == false) {
      validate = false;
    } else {
      if (bloc.price.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

  Widget _createPrice(bloc) {
    String text = (_validarPrice(bloc) == false) ? adsText.price() : '';

    controladorPrice.text = (_validarPrice(bloc) == false) ? '' : bloc.price;
    controladorPrice.selection = TextSelection.collapsed(
        offset: controladorPrice.text
            .length); //  esa linea sirve para que el cursor quede delante del texto

    return StreamBuilder(
        stream: bloc.priceStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Row(
            children: [
              Text('\$',
                  style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.045)),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                child: Form(
                  key: formKey,
                  child: TextFormField(
                      style:
                          TextStyle(fontSize: MediaQuery.of(context).size.width * 0.05, fontWeight: FontWeight.w600),
                      controller: controladorPrice,
                      textInputAction: TextInputAction.done,
                      cursorColor: Colors.deepOrange,
                      keyboardType: (Platform.isIOS)
                          ? TextInputType.text
                          : TextInputType.number,
                      decoration: InputDecoration(
                          labelText: text,
                          border: InputBorder.none,
                          labelStyle: TextStyle(
                              fontSize: (adsText.lang == 'en')
                                  ? MediaQuery.of(context).size.width * 0.07
                                  : MediaQuery.of(context).size.width * 0.06,
                              fontWeight: FontWeight.w600,
                              color: Color.fromRGBO(173, 181, 189, 1)),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 0.0),
                          errorText: snapshot.error),
                      onChanged: (value) => {
                            bloc.changePrice(value),
                          },
                      onTap: () {
                        text = '';
                      }),
                ),
              ),
              Text('USD',
                  style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1.0),
                      fontWeight: FontWeight.bold,
                      fontSize: MediaQuery.of(context).size.height * 0.025))
            ],
          );
        });
  }

   // ******************************************************************************************
  Widget toast(BuildContext context, Responsive responsive, double height, double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          toastService.showToastCenter(context: context, text: adsText.dataInvalid(), durationSeconds: 4);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          child: Center(
            child: Text(generalText.next(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: responsive.ip(2),
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

  Widget toastMenoaA30(BuildContext context, Responsive responsive, double height, double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          toastService.showToastCenter(context: context, text: generalText.ourDealsStartsIn30USD(), durationSeconds: 4);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          child: Center(
            child: Text(generalText.next(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: responsive.ip(2),
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
}
