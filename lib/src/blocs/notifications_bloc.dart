// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';

class NotificationsBloc {
  final  _tokenNotificationController = BehaviorSubject<String>();
  final  _pageController = BehaviorSubject<String>();


  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get tokenNotificationStream => _tokenNotificationController.stream;
  Stream<String> get pageStream => _pageController.stream;

  //  INSERTAR VALORES AL STREAM
  Function(String) get changeTokenNotification=> _tokenNotificationController.sink.add;
  Function(String) get changePage => _pageController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get tokenNotification => _tokenNotificationController.value;
  String get page => _pageController.value;


  dispose() {
    _tokenNotificationController?.close();
    _pageController?.close();
  }
}

NotificationsBloc blocNotifications = NotificationsBloc();
