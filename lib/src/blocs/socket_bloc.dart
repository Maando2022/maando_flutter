// @dart=2.9
import 'dart:async';
import 'package:maando/src/services/socket_io.dart';
import 'package:rxdart/rxdart.dart';

class SocketsBloc {
  final  _socketController = BehaviorSubject<SocketService>();
  final  _userController = BehaviorSubject<Map<String, dynamic>>();



  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<SocketService > get socketStream => _socketController.stream;
  Stream<Map<String, dynamic>> get userStream => _userController.stream;


  //  INSERTAR VALORES AL STREAM
  Function(SocketService ) get changeSocket => _socketController.sink.add;
  Function(Map<String, dynamic>) get changeUser => _userController.sink.add;


  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  SocketService get socket => _socketController.value;
  Map<String, dynamic> get user => _userController.value;


  dispose() {
    _socketController?.close();
    _userController?.close();
  }
}

SocketsBloc blocSocket = SocketsBloc();
