import 'dart:io';

class ReviewText {
  String lang = Platform.localeName.substring(0, 2);

  String reviews() {
      // return 'Reviews';
    if (lang == 'en') {
      return 'Reviews';
    } else if (lang == 'es') {
      return 'Reseñas';
    } else {
      return 'Reviews';
    }
  }

  String shortDescription() {
      // return 'Short description of the reviews screen.';
    if (lang == 'en') {
      return 'Short description of the reviews screen.';
    } else if (lang == 'es') {
      return 'Breve descripción de la pantalla de reseñas.';
    } else {
      return 'Short description of the reviews screen.';
    }
  }

  String errorLoadingReview() {
      // return 'Error loading reviews';
    if (lang == 'en') {
      return 'Error loading reviews';
    } else if (lang == 'es') {
      return 'Error al cargar las reseñas';
    } else {
      return 'Error loading reviews';
    }
  }

  String rateAndReview() {
      // return 'Rate and review';
    if (lang == 'en') {
      return 'Rate and review';
    } else if (lang == 'es') {
      return 'Valorar y comentar';
    } else {
      return 'Rate and review';
    }
  }

  String giveNameWhatHeDeserves(String name) {
      // return 'Give $name what\nhe deserves';
    if (lang == 'en') {
      return 'Give $name what\nhe deserves';
    } else if (lang == 'es') {
      return 'Dale a $name lo que\nel se merece';
    } else {
      return 'Give $name what\nhe deserves';
    }
  }

  String doYouWantToWrite() {
      // return 'Do you want to write a review?';
    if (lang == 'en') {
      return 'Do you want to write a review?';
    } else if (lang == 'es') {
      return '¿Quieres escribir una\nreseña?';
    } else {
      return 'Do you want to write a review?';
    }
  }

  String maximunCharacter() {
      // return 'Maximum 180 characters.';
    if (lang == 'en') {
      return 'Maximum 180 characters.';
    } else if (lang == 'es') {
      return 'Máximo 180 caracteres.';
    } else {
      return 'Maximum 180 characters.';
    }
  }

  String sendReview() {
    if (lang == 'en') {
      return 'Send review';
    } else if (lang == 'es') {
      return 'Enviar reseña';
    } else {
      return 'Send review';
    }
  }

  String yourReviewSuccessfilly() {
      // return 'Your review has been successfuly sent';
    if (lang == 'en') {
      return 'Your review has been successfuly sent';
    } else if (lang == 'es') {
      return 'Tu reseña ha sido enviada con éxito';
    } else {
      return 'Your review has been successfuly sent';
    }
  }

  String backToHome() {
     //  return 'Back to home';
    if (lang == 'en') {
      return 'Back to home';
    } else if (lang == 'es') {
      return 'Volver al inicio';
    } else {
      return 'Back to home';
    }
  }
}

ReviewText reviewText = ReviewText();
