import 'dart:io';

class MatchFlightText {
  String lang = Platform.localeName.substring(0, 2);


  String requestSentAd(String cityDestinationAirport) {
      // return 'This ad has sent you a request to the destination flight to "$cityDestinationAirport".';
    if (lang == 'en') {
      return 'This ad has sent you a request to the destination flight to "$cityDestinationAirport".';
    } else if (lang == 'es') {
      return 'Este anuncio te ha enviado una solicitud al vuelo destino a "$cityDestinationAirport".';
    } else {
      return 'This ad has sent you a request to the destination flight to "$cityDestinationAirport".';
    }
  }


  String requestSentFlight(String cityDestinationAirport) {
      // return 'You have requested to take this package to "$cityDestinationAirport".';
    if (lang == 'en') {
      return 'You have requested to take this package to "$cityDestinationAirport".';
    } else if (lang == 'es') {
      return 'Has solicitado llevar este paquete con destino a "$cityDestinationAirport".';
    } else {
      return 'You have requested to take this package to "$cityDestinationAirport".';
    }
  }

  String requestRetractedAd() {
      // return 'This ad has removed the request to ship the package.';
    if (lang == 'en') {
      return 'This ad has removed the request to ship the package.';
    } else if (lang == 'es') {
      return 'Este anuncio ha eliminado la solicitud del envío del paquete.';
    } else {
      return 'This ad has removed the request to ship the package.';
    }
  }

  String requestRetractedFligh() {
      // return 'You have removed the request to carry this package.';
    if (lang == 'en') {
      return 'You have removed the request to carry this package.';
    } else if (lang == 'es') {
      return 'Has eliminado la solicitud de llevar este paquete.';
    } else {
      return 'You have removed the request to carry this package.';
    }
  }

  String requestReceivedAd(String cityDestinationAirport) {
      // return 'This ad has received your request to take its package to "$cityDestinationAirport".';
    if (lang == 'en') {
      return 'This ad has received your request to take its package to "$cityDestinationAirport".';
    } else if (lang == 'es') {
      return 'Este anuncio ha recibido tu solicitud de llevar su paquete con destino a "$cityDestinationAirport".';
    } else {
      return 'This ad has received your request to take its package to "$cityDestinationAirport".';
    }
  }

  String requestReceivedFlight() {
      // return 'You have received the request to bring your package, you must accept the request to continue the process.';
    if (lang == 'en') {
      return 'You have received the request to bring your package, you must accept the request to continue the process.';
    } else if (lang == 'es') {
      return 'Has recibido la solicitud de llevar tu paquete, debes aceptar la solicitud para continuar el proceso.';
    } else {
      return 'You have received the request to bring your package, you must accept the request to continue the process.';
    }
  }

  String requestRejectedAd() {
      return 'This ad has rejected your request, you can reapply.';
    if (lang == 'en') {
      return 'This ad has rejected your request, you can reapply.';
    } else if (lang == 'es') {
      return 'Este anuncio ha rechazado tu solicitud, puedes volver a solicitar.';
    } else {
      return 'This ad has rejected your request, you can reapply.';
    }
  }

  String requestRejectedFlight() {
      // return 'You have declined the request for this ad.';
    if (lang == 'en') {
      return 'You have declined the request for this ad.';
    } else if (lang == 'es') {
      return 'Has rechazado la solicitud de este anuncio.';
    } else {
      return 'You have declined the request for this ad.';
    }
  }

  String requestAcceptedAd() {
      // return 'This ad has accepted your request, you must be aware of the status of the request and delivery of the package.';
    if (lang == 'en') {
      return 'This ad has accepted your request, you must be aware of the status of the request and delivery of the package.';
    } else if (lang == 'es') {
      return 'Este anuncio ha aceptado tu solicitud, debes estar atento al estado de la solicitud y entrega del paquete.';
    } else {
      return 'This ad has accepted your request, you must be aware of the status of the request and delivery of the package.';
    }
  }

  String requestAcceptedFlight() {
      // return 'You have accepted transport this package, you must be aware of the status of the request and delivery of the package.';
    if (lang == 'en') {
      return 'You have accepted transport this package, you must be aware of the status of the request and delivery of the package.';
    } else if (lang == 'es') {
      return 'Has aceptado transporta este paquete, debes estar atento al estado de la solicitud y entrega del paquete.';
    } else {
      return 'You have accepted transport this package, you must be aware of the status of the request and delivery of the package.';
    }
  }

  String requestPaidAd() {
      // return 'This package is ready to be shipped.';
    if (lang == 'en') {
      return 'This package is ready to be shipped.';
    } else if (lang == 'es') {
      return 'Este paquete está listo para ser transportado.';
    } else {
      return 'This package is ready to be shipped.';
    }
  }

  String requestPaidFlight() {
      // return 'You are ready to transport this package';
    if (lang == 'en') {
      return 'You are ready to transport this package';
    } else if (lang == 'es') {
      return 'Estás Listo para transportar este el paquete.';
    } else {
      return 'You are ready to transport this package';
    }
  }


    String requestStatus() {
      // return 'Request status';
    if (lang == 'en') {
      return 'Request status';
    } else if (lang == 'es') {
      return 'Estado de la solicitud';
    } else {
      return 'Request status';
    }
  }
}

MatchFlightText matchFlightText = MatchFlightText();
