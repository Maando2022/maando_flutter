// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/validaciones/create_account_validation.dart';
import 'package:rxdart/rxdart.dart';

class CompleteRegisterBloc with CreateAccountValidation {
  final _fullNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _cityController = BehaviorSubject<String>();

  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get fullNameStream =>
      _fullNameController.stream.transform(validarFullName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get phonedStream =>
      _phoneController.stream.transform(validarPhone);
  Stream<String> get countryStream => _countryController.stream.transform(validarCountryCity);
  Stream<String> get cityStream => _cityController.stream.transform(validarCountryCity);

  Stream<bool> get formValidarStream => CombineLatestStream.combine3(
      fullNameStream,
      emailStream,
      phonedStream,
      (fn, e, ph) => true);

  //  INSERTAR VALORES AL STREAM
  Function(String) get changeFullName => _fullNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get fullName => _fullNameController.value;
  String get email => _emailController.value;
  String get phone => _phoneController.value;
  String get country => _countryController.value;
  String get city => _cityController.value;

  dispose() {
    _fullNameController?.close();
    _emailController?.close();
    _phoneController?.close();
    _countryController?.close();
    _cityController?.close();
  }
}
