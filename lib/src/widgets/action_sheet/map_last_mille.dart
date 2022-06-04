// @dart=2.9
import 'dart:collection';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/map_style.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/loading/loading.dart';


// https://medium.com/@zeh.henrique92/google-maps-flutter-marker-circle-and-polygon-c71f4ea64498
class MapLastMille extends StatefulWidget {
  AdFormBloc bloc;
  dynamic positionAiport;
  MapLastMille({@required this.bloc, @required this.positionAiport});

  @override
  _MapLastMilleState createState() => _MapLastMilleState();
}




class _MapLastMilleState extends State<MapLastMille> {

  dynamic pointadd;
  int cont = 0;
  GoogleMapController _mapController;
  // Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String googleAPiKey = "AIzaSyA5Mhsy6cvg-IzuUJvb8uo5dmZfD4YTvoQ";
  int _markerIdCounter = 1;
   Set<Marker> _markers = HashSet<Marker>();
   CameraPosition _kGooglePlex;
  


// ****
  TextEditingController controladorAddress1 = TextEditingController();
  TextEditingController controladorAddress2 = TextEditingController();
  List<Widget> resultsAddress = []; 
  String labelAddress;
  double _keyboard = 0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.bloc.changeAddress2('');
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.positionAiport["latitude"], widget.positionAiport["longitude"]),
      zoom: 12.4746,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);


    return Container(
      child: Column(
        children: [
          Container(
              height: height * 0.3,
              width: width * 0.9,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomRight: Radius.circular(12),
                    bottomLeft: Radius.circular(12),
                  ),
                  child: GoogleMap(
                          initialCameraPosition: _kGooglePlex,
                          myLocationButtonEnabled: true,
                          myLocationEnabled: true,
                          zoomControlsEnabled: false,
                          markers: _markers,
                          polylines: Set<Polyline>.of(polylines.values),
                          onMapCreated: (GoogleMapController controller){
                            _mapController =  controller;
                            _mapController.setMapStyle(jsonEncode(mapStyleStandard)
                            );  // mapStyleAubergine   mapStyleDark   mapStyleStandard   mapStyleRetro  mapStyleSilver  mapStyleNight mapDartYellow
                          },
                          onTap: (LatLng p){},
                        ),
                ),
              ),
            ),
            SizedBox(height: height * 0.01),
             _crearPlaceOfDelivery(responsive, widget.bloc),
             _listDeparture(),
             SizedBox(height: _keyboard)
        ],
      ),
    );
  }


  void _setMarker(LatLng point, LatLng point2) async {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    final byData = await rootBundle.load('assets/images/general/icon-take-off-1@3x.png');
    Uint8List _pin = byData.buffer.asUint8List();
    _markerIdCounter++;

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          infoWindow: InfoWindow(
          title: 'Aiport'),
          position: point,
          icon: BitmapDescriptor.fromBytes(_pin),
        )
      );

       _markers.add(Marker(
            markerId: MarkerId(point.toString()),
            position: point2,
            infoWindow: InfoWindow(
              title: 'Dirección de entrega',
            ),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
       setPolylines(point2);
    });
  }
  _addPolyLine() {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(  width: 2, polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  void setPolylines(LatLng point2) async {  
    PolylineResult  result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
        PointLatLng(widget.positionAiport["latitude"], widget.positionAiport["longitude"]),
        PointLatLng(point2.latitude, point2.longitude),
        // travelMode: TravelMode.driving,
        // wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]
        );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }else{
    }
    _addPolyLine();
  }

  // ********************
  // ********************
  // ********************

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
                contentPadding: EdgeInsets.all(10),
                labelText: text,
                border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                labelStyle: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                // errorText: snapshot.error
                ), 
                onChanged: (value){
                      bloc.changeAddress2(value);
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      resultsAddress = [];
                      Http().places('${bloc.country} ${bloc.city} $value').then((value){  
                         Navigator.pop(context);
                        for(var place in value["results"]){
                          setState(() {
                             resultsAddress.add(_result(responsive, place["formatted_address"], place["geometry"]["location"], bloc, MediaQuery.of(context).size.width));
                          });
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

  Widget _result(Responsive responsive, String formattedAddress, dynamic location, AdFormBloc bloc, double miheight) {
    return GestureDetector(
      onTap: () {
        setState(() {
          labelAddress = formattedAddress;
          bloc.changeAddressGeocoding(formattedAddress);
          bloc.changeLocationGeocoding({"latitude": location["lat"], "longitude": location["lng"]});
          resultsAddress = [];
          polylineCoordinates = [];
              _setMarker(LatLng(widget.positionAiport["latitude"], widget.positionAiport["longitude"]),
                LatLng(location["lat"], location["lng"])
              );
              _kGooglePlex = CameraPosition(
                target: LatLng(location["lat"], location["lng"]),
                zoom: 13.4746,
              );
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: miheight * 0.04),
        child: Row(
          children: [
            textExpanded(
              formattedAddress, 
              MediaQuery.of(context).size.width * 0.8,
              responsive.ip(1.6),
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

}