import 'dart:async';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/textos/flight_text.dart';

class FlightValidation {
  final validarReservationCode = StreamTransformer<String, String>.fromHandlers(
      handleData: (reservationCode, sink) {
    if (reservationCode.trim().length >= 3) {
      sink.add(reservationCode);
    } else {
      sink.addError(flightText.itIsNotValidReservationCode());
    }
  });
// ---------------------------------------

  final validarCityAirport = StreamTransformer<String, String>.fromHandlers(
      handleData: (airport, sink) {
    if (airport.trim().length >= 3) {
      sink.add(airport);
    } else {
      sink.addError('There is no reservation city / airport');
    }
  });

  // ---------------------------------------

  final validarFecha = StreamTransformer<DateTime, DateTime>.fromHandlers(
      handleData: (fecha, sink) {
    if (formatearfecha(fecha) != 'Departure date') {
      sink.add(fecha);
    } else {
      sink.addError('There is no departure date');
    }
  });

  // ----------------------------------------
  final validarKindOfPackage = StreamTransformer<String, String>.fromHandlers(
      handleData: (kindOfPackage, sink) {
    if (kindOfPackage.length >= 3) {
      sink.add(kindOfPackage);
    } else {
      sink.addError('Enter minimum 3 characters: takes: ' +
          kindOfPackage.length.toString());
    }
  });

  // ----------------------------------------
  final validarNumeroVuelo = StreamTransformer<String, String>.fromHandlers(
      handleData: (numeroVuelo, sink) {
    // if (isNumber(numeroVuelo)) {
    //   if (numeroVuelo.length >= 3) {
    //     sink.add(numeroVuelo);
    //   } else {
    //     sink.addError('It is not a valid flight number');
    //   }
    // } else {
    //   sink.addError('Only numbers');
    // }

    if (numeroVuelo.trim().length >= 3) {
      sink.add(numeroVuelo);
    } else {
      sink.addError(flightText.itIsNotValidFlightNumber());
    }
  });

  static bool isNumber(String p) {
    if (p.isEmpty) return false;
    final n = num.tryParse(p);

    return (n == null) ? false : true;
  }
}