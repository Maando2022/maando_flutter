// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/widgets/iconos.dart';

class Detail_in_transit_page_8_3 extends StatefulWidget {
  Detail_in_transit_page_8_3({Key key}) : super(key: key);

  @override
  _Detail_in_transit_page_8_3State createState() =>
      _Detail_in_transit_page_8_3State();
}

class _Detail_in_transit_page_8_3State
    extends State<Detail_in_transit_page_8_3> {
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'detail_8_3');

    //Espacio para variables
    double izquierda = MediaQuery.of(context).size.width * 0.25;

    return SafeArea(
      child: Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          body: Stack(children: <Widget>[
            SingleChildScrollView(
                child: Stack(
              //stackprincipal

              children: [
                Container(
                    margin: new EdgeInsets.fromLTRB(izquierda, 0, 0, 0),
                    child: lineGray(context)),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: iconarrowyellow(context, 'principal')),
                          Container(
                              margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: iconFace1(context)),
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                              horizontal:
                                  MediaQuery.of(context).size.width * 0.05,
                            ),
                            child: Text('Timeline',
                                style: TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Color.fromRGBO(33, 36, 41, 1.0))),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                        ]),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      //row linea marilla
                      children: [
                        Container(
                            //container linea amarilla
                            margin: EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: lineYellow(context)),
                      ],
                    ),
                    //Cierre row linea amarilla
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      //row Estado 1
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width *
                                        0.05,
                              ),
                              child: Text(
                                '09:30 am',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Text(
                                '6:35 pm',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Text(
                                '08:00 am',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Text(
                                '09:40 am',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Container(
                              child: Text(
                                '12:40 pm',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color:
                                        Color.fromRGBO(173, 181, 189, 1.0),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.08,
                        ),
                        Column(
                          //columna principal izquierda

                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              //primer item columna derecha
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/general/icon-gate-2@3x.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'On departure gate',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Description if need it.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              //segundo item columna derecha
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/general/icon-take-off-1@3x.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Take off',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Description if need it.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              //tercer item columna derecha
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/general/icon-landed-1@3x.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Landed to Paris (CDG)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Stop, 1:40m',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              //cuarto item columna derecha
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/general/icon-take-off-1@3x.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Take off',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Description if need it.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Column(
                              //quinto item columna derecha
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      child: Image.asset(
                                          'assets/images/general/icon-landed-1@3x.png'),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Landed to St. Petersburg (LED)',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Description if need it.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ), //cierre row estado 1
                    //cierre row estado 2
                  ],
                ) //Cierre Container principal
              ],
            ) //cierre stack principal
                // ***********************
                )
          ])),
    );
  }
}
