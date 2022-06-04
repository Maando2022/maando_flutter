// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/matches/matchesAdText.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/card_ad.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class AdDetailPage extends StatefulWidget {
  // const AdDetailPage({Key key}) : super(key: key);

  @override
  _AdDetailPageState createState() => _AdDetailPageState();
}

class _AdDetailPageState extends State<AdDetailPage> {
  List<ImageModel> listaImagenes = [];
  List<dynamic> aiports = [];
  String phoneCode = '';
  String phoneWhatsApps = '';

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    aiports = blocGeneral.aiportsDestination;
  }


 List<Future<dynamic>> listImgFuture = [];
 Future _cargarImagenes(Map<String, dynamic> ad) async {  
    return Future.wait(listImgFuture);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    
    conectivity.validarConexion(context, 'principal');
    final ad = json.decode(ModalRoute.of(context).settings.arguments);  

    for(int i = 0; i < ad["images"].length; i++){
      listImgFuture.add(firebaseStorage.obtenerImagen(ad["user"]["email"], ad["_id"], i + 1));
    }

        // OBTENEMOS EL TELEFONO CON EL CODIGO DEL PAUS DEL USUARIO
    aiports.forEach((country) {
      if (ad["user"]["country"] == country["name"]) {
        phoneCode =
            '+(${country["indicative-code"]}) ${ad["user"]["phone"]}';
        phoneWhatsApps =
            '+${country["indicative-code"]}${ad["user"]["phone"]}';
      }
    });
    

    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: 
            Column(
              children: [
              Container(
                  margin: EdgeInsets.only(
                    top: variableGlobal.margenTopGeneral(context),
                    right: variableGlobal.margenPageWith(context),
                    left: variableGlobal.margenPageWith(context)),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      arrwBackYellow(context, 'principal'),
                      iconFace1(context),
                      botonTresPuntosGrises(context, 16, (){})
                    ],
                  ),
              ),
                Container(
                   margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
                  child: CardAd(
                      ad: ad, 
                      viewImages: true, 
                      allImages: true, 
                      viewButtonOption: false,
                      viewCountryCity: true,
                      viewDate: true,
                      viewRatings: false,
                      viewPrice: false,
                      code: false,
                      botonTitle: BotonTitle(title: ad['title']),
                      actionSheet: (){
                      //  print('AQUI VAN LAS ACCIONES');
                      }),
                ),
                (validateAdmin.isAdmin(preference.prefsInternal.getString('email')) == true) ? 
                    Container( // PARTE DEL ADMINISTRADOR
                      child: Column(
                                children: [
                            SizedBox(
                              height: height* 0.03,
                            ),
                            Text(ad["user"]["email"],
                                  style: TextStyle(
                                      letterSpacing: 0.07,
                                      color: Color.fromRGBO(173, 181, 189, 1.0),
                                      fontWeight: FontWeight.w600,
                                      fontSize: responsive.ip(2))),
                            SizedBox(
                              height: height* 0.03,
                            ),
                            CupertinoButton(
                              color: Colors.black,
                              onPressed: () async {
                                  // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                                      String message = "";
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
                                },
                                child: Text(phoneWhatsApps,
                                    style: TextStyle(
                                        letterSpacing: 0.07,
                                        color: Color.fromRGBO(173, 181, 189, 1.0),
                                        fontWeight: FontWeight.w600,
                                        fontSize: responsive.ip(2))),
                            ),
                                ],
                              ),
                    ) : Container(),
                    SizedBox(
                      height: height* 0.1,
                    )
              ],
            )
          ),
         (ad["user"]["email"] == preference.prefsInternal.get("email")) ? Container() : _crearTakeService(context, ad, height, width)
        ],
      ),
    );
  }

  Widget _widgetImagenes(BuildContext context, double height, double width, ad) {
  return FutureBuilder(
            future: _cargarImagenes(ad),
            builder: (BuildContext context, snapshot) {
              if(snapshot.hasData){
                
               for(var img in snapshot.data){
                 listaImagenes.add(ImageModel(nombre:  img, urlImage: img));
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
                                        image: NetworkImage(listaImagenes[index].urlImage),
                                        placeholder:
                                            AssetImage('assets/images/general/jar-loading.gif'),
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
                            // scrollDirection: Axis.horizontal,
                            fade: 0.5,
                            // control: new SwiperControl(
                            //     color: Colors.red, padding: EdgeInsets.symmetric(horizontal: 10.0)),
                          ) :
                          Container(
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
              }else if(snapshot.hasError){
                return Container();
              }else{
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
              height: 180.0,
              child: _widgetImagenes(context, height, width, ad)),
          // Container(
          //   height: 22.0,
          //   width: 80.0,
          //   margin: EdgeInsets.only(top: 18.0, left: 30.0),
          //   child: CupertinoButton(
          //       child: Container(
          //         child: Text(title.toUpperCase(),
          //             textAlign: TextAlign.center,
          //             style: TextStyle(
          //                 color: Color.fromRGBO(0, 0, 0, 1.0),
          //                 fontWeight: FontWeight.bold,
          //                 fontSize: variableGlobal.tamanoLabecardAd(context))),
          //       ),
          //       color: Color.fromRGBO(255, 206, 6, 1.0),
          //       borderRadius: BorderRadius.circular(4.0),
          //       padding: EdgeInsets.symmetric(horizontal: 15.0),
          //       onPressed: () {
          //         print('ESTE ES EL LABEL');
          //       }),
          // ),
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
                  fontSize: 12.0)),
          SizedBox(
            height: 5.0,
          ),
          Text(title,
              style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: 26.0)),
          SizedBox(
            height: 15.0,
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
                                fontSize: 12.0)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            date(context),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                                '${formatearfechaDateTime(DateTime.fromMillisecondsSinceEpoch(int.parse(arrivalDate)).toString())}',
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
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
                                fontSize: 12.0)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            position(height, width),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(country,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              Container(
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
                                fontSize: 12.0)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            position(height, width),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(city,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
                          ],
                        )
                      ],
                    ),
                     Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
               Container(
                child: Row(
                  children: <Widget>[
                    billeterequest(context),
                    SizedBox(
                      width: 8.0,
                    ),
                    Container( 
                      width: width * 0.5, 
                      child: Row(
                        children: [
                          Expanded( 
                            child: Text('${formatCurrency.format(price.toDouble())} USD',
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 36, 41, 1.0),
                                  fontWeight: FontWeight.bold,
                                  ),
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

  Widget _crearTakeService(BuildContext context, dynamic ad, double height, double width) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: height * 0.85,
        ),
        child: RaisedButton(
          onPressed: () {
            _takeService(context, ad);
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
                      fontSize: 16.0,
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

  void _takeService(BuildContext context, dynamic ad) {
    Http _http = Http();
   
     showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
    _http.verMisVuelos(context: context, email: preference.prefsInternal.get('email')).then((value) {
      Navigator.pop(context);
      if (value["ok"] == true) {
        if (value["count"] > 0) {
          Navigator.pushNamed(context, 'match_flight_12_2', arguments: json.encode({'myFlights': value["flightDB"], 'ad': ad}));
        } else {
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, matchAdText.youHaveNoFlightsCreated()); }).
           then((value){
              Navigator.pushNamed(context, 'create_flight_form');
           });
        }
      }
    });
  }
}

class ImageModel {
  String nombre;
  String urlImage;

  ImageModel({@required this.nombre, @required this.urlImage});
}
