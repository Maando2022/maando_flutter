// @dart=2.9
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:webview_flutter/webview_flutter.dart';

class WebViewChatPage extends StatefulWidget {
  // final dynamic match;
  String url;

  WebViewChatPage({this.url});

  @override
  State<StatefulWidget> createState() {
    return WebViewChatPageState();
  }
}

class WebViewChatPageState extends State<WebViewChatPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, 'principal');
          }),
      
      backgroundColor: Color.fromRGBO(255, 206, 6, 1),
     bottomOpacity: 0.0,
     elevation: 0.0,
    ),
    body: WebView(
            initialUrl: widget.url,
          )
    );
  }
}
