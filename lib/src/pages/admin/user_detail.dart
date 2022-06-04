// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:avatar_view/avatar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:cached_network_image/cached_network_image.dart';

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  Http _http = Http();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    dynamic user =
        json.decode(ModalRoute.of(context).settings.arguments)["user"];
    dynamic phoneCode =
        json.decode(ModalRoute.of(context).settings.arguments)["phoneCode"];
    dynamic phoneWhatsApps = json.decode(ModalRoute.of(context).settings.arguments)["phoneWhatsApps"];
    blocAdmin.changeUser(user);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _appBar(),
            SizedBox(height: height * 0.05),
            _avatar(context, responsive, user),
            SizedBox(height: height * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _active(context, responsive),
                SizedBox(height: height * 0.02),
                _countryAndCity(context, responsive, user),
                SizedBox(height: height * 0.2),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _whatapps(context, user, '$phoneCode$phoneWhatsApps'),
                SizedBox(width: width * 0.2),
                _call(context, phoneWhatsApps),
                SizedBox(width: width * 0.2),
                _position(context, user),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ********************
  Widget _appBar() {
    return Container(
        height: MediaQuery.of(context).size.height * 0.06,
        margin: EdgeInsets.only(
          left: variableGlobal.margenPageWith(context),
          right: variableGlobal.margenPageWith(context),
          top: variableGlobal.margenTopGeneral(context),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconFace1(context),
              ],
            ),
            arrwBackYellowPersonalizado(context, 'admin'),
          ],
        ));
  }

  // *************************
  Widget _avatar(BuildContext contex, Responsive responsive, dynamic user) {
    String avatar = '';
    try{
      if(user["avatar"] == null || user["avatar"] == ''){
        avatar = 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc';
      }else{
        avatar = user["avatar"];
      }
    }catch(e){
      avatar = 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc';
    }
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.35,
          height: MediaQuery.of(context).size.width * 0.35,
          child: 
          // AvatarView(
          //         radius: 60,
          //         borderColor: Colors.yellow,
          //         avatarType: AvatarType.CIRCLE,
          //         backgroundColor: Colors.red,
          //         imagePath: avatar,
          //         placeHolder: Container(
          //           child: Icon(Icons.person, size: 50,),
          //         ),
          //         errorWidget: Container(
          //           child: Icon(Icons.error, size: 50,),
          //         ),
          //       ),
          CircleAvatar(
            backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
            child: (avatar == '')
                ? Text(
                    user["name"].substring(0, 2).toUpperCase(),
                    style: TextStyle(
                        fontSize: responsive.ip(2),
                        // height: 1.6,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start,
                  )
                : Container(),
            backgroundImage: CachedNetworkImageProvider(avatar),
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          user["name"],
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Color.fromRGBO(173, 181, 189, 1),
              fontWeight: FontWeight.w400,
              fontSize: responsive.ip(2.5)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.01),
        Text(
          user["email"],
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: responsive.ip(2.5)),
        ),
      ],
    );
  }

  // ******************************
  Widget _active(BuildContext context, Responsive responsive) {
    return StreamBuilder(
        stream: blocAdmin.userStream,
        builder: (BuildContext context, snapshotUser) {
          if (snapshotUser.hasData) {
            return Container(
              margin: EdgeInsets.symmetric(
                  horizontal: variableGlobal.margenPageWith(context)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.01),
                  Text(
                      (snapshotUser.data["active"] == true
                          ? adminText.active()
                          : adminText.inactive()),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: responsive.ip(2))),
                  Switch(
                    value: snapshotUser.data["active"],
                    onChanged: (value) {
                      _http
                          .activeInactiveUser(
                              context: context,
                              email: preference.prefsInternal.get('email'),
                              emailUser: snapshotUser.data["email"])
                          .then((user) {
                        final valueMap = json.decode(user);
                        if (valueMap['ok'] == false) {
                        } else {
                          blocAdmin.changeUser(valueMap["user"]);
                        }
                      });
                    },
                    activeTrackColor: Color.fromRGBO(255, 206, 6, 1),
                    activeColor: Color.fromRGBO(255, 206, 6, 0.5),
                  ),
                ],
              ),
            );
          } else if (snapshotUser.hasError) {
            return Container();
          } else {
            return Container();
          }
        });
  }

  // ******************************
  Widget _whatapps(BuildContext context, dynamic user, String phoneWhatsApps) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/general/whatapps.jfif'),
            fit: BoxFit.contain),
      ),
      child: MaterialButton(onPressed: () async {
        // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
        String message =
            "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}";
        String url;
        if (Platform.isIOS) {
          url =
              "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
          await canLaunch(url)
              ? launch(url)
              : print('Error al enviar mensaje de WhatsApps');
        } else {
          url =
              "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
          await canLaunch(url)
              ? launch(url)
              : print('Error al enviar mensaje de WhatsApps');
        }
      }),
    );
  }

  Widget _call(BuildContext context, String phoneWhatsApps) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.05,
      width: MediaQuery.of(context).size.height * 0.05,
      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Icon(Icons.phone,
            color: Color.fromRGBO(255, 206, 6, 1),
            size: MediaQuery.of(context).size.height * 0.08),
        onPressed: () {
          print(phoneWhatsApps);
          launch('tel://$phoneWhatsApps');
        },
      ),
    );
  }

    Widget _position(BuildContext context, dynamic user) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      width: MediaQuery.of(context).size.height * 0.08,

      child: CupertinoButton(
        padding: EdgeInsets.all(0),
        child: Image.asset('assets/images/general/maps.png', fit: BoxFit.contain),
        onPressed: () {
          Navigator.pushNamed(context, 'user_map', arguments: json.encode(user));
        },
      ),
    );
  }

  // ******************************
  Widget _countryAndCity(BuildContext context, Responsive responsive, user) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: variableGlobal.margenPageWith(context)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            user["country"],
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                fontSize: responsive.ip(2.5)),
          ),
          Text(
            user["city"],
            textAlign: TextAlign.left,
            style: TextStyle(
                color: Color.fromRGBO(173, 181, 189, 1),
                fontWeight: FontWeight.w400,
                fontSize: responsive.ip(2.5)),
          )
        ],
      ),
    );
  }
  // ******************************
}
