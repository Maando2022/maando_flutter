// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/ranking_bloc.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'dart:io';

// 😁
Widget iconFace1(BuildContext context) {
  return Container(
    width: variableGlobal.iconsAppBar(context),
    height: variableGlobal.iconsAppBar(context),
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
          image: AssetImage('assets/images/face_1/icono1.png'),
          fit: BoxFit.contain),
    ),
  );
}

// 😁
Widget iconFace2(BuildContext context) {
  return Container(
    width: variableGlobal.iconsAppBar2(context),
    height: variableGlobal.iconsAppBar2(context),
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
          image: AssetImage('assets/images/face_1/icono1.png'),
          fit: BoxFit.contain),
    ),
  );
}

//**************************************************** */

Widget guy_back(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.43,
    width: MediaQuery.of(context).size.width * 0.25,
    decoration: BoxDecoration(
      // border: new Border.all(width: 1.0, color: Colors.yellow),
      image: DecorationImage(
        image: AssetImage('assets/images/general/guy-looking-back@3x.png'),
      ),
    ),
  );
}

//****************************************************** */
Widget iconarrowyellow(BuildContext context, String page) {
  return CupertinoButton(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.025,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, page);
      });
}

//****************************************************** */
Widget iconarrowyellowRequestToTransport(BuildContext context) {
  return CupertinoButton(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.025,
        padding: EdgeInsetsDirectional.only(top: 0.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onPressed: () {
        Navigator.pushNamed(context, 'notification');
      });
}

//****************************************************** */
Widget iconarrowyellowReview(BuildContext context, String page) {
  return CupertinoButton(
      padding: EdgeInsets.all(0),
      child: Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.025,
        decoration: BoxDecoration(
          image: DecorationImage(
            image:
                AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
            fit: BoxFit.fill,
          ),
        ),
      ),
      onPressed: () {
        if (page == 'principal') {
          blocNavigator.homePrincipal();
          Navigator.pushReplacementNamed(context, 'principal');
        } else {
          Navigator.pushReplacementNamed(context, page);
          // Navigator.pop(context);
        }
      });
}

//***************************************************** */
Widget iconEdit(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.077,
    height: MediaQuery.of(context).size.height * 0.04,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon-edit-1.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
} //*********************************************** */

Widget iconinfo(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.05,
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon info@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget arrawup(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.05,
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/post/arrow up@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget arrawdown(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/post/arrow 2@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//****************************************
Widget iconFaceLan(BuildContext context) {
  return Container(
    // margin: EdgeInsets.symmetric(vertical: 50.0),
    width: MediaQuery.of(context).size.width * 0.15,
    height: MediaQuery.of(context).size.width * 0.15,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/face_1/icono1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget facebook1(BuildContext context) {
  return Container(
    width: 14.1,
    height: 14.2,
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/facebook/facebook 2.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget apple1(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.06,
    height: MediaQuery.of(context).size.width * 0.07,
    decoration: BoxDecoration(
      // border: Border.all(width: 1, color: Colors.red),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/general/logo03.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget google1(BuildContext context) {
  return Container(
    width: 14.1,
    height: 14.2,
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/google/google.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget page(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.05,
    width: 22.0,
    height: 22.0,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/page/Page 1.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//*************************************/

Widget page2(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.04,
    height: MediaQuery.of(context).size.height * 0.04,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/page/icon - arrow@3x.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

// **********************************

Widget page1(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.height * 0.04,
    height: MediaQuery.of(context).size.height * 0.04,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/page/icon - arrow@3x.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}
// **********************************

Widget avion1(BuildContext context) {
  return Container(
    // height: MediaQuery.of(context).size.height * 0.05,
    width: 22.0,
    height: 22.0,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      // border: Border.all(width: 0),
      // borderRadius: BorderRadius.circular(100.0),
      image: DecorationImage(
        image: AssetImage('assets/images/general/avion1.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

// **********************************

Widget progress(String image, double width, double height) {
  return Container(
    width: width,
    height: height,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(image),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget lineYellow(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.15,
    height: MediaQuery.of(context).size.height * 0.005,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/line_yellow.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

/************************************ */
Widget lineYellowNoti(BuildContext context) {
  return Container(
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    width: MediaQuery.of(context).size.width * 0.19,
    height: 3.0,
    margin: EdgeInsets.only(
      right: MediaQuery.of(context).size.width * 0.72,
    ),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/line_yellow.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

//***************************************** */

Widget lineYellowShipmentSevice(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.19,
    height: 3.0,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/line_yellow.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//*************************************** */
Widget lineGray(context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.001,
    height: MediaQuery.of(context).size.width * 2,
    child: Container(
      color: Color.fromRGBO(173, 181, 189, 1.0),
    ),
  );
}
// **********************************

Widget avatarPost(BuildContext context, String image) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.09,
    height: MediaQuery.of(context).size.width * 0.09,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      image: _cargarAvatar(context, image),
    ),
  );
}

Widget avatar(
    BuildContext context, String image, GlobalKey<ScaffoldState> _scaffoldKey) {
  return CupertinoButton(
    onPressed: () {
      _scaffoldKey.currentState.openDrawer();
    },
    padding: EdgeInsets.all(0),
    minSize: 0,
    child: Container(
      width: variableGlobal.iconsAppBar(context),
      height: variableGlobal.iconsAppBar(context),
      child: _cargarAvatar(context, image),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(100.0),
      //   image: _cargarAvatar(context, image),
      // ),
    ),
  );
}

_cargarAvatar(BuildContext context, String image) {
       return StreamBuilder(
                stream: blocGeneral.avatarFileStream,
                builder: (BuildContext context, AsyncSnapshot snapshotAvatar) {
                  if(snapshotAvatar.hasData){
                    if(snapshotAvatar.data == null){
                        return CircleAvatar(
                          backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                          child: (image == null || image == '')
                              ? Text(
                                  preference.prefsInternal
                                      .get('fullName').toString().substring(0, 2).toUpperCase(),
                                  style: TextStyle(
                                      fontSize: MediaQuery.of(context).size.width * 0.045,
                                      // height: 1.6,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                )
                              : Container(),
                          backgroundImage: NetworkImage((image == null)
                              ? 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Fbackground_void.jpg?alt=media&token=69026fb3-874c-4068-9596-9e79abfeba00'
                              : image),
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
                      child: (image == null || image == '')
                          ? Text(
                              preference.prefsInternal
                                  .get('fullName').toString().substring(0, 2).toUpperCase(),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  // height: 1.6,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            )
                          : Container(),
                      backgroundImage: NetworkImage((image == null)
                          ? 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Fbackground_void.jpg?alt=media&token=69026fb3-874c-4068-9596-9e79abfeba00'
                          : image),
                    );
                  }else{
                    return CircleAvatar(
                      backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                      child: (image == null || image == '')
                          ? Text(
                              preference.prefsInternal
                                  .get('fullName').toString().substring(0, 2).toUpperCase(),
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width * 0.045,
                                  // height: 1.6,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            )
                          : Container(),
                      backgroundImage: NetworkImage((image == null)
                          ? 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Fbackground_void.jpg?alt=media&token=69026fb3-874c-4068-9596-9e79abfeba00'
                          : image),
                    );
                  }
                });
}

// **********************************

Widget boxYellow(double height, double width) {
  return Container(
    width: width * 0.05,
    height: width * 0.05,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/box/box1.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

// **********************************

Widget boxYellow2() {
  return Container(
    width: 16.0,
    height: 15.5,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon-box-1-filled.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget date(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.width * 0.05,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon - date.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
//************************************** */

Widget daterequest(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon-date-3@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************
Widget billeterequest(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.1,
    height: MediaQuery.of(context).size.height * 0.030,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon money@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget insurance(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.06,
    height: MediaQuery.of(context).size.width * 0.06,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/Group.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//************************************** */
Widget compactSmall(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.1,
    height: MediaQuery.of(context).size.width * 0.1,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/compact.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//************************************** */
Widget handybagSmall(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.1,
    height: MediaQuery.of(context).size.width * 0.1,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/handybag.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//************************************** */

Widget destirequest(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.height * 0.025,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon location@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
// **********************************

Widget starYellow(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.width * 0.05,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/staryellow.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************

Widget starGary(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.05,
    height: MediaQuery.of(context).size.width * 0.05,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/Vector@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// **********************************
Widget starRating(BuildContext context, int position, int ranking) {
  return GestureDetector(
      onTap: () {
        blocRanking.changeRating(ranking);
      },
      child: StreamBuilder(
          stream: blocRanking.ratingStream,
          builder: (BuildContext contex, AsyncSnapshot snapshotRating) {
            if (snapshotRating.hasData) {
              if (position == 1) {
                if (snapshotRating.data == 0) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 1) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 2) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 3) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 4) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 5) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                }
              } else if (position == 2) {
                if (snapshotRating.data == 0) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 1) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 2) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 3) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 4) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 5) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                }
              } else if (position == 3) {
                if (snapshotRating.data == 0) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 1) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 2) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 3) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 4) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 5) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                }
              } else if (position == 4) {
                if (snapshotRating.data == 0) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 1) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 2) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 3) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 4) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else if (snapshotRating.data == 5) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                }
              } else if (position == 5) {
                if (snapshotRating.data == 0) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 1) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 2) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 3) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 4) {
                  return estrella(
                      context, 'assets/images/general/Vector@3x.png');
                } else if (snapshotRating.data == 5) {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                } else {
                  return estrella(
                      context, 'assets/images/general/staryellow.png');
                }
              } else {
                return estrella(context, 'assets/images/general/Vector@3x.png');
              }
            } else if (snapshotRating.hasError) {
              return Container();
            } else {
              return Container();
            }
          }));
}

//*********************************** */
Widget estrella(BuildContext context, String start) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.08,
    height: MediaQuery.of(context).size.height * 0.04,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(start),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//********************************* */

Widget envelope() {
  return Container(
    width: 18.0,
    height: 15.4,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/envelope.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}
// **********************************

Widget position(double height, double width) {
  return Container(
    width: width * 0.035,
    height: width * 0.045,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/position.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}
// **********************************  TIMELINE

Widget gate(double height, double width) {
  return Container(
    width: width * 0.035,
    height: width * 0.045,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon gate 2@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget take(double height, double width) {
  return Container(
    width: width * 0.055,
    height: width * 0.055,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon-take-off-1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

Widget landed(double height, double width) {
  return Container(
    width: width * 0.055,
    height: width * 0.055,
    // padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/icon-landed-1@3x.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

//**************************************** */
Widget megafono2_1(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width * 0.16,
    height: MediaQuery.of(context).size.height * 0.07,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/megafono2_3@3x.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

//***************************************************** */
Widget packageCompact(double width, double height) {
  return Container(
    width: width * 0.9,
    height: width * 0.9,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/compact.png'),
        fit: BoxFit.contain,
      ),
    ),
  );
}

//***************************************************** */
Widget packageHandybag(double width, double height) {
  return Container(
     width: width * 0.9,
    height: width * 0.9,
    padding: EdgeInsetsDirectional.only(top: 0.0),
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/general/handybag.png'),
        fit: BoxFit.fill,
      ),
    ),
  );
}

// ****************************************

Widget ratings(BuildContext context, int rating) {
  if (rating == 0) {
    return Container(
      child: Row(
        children: [
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
        ],
      ),
    );
  } else if (rating == 1) {
    return Container(
      child: Row(
        children: [
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
        ],
      ),
    );
  } else if (rating == 2) {
    return Container(
      child: Row(
        children: [
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
        ],
      ),
    );
  } else if (rating == 3) {
    return Container(
      child: Row(
        children: [
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
        ],
      ),
    );
  } else if (rating == 4) {
    return Container(
      child: Row(
        children: [
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starGary(context),
        ],
      ),
    );
  } else {
    return Container(
      child: Row(
        children: [
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          starYellow(context),
        ],
      ),
    );
  }
}
