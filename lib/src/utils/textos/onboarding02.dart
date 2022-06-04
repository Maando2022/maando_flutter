import 'dart:io';


class Onboarding02Text {
  String lang = Platform.localeName.substring(0, 2);

  String titulo_1() {
     //  return 'Together, we all win.';
    if (lang == 'en') {
      return 'Together, we all win.';
    } else if (lang == 'es') {
      return 'Juntos, todos ganamos';
    } else {
      return 'Together, we all win.';
    }
  }

  String subtitulo_1() {
      // return 'Get paid anywhere you go.';
    if (lang == 'en') {
      return 'Get paid anywhere you go.';
    } else if (lang == 'es') {
      return 'Reciba pagos donde quiera que vaya.';
    } else {
      return 'Get paid anywhere you go.';
    }
  }

  String subtitulo_2() {
      // return 'Shipments in record time.';
    if (lang == 'en') {
      return 'Shipments in record time.';
    } else if (lang == 'es') {
      return 'Envíos en tiempo record.';
    } else {
      return 'Shipments in record time.';
    }
  }

  String pregunta_01() {
      // return "What's your Ad title ?";
    if (lang == 'en') {
      return "What's your Ad title ?";
    } else if (lang == 'es') {
      return 'Cuál es el título de su anuncio ?';
    } else {
      return "What's your Ad title ";
    }
  }

  String error_01() {
     //  return 'There is no title';
    if (lang == 'en') {
      return 'There is no title';
    } else if (lang == 'es') {
      return 'No hay titulo';
    } else {
      return 'There is no title';
    }
  }

  String createAd() {
      // return 'Create an ad';
    if (lang == 'en') {
      return 'Create an ad';
    } else if (lang == 'es') {
      return 'Crear un anuncio';
    } else {
      return 'Create an ad';
    }
  }

  String dateAndtimeAnddestination() {
     //  return 'Date, time & destination';
    if (lang == 'en') {
      return 'Date, time & destination';
    } else if (lang == 'es') {
      return 'Fecha, hora y destino';
    } else {
      return 'Date, time & destination';
    }
  }

  String photos() {
     //  return 'photos';
    if (lang == 'en') {
      return 'photos';
    } else if (lang == 'es') {
      return 'Fotos';
    } else {
      return 'photos';
    }
  }

  String country() {
     //  return 'Country';
    if (lang == 'en') {
      return 'Country';
    } else if (lang == 'es') {
      return 'País';
    } else {
      return 'Country';
    }
  }

  String city() {
     //  return 'City';
    if (lang == 'en') {
      return 'City';
    } else if (lang == 'es') {
      return 'Ciudad';
    } else {
      return 'City';
    }
  }

  String dateAndtimeDestinationPackages() {
      // return 'Date, time and destination for package delivery?';
    if (lang == 'en') {
      return 'Date, time and destination for package delivery?';
    } else if (lang == 'es') {
      return '¿Fecha, hora y destino para la entrega del paquete?';
    } else {
      return 'Date, time and destination for package delivery?';
    }
  }

  String thePackageIsDeliveredAtTheLocal() {
      // return 'The package is delivered at the local time of the destination.';
    if (lang == 'en') {
      return 'The package is delivered at the local time of the destination.';
    } else if (lang == 'es') {
      return 'El paquete se entrega a la hora local del destino.';
    } else {
      return 'The package is delivered at the local time of the destination.';
    }
  }

  String thereIsNoDate() {
     //  return 'There is no date';
    if (lang == 'en') {
      return 'There is no date';
    } else if (lang == 'es') {
      return 'No hay fecha';
    } else {
      return 'There is no date';
    }
  }

  String thereIsNoConuntryOrCity() {
     //  return 'There is no country or city';
    if (lang == 'en') {
      return 'There is no country or city';
    } else if (lang == 'es') {
      return 'No hay pais ni ciudad';
    } else {
      return 'There is no country or city';
    }
  }

  String recommendations() {
     //  return 'Recommendations';
    if (lang == 'en') {
      return 'Recommendations';
    } else if (lang == 'es') {
      return 'Recomendaciones';
    } else {
      return 'Recommendations';
    }
  }

  String upLoadPictureOfThePackage() {
      // return 'Upload pictures of the package you want to send!';
    if (lang == 'en') {
      return 'Upload pictures of the package you want to send!';
    } else if (lang == 'es') {
      return '¡Sube imágenes del paquete que deseas enviar!';
    } else {
      return 'Upload pictures of the package you want to send!';
    }
  }

  String yourCanUpload() {
      // return 'You can upload a maximum of five photos.';
    if (lang == 'en') {
      return 'You can upload a maximum of five photos.';
    } else if (lang == 'es') {
      return 'Puede cargar un máximo de cinco fotos.';
    } else {
      return 'You can upload a maximum of five photos.';
    }
  }

  String camera() {
     //  return 'Camera';
    if (lang == 'en') {
      return 'Camera';
    } else if (lang == 'es') {
      return 'Cámara';
    } else {
      return 'Camera';
    }
  }

  String gallery() {
     //  return 'Gallery';
    if (lang == 'en') {
      return 'Gallery';
    } else if (lang == 'es') {
      return 'Galería';
    } else {
      return 'Gallery';
    }
  }

  String addMorePhotos() {
     //  return 'Add more photos';
    if (lang == 'en') {
      return 'Add more photos';
    } else if (lang == 'es') {
      return 'Agregar más fotos';
    } else {
      return 'Add more photos';
    }
  }

  String insurances() {
     //  return 'Insurances';
    if (lang == 'en') {
      return 'Insurances';
    } else if (lang == 'es') {
      return 'Seguros';
    } else {
      return 'Insurances';
    }
  }

  String adReadyForPublish() {
    //   return 'Ad ready for publish';
    if (lang == 'en') {
      return 'Ad ready for publish';
    } else if (lang == 'es') {
      return 'Anuncio listo para publicar';
    } else {
      return 'Ad ready for publish';
    }
  }

  String chooseTheTypeOfInsurance() {
     //  return 'Choose the type of insurance to protect your package';
    if (lang == 'en') {
      return 'Choose the type of insurance to protect your package';
    } else if (lang == 'es') {
      return 'Elija el tipo de seguro para proteger su paquete';
    } else {
      return 'Choose the type of insurance to protect your package';
    }
  }

  String yourAdHasCreated() {
     //  return 'Your ad has been\nsuccessfully created!';
    if (lang == 'en') {
      return 'Your ad has been\nsuccessfully created!';
    } else if (lang == 'es') {
      return '¡Su anuncio se ha\n creado correctamente!';
    } else {
      return 'Your ad has been\n successfully created!';
    }
  }

  String shareAd() {
    //   return 'Share ad';
    if (lang == 'en') {
      return 'Share ad';
    } else if (lang == 'es') {
      return 'Compartir anuncio';
    } else {
      return 'Share ad';
    }
  }

  String findServiceMaches() {
     //  return 'Find services matches';
    if (lang == 'en') {
      return 'Find services matches';
    } else if (lang == 'es') {
      return 'Buscar coincidencias de servicios';
    } else {
      return 'Find services matches';
    }
  }

  String goToShipments() {
     //  return 'Ir a envíos';
    if (lang == 'en') {
      return 'Ir a envíos';
    } else if (lang == 'es') {
      return 'Ir a envíos';
    } else {
      return 'Ir a envíos';
    }
  }
}

Onboarding02Text onboarding02Text = Onboarding02Text();
