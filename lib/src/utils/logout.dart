import 'package:maando/src/services/loginFacebook.dart';
import 'package:maando/src/services/loginGoogle.dart';
import 'package:maando/src/services/shared_pref.dart';

logout() {
  final preference = Preferencias();
  handleSignOutGoogle();
  logOutFacebook();
  preference.obtenerPreferencias();
  preference.limpiarPreferencias();
}
