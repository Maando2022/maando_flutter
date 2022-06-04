// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/widgets/iconos.dart';

class Ratings extends StatefulWidget {
  // Ratings({Key key}) : super(key: key);

  BuildContext context;

  Ratings({@required this.context});

  @override
  _RatingsState createState() => _RatingsState();
}

class _RatingsState extends State<Ratings> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ratingsMedium(widget.context),
    );
  }

  // **************
  Widget ratingsMedium(BuildContext context) {
    return Container(
      child: Row(
        children: [
          starRating(context, 1, 1),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          starRating(context, 2, 2),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          starRating(context, 3, 3),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          starRating(context, 4, 4),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.03,
          ),
          starRating(context, 5, 5),
        ],
      ),
    );
  }
}
