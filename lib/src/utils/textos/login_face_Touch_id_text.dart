import 'dart:io';

class LoginFaceTouchIdText {
  String lang = Platform.localeName.substring(0, 2);

  String welcomeBack() {
      // return 'Welcome back';
    if (lang == 'en') {
      return 'Welcome back';
    } else if (lang == 'es') {
      return 'Bienvenido nuevamente';
    } else {
      return 'Welcome back';
    }
  }

  String shortDescription() {
      // return 'Short description to explain something related to Login, lorem ipsum dolor.';
    if (lang == 'en') {
      return 'Short description to explain something related to Login, lorem ipsum dolor.';
    } else if (lang == 'es') {
      return 'Breve descripción para explicar algo relacionado con Login, lorem ipsum dolor.';
    } else {
      return 'Short description to explain something related to Login, lorem ipsum dolor.';
    }
  }

   String joinThisAdventure() {
    // return 'Join this adventure and start to send packages in record time.';
    if (lang == 'en') {
      return 'Join this adventure and start to send packages in record time.';
    } else if (lang == 'es') {
      return 'Súmate a esta aventura y empieza a enviar paquetes en un tiempo récord.';
    } else {
      return 'Join this adventure and start to send packages in record time.';
    }
  }

  String loginWithFaceId() {
     //  return 'Login with Face ID';
    if (lang == 'en') {
      return 'Login with Face ID';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Face ID';
    } else {
      return 'Login with Face ID';
    }
  }

  String loginWithTouchId() {
     //  return 'Login with Touch ID';
    if (lang == 'en') {
      return 'Login with Touch ID';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Touch ID';
    } else {
      return 'Login with Touch ID';
    }
  }

  String loginWithEmail() {
     //  return 'Login with email';
    if (lang == 'en') {
      return 'Login with email';
    } else if (lang == 'es') {
      return 'Iniciar sesión con correo electrónico';
    } else {
      return 'Login with email';
    }
  }
}

LoginFaceTouchIdText loginFaceTouchIdText = LoginFaceTouchIdText();
