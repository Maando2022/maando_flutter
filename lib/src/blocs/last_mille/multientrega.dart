// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class MultientregaBloc {
  var _deliveryAddressDivision1Controller = BehaviorSubject<dynamic>(); 
  var _deliveryAddressDivision2Controller = BehaviorSubject<dynamic>(); 
  var _deliveryAddressDivision3Controller = BehaviorSubject<dynamic>(); 
  var _deliveryAddressDivision4Controller = BehaviorSubject<dynamic>(); 

  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<dynamic> get deliveryAdrressDivision1Stream => _deliveryAddressDivision1Controller.stream;
  Stream<dynamic> get deliveryAdrressDivision2Stream => _deliveryAddressDivision2Controller.stream;
  Stream<dynamic> get deliveryAdrressDivision3Stream => _deliveryAddressDivision3Controller.stream;
  Stream<dynamic> get deliveryAdrressDivision4Stream => _deliveryAddressDivision4Controller.stream;


  //  INSERTAR VALORES AL STREAM
  Function(dynamic) get changeDeliveryAdrressDivision1 => _deliveryAddressDivision1Controller.sink.add;
  Function(dynamic) get changeDeliveryAdrressDivision2 => _deliveryAddressDivision2Controller.sink.add;
  Function(dynamic) get changeDeliveryAdrressDivision3 => _deliveryAddressDivision3Controller.sink.add;
  Function(dynamic) get changeDeliveryAdrressDivision4 => _deliveryAddressDivision4Controller.sink.add;


  // OBTENER LOS VALORES
    dynamic get deliveryAddressDivision1 => _deliveryAddressDivision1Controller.value;
    dynamic get deliveryAddressDivision2 => _deliveryAddressDivision2Controller.value;
    dynamic get deliveryAddressDivision3 => _deliveryAddressDivision3Controller.value;
    dynamic get deliveryAddressDivision4 => _deliveryAddressDivision4Controller.value;



  streamNull() {
      _deliveryAddressDivision1Controller = BehaviorSubject<dynamic>();
      _deliveryAddressDivision2Controller = BehaviorSubject<dynamic>();
      _deliveryAddressDivision3Controller = BehaviorSubject<dynamic>();
      _deliveryAddressDivision4Controller = BehaviorSubject<dynamic>();
  }

  dispose() {
    _deliveryAddressDivision1Controller?.close();
    _deliveryAddressDivision2Controller?.close();
    _deliveryAddressDivision3Controller?.close();
    _deliveryAddressDivision4Controller?.close();
  }
}

MultientregaBloc multientregaBloc = MultientregaBloc();
