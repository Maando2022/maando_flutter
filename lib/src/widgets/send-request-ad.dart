// @dart=2.9
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/utils/textos/general_text.dart';
// import 'package:maando/src/widgets/PaypalPayment.dart';

class SendRequestAd extends StatelessWidget {
  // const SendRequestAd({Key key}) : super(key: key);
  String type;

  SendRequestAd({@required this.type});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return FadeInDown(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color.fromRGBO(234, 234, 234, 1.0),
                border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
                borderRadius: BorderRadius.circular(7.0),
                boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 3.0,
                      offset: Offset(3.0, 5.0),
                      spreadRadius: 3.0
                    )
                  ]
                ),
            child: Column(
              children: <Widget>[
                Container(
                  color: Color.fromRGBO(234, 234, 234, 1.0),
                  margin: EdgeInsets.all(width * 0.05),
                  child: _encabezado(),
                ),
                _precioCentro(),
                Container(
                  color: Color.fromRGBO(234, 234, 234, 1.0),
                  margin: EdgeInsets.all(width * 0.05),
                  child: _competitorsRate(),
                ),
                Container(
                    color: Color.fromRGBO(234, 234, 234, 1.0),
                    child: _botonera(context)),
                    SizedBox(height: height * 0.05,)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _encabezado() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(generalText.sendrequest(),
          style: TextStyle(
              fontSize: 24.0, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 16.0,
        ),
        Text(
          'Short description for send request screen.',
          style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(173, 181, 189, 1),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _precioCentro() {
    final formatCurrency = new NumberFormat.simpleCurrency();

    return Container(
      color: Color.fromRGBO(234, 234, 234, 1.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(generalText.transportationPackageCost(),
            style: TextStyle(
                fontSize: 16.0,
                color: Color.fromRGBO(33, 36, 41, 1),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(
            height: 6.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '${formatCurrency.format(25)}',
                style: TextStyle(
                    fontSize: 24.0,
                    color: Color.fromRGBO(33, 36, 41, 1),
                    fontWeight: FontWeight.bold),
              ),
              Text(
                ' USD',
                style: TextStyle(
                    fontSize: 24.0,
                    color: Color.fromRGBO(33, 36, 41, 1),
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _competitorsRate() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(generalText.ourCompetitorsRate(),
          style: TextStyle(
              fontSize: 14.0,
              color: Color.fromRGBO(33, 36, 41, 1),
              fontWeight: FontWeight.w400),
        ),
        SizedBox(
          height: 16.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            _company('UPS', 55, 'USD'),
            _company('DHL', 65, 'USD'),
            _company('FEDEX', 70, 'USD')
          ],
        ),
      ],
    );
  }

  Widget _company(String nombre, int precio, String moneda) {
    final formatCurrency = new NumberFormat.simpleCurrency();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          nombre,
          style: TextStyle(
              fontSize: 12.0,
              color: Color.fromRGBO(173, 181, 189, 1),
              fontWeight: FontWeight.w600),
        ),
        Row(
          children: <Widget>[
            Text(
              '${formatCurrency.format(precio)}',
              style: TextStyle(
                  fontSize: 16.0,
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontWeight: FontWeight.bold),
            ),
            Text(
              ' $moneda',
              style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(33, 36, 41, 1),
                  fontWeight: FontWeight.w400),
            )
          ],
        ),
      ],
    );
  }

  Widget _botonera(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(26.0),
      margin: EdgeInsets.only(
        left: MediaQuery.of(context).size.width * 0.03,
        right: MediaQuery.of(context).size.width * 0.03
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              blocGeneral.changeSendRequest(false);
              print('Aqui');
            },
            child: Container(
              width: 74,
              height: 48,
              child: Center(
                child: Text(generalText.cancel(),
                    style: TextStyle(
                      color: Color.fromRGBO(33, 36, 41, 0.5),
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            color: Color.fromRGBO(251, 251, 251, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                    width: 1.5, color: Color.fromRGBO(33, 36, 41, 1))),
          ),
          RaisedButton(
            onPressed: () {
              // braintree.obtenerClientToken(context);
              print('Se va para el pago');
              // blocGeneral.changeSendRequest(false);
              //  Navigator.of(context).push(MaterialPageRoute(
              //    builder: (BuildContext context) => PaypalPayment(
              //                 onFinish: (number) async {},
              //               ),
              //             ),
              //           );
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.35,
              height: MediaQuery.of(context).size.height * 0.07,
              // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
              child: Center(
                child: Text(generalText.send(),
                    style: TextStyle(
                      color: Color.fromRGBO(33, 36, 41, 0.5),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
            ),
            color: Color.fromRGBO(255, 206, 6, 1),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(
                    width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
          )
        ],
      ),
    );
  }


}
