// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/ad_form/create_ad_images2.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/packageResource.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/seleccionarInsurance.dart';
import 'package:rxdart/rxdart.dart';

class CreateAdInsurance extends StatefulWidget {
  CreateAdInsurance({Key key}) : super(key: key);

  @override
  _CreateAdInsuranceState createState() => _CreateAdInsuranceState();
}

class _CreateAdInsuranceState extends State<CreateAdInsurance> {
  final insurancesController = BehaviorSubject<List<dynamic>>();
  Http _http = Http();
  List<Widget> insurancesWidget;

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_insurance');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final bloc = ProviderApp.ofAdForm(context);

    insurancesWidget = [];

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Container(
          margin: EdgeInsets.only(
              top: variableGlobal.margenTopGeneral(context),
              right: 16.0,
              left: 16.0),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                            closeAd(context,
                                'assets/images/close/close button 1@3x.png'),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          height: height * 0.07,
                          child: Text(adsText.titulo_1(),
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: height * 0.04,)),
                        ),
                        SizedBox(
                          height: height * 0.02,
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              circuloVerde(context, 3, 3),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Text(adsText.insurances(),
                                      style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.03)),
                                  SizedBox(
                                    height: height * 0.02,
                                  ),
                                  Text(
                                      '${generalText.next()}: ${adsText.adReadyForPublish()}',
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.025))
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: height * 0.09,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: height * 0.03),
                                child: Text(
                                  adsText.chooseTheTypeOfInsurance(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: height * 0.02,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // ***************************  PARTE DEL MEDIO
                        Container(
                          height: height * 0.45,
                          child:
                              _planesInsurance(context, height, width, bloc),
                        ),
                      ]),
                  // *************************************  NEXT, CANCEL
                  Container(
                      margin: EdgeInsets.only(
                          bottom: variableGlobal.margenBotonesAbajo(context)),
                      child: StreamBuilder(
                          stream: bloc.insuranceStream,
                          builder: (BuildContext context, snapshoInsurance) {
                            return Container(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  back(context, CreateAdImages2()),
                                  (bloc.insurance == null)
                                      ? toast(context, height, width)
                                      : _next(context, 'create_ad_resume')
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ],
          )),
    );
  }

  _planesInsurance(BuildContext context, double height, double width, bloc) {
    insurancesController.sink.add(packageResource.insurances());

    for (var insurance in packageResource.insurances()) {
      insurancesWidget.add(_createInsurance(
          context,
          insurance["name"],
          insurance["description"],
          'assets/images/general/Group@2x.png',
          insurance["code"],
          double.parse(insurance["price"]),
          insurance["select"],
          height,
          width,
          bloc));
    }
    return Container(
        height: MediaQuery.of(context).size.height * 0.5,
        // child: Expanded(
        child: SingleChildScrollView(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: insurancesWidget,
        ))
        // )
        );
  }

  Widget _createInsurance(
      BuildContext context,
      String title,
      String subtitle,
      String img,
      String code,
      double price,
      bool insurance,
      double height,
      double width,
      bloc) {
    return StreamBuilder(
        stream: bloc.insuranceStream,
        builder: (BuildContext context, snapshot) {
          final formatCurrency = new NumberFormat.simpleCurrency();
          return Stack(
            children: <Widget>[
              CupertinoButton(
                  padding: EdgeInsets.all(0),
                  minSize: 0,
                  onPressed: () {
                    bloc.changeInsurance(title);
                  },
                  child: Container(
                    height: height * 0.12,
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: width * 0.03),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Color.fromRGBO(255, 255, 255, 1)),
                          width: width * 0.9,
                          height: height * 0.1,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  width: width * 0.13,
                                  height: width * 0.13,
                                  child: Image.asset(
                                    img,
                                    fit: BoxFit.contain,
                                  )),
                              SizedBox(
                                width: width * 0.02,
                              ),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text(title,
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    33, 36, 41, 1.0),
                                                fontWeight: FontWeight.bold,
                                                fontSize: height * 0.023)),
                                      ],
                                    ),
                                    Text(
                                      subtitle,
                                      style: TextStyle(
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.017),
                                    ),
                                    Text(
                                      '${formatCurrency.format(price)} USD',
                                      style: TextStyle(
                                          color:
                                              Color.fromRGBO(255, 206, 6, 1.0),
                                          fontWeight: FontWeight.bold,
                                          fontSize: height * 0.023),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Positioned(
                  left: width * 0.8,
                  top: height * 0.01,
                  child: (bloc.insurance == title)
                      ? seleccionaInsurance(context)
                      : Container())
            ],
          );
        });
  }

  // ***************************

  Widget toast(BuildContext context, double height, double width) {
    return Container();

    // StreamBuilder(
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //   return RaisedButton(
    //     onPressed: () {
    //       Toast.show(generalText.theIsNoInsurance(), context,
    //           duration: 3, gravity: Toast.CENTER);
    //     },
    //     child: Container(
    //       width: width * 0.35,
    //       height: height * 0.07,
    //       // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
    //       child: Center(
    //         child: Text(generalText.next(),
    //             style: TextStyle(
    //               color: Color.fromRGBO(33, 36, 41, 0.5),
    //               fontSize: width * 0.05,
    //               fontWeight: FontWeight.bold,
    //             )),
    //       ),
    //     ),
    //     color: Color.fromRGBO(251, 251, 251, 1),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15.0),
    //         side:
    //             BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    //   );
    // });
  }

  // ******************************++

  Widget _next(BuildContext context, String page) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          Navigator.pushNamed(
            context,
            page,
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.height * 0.07,
          // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Center(
            child: Text(generalText.next(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: MediaQuery.of(context).size.width * 0.05,
                  fontWeight: FontWeight.bold,
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

Widget checkB(bool plan) {
  if (plan == true) {
    return Container(
      width: 15.3,
      height: 15.3,
      child: Image.asset('assets/images/general/Fill-1560-2.png'),
    );
  } else {
    return Container();
  }
}
