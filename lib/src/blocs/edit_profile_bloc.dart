// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/validaciones/create_account_validation.dart';
import 'package:rxdart/rxdart.dart';

class EditProfileBloc with CreateAccountValidation {
  final _fullNameController = BehaviorSubject<String>();
  final _emailController = BehaviorSubject<String>();
  final _phoneController = BehaviorSubject<String>();
  final _countryController = BehaviorSubject<String>();
  final _cityController = BehaviorSubject<String>();
  final _payMethodController = BehaviorSubject<String>();  // paypal, stripe
  final _accountNumberController = BehaviorSubject<String>(); // Solo para Stripe
  final _typeAccountController = BehaviorSubject<Map<String, dynamic>>(); // Solo para Stripe (savings, current)  (Es un Map con el code y el value)
  final _bankController = BehaviorSubject<String>(); // Solo para Stripe
  final _bicController = BehaviorSubject<String>(); // Solo para Stripe (código de identificación bancaria)
  final _ibanController = BehaviorSubject<String>(); // Solo para Stripe (código internacional de la cuenta)
  final _accountPaypalController = BehaviorSubject<String>(); // Solo para Paypal

  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get fullNameStream =>
      _fullNameController.stream.transform(validarFullName);
  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get phoneStream =>
      _phoneController.stream.transform(validarPhone);
  Stream<String> get countryStream => _countryController.stream.transform(validarCountryCity);
  Stream<String> get cityStream => _cityController.stream.transform(validarCountryCity);
  Stream<String> get payMethodStream => _payMethodController.stream;
  Stream<String> get accountNumberStream => _accountNumberController.stream.transform(validarPhone);
  Stream<Map<String, dynamic>> get typeAccountStream => _typeAccountController.stream;
  Stream<String> get bankStream => _bankController.stream;
  Stream<String> get bicStream => _bicController.stream;
  Stream<String> get ibanStream => _ibanController.stream;
    Stream<bool> get formValidarStripeStream => CombineLatestStream.combine5(accountNumberStream, typeAccountStream, bankStream, bicStream, ibanStream, (a, t, b, bic, iban) => true);
  Stream<String> get accountPaypalStream => _accountPaypalController.stream.transform(validarEmail);



  //  INSERTAR VALORES AL STREAM
  Function(String) get changeFullName => _fullNameController.sink.add;
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePhone => _phoneController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changePayMethod => _payMethodController.sink.add;
  Function(String) get changeAccountnumber => _accountNumberController.sink.add;
  Function(Map<String, dynamic>) get changeTypeAccount => _typeAccountController.sink.add;
  Function(String) get changeBank => _bankController.sink.add;
  Function(String) get changeBic => _bicController.sink.add;
  Function(String) get changeIban => _ibanController.sink.add;
  Function(String) get changeAccountPaypal => _accountPaypalController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get fullName => _fullNameController.value;
  String get email => _emailController.value;
  String get phone => _phoneController.value;
  String get country => _countryController.value;
  String get city => _cityController.value;
  String get payMethod => _payMethodController.value;
  String get accountNumber => _accountNumberController.value;
  Map<String, dynamic> get typeAccount => _typeAccountController.value;
  String get bank => _bankController.value;
  String get bic => _bicController.value;
  String get iban => _ibanController.value;
  String get accountPaypal => _accountPaypalController.value;


  // HASVALUE
  bool get accountPaypalStreamValue => _accountPaypalController.stream.hasValue;

  dispose() {
    _fullNameController?.close();
    _emailController?.close();
    _phoneController?.close();
    _countryController?.close();
    _cityController?.close();
    _payMethodController?.close();
    _payMethodController?.close();
    _accountNumberController?.close();
    _typeAccountController?.close();
    _bankController?.close();
    _bicController?.close();
    _ibanController?.close();
    _accountPaypalController?.close();
  }
}


EditProfileBloc blocEditProfile = EditProfileBloc();
