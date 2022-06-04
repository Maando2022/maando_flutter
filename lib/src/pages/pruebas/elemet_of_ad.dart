// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/elements_compact_bloc_ad.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/flight_form/create_flight_type_package.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';


// https://rapidapi.com/magedata/api/amazon-data/pricing

class SelectElements extends StatelessWidget {
  const SelectElements({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

   double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return  Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: [
          // **************************************************************************************
          Column(
            children: [
               Container(
                        margin: EdgeInsets.only(
                          left:
                              variableGlobal.margenPageWithFlight(context),
                          right:
                              variableGlobal.margenPageWithFlight(context),
                          top: variableGlobal.margenTopGeneral(context),
                          bottom: width * 0.03,
                        ),
                        child: Center(
                            child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              backAd(
                                  context,
                                  'assets/images/general/icon-arrowback1@3x.png',
                                  'create_flight_type_package'),
                              iconFace1(context),
                              SizedBox(width: width * 0.07,)
                            ],
                          ),
                        ]))
                        ),
                      Container(
                        margin: EdgeInsets.only(
                          left: variableGlobal.margenPageWithFlight(context),
                          right: variableGlobal.margenPageWithFlight(context),
                          top: height * 0.01,
                          bottom: width * 0.03,
                      ),
                        child: Text('Escoja la imégen que mas describa su paquete',
                        textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 20.0,
                              color: Color.fromRGBO(33, 36, 41, 1),
                              fontWeight: FontWeight.bold),
                        ),
                    ),
                    SizedBox(height: height * 0.01),
                    _listElements()
            ],
          )
        ]
      ));
  }


  // ***********

  Widget _listElements(){
    List<dynamic> listaElementos = [];
    List<Widget> listaElementosWidget = [];

    return FutureBuilder(
        future: Http().getAsinProducts(keyword: 'computador'),
        // ignore: missing_return
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var respMap = json.decode(snapshot.data);
            // print('LA RESPUESTA  =====>>>>  ${respMap}');
   
            if(respMap['ok'] == true){

              listaElementos = respMap['resp'];

              
                if(listaElementos.length <=0){
                  return Container(
                      child: Center(child: Text('No result.'))
                  );
                }else{
                    for(var elment in listaElementos){
                        listaElementosWidget.add(
                            Column(
                              children: [
                                GestureDetector(
                                  onTap: (){
                                    print(elment['asin']);
                                    Navigator.pushNamed(context, 'element_of_ad', arguments: elment['asin']);
                                  },
                                  child: Container(
                                   height: MediaQuery.of(context).size.height * 0.45,
                                  width: MediaQuery.of(context).size.width * 0.8,
                                    margin: EdgeInsets.only(
                                                  left:
                                                      variableGlobal.margenPageWithFlight(context),
                                                  right:
                                                      variableGlobal.margenPageWithFlight(context)
                                                ),
                                      color: Color.fromRGBO(230, 232, 235, 1),
                                      child: FadeInImage(
                                        image: NetworkImage(elment['image_url']),
                                        placeholder: AssetImage('assets/images/general/jar-loading.gif'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.01),
                                  height: MediaQuery.of(context).size.height * 0.005,
                                  width: MediaQuery.of(context).size.width * 0.75,
                                  color: Colors.yellow,
                                )
                              ],
                            )
                        );
                      }

                      return  Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Column(children: listaElementosWidget),
                              ],
                            ),
                            ),
                        );
                }
              }else{
                  return Container(
                      child: Center(child: Text('Error'),),
                  );
              }
          }if(snapshot.hasError){
            return Container();
          }else{
            return Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.3),
              child: Center(child: CircularProgressIndicator()),
            );
          }
    });
  }
}



// *****************************************************
// *****************************************************
// *****************************************************
// *****************************************************
// *****************************************************


class ElementsOfAd extends StatefulWidget {
  // ElementsOfAd({@required String asin});

  @override
  _ElementsOfAdState createState() =>
      _ElementsOfAdState();
}

class _ElementsOfAdState
    extends State<ElementsOfAd> {
  String asin;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    conectivity.validarConexion(context, 'create_flight_add_elements_compact');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final bloc = ProviderApp.ofFlightForm(context);
    this.asin = ModalRoute.of(context).settings.arguments; 

    if(bloc.listElementsCompact == null){
      elementsBlocCompactAd.llenarListaElementosCompact(context);
      elementsBlocCompactAd.inicializarElementos();
    }


    return Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: [
          // **************************************************************************************
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(
                          left:
                              variableGlobal.margenPageWithFlight(context),
                          right:
                              variableGlobal.margenPageWithFlight(context),
                          top: variableGlobal.margenTopGeneral(context),
                          bottom: width * 0.03,
                        ),
                        child: Center(
                            child: Column(children: <Widget>[
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              backAd(
                                  context,
                                  'assets/images/general/icon-arrowback1@3x.png',
                                  'create_flight_type_package'),
                              iconFace1(context),
                              SizedBox(width: width * 0.07,)
                            ],
                          ),
                        ]))),
                    Container(
                      margin: EdgeInsets.only(
                        left: variableGlobal.margenPageWithFlight(context),
                        right: variableGlobal.margenPageWithFlight(context),
                        top: height * 0.01,
                        bottom: width * 0.03,
                      ),
                      child: Text(
                        generalText.addElements(),
                        style: TextStyle(
                            fontSize: 32.0,
                            color: Color.fromRGBO(33, 36, 41, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        left: variableGlobal.margenPageWithFlight(context),
                        right: variableGlobal.margenPageWithFlight(context),
                      ),
                      child: Text(
                        generalText.theElementsOnTheListCompact(),
                        style: TextStyle(
                            letterSpacing: 0.4,
                            height: width * 0.0035,
                            fontSize: width * 0.035,
                            color: Color.fromRGBO(173, 181, 189, 1)),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // ********************************************   Los elementos
                    Container(
                       
                        // height: height * 0.80,
                        child: _element(),),
                  ]),
              // ****************************************************  botones Cancel y Ad
              Container(
                child: Container(
                  margin: EdgeInsets.only(
                    right: variableGlobal.margenPageWithFlight(context),
                    left: variableGlobal.margenPageWithFlight(context),
                    bottom: variableGlobal.margenBotonesAbajo(context),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () {
                          _clear(bloc);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CreateFlightTyPePackage()),
                          );
                        },
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.07,
                          child: Center(
                            child: FittedBox(
                              child: Text(generalText.cancel(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 0.5),
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w500,
                                  )),
                            ),
                          ),
                        ),
                        color: Color.fromRGBO(251, 251, 251, 1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                width: 1.5,
                                color: Color.fromRGBO(33, 36, 41, 1))),
                      ),
                      Visibility(
                        child: RaisedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CreateFlightTyPePackage()),
                                    );
                                  },
                                  child: Container(
                                    width: width * 0.35,
                                    height: height * 0.07,
                                    child: Center(
                                      child: Text(generalText.add(),
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                33, 36, 41, 0.5),
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ),
                                  ),
                                  color: Color.fromRGBO(251, 251, 251, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
                                      side: BorderSide(
                                          width: 1.5,
                                          color: Color.fromRGBO(
                                              255, 206, 6, 1))),
                                ),
                        visible: _verBotonAdd(bloc), 
                      )
                      ,
                      
                    ],
                  ),
                ),
              )
            ],
          )
          // **************************************************************************************
        ],
      ),
    );
  }

  // **************************
  Widget _element() {
      return FutureBuilder(
        future: Http().getShippingProducts(context: context, asin: this.asin),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            var respMap = json.decode(snapshot.data);
            if(respMap['ok'] == true){
             print('LAS dimensiones ${respMap['resp']['asin_informations']}');

             if(respMap['resp']['asin_informations'].length <=0 ){
               return Column(
                 children: [
                   Container(
                        height: MediaQuery.of(context).size.height * 0.41,
                        width: MediaQuery.of(context).size.width * 0.75,
                        margin: EdgeInsets.only(
                                      left:
                                          variableGlobal.margenPageWithFlight(context),
                                      right:
                                          variableGlobal.margenPageWithFlight(context)
                                    ),
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/general/shipments 1@3x.png'),
                                fit: BoxFit.contain,
                              ),
                              shape: BoxShape.circle,
                           )
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.02
                          ),
                           child: Center(child: Text('No result.'))
                        )
                 ],
               );
             }else{
              var dimensiones;

              if(respMap['resp']['asin_informations']['Product Dimensions'] != null){
                dimensiones = respMap['resp']['asin_informations']['Product Dimensions'];
                print('Entro 1 $dimensiones');
              }else if(respMap['resp']['asin_informations']['Package Dimensions'] != null){
                dimensiones = respMap['resp']['asin_informations']['Package Dimensions'];
                print('Entro 2 $dimensiones');
              } else if(respMap['resp']['asin_informations']['Item Package Dimensions L x W x H'] != null){
                dimensiones = respMap['resp']['asin_informations']['Item Package Dimensions L x W x H'];
                print('Entro 3 $dimensiones');
              }else{
                print('ENTRO 4');
                dimensiones = 'x x inches; ';
              }


              var alto = (dimensiones.toString().split('x')[0] != null) ? dimensiones.toString().split('x')[0].trim() : '' ;
              var ancho = (dimensiones.toString().split('x')[1] != null) ? dimensiones.toString().split('x')[1].trim() : '';
              var profundidad = (dimensiones.toString().split('x')[2].split('inches;')[0] != null) ? dimensiones.toString().split('x')[2].split('inches;')[0].trim() : '';
              var peso = (respMap['resp']['asin_informations']['Item Weight'] != null) ? (respMap['resp']['asin_informations']['Item Weight']).trim() : '';

             final String image = (respMap['resp']['asin_images'][0] != null) ? respMap['resp']['asin_images'][0] : respMap['resp']['asin_images']["0"];


              return Column(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.41,
                    width: MediaQuery.of(context).size.width * 0.75,
                    margin: EdgeInsets.only(
                                  left:
                                      variableGlobal.margenPageWithFlight(context),
                                  right:
                                      variableGlobal.margenPageWithFlight(context)
                                ),
                      color: Color.fromRGBO(230, 232, 235, 1),
                      child: FadeInImage(
                        image: NetworkImage(image),
                        placeholder:
                            AssetImage('assets/images/general/jar-loading.gif'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                    Text('Alto: $alto\nAncho: $ancho\nProfundidad: $profundidad\nPeso: $peso',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05)),
                ],
              );
             }
            }else{
              return Container(
                  child: Center(child: Text('Error'),),
               );
            }
          }if(snapshot.hasError){
            return Container();
          }else{
            return Container(
                 margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.2),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

  _clear(bloc) {
    setState((){
      bloc.changeListElementsCompact([]);
      elementsBlocCompactAd.llenarListaElementosCompact(context);
      elementsBlocCompactAd.inicializarElementos();
    });
  }


  bool _verBotonAdd(bloc){
    List compact = [];
    if(bloc.listElementsCompact != null){
        for(var h in bloc.listElementsCompact){
          if(h["select"] == true){
            compact.add(h);
          }
        }
      }

      if(compact.length <= 0){
        return false;
      }else{
        return true;
      }
  }
}

