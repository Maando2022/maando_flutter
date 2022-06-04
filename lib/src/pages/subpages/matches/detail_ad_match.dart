// @dart=2.9
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/modal_confirm_submit_request_ad.dart';

class DetailAdMatch extends StatefulWidget {
  // const DetailAdMatch({Key key}) : super(key: key);

  @override
  _DetailAdMatchState createState() => _DetailAdMatchState();
}

class _DetailAdMatchState extends State<DetailAdMatch> {
  List<ImageModel> listaImagenes = [];

  List<Future<dynamic>> listImgFuture = [];
  Future _cargarImagenes(Map<String, dynamic> ad) async {
    return Future.wait(listImgFuture);
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'principal');
    final ad = json.decode(ModalRoute.of(context).settings.arguments);

    for (int i = 0; i < ad["images"].length; i++) {
      listImgFuture.add(
          firebaseStorage.obtenerImagen(ad["user"]["email"], ad["_id"], i + 1));
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    final flight = blocGeneral.flight;

    return StreamBuilder(
        stream: blocGeneral.sendRequestStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshopt) {
          if (snapshopt.hasData) {
            if (snapshopt.data == true) {
              return _scaffold2(context, height, width, ad, flight);
            } else {
              return _scaffold1(context, height, width, ad);
            }
          } else if (snapshopt.hasError) {
            return Container();
          } else {
            return Container(
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  // *********************************************************
  // *********************************************************
  Widget _scaffold1(BuildContext context, double height, double width, ad) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: 30.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          arrwBackYellowShipmentSERVICE(context),
                          iconFace1(context),
                          botonTresPuntosGrises(context, width * 0.09, () {})
                        ],
                      ),
                      Container(
                        color: Color.fromRGBO(251, 251, 251, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 32.0,
                            ),
                            _seccion1(
                                context, ad['title'], height, width, ad),
                            SizedBox(
                              height: 16.0,
                            ),
                            _seccion2(
                                context,
                                ad['title'],
                                ad['arrivalDate'],
                                ad['country'],
                                ad['city'],
                                ad['price'],
                                height,
                                width),
                            SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]))),
          ),
          _crearTakeService(context, height, width)
        ],
      ),
    );
  }

  // *********************************************************
  // *********************************************************

  Widget _scaffold2(
      BuildContext context, double height, double width, ad, flight) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: 30.0),
                child: Center(
                    child: Column(children: <Widget>[
                  Column(
                    children: <Widget>[
                      Container(
                        color: Color.fromRGBO(251, 251, 251, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 32.0,
                            ),
                            _seccion1(
                                context, ad['title'], height, width, ad),
                            SizedBox(
                              height: 16.0,
                            ),
                            _seccion2(
                                context,
                                ad['title'],
                                ad['arrivalDate'],
                                ad['country'],
                                ad['city'],
                                ad['price'],
                                height,
                                width),
                            SizedBox(
                              height: 32.0,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]))),
          ),
          _crearTakeService(context, height, width),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              color: Colors.white.withOpacity(0.2),
              child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: height * 0.18, horizontal: width * 0.04),
                  child: Center(
                      child: ModalConfirmSubmitRequestAd(
                          flight: flight, ad: ad, c: context))),
            ),
          )
        ],
      ),
    );
  }

  // *********************************************************
  // *********************************************************

  Widget _widgetImagenes(
      BuildContext context, double height, double width, ad) {
    return FutureBuilder(
        future: _cargarImagenes(ad),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            listaImagenes = [];
            for (var img in snapshot.data) {
              listaImagenes.add(ImageModel(nombre: img, urlImage: img));
            }

            return (listaImagenes.length > 1)
                ? Swiper(
                    // layout: SwiperLayout.TINDER,
                    itemWidth: width * 0.5,
                    itemHeight: height * 0.5,
                    itemBuilder: (BuildContext context, int index) {
                      return Hero(
                        tag: listaImagenes[index].nombre,
                        child: ClipRRect(
                          // borderRadius: BorderRadius.circular(20.0),
                          child: GestureDetector(
                            onTap: () {},
                            child: Container(
                              color: Color.fromRGBO(230, 232, 235, 1),
                              child: FadeInImage(
                                image:
                                    NetworkImage(listaImagenes[index].urlImage),
                                placeholder: AssetImage(
                                    'assets/images/general/jar-loading.gif'),
                                fit: BoxFit.contain,
                                // height: 200.0,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: listaImagenes.length,
                    pagination: new SwiperPagination(),
                    fade: 0.5,
                  )
                : Container(
                    margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                    width: double.infinity,
                    // height: height * 0.3,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(230, 232, 235, 1),
                      image: DecorationImage(
                        image: NetworkImage(listaImagenes[0].urlImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
          } else if (snapshot.hasError) {
            return Container();
          } else {
            return Container();
          }
        });
  }

  Widget _seccion1(
      BuildContext context, String title, double height, double width, ad) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: height * 0.3,
              child: _widgetImagenes(context, height, width, ad)),
        ],
      ),
    );
  }

  Widget _seccion2(BuildContext context, String title, String arrivalDate,
      String country, String city, int price, double height, double width) {

    final formatCurrency = new NumberFormat.simpleCurrency();
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(generalText.needToTransport(),
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.04)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.005,
          ),
          Text(title,
              style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: MediaQuery.of(context).size.width * 0.03)),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.02,
          ),
          Column(
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
                          height: MediaQuery.of(context).size.height * 0.005,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            date(context),
                            textExpanded(
                                '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(arrivalDate)).toString())}',
                                MediaQuery.of(context).size.width * 0.3,
                                MediaQuery.of(context).size.width * 0.035)
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(generalText.country(),
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03)),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.015,
                        ),
                        Row(
                          children: <Widget>[
                            position(height, width),
                            textExpanded(
                                country,
                                MediaQuery.of(context).size.width * 0.3,
                                MediaQuery.of(context).size.width * 0.04)
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Container(
                width: width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(generalText.city(),
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            position(height, width),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.015,
                            ),
                            Text(city,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.03))
                          ],
                        )
                      ],
                    ),
                    // *************************************  CIUDAD Y PRECIO
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              billeterequest(context),
                              SizedBox(
                                width:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                              Container(
                                width: width * 0.33,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                          '${formatCurrency.format(price.toDouble())} USD',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  33, 36, 41, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.03),
                                          textScaleFactor: 1),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _crearTakeService(BuildContext context, double height, double width) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.75,
        ),
        child: RaisedButton(
          onPressed: () {
            blocGeneral.changeSendRequest(true);
          },
          child: Container(
            width: width * 0.85,
            height: height * 0.09,
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(generalText.takeService(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 206, 6, 1),
                      fontSize: MediaQuery.of(context).size.width * 0.05,
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
      ),
    );
  }
}

class ImageModel {
  String nombre;
  String urlImage;

  ImageModel({@required this.nombre, @required this.urlImage});
}
