// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/validaciones/flight_validation.dart';
import 'package:rxdart/rxdart.dart';

class FlightFormBloc with FlightValidation {
  var _auxController = BehaviorSubject<String>();
  var _cityDepartureController = BehaviorSubject<String>();
  var _cityDestinationController = BehaviorSubject<String>();
  var _dateTimeDepartureController = BehaviorSubject<DateTime>();
  var _dateTimeDestinationController = BehaviorSubject<DateTime>();
  var _flightNumberController = BehaviorSubject<String>();
  var _reservationCodeController = BehaviorSubject<String>();
  var _typePackageCompactController = BehaviorSubject<bool>();
  var _typePackageHandybagController = BehaviorSubject<bool>();
  var _listElementsCompactController = BehaviorSubject<List<dynamic>>();
  var _listElementsHandybagController = BehaviorSubject<List<dynamic>>();
  var _insuranceController = BehaviorSubject<String>();

  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get auxStream => _auxController.stream.transform(validarCityAirport);
  // -----------------
  Stream<String> get cityDepartureStream => _cityDepartureController.stream.transform(validarCityAirport);
  // -----------------
  Stream<String> get cityDestinationStream => _cityDestinationController.stream.transform(validarCityAirport);
  //  -----------------
  Stream<DateTime> get dateTimeDepartureStream => _dateTimeDepartureController.stream.transform(validarFecha);
  // -----------------
  Stream<DateTime> get dateTimeDestinationStream => _dateTimeDestinationController.stream.transform(validarFecha);
  // -----------------
  Stream<String> get flightNumberStream => _flightNumberController.stream.transform(validarNumeroVuelo);
  // -----------------
  Stream<String> get reservationCodeStream => _reservationCodeController.stream.transform(validarReservationCode);
  // -----------------
  Stream<bool> get typePackageCompactStream => _typePackageCompactController.stream;
  // -----------------
  Stream<bool> get typePackageHandybagStream => _typePackageHandybagController.stream;
  // -----------------
  Stream<List<dynamic>> get listElementsCompactStream => _listElementsCompactController.stream;
  Stream<List<dynamic>> get listElementsHandybagStream =>  _listElementsHandybagController.stream;
  Stream<String> get insuranceStream => _insuranceController.stream;
  Stream<bool> get formValidarStream => CombineLatestStream.combine6(cityDepartureStream, cityDestinationStream, dateTimeDepartureStream, dateTimeDestinationStream, flightNumberStream, reservationCodeStream, (cdep, cdes, dtdep, dtdes, fn, rc) => true);

  //  INSERTAR VALORES AL STREAM  ==================================================================================================
  Function(String) get changeAux => _auxController.sink.add;
  Function(String) get changeCityDeparture => _cityDepartureController.sink.add;
  Function(String) get changeCityDestination => _cityDestinationController.sink.add;
  Function(DateTime) get changeDateTimeDeparture => _dateTimeDepartureController.sink.add;
  Function(DateTime) get changeDateTimeDestination => _dateTimeDestinationController.sink.add;
  Function(String) get changeflightNumber => _flightNumberController.sink.add;
  Function(String) get changeReservationCode => _reservationCodeController.sink.add;
  Function(bool) get changeTypePackageCompact => _typePackageCompactController.sink.add;
  Function(bool) get changeTypePackageHandybag => _typePackageHandybagController.sink.add;
  Function(List<dynamic>) get changeListElementsCompact => _listElementsCompactController.sink.add;
  Function(List<dynamic>) get changeListElementsHandybag => _listElementsHandybagController.sink.add;
  Function(String) get changeInsurance => _insuranceController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD =====================================================================================
  String get aux => _auxController.value;
  String get cityDeparture => _cityDepartureController.value;
  String get cityDestination => _cityDestinationController.value;
  DateTime get dateTimeDeparture => _dateTimeDepartureController.value;
  DateTime get dateTimeDestination => _dateTimeDestinationController.value;
  String get flightNumber => _flightNumberController.value;
  String get reservationCode => _reservationCodeController.value;
  bool get typePackageCompact => _typePackageCompactController.value;
  bool get typePackageHandybag => _typePackageHandybagController.value;
  List<dynamic> get listElementsCompact => _listElementsCompactController.value;
  List<dynamic> get listElementsHandybag => _listElementsHandybagController.value;
  String get insurance => _insuranceController.value;


 // HASVALUE 
 bool get auxStreamValue => _auxController.stream.hasValue;
 bool get cityDepartureStreamValue => _cityDepartureController.stream.hasValue;
 bool get cityDestinationStreamValue => _cityDestinationController.stream.hasValue;
 bool get dateTimeDepartureStreamValue => _dateTimeDepartureController.stream.hasValue;
 bool get dateTimeDestinationStreamValue => _dateTimeDestinationController.stream.hasValue;
 bool get flightNumberStreamValue => _flightNumberController.stream.hasValue;
 bool get reservationCodeStreamValue => _reservationCodeController.stream.hasValue;
 bool get typePackageCompactStreamValue => _typePackageCompactController.stream.hasValue;
 bool get typePackageHandybagStreamValue => _typePackageHandybagController.stream.hasValue;
 bool get listElementsCompactStreamValue => _listElementsCompactController.stream.hasValue;
 bool get listElementsHandybagStreamValue => _listElementsHandybagController.stream.hasValue;
 bool get insuranceStreamValue => _insuranceController.stream.hasValue;


  dispose() {
    _auxController?.close();
    _cityDepartureController?.close();
    _cityDestinationController?.close();
    _dateTimeDepartureController?.close();
    _dateTimeDestinationController?.close();
    _flightNumberController?.close();
    _reservationCodeController?.close();
    _typePackageCompactController?.close();
    _typePackageHandybagController?.close();
    _listElementsCompactController?.close();
    _listElementsHandybagController?.close();
    _insuranceController?.close();
  }

  streamNull() {
    _auxController = BehaviorSubject<String>();
    _cityDepartureController = BehaviorSubject<String>();
    _cityDestinationController = BehaviorSubject<String>();
    _dateTimeDepartureController = BehaviorSubject<DateTime>();
    _dateTimeDestinationController = BehaviorSubject<DateTime>();
    _flightNumberController = BehaviorSubject<String>();
    _reservationCodeController = BehaviorSubject<String>();
    _typePackageCompactController = BehaviorSubject<bool>();
    _typePackageHandybagController = BehaviorSubject<bool>();
    _listElementsCompactController = BehaviorSubject<List<dynamic>>();
    _listElementsHandybagController = BehaviorSubject<List<dynamic>>();
    _insuranceController = BehaviorSubject<String>();
  }
}

FlightFormBloc flightFromBloc = FlightFormBloc();
