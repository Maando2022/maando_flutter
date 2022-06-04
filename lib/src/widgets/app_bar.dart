// @dart=2.9
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class AppBarWidget extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  AppBarWidget({@required this.scaffoldKey});

  @override
  _AppBarWidgetState createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  String nombre = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // extraemos el primer nombre si lo tiene
    if (preference.prefsInternal.get('fullName').toString().contains(' ') == true) {
      nombre = preference.prefsInternal.get('fullName').toString().split(' ')[0];
    } else {
      nombre = preference.prefsInternal.get('fullName');
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return StreamBuilder<bool>(
        stream: blocGeneral.viewNavBarStream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshoptNavBar) {
          if (snapshoptNavBar.hasError) {
            return Container();
          } else if (snapshoptNavBar.hasData) {
            if (snapshoptNavBar.data == true) {
              return FadeInDown(
                child: Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: height * 0.065),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            top: height * 0.055,
                            right: variableGlobal.margenPageWith(context),
                            left: variableGlobal.margenPageWith(context),),
                        width: width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: width * 0.37,
                                child: Row(
                                  children: <Widget>[
                                    FutureBuilder(
                                        future: firebaseStorage.obtenerAvatar(
                                            preference.prefsInternal
                                                .get('email')),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.hasData) {
                                            return avatar(context, 
                                            (preference.prefsInternal.get('urlAvatar') == '' || preference.prefsInternal.get('urlAvatar') == null) ? snapshot.data : preference.prefsInternal.get('urlAvatar'), 
                                            widget.scaffoldKey);
                                          } else if (snapshot.hasError) {
                                            return Container(
                                              width: variableGlobal
                                                  .iconsAppBar(context),
                                              height: variableGlobal
                                                  .iconsAppBar(context),
                                            );
                                          } else {
                                            return Container(
                                              width: variableGlobal
                                                  .iconsAppBar(context),
                                              height: variableGlobal
                                                  .iconsAppBar(context),
                                            );
                                          }
                                        }),
                                    SizedBox(
                                      width: width * 0.01,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        widget.scaffoldKey.currentState
                                            .openDrawer();
                                      },
                                      child: Container(
                                        width: width * 0.22,
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '${generalText.hi()}, ${shortString(nombre, 10)}',
                                                  style: TextStyle(
                                                      fontSize: width * 0.04,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color.fromRGBO(
                                                          173, 181, 189, 1))),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  notiworld(context),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  notification(context, 'principal'),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  search(context, 'home'),
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                ),
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        });
    ;
  }
}
