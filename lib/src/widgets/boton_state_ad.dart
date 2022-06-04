// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/responsive.dart';

class BotonStateAd extends StatefulWidget {
  final Map<String, dynamic> entity;
  BotonStateAd({@required this.entity});

  @override
  _BotonStateAdState createState() => _BotonStateAdState();
}

class _BotonStateAdState extends State<BotonStateAd> {
  Http _http = Http();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return FutureBuilder(
        future: _http.findMatchSendAd(context: context, email: preference.prefsInternal.get('email'),id: widget.entity["_id"]),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            final valueData = json.decode(snapshot.data);            
            if(valueData["ok"] == true){
                  return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CupertinoButton(
                          onPressed:() =>
                            (valueData["count"] <= 0) 
                            ? toastService.showToastCenter(context: context, text: generalText.numberRequestPending(0), durationSeconds: 3)
                             :
                             _seePengingFlight(valueData["matchDB"], widget.entity),
                          padding: EdgeInsets.all(0),
                          child: Container(
                            margin: EdgeInsets.only(top: height * 0.015, left: width * 0.035),
                             height: height * 0.045,
                             width: width * 0.2,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(255, 206, 6, 1.0),
                            borderRadius: BorderRadius.circular(4.0)
                            ),
                            child: Center(child: Text(widget.entity["title"].toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.w600,
                                  fontSize: responsive.ip(1)))),
                          ),
                        ),
                      ],
                    );
            }else{
              return Container();
            }
          }else if(snapshot.hasError){
             return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.015, left: width * 0.035),
                           height: height * 0.045,
                           width: width * 0.2,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 206, 6, 1.0),
                          borderRadius: BorderRadius.circular(4.0)
                          ),
                          child: Center(child: Text('Erorr'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.w600,
                                fontSize: responsive.ip(1)))),
                        ),
                      ],
                    );
          }else{
            return Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: height * 0.015, left: width * 0.035),
                           height: height * 0.045,
                           width: width * 0.2,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 206, 6, 1.0),
                          borderRadius: BorderRadius.circular(4.0)
                          ),
                          child: Center(child: Text('...',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.w600,
                                fontSize: responsive.ip(1)))),
                        ),
                      ],
                    );
          }


        });

  }


// ****************************************+
_seePengingFlight(List<dynamic> flightPending, entity){
  blocGeneral.changeAd(entity);
  Navigator.pushNamed(context, 'list_flight_pending', arguments: json.encode(flightPending));
}

}
