// @dart=2.9
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/ciudades.dart';
import 'package:maando/src/utils/map_style.dart';
import 'dart:ui' as ui;

// https://medium.com/@zeh.henrique92/google-maps-flutter-marker-circle-and-polygon-c71f4ea64498
// 
class FlightMap extends StatefulWidget {
  @override
  _FlightMapState createState() => _FlightMapState();
}

class _FlightMapState extends State<FlightMap> {
  Http _http = Http();
  GoogleMapController _mapController;
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 2;
  List<dynamic> countriesDestination = blocGeneral.aiportsDestination;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    dynamic user = json.decode(ModalRoute.of(context).settings.arguments)["user"];
    dynamic flight = json.decode(ModalRoute.of(context).settings.arguments)["flight"];
    Map<String, double> positionFlight;
    String aiportName = '';

    countriesDestination.forEach((country){
      country["aiports"].forEach((city){
      // print('${city["city"]} (${city["code"]})');
      // return;
        if('${city["city"]} (${city["code"]})' == flight["cityDestinationAirport"]){
          positionFlight = {
            "latitude": city["geolocation"]["latitude"],
            "longitude": city["geolocation"]["longitude"]
          };
          aiportName = city["aiport"];
        }
      });
    });

    // LatLng _position 

    _setMarker(LatLng(
        (user["position"] == null) ? 0.000 : user["position"]["latitude"], 
        (user["position"] == null) ? 0.000 : user["position"]["longitude"]), positionFlight);
    _setMarkerAiport(positionFlight, flight, aiportName);

    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
        (user["position"] == null) ? 0.000 : user["position"]["latitude"], 
        (user["position"] == null) ? 0.000 : user["position"]["longitude"]),
      //  target: LatLng(10.414462499999999, -75.52987018951777),
      zoom: 15.4746,
      
    );
    return StreamBuilder<List<dynamic>>(
            stream: blocGeneral.aiportsOriginStream,
            builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                if(snapshotConutriesOrigin.hasData){
                    if(snapshotConutriesOrigin.data.length <= 0){
                      return Container();
                    }else{
                          return Scaffold(
                            appBar: AppBar(
                            leading: IconButton(
                                icon: Icon(Icons.arrow_back),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }),
                            backgroundColor: Color.fromRGBO(255, 206, 6, 1),
                            elevation: 0.0,
                          ),
                            body: Container(
                              height: double.infinity,
                              width: double.infinity,
                              child: GoogleMap(
                                      initialCameraPosition: _kGooglePlex,
                                      myLocationButtonEnabled: true,
                                      myLocationEnabled: true,
                                      zoomControlsEnabled: false,
                                      markers: _markers,
                                      // polylines: Set<Polyline>.of(polylines.values),
                                      onMapCreated: (GoogleMapController controller){
                                        _mapController =  controller;
                                        _mapController.setMapStyle(jsonEncode(mapStyleStandard)
                                        );  // mapStyleAubergine   mapStyleDark   mapStyleStandard   mapStyleRetro  mapStyleSilver  mapStyleNight mapDartYellow
                                      },
                                      onTap: (LatLng p){},
                                    ),
                            ),
                          );
                    }
                }else if(snapshotConutriesOrigin.hasError){
                    return Container();
                }else{
                    return Container();
                }
              },
        );
  }
  // ********************
  // Widget _appBar() {
  //   return Container(
  //       height: MediaQuery.of(context).size.height * 0.06,
  //       margin: EdgeInsets.only(
  //         left: variableGlobal.margenPageWith(context),
  //         right: variableGlobal.margenPageWith(context),
  //         top: variableGlobal.margenTopGeneral(context),
  //       ),
  //       child: Stack(
  //         children: [
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               iconFace1(context),
  //             ],
  //           ),
  //           arrwBackYellowPersonalizado(context, 'admin'),
  //         ],
  //       ));
  // }
  // ******************************
  Future<Uint8List> getBytesFromAsset(String path, int width) async {

      final byData = await rootBundle.load(path);
      Uint8List _pin = byData.buffer.asUint8List();
       final bitMap = BitmapDescriptor.fromBytes(_pin);
      ui.Codec codec = await ui.instantiateImageCodec(byData.buffer.asUint8List(), targetWidth: width);
      ui.FrameInfo fi = await codec.getNextFrame();
      return (await fi.image.toByteData(format: ui.ImageByteFormat.png)).buffer.asUint8List();
  }
   void _setMarkerAiport(Map<String, double> positionFlight, dynamic flight, String aiportName) async {

      final markerId = MarkerId(flight["_id"]);
      final Uint8List markerIcon = await getBytesFromAsset('assets/images/general/Maando-Plane-icon-.png', 100);

      final infowindow = InfoWindow(title: aiportName, snippet: flight["cityDestinationAirport"]);

      final markerAiport = Marker(
            markerId: markerId, 
            position: LatLng(positionFlight["latitude"], positionFlight["longitude"]), infoWindow: 
            infowindow, 
            icon: BitmapDescriptor.fromBytes(markerIcon));
          
      setState(() {
        _markers.add(markerAiport);
      });
   }

  void _setMarker(LatLng point, Map<String, double> positionFlight) async {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;

   double distance =  PositionClass().distanciaEnMetros(point.latitude, point.longitude, positionFlight["latitude"], positionFlight["longitude"]);
      final infowindow = InfoWindow(title: 'Distance', snippet: '${distance.toString()} m.');
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(markerIdVal),
            position: point,infoWindow: infowindow
          )
        );
      });

  }


}
