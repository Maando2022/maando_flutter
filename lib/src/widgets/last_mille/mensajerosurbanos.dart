// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/http_last_mille/mensajerosurbanos.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/utils/config.dart';
import "package:google_maps_webservice/geocoding.dart";
import 'package:maando/src/utils/ciudades.dart';
import 'dart:convert';

import 'package:maando/src/widgets/loading/loading.dart';

class MensajerosUrbanos extends StatefulWidget {
  @override
  _MensajerosUrbanosState createState() => _MensajerosUrbanosState();
}

class _MensajerosUrbanosState extends State<MensajerosUrbanos> {
  String tokenMensajerosUrbanos = '';

  final formKey = GlobalKey<FormState>();

  TextEditingController controladorAddress1 = TextEditingController();
  TextEditingController controladorAddress2 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);

    
    HttpMensajerosurbanos().generateTokenMensajerosUrbanos().then((value){
      dynamic valueMap = json.decode(value);
      if(valueMap["ok"] == true){
        tokenMensajerosUrbanos = valueMap["body"]["access_token"];
      }
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _crearPlaceOfDelivery(responsive, bloc),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          _label(bloc, responsive, MediaQuery.of(context).size.height, MediaQuery.of(context).size.width),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          _listDeparture()
        ],
      );
  }

  bool _validarAddress1(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.address2 == null) {
      validate = false;
    } else {
      if (bloc.address2.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

List<Widget> resultsAddress = []; 
String labelAddress;

 Widget _crearPlaceOfDelivery(Responsive responsive, AdFormBloc bloc) {
    String text =
        (_validarAddress1(bloc) == false) ? generalText.titlesDropdownPlaces()[4] : '';

    controladorAddress1.text = (_validarAddress1(bloc) == false) ? '' : bloc.address2;
    controladorAddress1.selection = TextSelection.collapsed(offset: controladorAddress1.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: bloc.address2Stream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorAddress1,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: text,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error),
                        
                onChanged: (value){
                      bloc.changeAddress2(value);
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      resultsAddress = [];
                       listPlaces('${bloc.country} ${bloc.city} $value').then((valueAddress){
                          for(GeocodingResult place in valueAddress.results){
                            Navigator.pop(context);
                              resultsAddress.add(_result(responsive, place.placeId, place.formattedAddress, place.geometry.location, bloc, MediaQuery.of(context).size.width));
                          }   
                      });
                    },
                onTap: () {
                  text = '';
                }),
          );
        });
  }

  Widget _listDeparture() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: resultsAddress,
    );
  }

  Widget _result(Responsive responsive, String placeId, String formattedAddress, Location location, AdFormBloc bloc, double miheight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          labelAddress = formattedAddress;
          bloc.changeAddressGeocoding(formattedAddress);
          bloc.changeLocationGeocoding({"latitude": location.lat, "longitude": location.lng});
          resultsAddress = [];
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: miheight * 0.04),
        child: Row(
          children: [
            textExpanded(
              formattedAddress, 
              MediaQuery.of(context).size.width * 0.9,
              responsive.ip(2),
              Color.fromRGBO(173, 181, 189, 1),
              FontWeight.w500,
              TextAlign.start
              ),
          ],
        ),
      ),
    );
  }

Widget _label(AdFormBloc bloc, Responsive responsive, double height, double width){
   return StreamBuilder(
       stream: bloc.addressGeocodingStream ,
       builder: (BuildContext context, AsyncSnapshot snapshot){
         if(snapshot.hasData){
           return  Text(snapshot.data,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(0, 0, 0, 1.0)));
         }else if(snapshot.hasError){
           return Container();
         }else{
           return Container();
         }
      },
    );
}
}