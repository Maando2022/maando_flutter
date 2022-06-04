import 'dart:io';

class AfterSignupText {
  String lang = Platform.localeName.substring(0, 2);

  String welcommeToMaando() {
    // return 'Welcome to Maando!';
    if (lang == 'en') {
      return 'Welcome to Maando!';
    } else if (lang == 'es') {
      return 'Bienvenido a Maando!';
    } else {
      return 'Welcome to Maando!';
    }
  }

  String toStartPlease() {
    // return 'To start please choose one the following options';
    if (lang == 'en') {
      return 'To start please choose one the following options';
    } else if (lang == 'es') {
      return 'Para comenzar, elija una de las siguientes opciones';
    } else {
      return 'To start please choose one the following options';
    }
  }

  String sending() {
    // return 'SENDING';
    if (lang == 'en') {
      return 'SENDING';
    } else if (lang == 'es') {
      return 'ENVIAR';
    } else {
      return 'SENDING';
    }
  }

  String taking() {
     // return 'TAKING';
    if (lang == 'en') {
      return 'TAKING';
    } else if (lang == 'es') {
      return 'TOMAR';
    } else {
      return 'TAKING';
    }
  }

  String ifYouNeed() {
    // return 'If you need to send something,';
    if (lang == 'en') {
       return 'If you need to send something,';
    } else if (lang == 'es') {
      return 'Si necesita enviar algo,';
    } else {
      return 'If you need to send something,';
    }
  }

  String createAd() {
    // return 'Create an ad.';
    if (lang == 'en') {
      return 'Create an ad.';
    } else if (lang == 'es') {
      return 'Crear un anuncio.';
    } else {
      return 'Create an ad.';
    }
  }

  String ifYouAreTraveling() {
    // return 'If you are traveling soon,';
    if (lang == 'en') {
      return 'If you are traveling soon,';
    } else if (lang == 'es') {
      return 'Si viaja pronto,';
    } else {
      return 'If you are traveling soon,';
    }
  }

  String publishYouFlight() {
    // return 'Publish your flight. ';
    if (lang == 'en') {
      return 'Publish your flight. ';
    } else if (lang == 'es') {
      return 'Publica tu vuelo.';
    } else {
      return 'Publish your flight.';
    }
  }

  String goToHome() {
    // return 'Go to home';
    if (lang == 'en') {
      return 'Go to home';
    } else if (lang == 'es') {
      return 'Ir al inicio';
    } else {
      return 'Go to home';
    }
  }
}

AfterSignupText afterSigupText = AfterSignupText();
