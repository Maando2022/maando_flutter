// @dart=2.9
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/enviromets/url_server.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/http_v2/http_v2.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:objectid/objectid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class CreateAdResune extends StatefulWidget {
  // const AdDepailPage({Key key}) : super(key: key);

  @override
  _CreateAdResuneState createState() => _CreateAdResuneState();
}

class _CreateAdResuneState extends State<CreateAdResune> {
  List<ImageModel> listaImagenes = [];
  List<dynamic> aiports = blocGeneral.aiportsDestination;
   
  final formatCurrency = new NumberFormat.simpleCurrency();
  ObjectId  id = ObjectId();
 
  String lastMille = '';

  @protected
  void initState() {
    super.initState();
    conectivity.validarConexion(context, 'create_ad_resume');
    adFromBloc.changeUploadImages(false);
    blocGeneral.uploadImagesStream.listen((lista) {
    });
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_resume');
    final bloc = ProviderApp.ofAdForm(context);
    bloc..changeInsurance('Free');
    bloc.changePrice('120');
    try{
      for (var i in bloc.listImages) {
        listaImagenes.add(ImageModel(nombre: i.path, urlImage: i.path, file: i));
      }
    }catch(e){

    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    for(var aiport in aiports){
      for(var city in aiport["aiports"]){
        if(bloc.cityDepature == city["city"]){
          bloc.changeCountryDeparture(aiport["name"]);
        }
        if(bloc.city == city["city"]){
          bloc.changeCountry(aiport["name"]);
          if(aiport["lastMille"].length > 0){
            try{
              bloc.changelastMille(aiport["lastMille"][0]['code']);
            }catch(e){
              bloc.changelastMille('');
            }
          }else{
            bloc.changelastMille('');
          }
        }
      }
    }

    print('TITULO   ==== >>> ${bloc.title}');
    print('COUNTRYDEPARTURE  ==== >>> ${bloc.countryDeparture}');
    print('COUNTRY  ==== >>> ${bloc.country}');
    print('CITYDEPARTURE  ==== >>> ${bloc.cityDepature}');
    print('CITY  ==== >>> ${bloc.city}');
    print('lastMille  ==== >>> ${bloc.lastMille}');
    print('FECHA DE SALIDA  ==== >>> ${bloc.dateTimeDeparture}');
    print('FECHA DE LLEGADA  ==== >>> ${bloc.dateTime}');
    print(
        'FECHA DE  EN MILISEGUNDOS  ==== >>> ${DateTime.parse(bloc.dateTime.toString()).millisecondsSinceEpoch}');
    print('NUMERO DE IMAGENES  ==== >>> ${bloc.listImages.length}');
    print('PRICE  ==== >>> ${bloc.price}');
    print('SEGURO  ==== >>> ${bloc.insurance}');
    print('ID  ==== >>> ${id.hexString}');
    // print('POSITION  ==== >>> ${bloc.locationGeocoding}');
// ******************************************************

    String title = bloc.title;
    String departureDate = DateTime.parse(bloc.dateTimeDeparture.toString()).millisecondsSinceEpoch.toString();
    String destinatioDate = DateTime.parse(bloc.dateTime.toString()).millisecondsSinceEpoch.toString();

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Container(
                margin: EdgeInsets.only(
                    top: variableGlobal.margenTopGeneral(context),
                    right: variableGlobal.margenPageWith(context),
                    left: variableGlobal.margenPageWith(context)),
                child: Center(
                    child: Column(children: <Widget>[
                  Column(
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
                          arrwBackYellowPersonalizado(context, 'create_ad_images2'),
                        ],
                      ),
                      Container(
                        color: Color.fromRGBO(251, 251, 251, 1),
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _images(context, responsive, title, height, width, bloc),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _datetime(context, responsive, departureDate,
                                destinatioDate, height, width),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _countryCity(context, responsive, bloc, height, width),
                            SizedBox(
                              height: height * 0.02,
                            ),
                            _price(context, responsive, bloc, height, width),
                            SizedBox(
                              height: height * 0.35,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ]))),
          ),
          _publish(context, responsive, height, width, bloc)
        ],
      ),
    );
  }

  Widget _widgetImagenes(
      BuildContext context, double height, double width, bloc) {
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
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(230, 232, 235, 1),
                          borderRadius: BorderRadius.circular(10.0),
                          image: DecorationImage(
                            image: FileImage(File(bloc.listImages[index].path)),
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                ),
              );
            },
            itemCount: listaImagenes.length,
            pagination: new SwiperPagination(),
            // scrollDirection: Axis.horizontal,
            fade: 0.5,
            // control: new SwiperControl(
            //     color: Colors.red, padding: EdgeInsets.symmetric(horizontal: 10.0)),
          )
        : GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(230, 232, 235, 1),
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    image: FileImage(File(bloc.listImages[0].path)),
                    fit: BoxFit.contain,
                  )),
            ),
          );
  }

  Widget _images(
      BuildContext context, Responsive responsive, String title, double height, double width, bloc) {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: height * 0.25,
              child: _widgetImagenes(context, height, width, bloc)),
          Container(
            height: height * 0.04,
            width: width * 0.22,
            margin: EdgeInsets.only(top: height * 0.02, left: width * 0.02),
            child: CupertinoButton(
                child: Container(
                  child: Text(title.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(1))),
                ),
                color: Color.fromRGBO(255, 206, 6, 1.0),
                borderRadius: BorderRadius.circular(4.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                onPressed: () {
                  // print('ESTE ES EL LABEL');
                }),
          ),
        ],
      ),
    );
  }

  Widget _datetime(BuildContext context, Responsive responsive, String departureDate,
      String destinationDate, double height, double width) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: width * 0.45,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(generalText.departure(),
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(2))),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: <Widget>[
                        // date(context),
                        // SizedBox(
                        //   width: 8.0,
                        // ),
                        textExpanded(
                          '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(departureDate)).toString())}',
                          width * 0.4,
                          responsive.ip(1.8),
                          Color.fromRGBO(33, 36, 41, 1.0),
                          FontWeight.w500,
                          TextAlign.start
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.45,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(generalText.destination(),
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(2),)),
                    SizedBox(height: height * 0.01),
                    Row(
                      children: <Widget>[
                        // date(context),
                        // SizedBox(
                        //   width: 8.0,
                        // ),
                        textExpanded(
                          '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(destinationDate)).toString())}',
                          width * 0.4,
                          responsive.ip(1.8),
                          Color.fromRGBO(33, 36, 41, 1.0),
                          FontWeight.w500,
                          TextAlign.start
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
    );
  }

  Widget _countryCity(BuildContext context, Responsive responsive, AdFormBloc bloc, double height, double width) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            width: width * 0.45,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(bloc.countryDeparture,
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(2),)),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(bloc.cityDepature,
                        style: TextStyle(
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            fontWeight: FontWeight.w500,
                            fontSize: responsive.ip(2),))
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: width * 0.45,
            child: Row(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(bloc.country,
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(2),)),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    Text(bloc.city,
                        style: TextStyle(
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            fontWeight: FontWeight.w500,
                            fontSize: width * 0.04))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


    Widget _price(BuildContext context, Responsive responsive, AdFormBloc bloc, double height, double width) {
    return Container(
            // width: width * 0.8,
            child: Row(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(adsText.price(),
                        style: TextStyle(
                            color: Color.fromRGBO(173, 181, 189, 1.0),
                            fontWeight: FontWeight.bold,
                            fontSize: responsive.ip(2),)),
                    SizedBox(
                      width: width * 0.01,
                    ),
                    Text('${formatCurrency.format(int.parse(bloc.price).toDouble())} USD',
                        style: TextStyle(
                            color: Color.fromRGBO(33, 36, 41, 1.0),
                            fontWeight: FontWeight.w500,
                            fontSize: responsive.ip(2),))
                  ],
                ),
              ],
            ),
          );
  }



  Widget _publish(BuildContext context, Responsive responsive, double height, double width, bloc) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.75,
        ),
        child: RaisedButton(
          onPressed: () {
            _publishAd(context, bloc);
          },
          child: Container(
            width: width * 0.85,
            height: height * 0.09,
            // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(generalText.publish(),
                    style: TextStyle(
                      color: Color.fromRGBO(255, 206, 6, 1),
                      fontSize: responsive.ip(2.5),
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

  void _publishAd(BuildContext context, AdFormBloc bloc) {
    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
    HttpV2().createAdv2(
                context: context, 
                emailOwner: prefsInternal.prefsInternal.get('email'),
                title: bloc.title.trim(),
                images: bloc.listImages,
                insurance: bloc.insurance,
                country: bloc.country,
                countryDeparture: bloc.countryDeparture,
                cityDeparture: bloc.cityDepature,
                city: bloc.city,
                price: bloc.price,
                departureDate: bloc.dateTimeDeparture.toString(),
                arrivalDate: bloc.dateTime.toString(),
                delivery: bloc.placeOfDelivery)
            .then((value) {
            // print('LA RESPUESTA   >>>>>>>>>>>  ==== >>> ${value}');
          Navigator.pop(context);
          dynamic valueMap = json.decode(value);

          if (valueMap["ok"] == true) {
            blocGeneral.changeListMyAds(blocGeneral.listMyAds..add(valueMap["adCreado"])); // agregamos el anuncio a la lista de mis anuncios
            blocGeneral.changeAd(valueMap['adCreado']); // actualizamos el bloc del anuncio actual
            blocSocket.socket.addEntityToHome(valueMap["adCreado"]); // enviamos un socket para que actualize el home de los demás
            // ENVIAMOS NOTIFICACION A JUAN DAVI Y A DAVID PARA QUE APRUEBEN 
            if(urlserver.url == 'https://api.maando.com'){
                Http().notificationOneToken(context: context, email: 'david@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'jdv@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'david@jdvgroup.co', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'jdv@jdvgroup.co', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'alia@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'friends@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'daniel@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'caro@jdvgroup.co', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
            Navigator.pushNamed(context, 'create_ad_publish_and_maches');
            }else if(urlserver.url == 'https://maando-test.herokuapp.com'){
                Http().notificationOneToken(context: context, email: 'david@maando.com', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                Http().notificationOneToken(context: context, email: 'david@jdvgroup.co', title: preference.prefsInternal.get('fullName'), body: generalText.arequestToSendAPackageHasBeenPublishedPendingForApproval(), data: {'datos': 'Aqui van los datos'});
                 Navigator.pushNamed(context, 'create_ad_publish_and_maches');
            }else{
               Navigator.pushNamed(context, 'create_ad_publish_and_maches');
            }

          } else {
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]); });
          }
        });
  }
}

// ************************************************
// ************************************************

List<String> listaImagenesString = [];
List<String> uploadImgs(
    List<File> files, String id, BuildContext context, AdFormBloc bloc) {
  if (files.length == 0) {
    return [];
  } else if (files.length == 1) {
    firebaseStorage
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      Future.delayed(Duration(milliseconds: 5000),
          () => adFromBloc.changeUploadImages(true));
      firebaseStorage
          .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
          .then((urlImagen1) {
        listaImagenesString.add(urlImagen1);
      });
    });
    return [];
  } else if (files.length == 2) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        Future.delayed(Duration(milliseconds: 6000),
            () => adFromBloc.changeUploadImages(true));
        firebaseStorage
            .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
            .then((urlImagen1) {
          listaImagenesString.add(urlImagen1);
        });
        firebaseStorage
            .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 2)
            .then((urlImagen2) {
          listaImagenesString.add(urlImagen2);
        });
      });
    });
    return [];
  } else if (files.length == 3) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          Future.delayed(Duration(milliseconds: 8000),
              () => adFromBloc.changeUploadImages(true));
          firebaseStorage
              .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
              .then((urlImagen1) {
            listaImagenesString.add(urlImagen1);
          });
          firebaseStorage
              .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 2)
              .then((urlImagen2) {
            listaImagenesString.add(urlImagen2);
          });
          firebaseStorage
              .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 3)
              .then((urlImagen3) {
            listaImagenesString.add(urlImagen3);
          });
        });
      });
    });
    return [];
  } else if (files.length == 4) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          firebaseStorage //  ============>>>>>  img4
              .subirImagen(
                  files[3],
                  '${prefsInternal.prefsInternal.get('email')}/$id/${4.toString()}',
                  context)
              .then((img4) {
            Future.delayed(Duration(milliseconds: 10000),
                () => adFromBloc.changeUploadImages(true));
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 1)
                .then((urlImagen1) {
              listaImagenesString.add(urlImagen1);
            });
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 2)
                .then((urlImagen2) {
              listaImagenesString.add(urlImagen2);
            });
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 3)
                .then((urlImagen3) {
              listaImagenesString.add(urlImagen3);
            });
            firebaseStorage
                .obtenerImagen(prefsInternal.prefsInternal.get('email'), id, 4)
                .then((urlImagen4) {
              listaImagenes.add(urlImagen4);
            });
          });
        });
      });
    });
    return [];
  } else if (files.length == 5) {
    firebaseStorage //  ============>>>>> img1
        .subirImagen(
            files[0],
            '${prefsInternal.prefsInternal.get('email')}/$id/${1.toString()}',
            context)
        .then((img1) {
      firebaseStorage //  ============>>>>>  img2
          .subirImagen(
              files[1],
              '${prefsInternal.prefsInternal.get('email')}/$id/${2.toString()}',
              context)
          .then((img2) {
        firebaseStorage //  ============>>>>>  img3
            .subirImagen(
                files[2],
                '${prefsInternal.prefsInternal.get('email')}/$id/${3.toString()}',
                context)
            .then((img3) {
          firebaseStorage //  ============>>>>>  img4
              .subirImagen(
                  files[3],
                  '${prefsInternal.prefsInternal.get('email')}/$id/${4.toString()}',
                  context)
              .then((img4) {
            firebaseStorage //  ============>>>>>  img5
                .subirImagen(
                    files[4],
                    '${prefsInternal.prefsInternal.get('email')}/$id/${5.toString()}',
                    context)
                .then((img5) {
              Future.delayed(Duration(milliseconds: 12000),
                  () => adFromBloc.changeUploadImages(true));
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 1)
                  .then((urlImagen1) {
                listaImagenesString.add(urlImagen1);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 2)
                  .then((urlImagen2) {
                listaImagenesString.add(urlImagen2);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 3)
                  .then((urlImagen3) {
                listaImagenesString.add(urlImagen3);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 4)
                  .then((urlImagen4) {
                listaImagenesString.add(urlImagen4);
              });
              firebaseStorage
                  .obtenerImagen(
                      prefsInternal.prefsInternal.get('email'), id, 5)
                  .then((urlImagen5) {
                listaImagenesString.add(urlImagen5);
              });
            });
          });
        });
      });
    });
    return [];
  } else {
    return [];
  }
}

// ************************************************
// ************************************************

class ImageModel {
  String nombre;
  String urlImage;
  File file;

  ImageModel({@required this.nombre, @required this.urlImage, this.file});
}
