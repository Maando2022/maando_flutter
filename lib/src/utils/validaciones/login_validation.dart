// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/textos/login_text.dart';

class LoginValidation {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if (regExp.hasMatch(email) || email.trim().length <= 0) {
      sink.add(email);
    } else {
      sink.addError(loginText.emailIsNotCorrect());
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.trim().length >= 6) {
      sink.add(password);
    } else {
      sink.addError(
          loginText.enterMinimumCharactersTakes() + password.length.toString());
    }
  });
}