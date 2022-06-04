import 'dart:io';

class LanzamientoText {
  String lang = Platform.localeName.substring(0, 2);

  String textoboton() {
      // return 'Win prizes on Instagram';
    if (lang == 'en') {
      return 'Win prizes on Instagram';
    } else if (lang == 'es') {
      return 'Gana premios en Instagram';
    } else {
      return 'Win prizes on Instagram';
    }
  }

  String textocontador() {
      // return 'Congrats! You’re the user';
    if (lang == 'en') {
      return 'Congrats! You’re the user';
    } else if (lang == 'es') {
      return '¡Felicidades! Tu eres el usuario';
    } else {
      return 'Congrats! You’re the user';
    }
  }

  String parrafo() {
      // return 'You have successfully downloaded the App. From this moment onward you will be a MAANDO friend. We are 100,000 people who will have the best benefits of this package delivery app between friends. Once we have reached the goal, we will be operating on a global level. Tell your entrepreneurial friends and family members that MAANDO is born.';
    if (lang == 'en') {
      return 'You have successfully downloaded the App. From this moment onward you will be a MAANDO friend. We are 100,000 people who will have the best benefits of this package delivery app between friends. Once we have reached the goal, we will be operating on a global level. Tell your entrepreneurial friends and family members that MAANDO is born.';
    } else if (lang == 'es') {
      return 'Has descargado la aplicación con éxito. A partir de ahora eres un MAANDO FRIEND. Seremos 100.000 personas que tendremos los mayores beneficios de esta app de envíos de paquetes entre amigos. Una vez lleguemos a la meta, estaremos funcionando a nivel global. Cuéntale a tu familia y a esos amigos emprendedores que ha nacido MAANDO';
    } else {
      return 'You have successfully downloaded the App. From this moment onward you will be a MAANDO friend. We are 100,000 people who will have the best benefits of this package delivery app between friends. Once we have reached the goal, we will be operating on a global level. Tell your entrepreneurial friends and family members that MAANDO is born.';
    }
  }

  String question_1() {
      // return 'HAVE ANY QUESTION ?';
    if (lang == 'en') {
      return 'HAVE ANY QUESTION ?';
    } else if (lang == 'es') {
      return '¿TIENES ALGUNA PREGUNTA?';
    } else {
      return 'HAVE ANY QUESTION?';
    }
  }

  String question_2() {
     //  return 'WORLD MATTERS';
    if (lang == 'en') {
      return 'WORLD MATTERS';
    } else if (lang == 'es') {
      return 'ASUNTOS MUNDIALES';
    } else {
      return 'WORLD MATTERS';
    }
  }

  String parrafo_1() {
      // return 'Let us know what you think or if\nyou have any comment or suggestion.';
    if (lang == 'en') {
      return 'Let us know what you think or if\nyou have any comment or suggestion.';
    } else if (lang == 'es') {
      return 'Háganos saber lo que piensa\no si tiene algún comentario o sugerencia.';
    } else {
      return 'Let us know what you think or if\nyou have any comment or suggestion.';
    }
  }

  String parrafo_2() {
     //  return ' Let’s spread the word! Help us to\nbuild a better world.';
    if (lang == 'en') {
      return ' Let’s spread the word! Help us to\nbuild a better world.';
    } else if (lang == 'es') {
      return '¡Hagamos correr la voz! \nAyúdanos a construir un mundo mejor.';
    } else {
      return ' Let’s spread the word! Help us to\nbuild a better world.';
    }
  }

  String myQuestionIs() {
     //  return 'About%20Maando%20I%20want%20to%20know ...';
    if (lang == 'en') {
      return 'About%20Maando%20I%20want%20to%20know ...';
    } else if (lang == 'es') {
      return 'Acerca%20de%20Maando%20quiero%20saber...';
    } else {
      return 'About%20Maando%20I%20want%20to%20know ...';
    }
  }

  String enjoyTogether() {
      // return 'Enjoy together this adventure!';
    if (lang == 'en') {
      return 'Enjoy together this adventure!';
    } else if (lang == 'es') {
      return '¡Disfrutemos juntos esta aventura! ';
    } else {
      return 'Enjoy together this adventure!';
    }
  }

  String logout() {
     //  return 'Log out';
    if (lang == 'en') {
      return 'Log out';
    } else if (lang == 'es') {
      return 'Cerrar Sesion ';
    } else {
      return 'Log out';
    }
  }

  String admina() {
     //  return 'Administrative access';
    if (lang == 'en') {
      return 'Administrative access';
    } else if (lang == 'es') {
      return 'Acceso administrativo ';
    } else {
      return 'Administrative access';
    }
  }
}

LanzamientoText lanzamientoText = LanzamientoText();
