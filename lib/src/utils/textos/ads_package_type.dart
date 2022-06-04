import 'dart:io';

class AdsPackType {
  String lang = Platform.localeName.substring(0, 2);

  String titulo_1() {
      // return 'Create ad';
    if (lang == 'en') {
      return 'Create ad';
    } else if (lang == 'es') {
      return 'Crear anuncio';
    } else {
      return 'Create ad';
    }
  }

  String subtitulo_1() {
      // return 'What kind of package you want to send?';
    if (lang == 'en') {
      return 'What kind of package you want to send?';
    } else if (lang == 'es') {
      return 'Qué tipo de paquete quieres enviar?';
    } else {
      return 'What kind of package you want to send?';
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
      // return 'There is no title';
    if (lang == 'en') {
      return 'There is no title';
    } else if (lang == 'es') {
      return 'No hay titulo';
    } else {
      return 'There is no title';
    }
  }

  String createAd() {
      // return 'Create an ad.';
    if (lang == 'en') {
      return 'Create an ad.';
    } else if (lang == 'es') {
      return 'Crear un anuncio.';
    } else {
      return 'Create an ad.';
    }
  }


  String compactName() {
      // return 'Compact';
    if (lang == 'en') {
      return 'Compact';
    } else if (lang == 'es') {
      return 'Maleta de carga';
    } else {
      return 'Compact';
    }
  }


  String handybagName() {
      // return 'Handybag';
    if (lang == 'en') {
      return 'Handybag';
    } else if (lang == 'es') {
      return 'Maleta de mano';
    } else {
      return 'Handybag';
    }
  }

    String compactDescription() {
      // return 'Description of compact';
    if (lang == 'en') {
      return 'Description of compact';
    } else if (lang == 'es') {
      return 'Descripción de la maleta de carga';
    } else {
      return 'Description of compact';
    }
  }


  String handybagDescription() {
      // return 'Description of handybag';
    if (lang == 'en') {
      return 'Description of handybag';
    } else if (lang == 'es') {
      return 'Descripción de la maleta de mano';
    } else {
      return 'Description of handybag';
    }
  }
}

AdsPackType adspacktypeText = AdsPackType();
