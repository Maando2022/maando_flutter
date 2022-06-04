// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:maando/src/blocs/socket_bloc.dart';

class CustomAppBar extends StatefulWidget {
  final bool iconarrowyellow;
  final String pageToBack;
  final bool iconFace1;
  final bool posts;
  final bool notifications;
  final bool search;

  CustomAppBar(
      {Key key,
      @required this.iconarrowyellow,
      this.pageToBack,
      @required this.iconFace1,
      @required this.posts,
      @required this.notifications,
      @required this.search
      });

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  Widget InitContainer = Container(
    width: 0,
    height: 0,
  );

  Widget yellowRowBack() {
    Widget rowback = InitContainer;

    if (widget.iconarrowyellow) {
      rowback = Container(
        width: MediaQuery.of(context).size.height * 0.03,
        height: MediaQuery.of(context).size.height * 0.025,
        margin: EdgeInsets.all(14),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/general/icon - arrow back 1@3x.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: CupertinoButton(
            padding: EdgeInsets.all(0),
            child: Container(),
            onPressed: () => {Navigator.pushNamed(context, widget.pageToBack)}),
      );
    }
    return rowback;
  }

  Widget iconoface() {
    Widget icono = InitContainer;

    if (widget.iconFace1) {
      Size measure = MediaQuery.of(context).size;

      icono = Container(
        margin: EdgeInsets.only(top: 7),
        width: measure.width * 0.12,
        height: measure.height * 0.12,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100.0),
          image: DecorationImage(
              image: AssetImage('assets/images/face_1/icono1.png'),
              fit: BoxFit.contain),
        ),
      );
    }

    return icono;
  }

  Widget buttonPost() {
    Widget postIcono = InitContainer;
    Size measure = MediaQuery.of(context).size;
    if (!widget.posts) {
      postIcono = Container(
        width: measure.width * 0.06,
        height: measure.height * 0.06,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.width * 0.0095),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/general/icon-world matters-1.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: CupertinoButton(
            child: Container(),
            onPressed: () => {Navigator.pushNamed(context, 'post')}),
      );
    }

    return postIcono;
  }

  Widget buttonNoti() {
    Widget buttonNotification = InitContainer;
    Size measure = MediaQuery.of(context).size;

    if (widget.notifications) {
      buttonNotification = CupertinoButton(
        onPressed: () {
          Navigator.pushNamed(context, 'notification');
        },
        minSize: 0,
        padding: EdgeInsets.all(0),
        child: Stack(
          children: [
            Container(
              width: measure.width * 0.06,
              height: measure.height * 0.06,
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width * 0.009),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/general/campana001.png'),
                  fit: BoxFit.contain,
                ),
              ),
              child: Container(),
            ),
            Positioned(
              child: StreamBuilder(
                  stream: blocSocket.userStream,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      var valueMap = snapshot.data;
                      // print('LOS MENSAGES    ${valueMap["messages"]}');
                      if (valueMap != null) {
                        List<dynamic> lengthMessagesView = [];
                        for (var m in valueMap["messages"]) {
                          if (m['view'] == false) {
                            lengthMessagesView.add(m);
                          }
                        }

                        if (lengthMessagesView.length > 0) {
                          double sizenumbreNotification = 0.03;
                          if (lengthMessagesView.length <= 9) {
                            sizenumbreNotification = 0.03;
                          } else if (lengthMessagesView.length > 9 &&
                              lengthMessagesView.length <= 99) {
                            sizenumbreNotification = 0.022;
                          } else {
                            sizenumbreNotification = 0.015;
                          }

                          return Container(
                            width: (MediaQuery.of(context).size.width < 1000)
                                ? MediaQuery.of(context).size.width * 0.05
                                : MediaQuery.of(context).size.width * 0.038,
                            height: (MediaQuery.of(context).size.width < 1000)
                                ? MediaQuery.of(context).size.width * 0.05
                                : MediaQuery.of(context).size.width * 0.038,
                            decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red),
                            child: Center(
                                child: Text(
                              '${lengthMessagesView.length}',
                              // child: Text('10000',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width *
                                      sizenumbreNotification),
                            )),
                          );
                        } else {
                          return Container();
                        }
                      } else {
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.05,
                          height: MediaQuery.of(context).size.width * 0.05,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.red),
                        );
                      }
                    } else if (snapshot.hasError) {
                      return Container();
                    } else {
                      return Container();
                    }
                  }),
            )
          ],
        ),
      );
    }

    return buttonNotification;
  }

  Widget buttonSearch() {
    Widget searchButton = InitContainer;
    Size measure = MediaQuery.of(context).size;

    if (widget.search) {
      searchButton = Container(
        width: measure.width * 0.06,
        height: measure.height * 0.06,
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.009),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/general/icon-search@3x.png'),
            fit: BoxFit.contain,
          ),
        ),
        child: CupertinoButton(
            child: Container(),
            onPressed: () {
              // Navigator.pushNamed(context, 'search_9_4',arguments: page);
            }),
      );
    }
    return searchButton;
  }

  @override
  Widget build(BuildContext context) {
    Size measure = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: measure.height * 0.07),
      width: double.infinity,
      height: 45.0,
      child: Stack(
        children: [
          Container(
            child: yellowRowBack(),
          ),
          Center(
            child: Positioned(
              child: iconoface(),
            ),
          ),
          Positioned(
            right: MediaQuery.of(context).size.height * 0.030,
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  buttonPost(),
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.025,
                  ),
                  buttonNoti(),
                  SizedBox(
                    width: MediaQuery.of(context).size.height * 0.025,
                  ),
                  buttonSearch()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}