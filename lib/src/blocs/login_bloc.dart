// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/validaciones/login_validation.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with LoginValidation {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);

  Stream<bool> get formValidarStream =>
      CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true);

  //  INSERTAR VALORES AL STREAM
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get email => _emailController.value;
  String get password => _passwordController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
  }

  streamNull() {
    _emailController.sink.add('');
    _passwordController.sink.add('');
  }
}

LoginBloc blocLogin = LoginBloc();
