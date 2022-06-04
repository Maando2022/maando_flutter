import 'dart:io';

class MatchAdText {
  String lang = Platform.localeName.substring(0, 2);


  String requestSentAd(String cityDestinationAirport) {
      // return 'You have sent a request to the flight destination to "$cityDestinationAirport", wait for the acceptance of the request to continue.';
    if (lang == 'en') {
      return 'You have sent a request to the flight destination to "$cityDestinationAirport", wait for the acceptance of the request to continue.';
    } else if (lang == 'es') {
      return 'Has enviado una solicitud al vuelo destino a "$cityDestinationAirport", espere la aceptación de la solicitud para poder continuar.';
    } else {
      return 'You have sent a request to the flight destination to "$cityDestinationAirport", wait for the acceptance of the request to continue.';
    }
  }


  String requestSentFlight() {
      // return 'This flight has sent you a package delivery request.';
    if (lang == 'en') {
      return 'This flight has sent you a package delivery request.';
    } else if (lang == 'es') {
      return 'Este vuelo te ha enviado una solicitud de envío de paquete.';
    } else {
      return 'This flight has sent you a package delivery request.';
    }
  }

  String requestRetractedAd() {
      // return 'You have retracted sending your package with this flight.';
    if (lang == 'en') {
      return 'You have retracted sending your package with this flight.';
    } else if (lang == 'es') {
      return 'Te has retractado de enviar tu paquete con este vuelo.';
    } else {
      return 'You have retracted sending your package with this flight.';
    }
  }

  String requestRetractedFligh() {
      // return 'This flight has found out that you have eliminated the request to take your package with it.';
    if (lang == 'en') {
      return 'This flight has found out that you have eliminated the request to take your package with it.';
    } else if (lang == 'es') {
      return 'Este vuelo se ha enterado que te has eliminado la solicitud de llevar tu paquete con el.';
    } else {
      return 'This flight has found out that you have eliminated the request to take your package with it.';
    }
  }

  String requestReceivedAd(String cityDestinationAirport) {
      // return 'You have received a request for a flight to "$cityDestinationAirport".';
    if (lang == 'en') {
      return 'You have received a request for a flight to "$cityDestinationAirport".';
    } else if (lang == 'es') {
      return 'Has recibido una solicitud de un vuelo con destino a "$cityDestinationAirport".';
    } else {
      return 'You have received a request for a flight to "$cityDestinationAirport".';
    }
  }

  String requestReceivedFlight() {
      // return 'This flight has received your package transport request.';
    if (lang == 'en') {
      return 'This flight has received your package transport request.';
    } else if (lang == 'es') {
      return 'Este vuelo ha recibido tu solicitud de transporte de paquete.';
    } else {
      return 'This flight has received your package transport request.';
    }
  }

  String requestRejectedAd() {
      // return 'You have rejected the request for this flight to carry your package.';
    if (lang == 'en') {
      return 'You have rejected the request for this flight to carry your package.';
    } else if (lang == 'es') {
      return 'Has rechazado la solicitud de este vuelo para llevar tu paquete.';
    } else {
      return 'You have rejected the request for this flight to carry your package.';
    }
  }

  String requestRejectedFlight() {
      // return 'This flight has rejected your request, you can reapply.';
    if (lang == 'en') {
      return 'This flight has rejected your request, you can reapply.';
    } else if (lang == 'es') {
      return 'Este vuelo ha rechazado tu solicitud, puedes volver a solicitar.';
    } else {
      return 'This flight has rejected your request, you can reapply.';
    }
  }

  String requestAcceptedAd() {
      // return 'You have accepted the request that this flight has made, go to the detail to proceed with the payment.';
    if (lang == 'en') {
      return 'You have accepted the request that this flight has made, go to the detail to proceed with the payment.';
    } else if (lang == 'es') {
      return 'Has aceptado la solicitud que este vuelo te ha hecho, ve al detalle para proceder al pago.';
    } else {
      return 'You have accepted the request that this flight has made, go to the detail to proceed with the payment.';
    }
  }

  String requestAcceptedFlight() {
      // return 'This flight has accepted your request, go to the detail to proceed with the payment.';
    if (lang == 'en') {
      return 'This flight has accepted your request, go to the detail to proceed with the payment.';
    } else if (lang == 'es') {
      return 'Este vuelo ha aceptado tu solicitud, ve al detalle para proceder al pago.';
    } else {
      return 'This flight has accepted your request, go to the detail to proceed with the payment.';
    }
  }

  String requestPaidAd() {
      // return 'Your package is ready to be transported.';
    if (lang == 'en') {
      return 'Your package is ready to be transported.';
    } else if (lang == 'es') {
      return 'Tu paquete está listo para ser transportado.';
    } else {
      return 'Your package is ready to be transported.';
    }
  }

  String requestPaidFlight() {
      // return 'The flight is ready to transport your package.';
    if (lang == 'en') {
      return 'The flight is ready to transport your package.';
    } else if (lang == 'es') {
      return 'El vuelo está listo para transportar tu paquete.';
    } else {
      return 'The flight is ready to transport your package.';
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



    // **************************************************************************************
  // **************************************************************************************
  // **************************************************************************************
  // **************************************************************************************


    String aceptRequest() {
        // return 'Accept this request';
      if (lang == 'en') {
        return 'Accept this request';
      } else if (lang == 'es') {
        return 'Aceptar esta solicitud';
      } else {
        return 'Accept this request';
      }
   }

    String rejectRequest() {
        // return 'Reject this request';
      if (lang == 'en') {
        return 'Reject this request';
      } else if (lang == 'es') {
        return 'Rechazar esta solicitud';
      } else {
        return 'Reject this request';
      }
   }

    String makeThePayment() {
        // return 'Make the payment of the service';
      if (lang == 'en') {
        return 'Make the payment of the service';
      } else if (lang == 'es') {
        return 'Realizar el pago del servicio';
      } else {
        return 'Make the payment of the service';
      }
   }

    String seeDeliveryStatus() {
        // return 'See delivery status';
      if (lang == 'en') {
        return 'See delivery status';
      } else if (lang == 'es') {
        return 'Ver estado de la entrega';
      } else {
        return 'See delivery status';
      }
   }

    String undoRequestSubmission() {
        // return 'Undo request submission';
      if (lang == 'en') {
        return 'Undo request submission';
      } else if (lang == 'es') {
        return 'Deshacer envío de solicitud';
      } else {
        return 'Undo request submission';
      }
   }

    String requestSent() {
        // return 'Request sent';
      if (lang == 'en') {
        return 'Request sent';
      } else if (lang == 'es') {
        return 'Solicitud enviada';
      } else {
        return 'Request sent';
      }
   }
    String youHaveNoFlightsCreated() {
        // return 'You have no flights created';
      if (lang == 'en') {
        return 'You have no flights created';
      } else if (lang == 'es') {
        return 'No tienes vuelos creados';
      } else {
        return 'You have no flights created';
      }
   }

}

MatchAdText matchAdText = MatchAdText();
