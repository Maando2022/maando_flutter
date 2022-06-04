// @dart=2.9
import 'dart:collection';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/map_style.dart';

// https://medium.com/@zeh.henrique92/google-maps-flutter-marker-circle-and-polygon-c71f4ea64498
class TimeLineMap extends StatefulWidget {
  @override
  _TimeLineMapState createState() => _TimeLineMapState();
}

class _TimeLineMapState extends State<TimeLineMap> {
  Http _http = Http();

  GoogleMapController _mapController;
  Set<Marker> _markers = HashSet<Marker>();
  int _markerIdCounter = 1;

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height;
    // double width = MediaQuery.of(context).size.width;
    dynamic user = json.decode(ModalRoute.of(context).settings.arguments);
    _setMarker(LatLng(
        (user["position"] == null) ? 0.000 : user["position"]["latitude"], 
        (user["position"] == null) ? 0.000 : user["position"]["longitude"]),);
    final CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(
        (user["position"] == null) ? 0.000 : user["position"]["latitude"], 
        (user["position"] == null) ? 0.000 : user["position"]["longitude"]),
      //  target: LatLng(10.414462499999999, -75.52987018951777),
      zoom: 15.4746,
      
    );


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

  void _setMarker(LatLng point){
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point
        )
      );
    });
  }


}
