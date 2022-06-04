// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class CardAdMatch extends StatefulWidget {
  // const CardAd({Key key}) : super(key: key);
  String ad;
  String title;
  String dateToDeliver;
  String destination;
  CardAdMatch(
      {@required this.title,
      @required this.ad,
      @required this.dateToDeliver,
      @required this.destination});

  @override
  _CardAdMatchState createState() => _CardAdMatchState();
}

class _CardAdMatchState extends State<CardAdMatch> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(251, 251, 251, 1),
        borderRadius: BorderRadius.circular(7.0),
        boxShadow: <BoxShadow>[
          BoxShadow(
              color: Colors.black26,
              blurRadius: 1.0,
              // spreadRadius: 2.0,
              offset: Offset(1.0, 1.0))
        ],
      ),
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 16.0,
          ),
          _seccion1(),
          SizedBox(
            height: 16.0,
          ),
          _seccion2(context, height, width),
          SizedBox(
            height: 16.0,
          ),
        ],
      ),
    );
  }

  Widget _seccion1() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            width: double.infinity,
            height: 180.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/general/photo@3x.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            height: 22.0,
            width: 60.0,
            margin: EdgeInsets.only(top: 18.0, left: 30.0),
            child: CupertinoButton(
                child: Container(
                  child: Text('LABEL',
                      style: TextStyle(
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: variableGlobal.tamanoLabecardAd(context))),
                ),
                color: Color.fromRGBO(255, 206, 6, 1.0),
                borderRadius: BorderRadius.circular(4.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                onPressed: () {
                  print('ESTE ES EL LABEL');
                }),
          ),
        ],
      ),
    );
  }

  Widget _seccion2(BuildContext context, double height, double width) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text('Need to transport',
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1.0),
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0)),
          SizedBox(
            height: 5.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  boxYellow(height, width),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(widget.title,
                      style: TextStyle(
                          color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0))
                ],
              ),
              botonTresPuntosGrises(context, width * 0.09,  (){})
            ],
          ),
          SizedBox(
            height: 15.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Date to deliver',
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            date(context),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(widget.dateToDeliver,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      width: width * 0.07,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Destination',
                            style: TextStyle(
                                color: Color.fromRGBO(173, 181, 189, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0)),
                        SizedBox(
                          height: 5.0,
                        ),
                        Row(
                          children: <Widget>[
                            position(height, width),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(widget.destination,
                                style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0))
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
              _botonSend(context)
            ],
          )
        ],
      ),
    );
  }

  Widget _botonSend(BuildContext context) {
    return GestureDetector(
        child: Container(
          width: 100.0,
          height: 25.0,
          decoration: BoxDecoration(
              color: Color.fromRGBO(33, 36, 41, 1.0),
              border: Border.all(
                  width: 2.0, color: Color.fromRGBO(33, 36, 41, 1.0)),
              borderRadius: BorderRadius.circular(14)),
          child: Center(
            child: Text(
              'Send request',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 10.0,
                  color: Color.fromRGBO(255, 206, 6, 1),
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        onTap: () {
          blocGeneral.changeSendRequest(true);
        });
  }
}
