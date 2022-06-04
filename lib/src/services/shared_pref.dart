// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferencias {
  static final Preferencias _instanciaPref = new Preferencias._internal();

  factory Preferencias() {
    return _instanciaPref;
  }

  Preferencias._internal();
  SharedPreferences prefsInternal;

  obtenerPreferencias() async {
    prefsInternal = await SharedPreferences.getInstance();
  }

  saveSesion(
      {String email,
      String langCode,
      String expire,
      String lastActivity,
      String fullName,
      String city,
      String country,
      String phone,
      String provider}) async {
    prefsInternal.setString('email', email);
    prefsInternal.setString('langCode', langCode);
    prefsInternal.setString('expire', expire);
    prefsInternal.setString('expire', DateTime.now().add(Duration(hours: 1)).toString());
    prefsInternal.setString('lastActivity', lastActivity);
    prefsInternal.setString('fullName', fullName);
    prefsInternal.setString('country', country);
    prefsInternal.setString('city', city);
    prefsInternal.setString('phone', phone);
    prefsInternal.setString('provider', provider);
  }


  guardarModaLocationInTheBackground(){
    prefsInternal.setBool('modaLocationInTheBackground', true);
  }

  obtenerModaLocationInTheBackground(){
    return prefsInternal.getBool('modaLocationInTheBackground');
  }

  mostrarPreferencias() {
    print('email  --> ${prefsInternal.get("email")}');
    print('langCode  --> ${prefsInternal.get("langCode")}');
    print('expire  --> ${prefsInternal.get("expire")}');
    print('lastActivity  --> ${prefsInternal.get("lastActivity")}');
    print('city  --> ${prefsInternal.get("city")}');
    print('phone  --> ${prefsInternal.get("phone")}');
    print('fullName  --> ${prefsInternal.get("fullName")}');
  }

  guardarOnboarding(String onboarding) {
    // no-onboarding  / onboarding
    prefsInternal.setString('onboarding', onboarding);
  }

  guardarCookies(String cookies) {
    if (cookies == null || cookies == '') {
      prefsInternal.setString('cookies', 'none');
    } else {
      prefsInternal.setString('cookies', cookies);
    }
  }


  guardarToken(String token) {
    if (token == null || token == '') {
      prefsInternal.setString('token', 'none');
    } else {
      prefsInternal.setString('token', token);
    }
  }

  guardarTokenNotification(String tokenNotification) {
    if (tokenNotification == null || tokenNotification == '') {
      prefsInternal.setString('tokenNotification', 'none');
    } else {
      prefsInternal.setString('tokenNotification', tokenNotification);
    }
  }

  guardarPaginaAnterior(BuildContext context, String page) {
    prefsInternal.setString('paginaAnterior', page);
    print('La pagina anterior es ${prefsInternal.getString('paginaAnterior')}');
    Navigator.pushReplacementNamed(context, 'lost_connection');
  }

  limpiarPreferencias() async {
    // prefsInternal.clear();
    prefsInternal.remove('email');
    prefsInternal.remove('langCode');
    prefsInternal.remove('expire');
    prefsInternal.remove('lastActivity');
    prefsInternal.remove('city');
    prefsInternal.remove('phone');
    prefsInternal.remove('fullName');
    prefsInternal.remove('UIDFB');
    prefsInternal.remove('appUserUUID');
    prefsInternal.remove('Authorization');
    prefsInternal.remove('cookies');
    prefsInternal.remove('token');
    prefsInternal.remove('urlAvatar');
    prefsInternal.remove('provider');
  }

  // ************************
  // ************************

  paginaInicio() {
    print('onboarding  ${prefsInternal.get('onboarding')}');
    if (prefsInternal.get('onboarding') == 'onboarding' ||
        prefsInternal.get('onboarding') == null) {
      return 'onboarding';
    } else {
      if (prefsInternal.getString('email') == null) {
        print(
            'Ruta inicial sin loguear: onboarding ==> usuario logeado: ${prefsInternal.getString('email')}');
        return 'login';
      } else {
        print(
            'Ruta inicial losgueado: ==> usuario logeado: ${prefsInternal.getString('email')}');
        return 'principal';
      }
    }
  }
}

Preferencias prefsInternal = Preferencias();
