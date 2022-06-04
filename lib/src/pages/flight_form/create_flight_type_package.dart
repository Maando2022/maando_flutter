// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/flight_form_bloc.dart';
import 'package:maando/src/pages/flight_form/create_flight_page2_form.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/packageResource.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_package_type.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/encabezado_flight.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/blocs/provider.dart';

class CreateFlightTyPePackage extends StatefulWidget {
  CreateFlightTyPePackage({Key key}) : super(key: key);

  @override
  _CreateFlightTyPePackageState createState() =>
      _CreateFlightTyPePackageState();
}

class _CreateFlightTyPePackageState extends State<CreateFlightTyPePackage> {
  TextEditingController controladorKindOfPackage = TextEditingController();
  final formKey = GlobalKey<FormState>();
  List<Widget> packagesWidget;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_flight_type_package');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofFlightForm(context);

    packagesWidget = [];

    packagesWidget.add(_package(responsive,
        imgPackage(packageResource.packages()[0]["code"]),
        packageResource.packages()[0],
        height,
        width,
        bloc));
    packagesWidget.add(_package(responsive,
        imgPackage(packageResource.packages()[1]["code"]),
        packageResource.packages()[1],
        height,
        width,
        bloc));

    // ======================================  ELIMINAR ELEMENTOS DUPICADOS DE LA LISTA
    final List<Widget> mapFilter = null;
    for (Widget myMap in packagesWidget) {
      // mapFilter[myMap['code']] = myMap;
    }

    // packagesWidget  =  mapFilter.keys.map((key) => mapFilter[key] as Map<String,dynamic>).toList();

    // ======================================

    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        resizeToAvoidBottomInset: false,
        body: Container(
          margin: EdgeInsets.only(
            left: variableGlobal.margenPageWith(context),
            right: variableGlobal.margenPageWith(context),
            top: variableGlobal.margenPageWithFlightTop(context),
            bottom: variableGlobal.margenBotonesAbajo(context),
          ),
          child: Stack(
            children: [
              // ******************************************************
              Positioned(
                  // left: variableGlobal.margenPageWith(context),
                  // right: variableGlobal.margenPageWith(context),
                  // top: variableGlobal.margenPageWithFlightTop(context),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    Column(
                      children: [
                        EncabezadoFlightFlightForm(
                          head: flightText.publishFlight(),
                          to: 2,
                          from: 2,
                          title: flightText.numberFlight(),
                          subtitle:
                              '${generalText.next()}: ${flightText.specialService()}')
                       
                      ],
                    ),
                    // ******************************
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          back(context, CreateFlightForm()),
                          (validarBotonNext(bloc))
                              ? toast(context, height, width)
                              : next(context, 'create_flight_resume')
                        ],
                      ),
                    )
                  ])),
              // ***************************************
              Container(
                margin: EdgeInsets.only(top: height * 0.23),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.05,
                    ),
                    Container(
                      child: _kindOfPackage(responsive, height, width),
                    ),
                    SizedBox(
                      height: height * 0.05,
                    ),
                    _packages(context, height, width, bloc)
                  ],
                ),
              )
            ],
          ),
        ));
  }

  String text = adspacktypeText.subtitulo_1();
  Widget _kindOfPackage(Responsive responsive, double height, double width) {
    return Container(
      child: Text(
        text,
        textAlign: TextAlign.start,
        style: TextStyle(
            fontSize: responsive.ip(2),
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(173, 181, 189, 1)),
      ),
    );
  }

  // -------------------

  Widget _packages(BuildContext context, double height, double width, bloc) {
    return Container(
      child: Column(
        children: packagesWidget,
      ),
    );
  }

  // -------------------
  Widget _package(Responsive responsive,
      Widget image, dynamic package, double height, double width, bloc) {
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.05),
      child: CupertinoButton(
        minSize: 0,
        padding: EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                image,
                SizedBox(
                  width: width * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(package["name"],
                        style: TextStyle(
                            fontSize: responsive.ip(2.5),
                            color: Color.fromRGBO(33, 36, 41, 1),
                            fontWeight: FontWeight.w500)),
                    SizedBox(height: height * 0.01),
                    textExpanded(
                      package["description"], 
                      width * 0.5, 
                      responsive.ip(1.5),
                      Color.fromRGBO(173, 181, 189, 1),
                      FontWeight.w500,
                      TextAlign.left
                      )
                    // Text(package["description"],
                    //     style: TextStyle(
                    //         fontSize: responsive.ip(1.8),
                    //         fontWeight: FontWeight.w500,
                    //         color: Color.fromRGBO(173, 181, 189, 1)))
                  ],
                )
              ],
            ),
            Text('${_numElemtsSelected(package["code"], bloc)}',
                style: TextStyle(
                    fontSize: responsive.ip(2.5),
                    fontWeight: FontWeight.w600,
                    color: Color.fromRGBO(33, 36, 41, 1))),
            Icon(Icons.chevron_right, color: Color.fromRGBO(173, 181, 189, 1))
          ],
        ),
        onPressed: () {
          if (package["code"] == 'Package-Compact') {
            bloc.changeTypePackageCompact(true);
            Navigator.pushReplacementNamed(
                context, 'create_flight_add_elements_compact');
          } else if (package["code"] == 'Package-Handybag') {
            bloc.changeTypePackageCompact(true);
            Navigator.pushReplacementNamed(
                context, 'create_flight_add_elements_handybag');
          } else {
            print('No va hace nada');
          }
        },
      ),
    );
  }
  // -------------------

  int _numElemtsSelected(String code, FlightFormBloc bloc) {
    if (code == 'Package-Compact') {
      List<dynamic> elementTrue = [];
      if (bloc.listElementsCompactStreamValue != false) {
        for (var element in bloc.listElementsCompact) {
          if (element["select"] == true) {
            elementTrue.add(element);
          }
        }
      }
      return elementTrue.length;
    } else if (code == 'Package-Handybag') {
      List<dynamic> elementTrue = [];
      if (bloc.listElementsHandybagStreamValue != false) {
        for (var element in bloc.listElementsHandybag) {
          if (element["select"] == true) {
            elementTrue.add(element);
          }
        }
      }
      return elementTrue.length;
    } else {
      return 0;
    }
  }

  // --------------------------

  bool validarBotonNext(FlightFormBloc bloc) {
    List compact = [];
    List handybag = [];

    if (bloc.listElementsCompactStreamValue == false && bloc.listElementsHandybagStreamValue == false) {
      return true;
    } else {
      if (bloc.listElementsCompactStreamValue != false) {
        for (var c in bloc.listElementsCompact) {
          if (c["select"] == true) {
            compact.add(c);
          }
        }
      }

      if (bloc.listElementsHandybagStreamValue != false) {
        for (var h in bloc.listElementsHandybag) {
          if (h["select"] == true) {
            handybag.add(h);
          }
        }
      }

      if (compact.length <= 0 && handybag.length <= 0) {
        return true;
      } else {
        return false;
      }
    }
  }
  // --------------------------

  Widget toast(BuildContext context, double height, double width) {
    return Container();

    // StreamBuilder(
    //     builder: (BuildContext context, AsyncSnapshot snapshot) {
    //   return RaisedButton(
    //     onPressed: () {
    //       Toast.show('There is no kind of package', context,
    //           duration: 3, gravity: Toast.CENTER);
    //     },
    //     child: Container(
    //       width: width * 0.35,
    //       height: height * 0.07,
    //       // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
    //       child: Center(
    //         child: Text('Next',
    //             style: TextStyle(
    //               color: Color.fromRGBO(33, 36, 41, 0.5),
    //               fontSize: width * 0.05,
    //               fontWeight: FontWeight.bold,
    //             )),
    //       ),
    //     ),
    //     color: Color.fromRGBO(251, 251, 251, 1),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15.0),
    //         side:
    //             BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
    //   );
    // });
  }

  Widget imgPackage(String code) {
    if (code == 'Package-Compact') {
      return packageCompact(
        MediaQuery.of(context).size.height * 0.1,
        MediaQuery.of(context).size.height * 0.1,
      );
    } else if (code == 'Package-Handybag') {
      return packageHandybag(
        MediaQuery.of(context).size.height * 0.1,
        MediaQuery.of(context).size.height * 0.1,
      );
    } else {
      return packageHandybag(
        MediaQuery.of(context).size.width * 0.2,
        MediaQuery.of(context).size.width * 0.2,
      );
    }
  }
}
