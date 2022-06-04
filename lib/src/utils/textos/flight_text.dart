// @dart=2.9
import 'dart:io';

class FlightText {
  String lang = Platform.localeName.substring(0, 2);

  String publishFlight() {
      // return 'Publish flight';
    if (lang == 'en') {
      return 'Publish flight';
    } else if (lang == 'es') {
      return 'Publicar vuelo';
    } else {
      return 'Publish flight';
    }
  }

  String numberFlight() {
      // return 'Flight number';
    if (lang == 'en') {
      return 'Flight number';
    } else if (lang == 'es') {
      return 'Número de vuelo';
    } else {
      return 'Flight number';
    }
  }

  String cityDepartureAirport() {
      // return 'Departure airport';
    if (lang == 'en') {
      return 'Departure airport';
    } else if (lang == 'es') {
      return 'Aeropuerto de salida';
    } else {
      return 'Departure airport';
    }
  }

  String cityDestinationeAirport() {
      // return 'City/Destination airport';
    if (lang == 'en') {
      return 'Arrival airport';
    } else if (lang == 'es') {
      return 'Aeropuerto de destino';
    } else {
      return 'Arrival airport';
    }
  }

  String departureDate() {
      // return 'Departure date';
    if (lang == 'en') {
      return 'Departure date';
    } else if (lang == 'es') {
      return 'Fecha de salida';
    } else {
      return 'Departure date';
    }
  }

  String arrivailDate() {
      // return 'Arrival date';
    if (lang == 'en') {
      return 'Arrival date';
    } else if (lang == 'es') {
      return 'Fecha de llegada';
    } else {
      return 'Arrival date';
    }
  }

  String reservationCode() {
      // return 'Reservation code';
    if (lang == 'en') {
      return 'Reservation code';
    } else if (lang == 'es') {
      return 'Código de reservación';
    } else {
      return 'Reservation code';
    }
  }

  String itIsNotValidFlightNumber() {
      // return 'It is not a valid flight number';
    if (lang == 'en') {
      return 'It is not a valid flight number';
    } else if (lang == 'es') {
      return 'No es un número de vuelo válido';
    } else {
      return 'It is not a valid flight number';
    }
  }

  String itIsNotValidReservationCode() {
      // return 'It is not a valid reservation code';
    if (lang == 'en') {
      return 'It is not a valid reservation code';
    } else if (lang == 'es') {
      return 'No es un código de reserva válido';
    } else {
      return 'It is not a valid reservation code';
    }
  }

  String pleaseConfirmProvidesFlightInfo() {
      // return 'Please confirm provided flight info.';
    if (lang == 'en') {
      return 'Please confirm provided flight info.';
    } else if (lang == 'es') {
      return 'Confirme la información de vuelo proporcionada.';
    } else {
      return 'Please confirm provided flight info.';
    }
  }

  String specialService() {
      // return 'Special Service';
    if (lang == 'en') {
      return 'Service price';
    } else if (lang == 'es') {
      return 'Servicio Especial';
    } else {
      return 'Special Service';
    }
  }

  String flightReadyForPublish() {
      // return 'Flight ready for publish';
    if (lang == 'en') {
      return 'Flight ready for publish';
    } else if (lang == 'es') {
      return 'Vuelo listo para publicar';
    } else {
      return 'Flight ready for publish';
    }
  }

  String chosseTheTypeOfService() {
      // return 'Choose the type of service to protect yourself';
    if (lang == 'en') {
      return 'Choose the type of service to protect yourself';
    } else if (lang == 'es') {
      return 'Elija el tipo de servicio para protegerse';
    } else {
      return 'Choose the type of service to protect yourself';
    }
  }


  String theAreTheLuggagesAllowed() {
      // return 'These are the luggages allowed to bring according to your flight ticket info.';
    if (lang == 'en') {
      return 'These are the luggages allowed to bring according to your flight ticket info.';
    } else if (lang == 'es') {
      return 'Estos son los equipajes permitidos de acuerdo con la información de su boleto de vuelo.';
    } else {
      return 'These are the luggages allowed to bring according to your flight ticket info.';
    }
  }

  String chooseTheTypeOfInsurance() {
      // return 'Choose the type of insurance to protect your package';
    if (lang == 'en') {
      return 'Choose the type of insurance to protect your package';
    } else if (lang == 'es') {
      return 'Elija el tipo de seguro para proteger su paquete';
    } else {
      return 'Choose the type of insurance to protect your package';
    }
  }

  String yourFlightHasBeenSuccefully() {
      // return 'Your flight has been \n successfully published!';
    if (lang == 'en') {
      return 'Your flight has been \n successfully published!';
    } else if (lang == 'es') {
      return '¡Tu vuelo ha sido publicado correctamente!';
    } else {
      return 'Your flight has been \n successfully published!';
    }
  }

  String shareFlight() {
      // return 'Share flight';
    if (lang == 'en') {
      return 'Share flight';
    } else if (lang == 'es') {
      return 'Compartir vuelo';
    } else {
      return 'Share flight';
    }
  }

  String findShipmentsMatches() {
      // return 'Find shipments matches';
    if (lang == 'en') {
      return 'Find shipments matches';
    } else if (lang == 'es') {
      return 'Encuentra coincidencias de envíos';
    } else {
      return 'Find shipments matches';
    }
  }

  String goToFlight() {
      // return 'Go to taking';
    if (lang == 'en') {
      return 'Go to taking';
    } else if (lang == 'es') {
      return 'Ir a vuelos';
    } else {
      return 'Go to taking';
    }
  }
}

FlightText flightText = FlightText();
