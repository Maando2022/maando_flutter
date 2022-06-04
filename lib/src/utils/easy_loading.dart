import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CustomAnimation extends EasyLoadingAnimation {
  CustomAnimation();

  @override
  Widget buildWidget(
    Widget child,
    AnimationController controller,
    AlignmentGeometry alignment,
  ) {
    return Opacity(
      opacity: controller.value,
      child: RotationTransition(
        turns: controller,
        child: child,
      ),
    );
  }
  

  customEasyLoad(){
        EasyLoading.instance
        // ..displayDuration = const Duration(milliseconds: 2000000000)
        ..indicatorType = EasyLoadingIndicatorType.pouringHourGlass
        ..loadingStyle = EasyLoadingStyle.custom
        ..indicatorSize = 45.0
        ..radius = 10.0
        ..progressColor = Colors.yellow
        ..backgroundColor = Color.fromRGBO(255, 206, 6, 1)
        ..indicatorColor = Color.fromRGBO(173, 181, 189, 1)
        ..textColor = Colors.black
        ..maskColor = Colors.blue.withOpacity(0.2)
        ..userInteractions = true
        ..dismissOnTap = false
        ..customAnimation = CustomAnimation();
  }
}