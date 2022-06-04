// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class AdminBloc{
  final  _tapController = BehaviorSubject<int>();
  final  _usuersController = BehaviorSubject<List<dynamic>>();
  final  _searchUserController = BehaviorSubject<String>();
  final  _searchTripController = BehaviorSubject<String>();
  final  _searchPackageController = BehaviorSubject<String>();
  final  _searchStoreController = BehaviorSubject<String>();
  final  _paymentController = BehaviorSubject<dynamic>();
  final  _paymentssController = BehaviorSubject<List<dynamic>>();
  final  _flightsController = BehaviorSubject<List<dynamic>>();
  final  _usuerController = BehaviorSubject<dynamic>();
  final  _totalUsersController = BehaviorSubject<int>();
  final  _adController = BehaviorSubject<dynamic>();
  final  _flightController = BehaviorSubject<dynamic>();
  final  _matchController = BehaviorSubject<dynamic>();





  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<int> get tapStream => _tapController.stream;
  Stream<List<dynamic>> get usersStream => _usuersController.stream;
  Stream<String> get searchUserStream => _searchUserController.stream;
  Stream<String> get searchTripStream => _searchTripController.stream;
  Stream<String> get searchPackageStream => _searchPackageController.stream;
  Stream<String> get searchStoreStream => _searchStoreController.stream;
  Stream<dynamic> get paymentStream => _paymentController.stream;
  Stream<List<dynamic>> get paymentsStream => _paymentssController.stream;
  Stream<List<dynamic>> get flightsStream => _flightsController.stream;
  Stream<dynamic> get userStream => _usuerController.stream;
  Stream<int> get totalUsersStream => _totalUsersController.stream;
  Stream<dynamic> get adStream => _adController.stream;
  Stream<dynamic> get flightStream => _flightController.stream;
  Stream<dynamic> get matchStream => _matchController.stream;



  //  INSERTAR VALORES AL STREAM
  Function(int) get changeTap => _tapController.sink.add;
  Function(List<dynamic>) get changeUsers => _usuersController.sink.add;
  Function(String) get changeSearchUser => _searchUserController.sink.add;
  Function(String) get changeSearchTrip => _searchTripController.sink.add;
  Function(String) get changeSearchPackage => _searchPackageController.sink.add;
  Function(String) get changeSearchStore => _searchStoreController.sink.add;
  Function(dynamic) get changePayment => _paymentController.sink.add;
  Function(List<dynamic>) get changePayments => _paymentssController.sink.add;
  Function(List<dynamic>) get changeFlights => _flightsController.sink.add;
  Function(dynamic) get changeUser => _usuerController.sink.add;
  Function(int) get changeTotalUsers => _totalUsersController.sink.add;
  Function(dynamic) get changeAd => _adController.sink.add;
  Function(dynamic) get changeFlight => _flightController.sink.add;
  Function(dynamic) get changeMatch => _matchController.sink.add;

  


  // OBTENER LOS VALORES 
  int get tap => _tapController.value;
  List<dynamic> get users => _usuersController.value;
  String get searchUser => _searchUserController.value;
  String get searchTrip => _searchTripController.value;
  String get searchPackage => _searchPackageController.value;
  String get searchStore => _searchStoreController.value;
  dynamic get payment => _paymentController.value;
  List<dynamic> get payments => _paymentssController.value;
  List<dynamic> get flights => _flightsController.value;
  dynamic get user => _usuerController.value;
  int get totaUsers => _totalUsersController.value;
  dynamic get ad => _adController.value;
  dynamic get flight => _flightController.value;
  dynamic get match => _matchController.value;

// HASVALUE 
    bool get tapStreamValue => _tapController.stream.hasValue;
    bool get usersStreamValue => _usuersController.stream.hasValue;
    bool get searchUserStreamValue => _searchUserController.stream.hasValue;
    bool get searchTripStreamValue => _searchTripController.stream.hasValue;
    bool get searchPackageStreamValue => _searchPackageController.stream.hasValue;
    bool get searchStoreStreamValue => _searchStoreController.stream.hasValue;
    bool get paymentStreamValue => _paymentController.stream.hasValue;
    bool get paymentsStreamValue => _paymentssController.stream.hasValue;
    bool get flightsStreamValue => _flightsController.stream.hasValue;
    bool get userStreamValue => _usuerController.stream.hasValue;
    bool get totaUsersStreamValue => _totalUsersController.stream.hasValue;
    bool get adStreamValue => _adController.stream.hasValue;
    bool get flightStreamValue => _flightController.stream.hasValue;
    bool get matchStreamValue => _matchController.stream.hasValue;



  dispose() {
    _usuersController?.close();
    _searchUserController?.close();
    _searchTripController?.close();
    _searchPackageController?.close();
    _searchStoreController?.close();
    _paymentController?.close();
    _paymentssController?.close();
    _tapController?.close();
    _flightsController?.close();
    _usuerController?.close();
    _totalUsersController?.close();
    _adController?.close();
    _flightController?.close();
    _matchController?.close();
  }
}

AdminBloc blocAdmin = AdminBloc();
