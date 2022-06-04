// import 'package:flutter/material.dart';
// import 'package:webfeed/webfeed.dart';
// import 'package:http/http.dart' as http;

// // https://medium.com/@scottingram.scott/hacker-news-rss-app-in-flutter-976728b09361

// class RSSDemo extends StatefulWidget {
//   RSSDemo({Key key}) : super(key: key);

//   @override
//   _RSSDemoState createState() => _RSSDemoState();
// }

// class _RSSDemoState extends State<RSSDemo> {
//   static const String FEED_URL = 'https://maando.com/world-matters/feed/';
//   RssFeed _feed;
//   Future<RssFeed> loadFeed() async {
//     try {
//       final client = http.Client();
//       final response = await client.get(FEED_URL);
//       return RssFeed.parse(response.body);
//     } catch (e) {
//       // handle any exceptions here
//     }
//     return null;
//   }

//   uploadFeed(feed) {
//     setState(() {
//       _feed = feed;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('World Matters'),
//       ),
//       body: FutureBuilder<RssFeed>(
//           future: loadFeed(),
//           builder: (BuildContext, AsyncSnapshot<RssFeed> snapshot) {
//             if (snapshot.hasError) {
//               return Container();
//             } else if (snapshot.hasData) {
//               print(
//                   '===================== >>>  ${snapshot.data.items[0].content.value}');
//               return Container(
//                 child: Text(snapshot.data.generator),
//               );
//             } else {
//               return Container();
//             }
//           }),
//     );
//   }
// }
