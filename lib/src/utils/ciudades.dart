// @dart=2.9
import 'dart:async';
import 'package:geolocator/geolocator.dart';
import "package:google_maps_webservice/geocoding.dart";


// https://pub.dev/packages/google_maps_webservice
// https://www.mapsdirections.info/coordenadas-de-googlemaps.html
final geocoding = new GoogleMapsGeocoding(apiKey: "AIzaSyA5Mhsy6cvg-IzuUJvb8uo5dmZfD4YTvoQ");

// Future<List<Placemark>> devolverCiudadActual() async {
//   try{
//       Position position = await Geolocator()
//       .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

//   return await Geolocator()
//       .placemarkFromCoordinates(position.latitude, position.longitude);
//   }catch(e){
//     print('No se accedió  a la ubicación');
//     return await null;
//   }

// }

Future<GeocodingResponse> listPlaces(String address) async {
  try{
     return await geocoding.searchByAddress(address);

  }catch(e){
    print('No se accedió  a la ubicación');
    return await null;
  }

}



class PositionClass {

  StreamSubscription<Position> _positionStream;
  // Future<Position> getPosition() async {
  //   try{
  //     return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  //   }catch(e){
  //     return await null;
  //   }

  // }

  double distanciaEnMetros(double startLatitude, double startLongitude, double endLatitude, double endLongitude) {
    return Geolocator.distanceBetween(startLatitude, startLongitude, endLatitude, endLongitude);
  }



//   listenPosition(BuildContext context) async{
    
//     final PermissionStatus status = await Permission.locationWhenInUse.request();
//     switch(status){
//       case PermissionStatus.undetermined:
//         // TODO: Aún no se solicitó el permiso.
//         // dialogPermissions.showPermissionLocationDialog(context, 'Aún no se solicitó el permiso');
//         break;
//       case PermissionStatus.granted:
//         // TODO: El usuario otorgó acceso a la función solicitada..
//             try{
//               Geolocator  geolocator = Geolocator();
//               LocationOptions  locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

//               _positionStream = geolocator.getPositionStream(locationOptions).listen(
//                 (Position position) {
//                     // Http().updatePosition(email: prefsInternal.prefsInternal.get('email'), latitude: position.latitude, longitude: position.longitude)
//                     //   .then((value){
//                     //     final valueMap = json.decode(value);
//                     //     if(valueMap["ok"] == false){
//                     //       print('ERROR AL GUARDAR POSiCION ====> $valueMap');
//                     //     }else{
//                     //     //  print(position == null ? 'Unknown' : 'Latitude ==> ${position.latitude.toString()}\nLongitude ==> ${position.longitude.toString()}');
//                     //       print('LA POSICION ===>>  ${valueMap["position"]}');
//                     //     }
//                     //   });
//                     bdBloc.dbUsersStream.listen((user) async { 
//                        if(bdBloc.dbUsers == null) return;
//                      dynamic user = await bdBloc.dbUsers.findOne({"email": prefsInternal.prefsInternal.get('email')});
//                       user["position"] = { "latitude" : position.latitude, "longitude" : position.longitude };
//                       await bdBloc.dbUsers.replaceOne({"email": prefsInternal.prefsInternal.get('email')}, user).then((valueMap){
//                         if(valueMap.success == false){
//                           print('ERROR AL GUARDAR POSiCION ====> ${valueMap.success}');
//                         }else{
//                           print('LA POSICION ===>>  ${user["position"]}');
//                         }
//                       });
//                     }); 
                  
//               });
//             }catch(e){
//               print('ERROR AL OBTENER POSiCION ====> ${e.toString()}');
//             }
//         break;
//       case PermissionStatus.denied:
//         // TODO: El usuario denegó el acceso a la función solicitada..
//         print('El usuario denegó el acceso a la función solicitada');
//         // dialogPermissions.showPermissionLocationDialog(context, 'El usuario denegó el acceso a la función solicitada.');
//         break;
//       case PermissionStatus.restricted:
//         // TODO: El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...
//         print('El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...');
//         // dialogPermissions.showPermissionLocationDialog(context, "El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS. ");
//         break;
//       case PermissionStatus.limited:
//         // TODO: El usuario ha autorizado esta aplicación para acceso limitado. Solo compatible con iOS (iOS14 +).
//             try{
//               Geolocator  geolocator = Geolocator();
//               LocationOptions  locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);

//               _positionStream = geolocator.getPositionStream(locationOptions).listen(
//                 (Position position) {
//                     Http().updatePosition(email: prefsInternal.prefsInternal.get('email'), latitude: position.latitude, longitude: position.longitude)
//                       .then((value){
//                         final valueMap = json.decode(value);
//                         if(valueMap["ok"] == false){
//                           print('ERROR AL GUARDAR POSiCION ====> $valueMap');
//                         }else{
//                         //  print(position == null ? 'Unknown' : 'Latitude ==> ${position.latitude.toString()}\nLongitude ==> ${position.longitude.toString()}');
//                           print('LA POSICION ===>>  ${valueMap["position"]}');
//                         }
//                       });
                  
//               });
//             }catch(e){
//               print('ERROR AL OBTENER POSiCION ====> ${e.toString()}');
//             }
//         break;
//       case PermissionStatus.permanentlyDenied:
//         // TODO: El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android..
//         // dialogPermissions.showPermissionLocationDialog(context, 'El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android.');
//         // dialogPermissions.showPermissionOpenAppSetting(context, generalText.grantPermissionsFromTheAppSettings());
//         break;
//     }

//   }

//   dispose() {
//     _positionStream.cancel();
//   }
}

PositionClass position = PositionClass();
