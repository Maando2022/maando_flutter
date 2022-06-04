// @dart=2.9
import 'package:flutter/material.dart';

class ContentPage extends StatelessWidget {
  const ContentPage({Key key, @required this.child, this.isScrollView = false})
      : super(key: key);

  final Widget child;
  final bool isScrollView;

  static final double _horizontalPadding = 30;
  static double get horizontalPadding => _horizontalPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: _horizontalPadding, vertical: 5),
      child: isScrollView
          ? SingleChildScrollView(
        child: child,
      )
          : child,
    );
  }
}
