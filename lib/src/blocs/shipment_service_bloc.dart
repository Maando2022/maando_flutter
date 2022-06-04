// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class ShipmentServiceBloc {
  final _shipmentServiceController = BehaviorSubject<List<bool>>();
  final _shipmentPublishedIntransitController = BehaviorSubject<List<bool>>();
  final _servicePublishedIntransitController = BehaviorSubject<List<bool>>();

  //  INSERTAR VALORES AL STREAM
  Function(List<bool>) get changeShipmentService =>
      _shipmentServiceController.sink.add;
  Function(List<bool>) get changeShipmentPublishedIntransit =>
      _shipmentPublishedIntransitController.sink.add;
  Function(List<bool>) get changeSesrvicePublishedIntransit =>
      _servicePublishedIntransitController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  List<bool> get shipmentService => _shipmentServiceController.value;
  List<bool> get shipmentPublishedIntransit =>
      _shipmentPublishedIntransitController.value;
  List<bool> get servicePublishedIntransit =>
      _servicePublishedIntransitController.value;

  Stream<List<bool>> get shipmentServiceStream =>
      _shipmentServiceController.stream;
  Stream<List<bool>> get shipmentPublishedIntransitStream =>
      _shipmentPublishedIntransitController.stream;
  Stream<List<bool>> get servicetPublishedIntransitStream =>
      _servicePublishedIntransitController.stream;

  dispose() {
    _shipmentServiceController?.close();
    _shipmentPublishedIntransitController?.close();
    _servicePublishedIntransitController?.close();
  }
}

final ShipmentServiceBloc blocShipmetService = ShipmentServiceBloc();
