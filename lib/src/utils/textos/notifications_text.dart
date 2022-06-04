import 'dart:io';

class NotificationText {
  String lang = Platform.localeName.substring(0, 2);

  String maandoUpdate() {
    // return 'Maando Update';
    if (lang == 'en') {
      return 'Maando Update';
    } else if (lang == 'es') {
      return 'Actualización de Maando';
    } else {
      return 'Maando Update';
    }
  }
  
  String yourMessageHasBeenDeletedByTheMaandoTeam() {
    // return 'Your message has been deleted by the Maando team.';
    if (lang == 'en') {
      return 'Your message has been deleted by the Maando team.';
    } else if (lang == 'es') {
      return 'Su mensaje ha sido eliminado por el equipo de Maando.';
    } else {
      return 'Your message has been deleted by the Maando team.';
    }
  }
  
  String nnewCommentHasBeenAddedToYourPost(String comment) {
    // return 'A new comment has been added to your post. \n $comment';
    if (lang == 'en') {
      return 'A new comment has been added to your post. \n $comment';
    } else if (lang == 'es') {
      return 'Se ha añadido un nuevo comentario a tu publicación. \n $comment';
    } else {
      return 'Se ha añadido un nuevo comentario a tu publicación. \n $comment';
    }
  }
}

NotificationText notificationText = NotificationText();