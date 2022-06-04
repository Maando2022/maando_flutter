// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:maando/src/widgets/loading/success.dart';


class Search_page_9_4 extends StatefulWidget {
  Search_page_9_4({Key key}) : super(key: key);

  @override
  _Search_page_9_4State createState() => _Search_page_9_4State();
}

class _Search_page_9_4State extends State<Search_page_9_4> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controladorSearch = TextEditingController();
  String search = 'VACIO';
  String searchInput = '';
  List<dynamic> flightArray;
  Http _http = Http();

  List<dynamic> aiportsDestinations = blocGeneral.aiportsDestination;
  List<dynamic> aiportsOrigin = blocGeneral.aiportsOrigin;
  List<String> ciudadesOrigen = [];
  List<String> ciudadesDestino = [];


    @override
  void initState() {
    super.initState();
     // LLENAMOS LAS CIUDADES DE ORIGEN Y DESTINO
    for(int i = 0;  i < aiportsOrigin.length; i++){
      for(var co in aiportsOrigin[i]["aiports"]){
        ciudadesOrigen.add(co["city"]);
      }
    }
    for(int i = 0;  i < aiportsDestinations.length; i++){
      for(var cd in aiportsDestinations[i]["aiports"]){
        ciudadesDestino.add(cd["city"]);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'search_9_4');
    double miheight = MediaQuery.of(context).size.height;
    double miwidth = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    String page = ModalRoute.of(context).settings.arguments;

    return StreamBuilder<List<dynamic>>(
            stream: blocGeneral.aiportsOriginStream,
            builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                if(snapshotConutriesOrigin.hasData){
                    if(snapshotConutriesOrigin.data.length <= 0){
                      return Container();
                    }else{
                          return Scaffold(
                              backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                              body: Stack(children: <Widget>[
                                SingleChildScrollView(
                                    child: Container(
                                        //Container principal
                                        width: miheight * 0.95,
                                        margin: EdgeInsets.only(
                                            top: variableGlobal.margenTopGeneral(context),
                                            right: variableGlobal.margenPageWith(context),
                                            left: variableGlobal.margenPageWith(context)),
                                        child: Column(children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              (search == 'VACIO')
                                                  ? closeSearch(
                                                      context,
                                                      'assets/images/close/close button 1@3x.png',
                                                      page)
                                                  : arrwBackYellow(context, 'principal'),
                                            ],
                                          ),
                                          SizedBox(
                                            height: miheight * 0.03,
                                          ),
                                          _typeShearch(context, responsive, miheight, miwidth),
                                          SizedBox(
                                            height: miheight * 0.01,
                                          ),
                                          _inputSearch(responsive),
                                          _listDeparture(responsive, miheight, miwidth)
                                        ])) //cierre container principal
                                    )
                              ]));
                    }
                }else if(snapshotConutriesOrigin.hasError){
                    return Container();
                }else{
                    return Container();
                }
              },
        );
  }

  Widget _typeShearch(BuildContext context, Responsive responsive, double miheight, double miwidth) {
    if (search == 'DEPARTURE') {
      return _departure(context, responsive, miheight, miwidth);
    } else if (search == 'DESTINATION') {
      return _destination(context,responsive, miheight, miwidth);
    } else {
      return _botonera(context, responsive, miheight, miwidth);
    }
  }

  // ********************
  Widget _departure(BuildContext context, Responsive responsive, double miheight, double miwidth) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            child: Text(
              generalText.clear(),
              style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                search = 'VACIO';
              });
            },
          ),
          SizedBox(
            width: miwidth * 0.04,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                search = 'DEPARTURE';
              });
            },
            child: Container(
              height: miheight * 0.04,
              width: miheight * 0.12,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(86, 194, 227, 1),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                child: Text(generalText.departure().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontSize: responsive.ip(1.5),
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ********************
  // ********************
  Widget _destination(BuildContext context, Responsive responsive, double miheight, double miwidth) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            child: Text(
              generalText.clear(),
              style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.w500),
            ),
            onTap: () {
              setState(() {
                search = 'VACIO';
              });
            },
          ),
          SizedBox(
            width: miwidth * 0.04,
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                search = 'DESTINATION';
              });
            },
            child: Container(
              height: miheight * 0.04,
              width: miheight * 0.12,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(86, 194, 227, 1),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                child: Text(generalText.destination().toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontSize: responsive.ip(1.5),
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
          )
        ],
      ),
    );
  }

  // ********************
  Widget _botonera(BuildContext context, Responsive responsive, double miheight, double miwidth) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [

      SizedBox(
        height: miheight * 0.04,
        width: miwidth * 0.27,
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              search = 'DEPARTURE';
            });
          },
          child: Container(
            child: Text(generalText.departure().toUpperCase(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontSize: responsive.ip(1.3),
                  fontWeight: FontWeight.w600,
                )),
          ),
          color: Color.fromRGBO(230, 232, 235, 1),
        ),
      ),
      SizedBox(
        width: miwidth * 0.03,
      ),
      SizedBox(
        height: miheight * 0.04,
        width: miwidth * 0.27,
        child: CupertinoButton(
          padding: EdgeInsets.all(0),
          onPressed: () {
            setState(() {
              search = 'DESTINATION';
            });
          },
          child: Container(
            child: Text(generalText.destination().toUpperCase(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontSize: responsive.ip(1.3),
                  fontWeight: FontWeight.w600,
                )),
          ),
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(4.0),
          // ),
          color: Color.fromRGBO(230, 232, 235, 1),
        ),
      ),
      SizedBox(
        width: miwidth * 0.05,
      ),
    ]);
  }

  Widget _inputSearch(Responsive responsive) {
    return Container(
      child: Form(
        key: formKey,
        child: TextFormField(
            style: TextStyle(
                fontSize: responsive.ip(2.5),
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(173, 181, 189, 1)),
            textInputAction: TextInputAction.done,
            cursorColor: Colors.deepOrange,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: generalText.search(),
              border: InputBorder.none,
              labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.w500,
                  color: Color.fromRGBO(173, 181, 189, 1)),
            ),
            onChanged: (value) {
              setState(() {
                searchInput = value;
              });
            }),
      ),
    );
  }

  // *******************

  Widget _listDeparture(Responsive responsive, double miheight, double miwidth) {
    List<Widget> results = [];
    if (searchInput.length > 0 && search == 'DEPARTURE') {
      for (int i = 0; i < ciudadesOrigen.length; i++) {
        if (ciudadesOrigen[i]
                .toLowerCase()
                .contains(searchInput.toLowerCase().trim()) ==
            true) {
          results.add(_result(responsive, ciudadesOrigen[i], miwidth));
        }
      }
    } else if (searchInput.length > 0 && search == 'DESTINATION') {
      for (int i = 0; i < ciudadesDestino.length; i++) {
        if (ciudadesDestino[i].toLowerCase().contains(searchInput.toLowerCase().trim()) == true) {
          results.add(_result(responsive, ciudadesDestino[i], miwidth));
        }
      }
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: results,
      ),
    );
  }

  // *******************
  Widget _result(Responsive responsive, String text, double miheight) {
    return GestureDetector(
      onTap: () {
        flightArray = [];
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

        _http.home(context: context, email: preference.prefsInternal.get("email"), cont: 1000000).then((value) {
          
          final valueMap = json.decode(value);
          if (valueMap["ok"] != false) {
            Navigator.pop(context);
            for (var flight in valueMap["adsFlightBD"]) {
              if (search == 'DEPARTURE') {
                if (flight["type"] == 'flight' &&
                    flight["cityDepartureAirport"].split(' (')[0] == text) {
                  flightArray.add(flight);
                }
              } else if (search == 'DESTINATION') {
                  if (flight["type"] == 'flight' &&
                      flight["cityDestinationAirport"].split(' (')[0] == text) {
                    flightArray.add(flight);
                  }
              }
            }

            if (flightArray.length <= 0) {
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, "Useful Information."); } ).then((_){
                    Navigator.pop(context);
                  });
            } else {
              Navigator.pop(context);
              blocGeneral.changeArrayFlightSearch(flightArray);
              Navigator.pushNamed(context, 'result_flight_search',
                  arguments: jsonEncode({'text': text, 'pageBack': 'search_9_4'}));
            }
          } else {
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, "Error"); })
            .then((_){
                    Navigator.pop(context);
                  });
          }
        });
      },
      child: Container(
        margin: EdgeInsets.only(bottom: miheight * 0.04),
        child: Text(
          text,
          style: TextStyle(
              color: Color.fromRGBO(173, 181, 189, 1),
              fontSize: responsive.ip(2),
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
