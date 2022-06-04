// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';


class Payments extends StatefulWidget {

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {

  ScrollController _scrollController = ScrollController();
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  Http _http = Http();
  int cont = 30;


@override
void initState() {
  // TODO: implement initState
    super.initState();
        blocGeneral.changeViewNavBar(true);
      _http.getMatchesPaymentsAdmin(email: preference.prefsInternal.get('email'), cont: cont)
          .then((payments) {
        final valueMap = json.decode(payments);
        if (valueMap['ok'] == false) {
        } else {
          blocAdmin.changePayments(valueMap["flights"]);
        }
      });


    // *********

    _scrollController
      ..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 500), () {
          blocGeneral.changeViewNavBar(true);
        });

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta abajo
          cont = cont + 15;
          _http.getMatchesPaymentsAdmin(
                  email: preference.prefsInternal.get('email'), cont: cont)
              .then((payments) {
            final valueMap = json.decode(payments);
            // print('LOS MATCHES  =====>>> ${valueMap}');
            if (valueMap['ok'] == false) {
            } else {
              blocAdmin.changePayments(valueMap["flights"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });
}



  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container();
                      }else{
                         return Container(
                            height: height * 0.73,
                            width: width,
                            child: listFlight(height, width),
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

  // **********
  Widget listFlight(double height, double width){
  return StreamBuilder(
          stream: blocAdmin.paymentsStream,
          // ignore: missing_return
          builder: (BuildContext context, snapshotPayments) {
            if(snapshotPayments.hasData){

              if(snapshotPayments.data.length <=0){
                return Center(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: height * 0.2),
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.center,
                              children: [
                                Text(generalText.weWillGetItThereFast(),
                                textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(
                                            0, 0, 0, 1.0),
                                        fontSize:
                                            MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.05)),
                              ],
                            ),
                          ),
                        );
              }else{
                return ListView.builder(
                itemCount: snapshotPayments.data.length,
                controller: _scrollController,
                itemBuilder: (context, i) {
                  String phoneCode = '';
                  String phoneWhatsApps = '';

                aiports.forEach((country){
                  if(snapshotPayments.data[i]["flight"]["user"]["country"] == country["name"]){
                    phoneCode = '+(${country["indicative-code"]}) ${snapshotPayments.data[i]["flight"]["user"]["phone"]}';
                    phoneWhatsApps ='+${country["indicative-code"]}${snapshotPayments.data[i]["flight"]["user"]["phone"]}';
                  }
                });

                  return CupertinoButton(
                    color: (snapshotPayments.data[i]["stateFlight"] == 'request_paidFlight') ?  Color.fromRGBO(45, 222, 152, 0.5) : null,
                    padding: EdgeInsets.all(0),
                    onPressed: () => _viewDetailPayment(snapshotPayments.data[i], phoneCode, phoneWhatsApps),
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(snapshotPayments.data[i]["flight"]["user"]["email"]),
                          Text(phoneCode),
                          (snapshotPayments.data[i]["stateFlight"] == 'request_paidFlight') ? Text(adminText.isPaid()) : Text(adminText.noPaid()),
                          SizedBox(height: height * 0.01,)
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      leading: CircleAvatar(
                                  child: (snapshotPayments.data[i]["flight"]["user"]["avatar"] == null || snapshotPayments.data[i]["flight"]["user"]["avatar"] == '')
                                  ? Text(snapshotPayments.data[i]["name"].substring(0, 2).toUpperCase(), style: TextStyle(
                                                                    fontSize: width * 0.045,
                                                                    // height: 1.6,
                                                                    fontWeight: FontWeight.bold),
                                                                textAlign: TextAlign.start,
                                                              )
                                  : Container(),
                                  backgroundImage: NetworkImage(snapshotPayments.data[i]["flight"]["user"]["avatar"]),
                                ),
                      title: Text(snapshotPayments.data[i]["flight"]["user"]["name"].toString()),
                    ),
                  );

                  },
                );
              }
      
              
            }else if(snapshotPayments.hasError){
              return Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Error!!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontSize: 24.0)),
                  ],
                ),
              ));
            } else {
                return Container(
                  margin: EdgeInsets.only(top: 100.0),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
          });
  }


  _viewDetailPayment(dynamic match, String phoneCode, String phoneWhatsApps){
    blocAdmin.changePayment(match);
    Navigator.pushNamed(context, 'payment_datail', arguments: json.encode({'phoneCode': phoneCode, 'phoneWhatsApps': phoneWhatsApps}));
  }
}
