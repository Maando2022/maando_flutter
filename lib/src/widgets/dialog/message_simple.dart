// https://medium.com/flutterdevs/custom-dialog-in-flutter-7ca5c2a8d33a
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';



Widget messageSimple(context){  
  return MessageSimple();
}


class MessageSimple extends StatefulWidget {
  // Loading({Key? key}) : super(key: key);

  @override
  _MessageSimpleState createState() => _MessageSimpleState();
}

class _MessageSimpleState extends State<MessageSimple> with TickerProviderStateMixin{

 late AnimationController _animation;

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animation = AnimationController(duration: Duration(seconds: 4), vsync: this);
    _animation.repeat();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animation.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return FadeIn(
      animate: true,
      child: Stack(
        alignment: Alignment.center,
      children: <Widget>[
        Center(
          child: Container(
            height: height * 0.13,
            margin: EdgeInsets.symmetric(horizontal: width * 0.25),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(generalText.yourRequestIsPendingApproval(),style: TextStyle(fontSize: responsive.ip(2), fontWeight: FontWeight.bold),textAlign: TextAlign.center),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: height * 0.125),
          child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: responsive.ip(2),
                          child: Container(
                            child: SvgPicture.asset(
                                      "assets/icon/maando.svg"
                                    ),
                          ),
                    ),
        ),
      ],
  ),
    );;
  }
}
