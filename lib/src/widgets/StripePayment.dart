// import 'dart:async';
// import 'dart:core';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:maando/src/enviromets/url_server.dart';
// import 'package:webview_flutter/webview_flutter.dart';

// class StripePayment extends StatefulWidget {
//   final dynamic match;

//   StripePayment({@required this.match});

//   @override
//   State<StatefulWidget> createState() {
//     return StripePaymentState();
//   }
// }

// class StripePaymentState extends State<StripePayment> {
//   GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
//   final _url = urlserver.url;

//   // you can change default currency according to your need
//   Map<dynamic, dynamic> defaultCurrency = {
//     "symbol": "USD ",
//     "decimalDigits": 2,
//     "symbolBeforeTheNumber": true,
//     "currency": "USD"
//   };

//   bool isEnableShipping = false;
//   bool isEnableAddress = false;

//   String returnURL = 'return.example.com';
//   String cancelURL = 'cancel.example.com';

//   final Completer<WebViewController> _controller =
//       Completer<WebViewController>();

//   @override
//   void initState() {
//     super.initState();
//     if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _scaffoldKey,
//         appBar: AppBar(
//           leading: IconButton(
//               icon: Icon(Icons.arrow_back),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               }),
//           backgroundColor: Color.fromRGBO(255, 206, 6, 1),
//           elevation: 0.0,
//         ),
//         body: WebView(
//           initialUrl: '$_url/stripe_payment/?matchid=${widget.match["_id"]}',
//           javascriptMode: JavascriptMode.unrestricted,
//           onWebViewCreated: (WebViewController webViewController) {
//             _controller.complete(webViewController);
//           },
//           // onProgress: (int progress) {
//           //   print("WebView is loading (progress : $progress%)");
//           // },
//           // javascriptChannels: <JavascriptChannel>{
//           //   _toasterJavascriptChannel(context),
//           // },
//           // navigationDelegate: (NavigationRequest request) {
//           //   if (request.url.startsWith('https://www.youtube.com/')) {
//           //     print('blocking navigation to $request}');
//           //     return NavigationDecision.prevent;
//           //   }
//           //   print('allowing navigation to $request');
//           //   return NavigationDecision.navigate;
//           // },
//           // onPageStarted: (String url) {
//           //   print('Page started loading: $url');
//           // },
//           // onPageFinished: (String url) {
//           //   print('Page finished loading: $url');
//           // },
//           gestureNavigationEnabled: true,
//         ));
//   }
// }
