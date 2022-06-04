// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';


class CardAdPending extends StatefulWidget {
  // const CardAd({Key key}) : super(key: key);
  Map<String, dynamic> ad;
  Map<String, dynamic> match;

  CardAdPending({@required this.match, @required this.ad});

  

  @override
  _CardAdPendingState createState() => _CardAdPendingState();
}

class _CardAdPendingState extends State<CardAdPending> {


  
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    dynamic ad = widget.ad;    

    
    return Container(
      margin: EdgeInsets.only(right: width * 0.03, left: width * 0.03),
      child: Row(
        children: [
          _image(context, height, width, ad),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _title(context, responsive, height, width, ad),
              SizedBox(
                height: height * 0.025,
              ),
              _city(context, responsive, height, width, ad),
            ],
          ),
        ],
      ),
    );
  }

  Widget _image(BuildContext context, double height, double width, ad){
    String emailAd;
    try{
     emailAd = ad["user"]["email"];
    }catch(e){
     emailAd = widget.match["emailAd"];
    }

  return FutureBuilder<dynamic>(
    future: firebaseStorage.obtenerImagen(emailAd, ad["_id"], 1),
    // ignore: missing_return
    builder: (BuildContext context, snapshot) {
      if(snapshot.hasData){
        return Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Color.fromRGBO(230, 232, 235, 1),
          ),
          height: width * 0.2,
          width: width * 0.2,
          child: FadeInImage(
            image: NetworkImage(snapshot.data),
            placeholder:
                AssetImage('assets/images/general/jar-loading.gif'),
            fit: BoxFit.contain,
          ),
        );
      }else if(snapshot.hasError){
                return Container();
              }else{
                return Container(
                  height: width * 0.2,
                  width: width * 0.2,
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7.0),
                  color: Color.fromRGBO(230, 232, 235, 1),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/images/general/jar-loading.gif'),
                    fit: BoxFit.contain,
                  ),
                ),
                );
              }
    });

  }

  Widget _title(BuildContext context, Responsive responsive, double height, double width, ad){
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
                children: <Widget>[
                  boxYellow(height, width),
                  SizedBox(
                    width: width * 0.01,
                  ),
                  Text(ad["title"],
                      style: TextStyle(
                          color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(2)))
                ],
              ),
    );
  }

  // ************************************
  Widget _city(BuildContext context, Responsive responsive, double height, double width, ad) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: Row(
                children: <Widget>[
                  position(height, width),
                  SizedBox(
                    width: width * 0.01
                  ),
                  Text(ad["city"],
                      style: TextStyle(
                          color: Color.fromRGBO(33, 36, 41, 1.0),
                          fontWeight: FontWeight.w500,
                          fontSize: responsive.ip(2)))
                ],
              ),
    );
  }

}
