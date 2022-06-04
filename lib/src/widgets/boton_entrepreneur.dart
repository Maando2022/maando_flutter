// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EntrePreneur extends StatefulWidget {
  @override
  _EntrePreneurState createState() => _EntrePreneurState();
}

class _EntrePreneurState extends State<EntrePreneur>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 500000000),
      vsync: this,
    );
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: Tween(begin: 0.0, end: 100000000.0).animate(_controller),
      child: Container(
        // height: MediaQuery.of(context).size.height * 0.05,
        width: MediaQuery.of(context).size.width * 0.20,
        height: MediaQuery.of(context).size.width * 0.2,
        padding: EdgeInsetsDirectional.only(top: 0.0),
        decoration: BoxDecoration(
          // border: Border.all(width: 0),
          // borderRadius: BorderRadius.circular(100.0),
          image: DecorationImage(
            image: AssetImage('assets/images/general/mundo@3x.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: CupertinoButton(
            child: Container(),
            onPressed: () => {
                  // blocNavigator.shipmentPrincipal(),
                  Navigator.pushReplacementNamed(
                    context,
                    'entrepreneurs',
                  )
                  //     arguments: jsonEncode({"shipments": true, "service": false}))
                }),
      ),
    );
  }
}
