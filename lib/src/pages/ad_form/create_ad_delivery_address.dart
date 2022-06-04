// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/action_sheet/map_last_mille.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/pages/ad_form/create_ad_title_date_destination.dart';
import 'package:maando/src/utils/responsive.dart';

class CreateAdDelivaryAddress extends StatefulWidget {
  // const CreateAd_10_0({Key key}) : super(key: key);
  @override
  _CreateAdDelivaryAddressState createState() =>
      _CreateAdDelivaryAddressState();
}

class _CreateAdDelivaryAddressState
    extends State<CreateAdDelivaryAddress> {


  // ************************************************
  final formKey = GlobalKey<FormState>();
  double _keyboard = 0;
  TextEditingController controladorPlaceOfDelivery = TextEditingController();
  List<Widget> resultsAddress = []; 
  String labelAddress;
  dynamic positionAiport;
  // ********

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_delivery_address');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);


     for(var aiport in blocGeneral.aiportsDestination){
      for(var city in aiport["aiports"]){
        if(bloc.cityDepature == city["city"]){
          bloc.changeCountryDeparture(aiport["name"]);
        }
        if(bloc.city == city["city"]){
          positionAiport = city["geolocation"];
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
 

    return Scaffold(
        resizeToAvoidBottomInset:
            false, // los widgets no cambian de tamaño de alto cuando sale el teclado
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: Stack(

          // alignment: Alignment.center,
          children: [
            // **********************************************************
            Container(
              height: double.infinity,
              margin: EdgeInsets.only(
                  top: width * 0.5,
                  right: variableGlobal.margenPageWith(context),
                  left: variableGlobal.margenPageWith(context)),
              child: SingleChildScrollView(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                    _deliveryAddress(context, responsive, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width, bloc),
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
                      circuloVerde(context, 2, 3),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: <Widget>[
                          Text(adsText.deliveryAddress(),
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.w600, 
                                  fontSize: responsive.ip(2.2))),
                          Text('${generalText.next()}: ${adsText.photos()}',
                              style: TextStyle(
                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: responsive.ip(2)))
                        ],
                      )
                    ],
                  ), //cierre row circulo verde
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
                          back(context, CreateAdTitleDateDestination()),
                          //  (bloc.lastMille == null) ?
                                  StreamBuilder(
                                             stream: bloc.placeOfDeliveryStream,
                                             builder: (_, snapshotPlaceOfDeivery){
                                               
                                               if(snapshotPlaceOfDeivery.hasData){
                                                 return next(context, 'create_ad_images1');
                                               }else if(snapshotPlaceOfDeivery.hasError){
                                                 return toast(context, responsive, height, width);
                                               }else{
                                                 return toast(context, responsive, height, width);
                                               }
                                             })
                                // : _nextOrToast(bloc, responsive, height, width)
                        ],
                      ),
                    ),
            )
          ],
        ));
  }

  Widget _nextOrToast(AdFormBloc bloc, Responsive responsive, double height, double width){
    return toast(context, responsive, height, width);
    // if(bloc.lastMille == 'multi-entrega'){
    //      return StreamBuilder(
    //             stream: bloc.placesValidarStream,
    //             builder: (_, snapshotPlaces){
    //               if(snapshotPlaces.hasData){
    //                 return next(context, 'create_ad_images1');
    //               }else if(snapshotPlaces.hasError){
    //                 return toast(context, responsive, height, width);
    //               }else{
    //                 return toast(context, responsive, height, width);
    //               }
    //             });
    // }else if(bloc.lastMille == 'mensajeros-urbanos'){
    //   bloc.changeAddress1('123456');
    //   return StreamBuilder(
    //             stream: bloc.addresstream,
    //             builder: (_, snapshot){
    //               if(snapshot.hasData){
    //                 return next(context, 'create_ad_images1');
    //               }else if(snapshot.hasError){
    //                 return toast(context, responsive, height, width);
    //               }else{
    //                 return toast(context, responsive, height, width);
    //               }
    //             });
    // }else{
    //   return toast(context, responsive, height, width);
    // }
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


  // ***************************
  Widget _deliveryAddress(BuildContext context, Responsive responsive, double height, double width, AdFormBloc bloc){
    return _loadingWidgetLastMille(responsive, bloc);
  }

  Widget _loadingWidgetLastMille(Responsive responsive, AdFormBloc bloc){
    return _inputAdrress(responsive, bloc);
    // if(bloc.lastMille == null){
    //   return _inputAdrress(responsive, bloc);
    // }else{
    //   if(bloc.lastMille == 'multi-entrega'){
    //     return Multientrega();
    //   }else if(bloc.lastMille == 'mensajeros-urbanos'){
    //     return MensajerosUrbanos();
    //   }else{
    //     return Container();
    //   }
    // }
  }

    // **********************************************************
    Widget _inputAdrress(Responsive responsive, AdFormBloc bloc){
      return  Container(
                margin: EdgeInsets.symmetric(
                    horizontal: variableGlobal.margenPageWith(context)),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                           Container(
                             child: Column(
                             children: <Widget>[ 
                               Text(adsText.examplePlaceOfDelivery(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(2.5)),
                                textAlign: TextAlign.left),
                                SizedBox(
                                   height: MediaQuery.of(context).size.height * 0.03,
                                  ),
                             ]
                            )
                           ),
                           Container(),
                            _inputSegunLastMille(responsive, bloc),
                            KeyboardVisibilityBuilder(
                              builder: (context, isKeyboardVisible) {
                                return SizedBox(height: (isKeyboardVisible) ? 500.0 : 0);
                              }
                            )
                          ],
                        ),
                      ),
                    ]),
              );
    }


  bool _validarTitulo(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.placeOfDeliveryStreamHasValue == false) {
      validate = false;
    } else {
      if (bloc.placeOfDelivery.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }



  Widget _crearPlaceOfDelivery(Responsive responsive, AdFormBloc bloc) {
    String text =
        (_validarTitulo(bloc) == false) ? adsText.whatIsThePlaceOfDelivery() : '';

    controladorPlaceOfDelivery.text = (_validarTitulo(bloc) == false) ? '' : bloc.placeOfDelivery;
    controladorPlaceOfDelivery.selection = TextSelection.collapsed(offset: controladorPlaceOfDelivery.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: bloc.placeOfDeliveryStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: Form(
              key: formKey,
              child: TextFormField(
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Color.fromRGBO(173, 181, 189, 1)),
                  controller: controladorPlaceOfDelivery,
                  textInputAction: TextInputAction.done,
                  cursorColor: Colors.deepOrange,
                  keyboardType: TextInputType.multiline,
                  maxLines: 3,
                  maxLength: 150,
                  decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0),
                  labelText: text,
                  border: InputBorder.none,
                  labelStyle: TextStyle(
                    fontSize: responsive.ip(2.3),
                    fontWeight: FontWeight.w500,
                    color: Color.fromRGBO(173, 181, 189, 1),
                  ),
                  errorText: snapshot.error),
                  onChanged: (value){
                        bloc.changePlaceOfDelivery(value);
                      },
                  ),
            ),
          );
        });
  }


  Widget _inputSegunLastMille(Responsive responsive, AdFormBloc bloc){
    if(bloc.lastMille == 'mensajeros-urbanos'){
      // return MapLastMille(bloc: bloc, positionAiport: positionAiport);
      return _crearPlaceOfDelivery(responsive, bloc);
    }else if(bloc.lastMille == ''){
      return _crearPlaceOfDelivery(responsive, bloc);
    }else{
      return Container();
    }
  }

}
