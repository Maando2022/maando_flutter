// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/edit_profile_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notification_text.dart';
import 'package:maando/src/utils/recursos.dart';
import 'package:maando/src/widgets/dialog_pay_methods.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerHome extends StatefulWidget {
  DrawerHome({Key key}) : super(key: key);

  @override
  _DrawerHomeState createState() => _DrawerHomeState();
}

class _DrawerHomeState extends State<DrawerHome> {
  Http _http = Http();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    return Container(
      width: width * 0.9,
      height: double.infinity,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Container(
                margin: EdgeInsets.only(top: height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: width * 0.15,
                          height: width * 0.15,
                          child: StreamBuilder(
                                  stream: blocGeneral.avatarFileStream,
                                  builder: (BuildContext context, AsyncSnapshot snapshotAvatar) {
                                    if(snapshotAvatar.hasData){
                                      if(snapshotAvatar.data == null){
                                        return CircleAvatar(
                                              backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                              backgroundImage: NetworkImage(
                                                  preference.prefsInternal.get('urlAvatar')),
                                              child: (preference.prefsInternal.get('urlAvatar') ==
                                                          null ||
                                                      preference.prefsInternal.get('urlAvatar') ==
                                                          '')
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(urlAvatarVoid),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ))
                                                  : Container(),
                                            );
                                      }else{
                                        return Container(
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(image: FileImage(
                                                            File(snapshotAvatar.data.path)), fit: BoxFit.cover,)
                                          ),
                                         
                                        );
                                      }
                                    }else if(snapshotAvatar.hasError){
                                      return CircleAvatar(
                                              backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                              backgroundImage: NetworkImage(
                                                  preference.prefsInternal.get('urlAvatar')),
                                              child: (preference.prefsInternal.get('urlAvatar') ==
                                                          null ||
                                                      preference.prefsInternal.get('urlAvatar') ==
                                                          '')
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(urlAvatarVoid),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ))
                                                  : Container(),
                                            );
                                    }else{
                                      return CircleAvatar(
                                              backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                              backgroundImage: NetworkImage(
                                                  preference.prefsInternal.get('urlAvatar')),
                                              child: (preference.prefsInternal.get('urlAvatar') ==
                                                          null ||
                                                      preference.prefsInternal.get('urlAvatar') ==
                                                          '')
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(urlAvatarVoid),
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ))
                                                  : Container(),
                                            );
                                    }
                          
                                  }),
                  
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            textExpanded(
                              preference.prefsInternal.get('fullName'),
                              width * 0.6,
                              responsive.ip(1.8),
                              Colors.black,
                              FontWeight.bold,
                              TextAlign.start,
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Row(
                      children: [
                        SizedBox(width: width * 0.19),
                        Container(
                          width: width * 0.08,
                          height: height * 0.005,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 206, 6, 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: height * 0.035,
                    ),
                    Row(
                      children: [
                        SizedBox(width: width * 0.19),
                        Text(
                          'menu'.toUpperCase(),
                          style: TextStyle(
                              fontSize: responsive.ip(1.8),
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // ******************************************* FIN DE LA CABECERA
            SizedBox(
              height: height * 0.04,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      StreamBuilder<List<dynamic>>(
                          stream: blocGeneral.adminsStream,
                          builder: (BuildContext context, AsyncSnapshot snapshotAdmins) {
                            if(snapshotAdmins.hasData){
                              return (validateAdmin.isAdmin(preference.prefsInternal.getString('email')))
                          ? Container(
                              margin: EdgeInsets.only(left: width * 0.04),
                              child: CupertinoButton(
                                padding: EdgeInsets.all(0),
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, 'admin');
                                },
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    _yellowBox(height, width,
                                        'assets/images/sidebar/admin.png'),
                                    SizedBox(
                                      width: width * 0.07,
                                    ),
                                    Text(
                                      generalText.admin(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                          fontSize: responsive.ip(2.3)),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container();
                            }else if(snapshotAdmins.hasError){
                              return Container();
                            }else{
                              return Container();
                            }
                          }
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.04),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, 'profile_page');
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.01,
                              ),
                              _yellowBox(height, width,
                                  'assets/images/sidebar/Profile.png'),
                              SizedBox(
                                width: width * 0.07,
                              ),
                              Text(
                                generalText.profile(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: responsive.ip(2.3)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.04),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(
                                context, 'notification',
                                arguments: 'principal');
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.01,
                              ),
                              _yellowBox(height, width,
                                  'assets/images/sidebar/Notifications.png'),
                              SizedBox(
                                width: width * 0.07,
                              ),
                              Text(
                                notificationText.notifications(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: responsive.ip(2.3)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.04),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            Navigator.pushNamed(context, 'history');
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.01,
                              ),
                              _yellowBox(height, width,
                                  'assets/images/sidebar/Historial.png'),
                              SizedBox(
                                width: width * 0.07,
                              ),
                              Text(
                                generalText.servicesHistory(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: responsive.ip(2.3)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: width * 0.04),
                        child: CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

                            _http
                                .findUserForEmail(
                                    email: preference.prefsInternal
                                        .getString('email'))
                                .then((user) {
                              Navigator.pop(context);
                              final userMap = json.decode(user);
                              if (userMap["ok"] == true) {
                                if (userMap["user"]['pay'] == null) {
                                  dialogPayMethods.showMaterialDialog(
                                      context, userMap["user"]);
                                  blocEditProfile.changePayMethod(null);
                                }
                                if (userMap["user"]['pay'] != null &&
                                    userMap["user"]['pay']["name"] ==
                                        'paypal') {
                                  blocEditProfile.changePayMethod(
                                      userMap["user"]['pay']["name"]);
                                  dialogPayMethods.showMaterialDialog(
                                      context, userMap["user"]);
                                } else if (userMap["user"]['pay'] != null &&
                                    userMap["user"]['pay']["name"] ==
                                        'stripe') {
                                  blocEditProfile.changePayMethod(
                                      userMap["user"]['pay']["name"]);
                                  dialogPayMethods.showMaterialDialog(
                                      context, userMap["user"]);
                                } 
                                else {}
                              } else {
                                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, userMap["message"]);});
                              }
                            });
                          },
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.01,
                              ),
                              _yellowBox(height, width,
                                  'assets/images/sidebar/Payment.png'),
                              SizedBox(
                                width: width * 0.07,
                              ),
                              Text(
                                generalText.paymentMethods(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black,
                                    fontSize: responsive.ip(2.3)),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.04,
                      ),
                      FutureBuilder(
                        future: _http.getContactsPhone(),
                        builder: (_, AsyncSnapshot snapshot) {
                          if(snapshot.hasData){
                            return Container(
                                margin: EdgeInsets.only(left: width * 0.04),
                                child: CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                        onPressed: () async {
                                    // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                                    String message = "";
                                    String url;
                                    if (Platform.isIOS) {
                                      url =
                                          "whatsapp://send?phone=+${snapshot.data["contactsPhone"][0]}&text=${Uri.encodeFull(message)}";
                                      await canLaunch(url)
                                          ? launch(url)
                                          : print('Error al enviar mensaje de WhatsApps');
                                    } else {
                                      url =
                                          "whatsapp://send?phone=${snapshot.data["contactsPhone"][0]}&text=${Uri.encodeFull(message)}";
                                      await canLaunch(url)
                                          ? launch(url)
                                          : print('Error al enviar mensaje de WhatsApps');
                                    }
                                    Navigator.pop(context);
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      _yellowBox(height, width,
                                          'assets/images/sidebar/Necesitas-ayuda.png'),
                                      SizedBox(
                                        width: width * 0.07,
                                      ),
                                      Text(
                                        generalText.needHelp(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Colors.black,
                                            fontSize: responsive.ip(2.3)),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                          }else if(snapshot.hasError){
                            return Container();
                          }else{
                            return Container();
                          }
                        }
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.04),
                  child: CupertinoButton(
                    padding: EdgeInsets.all(0),
                    onPressed: () {
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      _http
                          .signOut(email: preference.prefsInternal.get('email'))
                          .then((value) {
                        var valueMap = json.decode(value);
                        Navigator.pop(context);
                        if (valueMap["ok"] == true) {
                          Navigator.pushReplacementNamed(context, 'login')
                              .then((_) {
                            // Navigator.pop(context);
                          });
                        } else {
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);})
                              .then((value) {
                            // Navigator.pop(context);
                          });
                        }
                      });
                    },
                    child: Row(
                      children: [
                        SizedBox(
                          width: width * 0.01,
                        ),
                        _yellowBox(
                            height, width, 'assets/images/sidebar/logout.png'),
                        SizedBox(
                          width: width * 0.07,
                        ),
                        Text(
                          generalText.logOut(),
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: responsive.ip(2.3)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
              ],
            ),
            // SizedBox(height:  height * 0.1),

            // ListTile(
            //   title: Text('Item 2'),
            //   onTap: () {
            //     // Update the state of the app.
            //     // ...
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  // **************
  Widget _yellowBox(double height, double width, String img) {
    return Container(
        height: height * 0.06,
        width: height * 0.06,
        decoration: BoxDecoration(
            color: Color.fromRGBO(255, 206, 6, 1),
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.fill,
            )));
  }
}
