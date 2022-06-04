import 'package:intl/intl.dart';

// DateFormat.jm().format(DateTime.parse(bloc.fechaHoraLlegada.toString()))   12:00 AM
// '${DateFormat().add_jm().format(DateTime.parse(bloc.fechaHoraLlegada.toString()))}',12:00 AM
// Text(DateFormat().add_Hm().format(departureDT) 12:00
// '${DateFormat("a").format(bloc.fechaHoraLlegada)}'  AM
// https://api.flutter.dev/flutter/intl/DateFormat-class.html

String formatearfecha(DateTime date) {
  return '${DateFormat.E().format(date)}, ${DateFormat.d().format(date)} ${DateFormat.LLL().add_jm().format(date)}';
}

String formatearfechaDateTime(String date) {
  return '${DateFormat.E().format(DateTime.parse(date))}, ${DateFormat.d().format(DateTime.parse(date))} ${DateFormat.LLL().add_jm().format(DateTime.parse(date))}';
}

DateTime convertirStringToDateTime(String fecha) {
  return DateTime.parse(fecha);
}

DateTime convertirMilliSecondsToDateTime(int fecha) {
  return DateTime.fromMillisecondsSinceEpoch(fecha);
}

bool rango2horasAntesDespues(String fechaFlight, String fechaAComparar) {
  if (DateTime.parse(fechaAComparar)
              .difference(
                  DateTime.parse(fechaFlight).subtract(Duration(hours: 2)))
              .inHours >=
          0 &&
      DateTime.parse(fechaAComparar)
              .difference(DateTime.parse(fechaFlight).add(Duration(hours: 2)))
              .inHours <=
          0) {
    // print('FECHA1  ==A> $fechaFlight');
    // print('FECHA2  ==A> $fechaAComparar');
    return true;
  } else {
    // print('FECHA1  ==A> $fechaFlight');
    // print('FECHA2  ==A> $fechaAComparar');
    return false;
  }
}

Map<String, dynamic> obtenerTiempoDePublicacion(String fechaMilisegundo){
  DateTime ahora = DateTime.now();
  DateTime fechaPost = DateTime.fromMillisecondsSinceEpoch(int.parse(fechaMilisegundo));

  var diference = ahora.difference(fechaPost);

  if(diference.inSeconds <= 60){
    return {'number': diference.inSeconds, 'time': 's'};
  }else if(diference.inSeconds >= 60 && diference.inSeconds <= 3600){
    return {'number': diference.inMinutes, 'time': 'm'};
  }else if(diference.inSeconds >= 3600 && diference.inSeconds <= 86400){
    return {'number': diference.inHours, 'time': 'h'};
  }else{
    return {'number': diference.inDays, 'time': 'd'};
  }

}