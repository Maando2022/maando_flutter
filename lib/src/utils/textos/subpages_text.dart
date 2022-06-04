import 'dart:io';

class SubPagesText {
  String lang = Platform.localeName.substring(0, 2);

  String sending() {
     //  return 'Sending';
    if (lang == 'en') {
      return 'Sending';
    } else if (lang == 'es') {
      return 'Enviar';
    } else {
      return 'Sending';
    }
  }

  String taking() {
     //  return 'Taking';
    if (lang == 'en') {
      return 'Taking';
    } else if (lang == 'es') {
      return 'Llevar';
    } else {
      return 'Taking';
    }
  }

  String shippingPackageSoon() {
     //  return 'Shipping a package soon?';
    if (lang == 'en') {
      return 'Shipping a package soon?';
    } else if (lang == 'es') {
      return '¿Enviar un paquete pronto?';
    } else {
      return 'Shipping a package soon?';
    }
  }

  String travelingSoon() {
     //  return 'Traveling soon?';
    if (lang == 'en') {
      return 'Traveling soon?';
    } else if (lang == 'es') {
      return '¿Viajas pronto?';
    } else {
      return 'Traveling soon?';
    }
  }

  String createYourFist1() {
      // return 'Create your first ad and find a';
    if (lang == 'en') {
      return 'Create your first ad and find a';
    } else if (lang == 'es') {
      return 'Crea tu primer anuncio y encuentra un';
    } else {
      return 'Create your first ad and find a';
    }
  }

  String createYourFist2() {
     //  return 'transporter, tap on the ';
    if (lang == 'en') {
      return 'transporter, tap on the ';
    } else if (lang == 'es') {
      return 'transportador, toque el ícono ';
    } else {
      return 'transporter, tap on the ';
    }
  }

  String createYourFist3() {
     //  return ' icon.';
    if (lang == 'en') {
      return ' icon.';
    } else if (lang == 'es') {
      return '';
    } else {
      return ' icon.';
    }
  }

  String publisYourFlight1() {
     //  return 'Publish your flights and make money.';
    if (lang == 'en') {
      return 'Publish your flights and make money.';
    } else if (lang == 'es') {
      return 'Publica tus vuelos, gana dinero';
    } else {
      return 'Publish your flights and make money.';
    }
  }

  String publisYourFlight2() {
     //  return ' Tap the ';
    if (lang == 'en') {
      return ' Tap the ';
    } else if (lang == 'es') {
      return ' toque en el ';
    } else {
      return ' Tap the ';
    }
  }

  String publishYourFlight3() {
     //  return ' to add what you can bring.';
    if (lang == 'en') {
      return ' to add what you can bring.';
    } else if (lang == 'es') {
      return ' para agregar lo que puedas traer.';
    } else {
      return ' to add what you can bring.';
    }
  }

  String published() {
      // return 'Published';
    if (lang == 'en') {
      return 'Published';
    } else if (lang == 'es') {
      return 'Publicados';
    } else {
      return 'Published';
    }
  }

  String inTransit() {
     //  return 'In transit';
    if (lang == 'en') {
      return 'In transit';
    } else if (lang == 'es') {
      return 'En tránsito';
    } else {
      return 'In transit';
    }
  }
}

SubPagesText subPagesText = SubPagesText();
