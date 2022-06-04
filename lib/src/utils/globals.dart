import 'package:flutter/cupertino.dart';

class VariablesGlobales {
  double margenPageWith(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.035;
  }

  double margenPageWithFlight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.05;
  }

  double margenPageWithFlightTop(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.10;
  }

  double highInputFormFlight(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.17;
  }

  double margenPageWithLoginCreateAccount(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.05;
  }

  //Botones login
  double highBotton1(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.16;
  }

  //Botones Input
  double highInput1(BuildContext context) {
    return MediaQuery.of(context).size.width * 0.16;
  }

// **********************
  double margenBotonesAbajo(BuildContext context) {
    if (MediaQuery.of(context).size.height <= 680) {
      return MediaQuery.of(context).size.height * 0.01;
    } else if (MediaQuery.of(context).size.height > 680 &&
        MediaQuery.of(context).size.height <= 812) {
      return MediaQuery.of(context).size.height * 0.05;
    } else {
      return MediaQuery.of(context).size.height * 0.03;
    }
  }

  double altoBotoneraFlight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }

  double margenBotonesHandybagLeft(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.01;
  }

  double margenBotonesHandybaRight(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }

  double margenBotonesHandybagTop(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.25;
  }

  double margenBotonesHandybagBottom(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.00;
  }

  double margenTopGeneral(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.06;
  }

  double heightInput(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.08;
  }

  double tamanoLabecardAd(BuildContext context) {
    if (MediaQuery.of(context).size.width <= 375) {
      return MediaQuery.of(context).size.width * 0.021;
    } else {
      return MediaQuery.of(context).size.width * 0.021;
    }
  }

  double topNavigation(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.88;
    // if (MediaQuery.of(context).size.height <= 680) {
    //   return MediaQuery.of(context).size.height * 0.9;
    // } else if (MediaQuery.of(context).size.height > 680 &&
    //     MediaQuery.of(context).size.height <= 812) {
    //   return MediaQuery.of(context).size.height * 0.88;
    // } else {
    //   return MediaQuery.of(context).size.height * 0.9;
    // }
  }

  double iconsAppBar(BuildContext context) {
    return MediaQuery.of(context).size.height * 0.03;
  }

  double iconsAppBar2(BuildContext context) {
    if (MediaQuery.of(context).size.height <= 680.0) {
      return MediaQuery.of(context).size.height * 0.05;
    } else if (MediaQuery.of(context).size.height > 680 &&
        MediaQuery.of(context).size.height <= 812) {
      return MediaQuery.of(context).size.height * 0.045;
    } else if (MediaQuery.of(context).size.height > 812 &&
        MediaQuery.of(context).size.height <= 1300) {
      return MediaQuery.of(context).size.height * 0.024;
    } else {
      return MediaQuery.of(context).size.height * 0.05;
    }
  }

  Map<String, double> positionetNotifications(BuildContext context) {
    if (MediaQuery.of(context).size.height <= 680.0) {
      return {
        'left': MediaQuery.of(context).size.height * 0.03,
        'bottom': MediaQuery.of(context).size.height * 0.025
      };
    } else if (MediaQuery.of(context).size.height > 680 &&
        MediaQuery.of(context).size.height <= 812) {
      return {
        'left': MediaQuery.of(context).size.height * 0.025,
        'bottom': MediaQuery.of(context).size.height * 0.022
      };
    } else if (MediaQuery.of(context).size.height > 812 &&
        MediaQuery.of(context).size.height <= 1300) {
      return {
        'left': MediaQuery.of(context).size.height * 0.18,
        'bottom': MediaQuery.of(context).size.height * 0.02
      };
    } else {
      return {
        'left': MediaQuery.of(context).size.height * 0.025,
        'bottom': MediaQuery.of(context).size.height * 0.025
      };
    }
  }
}

VariablesGlobales variableGlobal = VariablesGlobales();
