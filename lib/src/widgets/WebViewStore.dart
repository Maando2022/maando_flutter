// @dart=2.9
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:webview_flutter/webview_flutter.dart';

class WebViewStorePage extends StatefulWidget {
  // final dynamic match;
  String url;

  WebViewStorePage({this.url});

  @override
  State<StatefulWidget> createState() {
    return WebViewStorePageState();
  }
}

class WebViewStorePageState extends State<WebViewStorePage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  // you can change default currency according to your need
  // Map<dynamic, dynamic> defaultCurrency = {
  //   "symbol": "USD ",
  //   "decimalDigits": 2,
  //   "symbolBeforeTheNumber": true,
  //   "currency": "USD"
  // };

  bool isEnableShipping = false;
  bool isEnableAddress = false;

  String returnURL = 'return.example.com';
  String cancelURL = 'cancel.example.com';

  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();

  @override
  void initState() {
    super.initState();
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, 'principal');
          }),
      backgroundColor: Color.fromRGBO(255, 206, 6, 1),
      elevation: 0.0,
    ),
    body: WebView(
            initialUrl: widget.url,
          )
    );
  }
}
