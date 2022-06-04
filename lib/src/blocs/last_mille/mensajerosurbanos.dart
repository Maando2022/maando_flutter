// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MensajerosurbanosBloc {
  var _deliveryAddressDivision1Controller = BehaviorSubject<dynamic>(); 


  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<dynamic> get deliveryAdrressDivision1Stream => _deliveryAddressDivision1Controller.stream;



  //  INSERTAR VALORES AL STREAM
  Function(dynamic) get changeDeliveryAdrressDivision1 => _deliveryAddressDivision1Controller.sink.add;



  // OBTENER LOS VALORES
    dynamic get deliveryAddressDivision1 => _deliveryAddressDivision1Controller.value;




  streamNull() {
      _deliveryAddressDivision1Controller = BehaviorSubject<dynamic>();

  }

  dispose() {
    _deliveryAddressDivision1Controller?.close();

  }
}

MensajerosurbanosBloc mensajerosurbanosBloc = MensajerosurbanosBloc();
