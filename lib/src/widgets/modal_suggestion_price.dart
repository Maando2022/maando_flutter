import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/blocs/provider.dart';

class ModalConSuggestionPrice extends StatelessWidget {
  Http _http = Http();
  final preference = Preferencias();





  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final bloc = ProviderApp.ofAdForm(context);

    return BounceInDown(
      child: Column(
        children: [
          Container(
            height: height * 0.5,
             decoration: BoxDecoration(
                        color: Color.fromRGBO(251, 251, 251, 1),
                        border: Border.all(color: Colors.black.withOpacity(0.3), width: 0.5),
                        borderRadius: BorderRadius.circular(7.0),
                        // boxShadow: <BoxShadow>[
                        //     BoxShadow(
                        //       color: Colors.black26,
                        //       blurRadius: 3.0,
                        //       offset: Offset(3.0, 5.0),
                        //       spreadRadius: 3.0
                        //     )
                        //   ]
                        ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconFace1(context),
                SizedBox(height: height * 0.02,),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                  child: Column(
                    children: [
                      Text(generalText.suggestOffer(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color.fromRGBO(33, 36, 41, 1.0),
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.08)),
                                   SizedBox(height: height * 0.02),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(generalText.onlyForPackagesThatHaveNoUrgency(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 36, 41, 1.0),
                                      fontWeight: FontWeight.bold,
                                      fontSize: width * 0.05)),
                          SizedBox(height: height * 0.02),
                          Text(generalText.ifYourServiceDoesntHaveToBeImmediate(),
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      color: Color.fromRGBO(33, 36, 41, 1.0),
                                      fontWeight: FontWeight.w300,
                                      fontSize: width * 0.0)),
                        ],
                      ),
                    ],
                  )),
              SizedBox(height: height * 0.05,),
               RaisedButton(
                child: Container(
                  width: width * 0.4,
                  child: Text(generalText.suggest(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                           color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04)),
                ),
                color: Color.fromRGBO(255, 206, 6, 1.0),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
                onPressed: () {
                  blocGeneral.changeSendRequest(false);
                  Navigator.pushNamed(context, 'create_ad_price');
                }),
              SizedBox(height: height * 0.01,),
                RaisedButton(
                child: Container(
                  width: width * 0.4,
                  child: Text(generalText.skip(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Color.fromRGBO(255, 206, 6, 1.0),
                          fontWeight: FontWeight.bold,
                          fontSize: width * 0.04)),
                ),
                color: Color.fromRGBO(33, 36, 41, 1.0),
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
                side: BorderSide(color: Colors.black, width: 1)),
                padding: EdgeInsets.symmetric(horizontal: 15.0),
                onPressed: () {
                  blocGeneral.changeSendRequest(false);
                  bloc.changePrice('120');
                  Navigator.pushNamed(context, 'create_ad_resume');
                })
              ],
            ),
          ),
        ],
      ),
    );
  }


}
