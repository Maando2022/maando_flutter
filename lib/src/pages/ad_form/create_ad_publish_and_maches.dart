// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/dialog/message_simple.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:share/share.dart';
// import 'package:share/share.dart';

class CreateAdPublisAndMaches extends StatefulWidget {
  CreateAdPublisAndMaches({Key key}) : super(key: key);

  @override
  _CreateAdPublisAndMachesState createState() => _CreateAdPublisAndMachesState();
}

class _CreateAdPublisAndMachesState extends State<CreateAdPublisAndMaches> {
  final blocNavigator = blocGeneral;
  
 final formatCurrency = new NumberFormat.simpleCurrency();
  Http _http = Http();
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_publish_and_maches');
    final bloc = ProviderApp.ofAdForm(context);
    String idAd = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    Future.delayed(Duration(seconds: 1), (){
      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){return messageSimple(context);});
    });

    return Scaffold(
        backgroundColor: Color.fromRGBO(255, 206, 6, 1),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Column(
                //column principal
                children: <Widget>[
                  Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                            width: width,
                            height: height * 0.45,
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: <Widget>[
                                  Image.asset(
                                      'assets/images/general/bg-ad-created-1@3x.png',
                                      fit: BoxFit.fill,  width: width),
                                  Container(
                                    child: Image.asset(
                                        'assets/images/general/megaphone-checkmark-1.png', fit: BoxFit.fill),     
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: height * 0.35),
                                    child: Center(
                                      child: Text(adsText.yourAdHasCreated(),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              letterSpacing: 0.07,
                                              color: Color.fromRGBO(
                                                  33, 36, 41, 1.0),
                                              fontWeight: FontWeight.bold,
                                              fontSize: responsive.ip(2.5))),
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  // -------------------------------------------------  PARTE BLANCA
                  Container(    
                      child: Container(
                        margin: EdgeInsets.only(right: width * 0.05, left: width * 0.05),
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                  margin: EdgeInsets.only(left: width * 0.03),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Color.fromRGBO(230, 232, 235, 1),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image(
                                      image: FileImage(
                                          File(bloc.listImages[0].path),
                                          scale: 10),
                                      fit: BoxFit.contain,
                                      width: width * 0.2,
                                      height: width * 0.2,
                                    ),
                                  )),
                              Container(
                                margin: EdgeInsets.only(top: height * 0.02, left: width * 0.03),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: FittedBox(
                                        child: Text('${bloc.title}',
                                            style: TextStyle(
                                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                                fontWeight: FontWeight.w600,
                                                fontSize: responsive.ip(2))),
                                      ),
                                    ),
                                    Container(
                                      child: FittedBox(
                                        child: Row(
                                          children: [
                                             textExpanded(
                                                formatearfecha(bloc.dateTime), 
                                                width * 0.5, 
                                                responsive.ip(2),
                                                null,
                                                FontWeight.normal,
                                                TextAlign.left)
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: 
                                      textExpanded(
                                                '${bloc.city},\n${bloc.country}', 
                                                width * 0.5, 
                                                responsive.ip(2),
                                                null,
                                                FontWeight.normal,
                                                TextAlign.left)
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Container(
                                      child: GestureDetector(
                                        onTap: () async { 
                                        String urlPrimeraImagen = await firebaseStorage.obtenerImagen(preference.prefsInternal.get('email'), idAd, 1);
                                        var request = await HttpClient().getUrl(Uri.parse(urlPrimeraImagen));
                                        var response = await request.close();
                                        final RenderBox box = context.findRenderObject() as RenderBox;
                                        Uint8List bytes = await consolidateHttpClientResponseBytes(response);
                                          Share.shareFiles(
                                            ['${bloc.listImages[0].path}/image.jpg'],
                                            text: bloc.title,
                                            subject: 'I’ve created an ad using www.https://maando.com\n\nTitle: ${bloc.title}\nDate, time and destination: ${formatearfecha(bloc.dateTime)} ${bloc.city}\nPrice: ${formatCurrency.format(bloc.price)} USD\n\n',
                                            sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size   
                                          );
                                          // setState(() {});
                                        },
                                        child: Row(children: <Widget>[
                                          Text(adsText.shareAd(),
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      33, 36, 41, 1.0),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: responsive.ip(1.8))),
                                         SizedBox(width: width * 0.01,),
                                          Container(
                                            width: width * 0.05,
                                            height: width * 0.05,
                                            child: Image.asset(
                                                'assets/images/general/icon-share-1@3x.png'),
                                          ),
                                        ]),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: height * 0.02)
                        ]),
                      )),
                  Container(
                    width: width * 0.91,
                    height: height * 0.09,
                    margin: EdgeInsets.fromLTRB(0, 80, 0, 0),
                    child: CupertinoButton(
                        child: Text(adsText.findServiceMaches(),
                            style: TextStyle(
                                color: Color.fromRGBO(255, 206, 6, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(2.5))),
                        color: Color.fromRGBO(33, 36, 41, 1.0),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        onPressed: () {
                          _findShipmentMatches(bloc);
                        }),
                  ),
                  Container(
                    width: width * 0.91,
                    height: height * 0.09,
                    margin: EdgeInsets.only(top: height * 0.03),
                    child: CupertinoButton(
                        child: Text(adsText.goToShipments(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.w500,
                                fontSize: responsive.ip(2.2))),
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        onPressed: () {
                          blocNavigator.shipmentPrincipal();
                          bloc.streamNull();
                          Navigator.pushReplacementNamed(context, 'principal',
                              arguments: jsonEncode(
                                  {"shipments": true, "service": false}));
                        }),
                  ),
                ]),
          ),
        ));
  }

  // *******************************************
  _findShipmentMatches(bloc) {
       showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
      _http.searchMatchesToAd(
        context: context, 
        email: preference.prefsInternal.get('email'),
        departureDate: blocGeneral.ad["departureDate"],
        arrivalDate: blocGeneral.ad["arrivalDate"],
        cityDeparture: blocGeneral.ad["cityDeparture"],
        city: blocGeneral.ad["city"]
        ).then((value) {
            print('LA RESPUESTA DEL MACH  ${value}');
            Navigator.pop(context);
          final valueMap = json.decode(value);
          if(valueMap['count'] <= 0){
           showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.noresults()); } );
          }else{
            bloc.streamNull();
            blocGeneral.changeArrayFlightSearch(valueMap['flightDB']);
            Navigator.pushNamed(context, 'list_flights', arguments: jsonEncode(blocGeneral.ad));
          }
        });
  }

}
