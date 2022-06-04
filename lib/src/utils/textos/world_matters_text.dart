import 'dart:io';

class WorldMattersText {
  String lang = Platform.localeName.substring(0, 2);

  String worldMatters() {
      // return 'World matters';
    if (lang == 'en') {
      return 'World matters';
    } else if (lang == 'es') {
      return 'El mundo importa';
    } else {
      return 'World matters';
    }
  }

  String recentActions() {
     //  return 'Recent actions';
    if (lang == 'en') {
      return 'Recent actions';
    } else if (lang == 'es') {
      return 'Acciones recientes';
    } else {
      return 'Recent actions';
    }
  }

  String readMore() {
      // return 'Read more';
    if (lang == 'en') {
      return 'Read more';
    } else if (lang == 'es') {
      return 'Leer mas';
    } else {
      return 'Read more';
    }
  }

// How it works?

}

WorldMattersText worlMattersText = WorldMattersText();
