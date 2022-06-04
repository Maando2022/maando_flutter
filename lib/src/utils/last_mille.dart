// @dart=2.9
import 'dart:convert';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/services/http_last_mille/mensajerosurbanos.dart';
import 'package:maando/src/services/http_last_mille/multientrega.dart';


class LastMilleResourse {

  Map<String, dynamic> getDelivery(AdFormBloc bloc){
    Map<String, dynamic> delivery;

    if(bloc.lastMille == null){
      delivery = null;
    }else{
      if(bloc.lastMille == 'multi-entrega'){
        delivery = {
          "deliveryAddress": bloc.lastMille,
          "division1": bloc.division1,
          "division2": bloc.division2,
          "division3": bloc.division3,
          "division4": bloc.division4,
          "address": bloc.address,
          "phoneDelivery": bloc.phoneDelivery,
          "contact": bloc.contact,
          // "sucursal": 107,
          "data_branch_office": [1],
          "dataService": null
        };
      }else if(bloc.lastMille == 'mensajeros-urbanos'){
        int city;
        dynamic coordinate1;
        dynamic coordinate2;
        
        if(bloc.city == 'Bogota'){
          city = 1;
          coordinate1 = {
            "address": "El Dorado International Airport, aerodrome, Bogota Capital District, Colombia",
            "description": "28852",
            "lat": "4.702317",
            "log": "-74.1479881172965"
          };
        }else if(bloc.city == 'Cartagena'){
          city = 8;
          coordinate1 = {
            "address": "Aeropuerto Rafael Nunez, terminal, Bolívar, Colombia",
            "description": "28852",
            "lat": "10.445766249999998",
            "log": "-75.51628480729164"
          };
        }else{
          city = 1;
          coordinate1 = {
            "address": "El Dorado International Airport, aerodrome, Bogota Capital District, Colombia",
            "description": "28852",
            "lat": "4.702317",
            "log": "-74.1479881172965"
          };
        }
        coordinate2 = {
          "address": bloc.addressGeocoding,
          "description":bloc.address2,
          "lat": bloc.locationGeocoding["latitude"].toString(),
          "log":  bloc.locationGeocoding["longitude"].toString()
        };

        delivery = {
            "deliveryAddress": bloc.lastMille,
            "dateStart": bloc.dateTime.toString(),
            "city": city,
            "description": bloc.title,
            "location": {"latitude": bloc.locationGeocoding["latitude"], "longitude": bloc.locationGeocoding["longitude"]},
            "address1": bloc.address1,
            "address2": bloc.address2,
            "addressGeocoding": bloc.addressGeocoding,
            "coordinates": [coordinate1, coordinate2],
            "dataService": null
        };
      }else{
        delivery = null;
      }
    }

    return delivery;
  }


  createservice(dynamic ad, dynamic flight){
    if(ad["delivery"]["deliveryAddress"] == "multi-entrega"){
      HttpLastMultientrega().generateTokenMultientrega().then((value){
      dynamic valueMapToken = json.decode(value);

        if(valueMapToken["ok"] == true){
          HttpLastMultientrega().createServiceMultientrega(
            valueMapToken["token"], 
            ad["delivery"], 
            ad["_id"], 
            ad["delivery"]["address"], 
            ad["title"], 
            ad["user"]["email"], 
            ad["user"]["phone"], 
            ad["delivery"]["contact"], 
            ad["delivery"]["division4"]["Id"],  
            flight["user"]["name"], 
            flight["flightNumber"], 
            ad["arrivalDate"]).then((valueMultientrega){

              var valueMapMultientrega = json.decode(valueMultientrega);
              print('ENTRO AQUÍ  =============>>>>>>>>>>  ${valueMapMultientrega}');
                if(valueMapMultientrega["ok"] == true){
                  if(valueMapMultientrega["body"]["success"] == true){
                    EasyLoading.showSuccess(generalText.paymentsSuccessful());
                    
                  }else{
                    EasyLoading.showError("Error!");
                  }
                }else{
                  EasyLoading.showError("Error!");
                }
            });
        }
      });

    }else if(ad["delivery"]["deliveryAddress"] == "mensajeros-urbanos"){
        HttpMensajerosurbanos().generateTokenMensajerosUrbanos().then((valueToken){
          dynamic valueMapToken = json.decode(valueToken);
          if(valueMapToken["ok"] == true){
            // *****
              HttpMensajerosurbanos().createServiceMesajerosUrbanos(valueMapToken["body"]["access_token"], json.encode(ad)).then((valueMensajerosurbanos) {
                var valueMapMensajerosurbanos = json.decode(valueMensajerosurbanos);
                  if(valueMapMensajerosurbanos["ok"] == true){
                      EasyLoading.showSuccess(generalText.paymentsSuccessful());
                      // print(' LA RESPUESTA  ==============>>>>  ${valueMapMensajerosurbanos}');
                  }
              });
          }
        });
    }else{

    }
  }

}

LastMilleResourse lastMilleResourse = LastMilleResourse();