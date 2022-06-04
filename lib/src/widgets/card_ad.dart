// @dart=2.9
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/hexa_color.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:photo_view/photo_view.dart';

class CardAd extends StatelessWidget {
  final Map<String, dynamic> ad;
  final bool allImages;
  final bool viewImages;
  final bool viewButtonOption;
  final bool viewCountryCity;
  final bool viewDate;
  final bool viewRatings;
  final bool viewPrice;
  final Widget botonTitle;
  final Function actionSheet;
  final bool code;

  CardAd(
      {@required this.ad,
      @required this.allImages,
      @required this.viewImages,
      @required this.viewButtonOption,
      @required this.viewCountryCity,
      @required this.viewDate,
      @required this.viewRatings,
      @required this.viewPrice,
      @required this.botonTitle,
      @required this.actionSheet,
      @required this.code
      });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;


    return Container(
      margin: EdgeInsets.symmetric(vertical: height * 0.01),
      decoration: BoxDecoration(
      color: Color.fromRGBO(251, 251, 251, 1),
      borderRadius: BorderRadius.circular(10.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: HexColor('#F2CB05'),
              spreadRadius: 2,
              offset: Offset(0.5, 0.5)),
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: height * 0.01,
          ),
          (viewImages == true)
              ? ((allImages == true) ? ImagesAd(ad: ad, botonTitle: botonTitle) : ImageAd(ad: ad, botonTitle: botonTitle,))
              : Container(),
          SizedBox(
            height: (viewImages == true) ? height * 0.025 : 0,
          ),
          (viewCountryCity == true)
              ? CountryAndCity(
                  countryDeparture: ad["countryDeparture"],
                  country: ad["country"],
                  cityDeparture: ad["cityDeparture"],
                  city: ad["city"],
                  viewButtonOption: viewButtonOption,
                  actionSheet: actionSheet)
              : Container(),
          SizedBox(
            height: (viewCountryCity == true) ? height * 0.01 : 0,
          ),
          (viewDate == true)
              ? Dates(dateDeparture: ad["departureDate"], dateDestination: ad["arrivalDate"], code: (this.code == true) ? ad["code"] : '')
              : Container(),
          SizedBox(
            height: (viewDate == true) ? height * 0.02 : 0,
          ),
          (viewRatings == true) ? Ratings(emailUser: ad["user"]["email"]) : Container(),
          SizedBox(
            height: (viewRatings == true) ? height * 0.04 : 0,
          ),
          (viewPrice == true) ? Price(price: ad['price']) : Container(),
          SizedBox(
            height: (viewPrice == true) ? height * 0.02 : 0,
          ),
        ],
      ),
    );
  }
}

// SOLO MUESTRA LA PRIMERA IMAGEN
class ImageAd extends StatelessWidget {
  final Map<String, dynamic> ad;
  final Widget botonTitle;
  ImageAd({@required this.ad, @required this.botonTitle});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // final Responsive responsive = Responsive.of(context);

    return FutureBuilder(
      future: firebaseStorage.obtenerImagen(ad["user"]["email"], ad["_id"], 1),
      builder: (_, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
                  return Container(
                    width: double.infinity,
                    height: height * 0.3,
                    child: FadeInImage(
                        image: NetworkImage(snapshot.data),
                        placeholder:
                            AssetImage('assets/images/general/jar-loading.gif'),
                        fit: BoxFit.contain,
                      ),
                  //   child: CachedNetworkImage(
                  //   imageUrl: snapshot.data,
                  //   placeholder: (context, url) => FadeInImage(
                  //       image: NetworkImage(snapshot.data),
                  //       placeholder:
                  //           AssetImage('assets/images/general/jar-loading.gif'),
                  //       fit: BoxFit.contain,
                  //     ),
                  //   imageBuilder: (context, imageProvider) => PhotoView(
                  //     imageProvider: imageProvider,
                  //   )
                  //  ),
                  );
        }else if (snapshot.hasError) {
                  return Container();
                } else {
                  return Container(
                    margin: EdgeInsets.only(top: height * 0.22),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
      }
    );
  }
}

// SE MUESTRAN TODAS LAS IMAGENES
class ImageModel {
  String nombre;
  String urlImage;
  ImageModel({@required this.nombre, @required this.urlImage});
}

class ImagesAd extends StatelessWidget {
  final Map<String, dynamic> ad;
  final Widget botonTitle;
  ImagesAd({@required this.ad, @required this.botonTitle});

  List<ImageModel> listaImagenes;
  List<Future<dynamic>> listImgFuture;
  Future _cargarImagenes(Map<String, dynamic> ad) async {
    return Future.wait(listImgFuture);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    listImgFuture = [];
    for (int i = 0; i < ad["numImages"]; i++) {
      listImgFuture.add(
          firebaseStorage.obtenerImagen(ad["user"]["email"], ad["_id"], i + 1));
    }

    return Stack(
      children: [
        FutureBuilder(
            future: _cargarImagenes(ad),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                listaImagenes = [];
                for (var img in snapshot.data) {
                  listaImagenes.add(ImageModel(nombre: img, urlImage: img));
                }

 
                return (listaImagenes.length > 1)
                    ? Container(
                       width: double.infinity,
                        height: height * 0.3,
                         decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(230, 232, 235, 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Swiper(
                                itemWidth: width * 0.5,
                                itemHeight: height * 0.5,
                                itemCount: listaImagenes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Hero(
                                    tag: listaImagenes[index].nombre,
                                    child: ClipRRect(
                                      child: Container(
                                        width: double.infinity,
                                        height: height * 0.35,
                                         decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Color.fromRGBO(230, 232, 235, 1),
                                          ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Color.fromRGBO(230, 232, 235, 1),
                                          ),
                                          child: FadeInImage(
                                            image: NetworkImage(
                                                listaImagenes[index].urlImage),
                                            placeholder: AssetImage(
                                                'assets/images/general/jar-loading.gif'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                scrollDirection: Axis.horizontal,
                                pagination: new SwiperPagination(),
                                fade: 0.5,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: double.infinity,
                        height: height * 0.3,
                         decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Color.fromRGBO(230, 232, 235, 1),
                        ),
                        child: (listaImagenes.length == 1)
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(230, 232, 235, 1),
                                   borderRadius: BorderRadius.circular(12),
                                ),
                                child: FadeInImage(
                                  image: NetworkImage(listaImagenes[0].urlImage),
                                  placeholder: AssetImage(
                                      'assets/images/general/jar-loading.gif'),
                                  fit: BoxFit.contain,
                                ),
                              )
                            : Container(
                                decoration: new BoxDecoration(
                                  color: Color.fromRGBO(230, 232, 235, 1),
                                  borderRadius: BorderRadius.circular(12),
                                  image: new DecorationImage(
                                    image: new AssetImage(
                                        'assets/images/general/Mask Group@3x.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                      );
              } else if (snapshot.hasError) {
                return Container();
              } else {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                  width: double.infinity,
                  height: height * 0.35,
                );
              }
            }),
            botonTitle
      ],
    );
  }
}


class BotonTitle extends StatelessWidget {
  final String title;
  BotonTitle({@required this.title});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
              margin: EdgeInsets.only(top: height * 0.015, left: width * 0.035),
                height: height * 0.045,
                width: width * 0.2,
              decoration: BoxDecoration(
                color: Color.fromRGBO(255, 206, 6, 1.0),
              borderRadius: BorderRadius.circular(4.0)
              ),
              child: Center(child: Text(title.toUpperCase(),
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromRGBO(0, 0, 0, 1.0),
                    fontWeight: FontWeight.w600,
                    fontSize: responsive.ip(1)))),
            );
  }
}


class CountryAndCity extends StatelessWidget {
  final String countryDeparture;
  final String country;
  final String cityDeparture;
  final String city;
  final bool viewButtonOption;
  final Function actionSheet;

  CountryAndCity(
      {
      @required this.countryDeparture,
      @required this.country,
      @required this.city,
      @required this.cityDeparture,
      @required this.viewButtonOption,
      @required this.actionSheet});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
        margin: EdgeInsets.only(left: width * 0.035),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(generalText.departure(),
                                style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.ip(1.5))),
                              textExpanded(
                                '$cityDeparture',
                                width * 0.4,
                                responsive.ip(1.6),
                                Color.fromRGBO(33, 36, 41, 1.0),
                                FontWeight.bold,
                                TextAlign.start
                              ),
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.36,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(generalText.destination(),
                                style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.w600,
                                    fontSize: responsive.ip(1.5))),
                            textExpanded(
                                '$city',
                                width * 0.4,
                                responsive.ip(1.6),
                                Color.fromRGBO(33, 36, 41, 1.0),
                                FontWeight.bold,
                                TextAlign.start
                              ),
                          ]),
                    )
                  ])),
                 (viewButtonOption == true)
              ? botonTresPuntosGrises(context, width * 0.08, actionSheet)
              : Container()
        ]));
  }
}

class Dates extends StatelessWidget {
  final String dateDeparture;
  final String dateDestination;
  final String code;
  Dates({@required this.dateDeparture, @required this.dateDestination, @required this.code});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
                                fontSize: responsive.ip(1.5))),
                        SizedBox(
                          height: height * 0.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            date(context),
                            SizedBox(
                              width: width * 0.01,
                            ),
                            Row(
                              children: [
                                textExpanded(
                                  '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(dateDeparture)).toString())}',
                                  width * 0.4,
                                  responsive.ip(1.6),
                                  Color.fromRGBO(33, 36, 41, 1.0),
                                  FontWeight.bold,
                                  TextAlign.start
                                ),
                                textExpanded(
                                  '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(dateDestination)).toString())}',
                                  width * 0.4,
                                  responsive.ip(1.6),
                                  Color.fromRGBO(33, 36, 41, 1.0),
                                  FontWeight.bold,
                                  TextAlign.start
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          (this.code != '') ? Column(
            children: [
              SizedBox(height: height * 0.01),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('${generalText.code()}: ',
                  style: TextStyle(
                            fontSize: responsive.ip(1.6),
                            // height: 1.6,
                            fontWeight: FontWeight.bold)),
                  Text(this.code,
                  style: TextStyle(
                            fontSize: responsive.ip(1.6),
                            // height: 1.6,
                            fontWeight: FontWeight.w300)),
                ],
              )
            ],
          ) : Container()
        ],
      ),
    );
  }
}

// *************  CALIFICACION DEL VUELO RECIBE UN ENTERO
class Ratings extends StatelessWidget {
  int rating = 0;
  String emailUser;
  Ratings({@required this.emailUser});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

      return FutureBuilder(
        future: Http().findMatchForEmailOfAd(context: context, email: emailUser),
        builder: (_, AsyncSnapshot snapshot) {
          if(snapshot.hasData){


            dynamic valueMap = json.decode(snapshot.data);
            int r = 0;
            List qualifiedServices = [];

            if(valueMap["ok"] == true){
                for (var m in valueMap['arrayMatch']) {
                  for(var r in m["reviews"]){
                    rating = rating + r["rating"];
                    if(r["rating"] != 0 ||  r["rating"] != null){
                      qualifiedServices.add(r);
                    }
                  }
                }
                // Validamos que el denominador sea diferente de cero
                if(qualifiedServices.length > 0){
                   r = (valueMap['arrayMatch'].length != 0) ? (rating ~/ qualifiedServices.length)  : 0;
                } else{
                  rating = 0;
                  r = 0;
                }
            }else{
              rating = 0;
              r = 0;
            }   



        return Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.035),
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(generalText.customerratings(),
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(1.5))),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Row(
                          children: <Widget>[
                            ratings(context, r),
                            SizedBox(
                              width: width * 0.03,
                            ),
                            GestureDetector(
                              child: Text(generalText.seeCustomerReviews(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(81, 201, 245, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: responsive.ip(1.5))),
                              onTap: () {
                                Navigator.pushNamed(context, 'reviews_12_3',
                                    arguments: this.emailUser);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ));
          }else if(snapshot.hasError){
            return Container();
          }else{
            return Container(height: height * 0.05);
          }
        });
  }
}

class Price extends StatelessWidget {
  final int price;
  Price({@required this.price});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final formatCurrency = new NumberFormat.simpleCurrency();


    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.035),
      child: Row(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                billeterequest(context),
                SizedBox(
                  width: width * 0.03,
                ),
                Container(
                  width: width * 0.33,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                            '${formatCurrency.format(price.toDouble())} USD',
                            style: TextStyle(
                                color: Color.fromRGBO(33, 36, 41, 1.0),
                                fontWeight: FontWeight.bold,
                                 fontSize: responsive.ip(1.8)),
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
    );
  }
}
