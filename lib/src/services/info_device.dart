// @dart=2.9
import 'dart:convert';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';

class InfoDevice {
  Http _http = Http();
  final preference = Preferencias();

  obtenerInfoDevice() async {
    _http
        .register(deviceId: preference.prefsInternal.get('email'))
        .then((value) {
      // _http.register(deviceId: '12345').then((value) {
      final valueMap = json.decode(value);
      blocGeneral.changeRegiterDevice(valueMap);
      if (valueMap["error"] == true) {
        print('Error al mostrar el numero de registro');
      } else {
        print('Registro numero  ${valueMap["data"]["numberRegister"]}');
      }
    });
  }
}

InfoDevice infoDevice = InfoDevice();
