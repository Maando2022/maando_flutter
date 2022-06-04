import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/ranking_bloc.dart';
import 'package:maando/src/pages/home/principal_page.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';


class RoquestToTransport extends StatefulWidget {
  // const RoquestToTransport({Key key}) : super(key: key);

  @override
  _RoquestToTransportState createState() => _RoquestToTransportState();
}

class _RoquestToTransportState extends State<RoquestToTransport> {
  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'request_to');
    double miheight = MediaQuery.of(context).size.height;
    double miwidth = MediaQuery.of(context).size.width;
    final ad = blocRanking.adReview;

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(
                    top: variableGlobal.margenTopGeneral(context),
                    right: 16.0,
                    left: 16.0),
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                              child:
                                  iconarrowyellowRequestToTransport(context)),
                          iconFace1(context),
                          Container(
                            width: 32.0,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              'Request to transport on your TK18 flight.',
                              style: TextStyle(
                                fontSize: 32.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 16.6,
                            ),
                            Container(
                              width: miwidth * 0.95,
                              height: miheight * 0.20,
                              padding: EdgeInsetsDirectional.only(top: 0.0),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/general/photo@3x.png'),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: miheight * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Need to transport',
                                  style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: miwidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.01,
                            ),
                            Row(
                              children: [
                                Text(
                                  ad.adTitle,
                                  style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontSize: miwidth * 0.045,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.02,
                            ),
                            Row(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Date to deliver',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                173, 181, 189, 1.0),
                                            fontSize: miwidth * 0.035,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: miheight * 0.005,
                                        ),
                                        Row(
                                          children: [
                                            daterequest(context),
                                            SizedBox(
                                              width: miwidth * 0.02,
                                            ),
                                            Text(
                                              '${formatearfechaDateTime(ad.deliveryDT)}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    33, 36, 41, 1.0),
                                                fontSize: miwidth * 0.035,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      width: miwidth * 0.1,
                                    ),

                                    // ****************************
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Destination',
                                          style: TextStyle(
                                            color: Color.fromRGBO(
                                                173, 181, 189, 1.0),
                                            fontSize: miwidth * 0.035,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          textAlign: TextAlign.start,
                                        ),
                                        SizedBox(
                                          height: miheight * 0.005,
                                        ),
                                        Row(
                                          children: [
                                            destirequest(context),
                                            SizedBox(
                                              width: miwidth * 0.02,
                                            ),
                                            Text(
                                              '${ad.destination}',
                                              style: TextStyle(
                                                color: Color.fromRGBO(
                                                    33, 36, 41, 1.0),
                                                fontSize: miwidth * 0.035,
                                                fontWeight: FontWeight.w700,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ],
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.02,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Customer ratings ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: miwidth * 0.04,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ratings(context, 4),
                                SizedBox(
                                  width: miwidth * 0.05,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, 'reviews_12_3',
                                        arguments: 'request_to');
                                  },
                                  child: Text(
                                    'See customer reviews',
                                    style: TextStyle(
                                      color: Color.fromRGBO(81, 201, 245, 1.0),
                                      fontSize: miwidth * 0.035,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                SizedBox(
                                  width: miwidth * 0.035,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'You’ll receive',
                                  style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: miwidth * 0.035,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(
                                  width: miwidth * 0.035,
                                ),
                                iconEdit(context)
                              ],
                            ),
                            SizedBox(
                              height: miheight * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                billeterequest(context),
                                SizedBox(
                                  width: miwidth * 0.02,
                                ),
                                Text(
                                  '25.00 USD',
                                  style: TextStyle(
                                    color: Color.fromRGBO(33, 36, 41, 1.0),
                                    fontSize: miwidth * 0.035,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // SizedBox(
                      //   height: width * 0.5,
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: miheight * 0.07,
              ),
              Container(
                child: _acceptservices(),
              ),
              SizedBox(
                height: miheight * 0.02,
              ),
              Container(
                child: backrequest(context, PrincipalPage()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _acceptservices() {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          print('Accept service');
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Accept service',
                style: TextStyle(
                  color: Color.fromRGBO(255, 206, 6, 1),
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side: BorderSide(width: 0.5, color: Colors.white)),
        elevation: 5.0,
        color: Color.fromRGBO(33, 36, 41, 1),
        textColor: Colors.white,
      );
    });
  }
}
