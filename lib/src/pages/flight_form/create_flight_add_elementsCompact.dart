// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/elements_compact_bloc_ad.dart';
import 'package:maando/src/blocs/flight_form_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/flight_form/create_flight_type_package.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class CreateFlightAddElementsCompact extends StatefulWidget {
  CreateFlightAddElementsCompact({Key key}) : super(key: key);

  @override
  _CreateFlightAddElementsCompactState createState() =>
      _CreateFlightAddElementsCompactState();
}

class _CreateFlightAddElementsCompactState
    extends State<CreateFlightAddElementsCompact> {
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
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofFlightForm(context);

    if (bloc.listElementsCompactStreamValue == false) {
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
                              GestureDetector(
                                child: Text(
                                  generalText.clear(),
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 36, 41, 1),
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.w500),
                                ),
                                onTap: () => {_clear(bloc)},
                              )
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
                            fontSize: responsive.ip(3.5),
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
                            fontSize: responsive.ip(2),
                            color: Color.fromRGBO(173, 181, 189, 1)),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // ********************************************   Los elementos
                    Container(
                      margin: EdgeInsets.only(
                        top: height * 0.015,
                        bottom: variableGlobal.margenBotonesAbajo(context),
                      ),
                      height: height * 0.40,
                      child: _filaDe5(responsive, [], bloc),
                    ),
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
                          width: width * 0.2,
                          height: height * 0.07,
                          child: Center(
                            child: textExpanded(
                                    generalText.cancel(),
                                    width * 0.2,
                                    responsive.ip(2.1),
                                    Color.fromRGBO(33, 36, 41, 0.5),
                                    FontWeight.w500,
                                    TextAlign.center
                              )
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
                              child: textExpanded(
                                        generalText.add(),
                                        width * 0.35,
                                        responsive.ip(2),
                                        Color.fromRGBO(33, 36, 41, 0.5),
                                        FontWeight.w500,
                                        TextAlign.center
                                  )
                            ),
                          ),
                          color: Color.fromRGBO(251, 251, 251, 1),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                              side: BorderSide(
                                  width: 1.5,
                                  color: Color.fromRGBO(255, 206, 6, 1))),
                        ),
                        visible: _verBotonAdd(bloc),
                      ),
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
  Widget _filaDe5(Responsive responsive, List<Widget> elements, bloc) {
    var ele;
    List<Widget> listaElementosWidget1 = [];
    List<Widget> listaElementosWidget2 = [];
    List<Widget> listaElementosWidget3 = [];
    List<Widget> listaElementosWidget4 = [];
    List<Widget> listaElementosWidget5 = [];
    List<Widget> listaElementosWidget6 = [];
    List<Widget> listaElementosWidget7 = [];

    for (var i = 0; i < bloc.listElementsCompact.length; i++) {
      if (i <= 4) {
        ele = (bloc.listElementsCompact[i]["name"].length < 9)
            ? _elementShort(responsive, bloc.listElementsCompact[i], bloc)
            : _elementLong(responsive, bloc.listElementsCompact[i], bloc);
        listaElementosWidget1.add(ele);
      } else {
        ele = (bloc.listElementsCompact[i]["name"].length < 9)
            ? _elementShort(responsive, bloc.listElementsCompact[i], bloc)
            : _elementLong(responsive, bloc.listElementsCompact[i], bloc);
        listaElementosWidget2.add(ele);
      }
    }
    return Container(
        // decoration: new BoxDecoration(
        //     border: new Border.all(width: 5.0, color: Colors.red)),
        margin: EdgeInsets.symmetric(
          horizontal: variableGlobal.margenPageWithFlight(context),
        ),
        child: Column(
          children: <Widget>[
            Row(children: listaElementosWidget1),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget2),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget3),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget4),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget5),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget6),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.018,
            ),
            Row(children: listaElementosWidget7),
          ],
        ));
  }

  Widget _elementShort(Responsive responsive, dynamic element, bloc) {
    return StreamBuilder(
        stream: bloc.listElementsCompactStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>> snapshopt) {
          return GestureDetector(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.15,
              height: MediaQuery.of(context).size.height * 0.035,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  color: (element["select"] == false)
                      ? Color.fromRGBO(230, 232, 235, 1)
                      : Color.fromRGBO(86, 194, 227, 1),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                child: Text(
                  element["name"].toUpperCase(),
                  style: TextStyle(
                      fontSize: responsive.ip(1.3),
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(33, 36, 41, 1)),
                ),
              ),
            ),
            onTap: () {
              setState(() {
                for (var elem in bloc.listElementsCompact) {
                  if (element["code"] == elem["code"]) {
                    elem["select"] = true;
                    bloc.changeListElementsCompact(snapshopt.data);
                  }
                }
              });
            },
          );
        });
  }

  Widget _elementLong(Responsive responsive, dynamic element, bloc) {
    return StreamBuilder(
        stream: bloc.listElementsCompactStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<dynamic>> snapshopt) {
          return CupertinoButton(
            minSize: 0,
            padding: EdgeInsets.all(0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.234,
              height: MediaQuery.of(context).size.height * 0.035,
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.01),
              decoration: BoxDecoration(
                  color: (element["select"] == false)
                      ? Color.fromRGBO(230, 232, 235, 1)
                      : Color.fromRGBO(86, 194, 227, 1),
                  borderRadius: BorderRadius.circular(4.0)),
              child: Center(
                child: Text(
                  element["name"].toUpperCase(),
                  style: TextStyle(
                      fontSize: responsive.ip(1.3),
                      fontWeight: FontWeight.w500,
                      color: Color.fromRGBO(33, 36, 41, 1)),
                ),
              ),
            ),
            onPressed: () {
              setState(() {
                for (var elem in bloc.listElementsCompact) {
                  if (element["code"] == elem["code"]) {
                    elem["select"] = true;
                    bloc.changeListElementsCompact(snapshopt.data);
                  }
                }
              });
            },
          );
        });
  }

  _clear(bloc) {
    setState(() {
      bloc.changeListElementsCompact([]);
      elementsBlocCompactAd.llenarListaElementosCompact(context);
      elementsBlocCompactAd.inicializarElementos();
    });
  }

  bool _verBotonAdd(FlightFormBloc bloc) {
    List compact = [];
    if (bloc.listElementsCompactStreamValue != false) {
      for (var h in bloc.listElementsCompact) {
        if (h["select"] == true) {
          compact.add(h);
        }
      }
    }

    if (compact.length <= 0) {
      return false;
    } else {
      return true;
    }
  }
}
