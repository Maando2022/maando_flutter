import 'dart:io';

class PostText {
  String lang = Platform.localeName.substring(0, 2);

  String createPost() {
    // return 'Create Post';
    if (lang == 'en') {
      return 'Create Post';
    } else if (lang == 'es') {
      return 'Crear publicación';
    } else {
      return 'Create Post';
    }
  }

  String editPost() {
    // return 'Edit post';
    if (lang == 'en') {
      return 'Edit post';
    } else if (lang == 'es') {
      return 'Editar publicación';
    } else {
      return 'Edit post';
    }
  }

  String shareYourThoughts() {
    // return 'Share your thoughts';
    if (lang == 'en') {
      return 'Share your thoughts';
    } else if (lang == 'es') {
      return 'Comparte tus pensamientos';
    } else {
      return 'Share your thoughts';
    }
  }

  String edit() {
    // return 'Edit';
    if (lang == 'en') {
      return 'Edit';
    } else if (lang == 'es') {
      return 'Editar';
    } else {
      return 'Edit';
    }
  }

  String publish() {
    // return 'Publish';
    if (lang == 'en') {
      return 'Publish';
    } else if (lang == 'es') {
      return 'Publicar';
    } else {
      return 'Publish';
    }
  }

  String shareYouyThoghts() {
    // return 'Share your thoughts';
    if (lang == 'en') {
      return 'Share your thoughts';
    } else if (lang == 'es') {
      return 'Comparte tus pensamientos';
    } else {
      return 'Share your thoughts';
    }
  }

  String replies() {
    // return 'Replies';
    if (lang == 'en') {
      return 'Replies';
    } else if (lang == 'es') {
      return 'Respuestas';
    } else {
      return 'Replies';
    }
  }

  String readMore() {
    // return 'See more';
    if (lang == 'en') {
      return 'Read more';
    } else if (lang == 'es') {
      return 'Leer más';
    } else {
      return 'Read more';
    }
  }

  String readLees() {
    // return 'Read lees';
    if (lang == 'en') {
      return 'Read lees';
    } else if (lang == 'es') {
      return 'Leer menos';
    } else {
      return 'Read lees';
    }
  }

  String orderBy() {
    // return 'Sort by';
    if (lang == 'en') {
      return 'Sort by';
    } else if (lang == 'es') {
      return 'Ordenar por';
    } else {
      return 'Sort by';
    }
  }

  String order() {
    // return 'Order';
    if (lang == 'en') {
      return 'Order';
    } else if (lang == 'es') {
      return 'Ordenar';
    } else {
      return 'Order';
    }
  }

  String dateRange() {
    // return 'Date range';
    if (lang == 'en') {
      return 'Date range';
    } else if (lang == 'es') {
      return 'Rango de fechas';
    }else{
      return 'Date range';

    }
  }

  String descendingDate() {
    // return 'Descending date';
    if (lang == 'en') {
      return 'Descending date';
    } else if (lang == 'es') {
      return 'Fecha Descendente';
    }else{
      return 'Descending date';
      
    }
  }

  String email() {
    // return 'Email';
    if (lang == 'en') {
      return 'Email';
    } else if (lang == 'es') {
      return 'Correo electrónico';
    }else{
      return 'Email';
      
    }
  }

  String myPosts() {
    // return 'My posts';
    if (lang == 'en') {
      return 'My posts';
    } else if (lang == 'es') {
      return 'Mi publicaciones';
    }else{
      return 'My posts';
      
    }
  }

  
  String posts() {
    // return 'Posts';
    if (lang == 'en') {
      return 'Posts';
    } else if (lang == 'es') {
      return 'Publicaciones';
    }else{
      return 'Posts';
      
    }
  }
  
  String chatWithTheMaandoTeam() {
    // return 'Chat with the Maando Team';
    if (lang == 'en') {
      return 'Chat with the Maando Team';
    } else if (lang == 'es') {
      return 'Chatea con el equipo de Maando';
    }else{
      return 'Chat with the Maando Team';
      
    }
  }

  String replyToMessage() {
    // return 'Reply to message';
    if (lang == 'en') {
      return 'Reply to message';
    } else if (lang == 'es') {
      return 'Responder al mensaje';
    }else{
      return 'Reply to message';

    }
  }
  
  String to() {
   //  return 'To';
    if (lang == 'en') {
      return 'To';
    } else if (lang == 'es') {
      return 'Hasta';
    }else{
      return 'To';

    }
  }

  String from() {
    // return 'From';
    if (lang == 'en') {
      return 'From';
    } else if (lang == 'es') {
      return 'Desde';
    }else{
      return 'From';

    }
  }


    String myConversatiosn() {
    // return 'Create Post';
    if (lang == 'en') {
      return 'My conversations';
    } else if (lang == 'es') {
      return 'Mis conversaciones';
    } else {
      return 'My conversations';
    }
  }
}


PostText postText = PostText();
