// @dart=2.9
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:maando/src/enviromets/url_server.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

class PaypalPayPage extends StatefulWidget {
  // final dynamic match;
  String urlPay;

  PaypalPayPage({this.urlPay});

  @override
  State<StatefulWidget> createState() {
    return PaypalPayPageState();
  }
}

class PaypalPayPageState extends State<PaypalPayPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _url = urlserver.url;

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

       return  MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              "/": (_) => new WebviewScaffold(
                url: widget.urlPay,
                appBar: AppBar(
                  leading: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, 'principal');
                      }),
                  backgroundColor: Color.fromRGBO(255, 206, 6, 1),
                  elevation: 0.0,
                ),
                
              ),
            },
          );


    //   return  MaterialApp(
    //         routes: {
    //           "/": (_) => new WebviewScaffold(
    //             url: widget.urlPay,
    //             appBar: AppBar(
    //               leading: IconButton(
    //                   icon: Icon(Icons.arrow_back),
    //                   onPressed: () {
    //                     Navigator.pushReplacementNamed(context, 'principal');
    //                   }),
    //               backgroundColor: Color.fromRGBO(255, 206, 6, 1),
    //               elevation: 0.0,
    //             )
    //           ),
    //         },
    //       );

    // return Scaffold(
    // key: _scaffoldKey,
    // appBar: AppBar(
    //   leading: IconButton(
    //       icon: Icon(Icons.arrow_back),
    //       onPressed: () {
    //         Navigator.pushReplacementNamed(context, 'principal');
    //       }),
    //   backgroundColor: Color.fromRGBO(255, 206, 6, 1),
    //   elevation: 0.0,
    // ),
    // body: WebView(
    //         initialUrl: widget.urlPay,
    //       )
    // // WebView(
    // //   initialUrl: '${widget.urlPay}}',
    // //   javascriptMode: JavascriptMode.unrestricted,
    // //   onWebViewCreated: (WebViewController webViewController) {
    // //     _controller.complete(webViewController);
    // //   }
    // //   gestureNavigationEnabled: true,
    // // )
    // );
  }
}
