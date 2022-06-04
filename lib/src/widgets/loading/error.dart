// https://medium.com/flutterdevs/custom-dialog-in-flutter-7ca5c2a8d33a
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/config.dart';



Widget loadingError(context, text){  
  return LoadingError(text: text);
}


class LoadingError extends StatelessWidget{
  String text;
  LoadingError({this.text = ''});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return BounceInDown(
      animate: true,
      from: 200,
      child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          height: height * 0.13,
          margin: EdgeInsets.symmetric(horizontal: width * 0.25),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            //  boxShadow: [
            //         BoxShadow(
            //             color: Colors.redAccent.withOpacity(0.3),
            //             spreadRadius: 2,
            //             blurRadius: 3,
            //             offset: Offset(1, 4), // changes position of shadow
            //           ),
            //       ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(horizontal: width * 0.07),
                child: textExpanded(
                                this.text, 
                                width * 0.33,
                                responsive.ip(1.5),
                                Colors.black,
                                FontWeight.w400,
                                TextAlign.center
                              ),)
                // child: Text(this.text, style: TextStyle(fontSize: responsive.ip(2), fontWeight: FontWeight.bold, color: Colors.grey),textAlign: TextAlign.center)),
            ],
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
        // Container(
        //   margin: EdgeInsets.only(top: responsive.ip(0.5), right: responsive.ip(0.5)),
        //   child: CupertinoButton(
        //     onPressed: ()=>{Navigator.pop(context)},
        //     padding: EdgeInsets.all(0),
        //     minSize: 0,
        //     child: Container(
        //              decoration: BoxDecoration(
        //                border: Border.all(color: Colors.grey),
        //                borderRadius: BorderRadius.circular(100)
        //              ),
        //               child: Icon(Icons.close, color: Colors.grey)
        //             ),
        //   ),
        // ),
      ],
  ),
    );;
  }
}
