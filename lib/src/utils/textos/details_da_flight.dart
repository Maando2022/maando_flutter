import 'dart:io';

class DetailAdFlightText {
  String lang = Platform.localeName.substring(0, 2);

  // FLIGHT ***********************************************

  String serviceDetails() {
      // return 'Service details';
    if (lang == 'en') {
      return 'Service details';
    } else if (lang == 'es') {
      return 'Detalles del servicio';
    } else {
      return 'Service details';
    }
  }

  String takeService() {
      // return 'Take service';
    if (lang == 'en') {
      return 'Take service';
    } else if (lang == 'es') {
      return 'Tomar servicio';
    } else {
      return 'Take service';
    }
  }

  String submitPackageDeliveryRequest() {
      // return 'Submit package delivery request.';
    if (lang == 'en') {
      return 'Submit package delivery request.';
    } else if (lang == 'es') {
      return 'Enviar solicitud de envío de paquete.';
    } else {
      return 'Submit package delivery request.';
    }
  }
}

DetailAdFlightText detailAdFlifhtText = DetailAdFlightText();
