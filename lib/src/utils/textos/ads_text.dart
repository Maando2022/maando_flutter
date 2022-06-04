import 'dart:io';

class AdsText {
  String lang = Platform.localeName.substring(0, 2);

  String titulo_1() {
   //  return 'Create ad';
    if (lang == 'en') {
      return 'Create ad';
    } else if (lang == 'es') {
      return 'Crear anuncio';
    } else {
      return 'Create ad';
    }
  }

  String whatCanIBring() {
    // return 'What can I bring?';
    if (lang == 'en') {
      return 'What can I bring?';
    } else if (lang == 'es') {
      return '¿Que puedo traer?';
    } else {
      return 'What can I bring?';
    }
  }

  String whatCanISend() {
    // return 'What can I send? ';
    if (lang == 'en') {
      return 'What can I send? ';
    } else if (lang == 'es') {
      return '¿Que puedo enviar?';
    } else {
      return 'What can I send? ';
    }
  }

  String subtitulo_1() {
    // return 'Title';
    if (lang == 'en') {
      return 'Title';
    } else if (lang == 'es') {
      return 'Título';
    } else {
      return 'Title';
    }
  }

  String subtitulo_2() {
    // return 'Next: Package type';
    if (lang == 'en') {
      return 'Next: Package type';
    } else if (lang == 'es') {
      return 'Siguiente: Tipo de Paquete';
    } else {
      return 'Next: Package type';
    }
  }

  String subtitulo_3() {
    // return 'Place of delyvery';
    if (lang == 'en') {
      return 'Place of delyvery';
    } else if (lang == 'es') {
      return 'Lugar de entrega';
    } else {
      return 'Place of delyvery';
    }
  }

  String descripcion() {
    // return 'Description';
    if (lang == 'en') {
      return 'Description';
    } else if (lang == 'es') {
      return 'Descripción';
    } else {
      return 'Description';
    }
  }

  String dimencion() {
    // return 'Dimensions';
    if (lang == 'en') {
      return 'Dimensions';
    } else if (lang == 'es') {
      return 'Dimensiones';
    } else {
      return 'Dimensions';
    }
  }

  String price() {
    // return 'Price';
    if (lang == 'en') {
      return 'Price';
    } else if (lang == 'es') {
      return 'Precio';
    } else {
      return 'Price';
    }
  }

  String pregunta_01() {
    // return "What's your Ad title?";
    if (lang == 'en') {
      return "What's your Ad title?";
    } else if (lang == 'es') {
      return '¿Cuál es el título de su anuncio?';
    } else {
      return "What's your Ad title?";
    }
  }

  String whatIsThePlaceOfDelivery() {
    // return "What is the place of delivery?";
    if (lang == 'en') {
      return "What is the place of delivery?";
    } else if (lang == 'es') {
      return '¿Cual es el lugar de entrega?';
    } else {
      return "What is the place of delivery?";
    }
  }

  String placeOfDelivery() {
    // return "Place of delivery";
    if (lang == 'en') {
      return "Place of delivery";
    } else if (lang == 'es') {
      return 'Lugar de entrega';
    } else {
      return "Place of delivery";
    }
  }

  String departureCity() {
    // return "Departure city";
    if (lang == 'en') {
      return "Departure city";
    } else if (lang == 'es') {
      return 'Ciudad de partida';
    } else {
      return "Departure city";
    }
  }

  String destinationCity() {
    // return "Destination city";
    if (lang == 'en') {
      return "Destination city";
    } else if (lang == 'es') {
      return 'Ciudad de destino';
    } else {
      return "Destination city";
    }
  }

  String dataInvalid() {
    // return 'Invalid data';
    if (lang == 'en') {
      return 'Invalid data';
    } else if (lang == 'es') {
      return 'Datos inválidos';
    } else {
      return 'Invalid data';
    }
  }

  String error_01() {
    return 'Invalid title';
    if (lang == 'en') {
      return 'Invalid title';
    } else if (lang == 'es') {
      return 'Titulo inválido';
    } else {
      return 'Invalid title';
    }
  }

  String error_02() {
    // return 'Invalid place of delivery.';
    if (lang == 'en') {
      return 'Invalid place of delivery.';
    } else if (lang == 'es') {
      return 'Lugar de entrega inválido.';
    } else {
      return 'Invalid place of delivery.';
    }
  }

  String errorDescription() {
    // return 'Invalid description.';
    if (lang == 'en') {
      return 'Invalid description.';
    } else if (lang == 'es') {
      return 'Descripción inválida.';
    } else {
      return 'Invalid description.';
    }
  }

  String errorDimensions() {
    // return 'Invalid dimensions.';
    if (lang == 'en') {
      return 'Invalid dimensions.';
    } else if (lang == 'es') {
      return 'Dimenciones inválidas.';
    } else {
      return 'Invalid dimensions.';
    }
  }

  String errorPrice() {
    // return 'Invalid price.';
    if (lang == 'en') {
      return 'Invalid price.';
    } else if (lang == 'es') {
      return 'Precio inválido.';
    } else {
      return 'Invalid price.';
    }
  }

  String createAd() {
    // return 'Create ad';
    if (lang == 'en') {
      return 'Create ad';
    } else if (lang == 'es') {
      return 'Crear anuncio';
    } else {
      return 'Create ad';
    }
  }

  String dateAndtimeAnddestination() {
    // return 'Date, time & destination';
    if (lang == 'en') {
      return 'Date, time & destination';
    } else if (lang == 'es') {
      return 'Fecha, hora y destino';
    } else {
      return 'Date, time & destination';
    }
  }

  String photos() {
    // return 'Photos';
    if (lang == 'en') {
      return 'photos';
    } else if (lang == 'es') {
      return 'Fotos';
    } else {
      return 'photos';
    }
  }

  String country() {
    // return 'Country';
    if (lang == 'en') {
      return 'Country';
    } else if (lang == 'es') {
      return 'País';
    } else {
      return 'Country';
    }
  }

  String city() {
    // return 'City';
    if (lang == 'en') {
      return 'City';
    } else if (lang == 'es') {
      return 'Ciudad';
    } else {
      return 'City';
    }
  }

  String dateAndtimeDestinationPackages() {
    // return 'Destination date and time for package delivery?';
    if (lang == 'en') {
      return 'Destination date and time for package delivery?';
    } else if (lang == 'es') {
      return '¿Fecha y Hora de destino para la entrega del paquete?';
    } else {
      return 'Destination date and time for package delivery?';
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
    // return 'There is no date';
    if (lang == 'en') {
      return 'There is no date';
    } else if (lang == 'es') {
      return 'No hay fecha';
    } else {
      return 'There is no date';
    }
  }

  String thereIsNoConuntryOrCity() {
    // return 'There is no country or city';
    if (lang == 'en') {
      return 'There is no country or city';
    } else if (lang == 'es') {
      return 'No hay pais ni ciudad';
    } else {
      return 'There is no country or city';
    }
  }

  String recommendations() {
    // return 'Recommendations';
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
    // return 'Camera';
    if (lang == 'en') {
      return 'Camera';
    } else if (lang == 'es') {
      return 'Cámara';
    } else {
      return 'Camera';
    }
  }

  String gallery() {
    // return 'Gallery';
    if (lang == 'en') {
      return 'Gallery';
    } else if (lang == 'es') {
      return 'Galería';
    } else {
      return 'Gallery';
    }
  }

  String addMorePhotos() {
    // return 'Add more photos';
    if (lang == 'en') {
      return 'Add more photos';
    } else if (lang == 'es') {
      return 'Agregar más fotos';
    } else {
      return 'Add more photos';
    }
  }

  String pressAndHoldToRemoveAnImage() {
    // return 'Press and hold to remove an image.';
    if (lang == 'en') {
      return 'Press and hold to remove an image.';
    } else if (lang == 'es') {
      return 'Mantenga presionado para remover una imágen.';
    } else {
      return 'Press and hold to remove an image.';
    }
  }

  String insurances() {
    // return 'Insurances';
    if (lang == 'en') {
      return 'Insurances';
    } else if (lang == 'es') {
      return 'Seguros';
    } else {
      return 'Insurances';
    }
  }

  String adReadyForPublish() {
    // return 'Publish';
    if (lang == 'en') {
      return 'Publish';
    } else if (lang == 'es') {
      return 'Publicar';
    } else {
      return 'Publish';
    }
  }

  String chooseTheTypeOfInsurance() {
    // return 'Choose the type of insurance to protect your package';
    if (lang == 'en') {
      return 'Choose the type of insurance to protect your package';
    } else if (lang == 'es') {
      return 'Elija el tipo de seguro para proteger su paquete';
    } else {
      return 'Choose the type of insurance to protect your package';
    }
  }

  String yourAdHasCreated() {
    // return 'Your ad has been\nsuccessfully created!';
    if (lang == 'en') {
      return 'Your ad has been\nsuccessfully created!';
    } else if (lang == 'es') {
      return '¡Su anuncio se ha\n creado correctamente!';
    } else {
      return 'Your ad has been\n successfully created!';
    }
  }

  String shareAd() {
    // return 'Share ad';
    if (lang == 'en') {
      return 'Share ad';
    } else if (lang == 'es') {
      return 'Compartir anuncio';
    } else {
      return 'Share ad';
    }
  }

  String findServiceMaches() {
    // return 'Find services matches';
    if (lang == 'en') {
      return 'Find services matches';
    } else if (lang == 'es') {
      return 'Buscar coincidencias de servicios';
    } else {
      return 'Find services matches';
    }
  }

  String youCannotSelectMoreThan5Images() {
    // return 'Find services matches';
    if (lang == 'en') {
      return 'You cannot select more than 5 images';
    } else if (lang == 'es') {
      return 'No puede seleccionar más de 5 imágenes';
    } else {
      return 'You cannot select more than 5 images';
    }
  }

  String goToShipments() {
    // return 'Go to sending';
    if (lang == 'en') {
      return 'Go to sending';
    } else if (lang == 'es') {
      return 'Ir a envíos';
    } else {
      return 'Go to sending';
    }
  }

  String examplePlaceOfDelivery() {
    // return 'Example: Central Park 745 5Th Ave, Suite 500 New York, NY 10151';
    if (lang == 'en') {
      return 'Example: Central Park 745 5Th Ave, Suite 500 New York, NY 10151';
    } else if (lang == 'es') {
      return 'Ejemplo: Central Park 745 5Th Ave, Suite 500 New York, NY 10151';
    } else {
      return 'Example: Central Park 745 5Th Ave, Suite 500 New York, NY 10151';
    }
  }

  String instructionDescription() {
    // return 'Post a package description with at least 50 letters.';
    if (lang == 'en') {
      return 'Post a package description with at least 50 letters.';
    } else if (lang == 'es') {
      return 'Ingrese una descripción del paquete con al menos de 50 letras.';
    } else {
      return 'Post a package description with at least 50 letters.';
    }
  }

  String heightWidthLongWeight() {
    // return 'Enter the height, width, length and weight of the package.';
    if (lang == 'en') {
      return 'Enter the height, width, length and weight of the package.';
    } else if (lang == 'es') {
      return 'ingrese el alto, ancho, largo y peso del paquete.';
    } else {
      return 'Enter the height, width, length and weight of the package.';
    }
  }

  String enterPriceLegend() {
    // return 'How much are you willing to pay for your package to arrive soon? The options are in US dollars (without period or commas).';
    if (lang == 'en') {
      return 'How much are you willing to pay for your package to arrive soon? The options are in US dollars (without period or commas).';
    } else if (lang == 'es') {
      return '¿Cuánto estas dispuesto a pagar para que tu paquete llegue pronto? Las opciones están en dólares estadounidenses (sin puntos ni comas).';
    } else {
      return 'How much are you willing to pay for your package to arrive soon? The options are in US dollars (without period or commas).';
    }
  }

  String validateNumber() {
    // return 'Only numbers';
    if (lang == 'en') {
      return 'Only numbers';
    } else if (lang == 'es') {
      return 'Sólo números';
    } else {
      return 'Only numbers';
    }
  }

  String centimeters() {
    // return 'centimeters';
    if (lang == 'en') {
      return 'centimeters';
    } else if (lang == 'es') {
      return 'centímetros';
    } else {
      return 'centimeters';
    }
  }

  String usd() {
    // return 'dollars';
    if (lang == 'en') {
      return 'dollars';
    } else if (lang == 'es') {
      return 'dólares';
    } else {
      return 'dollars';
    }
  }

  String height() {
    // return 'Height';
    if (lang == 'en') {
      return 'Height';
    } else if (lang == 'es') {
      return 'Alto';
    } else {
      return 'Height';
    }
  }

  String width() {
    // return 'Width';
    if (lang == 'en') {
      return 'Width';
    } else if (lang == 'es') {
      return 'Ancho';
    } else {
      return 'Width';
    }
  }

  String long() {
    // return 'Long';
    if (lang == 'en') {
      return 'Long';
    } else if (lang == 'es') {
      return 'Largo';
    } else {
      return 'Long';
    }
  }

  String weight() {
    // return 'Weight';
    if (lang == 'en') {
      return 'Weight';
    } else if (lang == 'es') {
      return 'Peso';
    } else {
      return 'Weight';
    }
  }

  String ofHeight() {
    // return 'of height';
    if (lang == 'en') {
      return 'of height';
    } else if (lang == 'es') {
      return ' de alto';
    } else {
      return 'of height';
    }
  }

  String ofWidth() {
    // return 'of width';
    if (lang == 'en') {
      return 'of width';
    } else if (lang == 'es') {
      return ' de ancho';
    } else {
      return 'of width';
    }
  }

  String ofLong() {
    // return 'of long';
    if (lang == 'en') {
      return 'of long';
    } else if (lang == 'es') {
      return ' de largo';
    } else {
      return 'of long';
    }
  }

  String ofWeight() {
    // return 'of weight';
    if (lang == 'en') {
      return 'of weight';
    } else if (lang == 'es') {
      return ' de peso';
    } else {
      return 'of weight';
    }
  }

  // **********************************
  String titleDateAndDestination() {
    // return 'Title, Date and Destination';
    if (lang == 'en') {
      return 'Title, Date and Destination';
    } else if (lang == 'es') {
      return ' Título, Fecha y Destino';
    } else {
      return 'Title, Date and Destination';
    }
  }

  // **********************************
  String deliveryAddress() {
    // return 'Delivery address';
    if (lang == 'en') {
      return 'Delivery address';
    } else if (lang == 'es') {
      return 'Dirección de entrega';
    } else {
      return 'Delivery address';
    }
  }
}

AdsText adsText = AdsText();
