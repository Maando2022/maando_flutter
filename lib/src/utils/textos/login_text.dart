import 'dart:io';

class LoginText {
  String lang = Platform.localeName.substring(0, 2);

  String login() {
     //  return 'Login';
    if (lang == 'en') {
      return 'Login';
    } else if (lang == 'es') {
      return 'Iniciar sesión';
    } else {
      return 'Login';
    }
  }

  String connectWith() {
     //  return 'Login with';
    if (lang == 'en') {
      return 'Login with';
    } else if (lang == 'es') {
      return 'Iniciar sesión con';
    } else {
      return 'Login with';
    }
  }

  String logintWithgoogle() {
     //  return 'Sign in with Google';
    if (lang == 'en') {
      return 'Sign in with Google';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Google';
    } else {
      return 'Sign in with Google';
    }
  }

  String logintWithFacebook() {
     //  return 'Sign in with Facebook';
    if (lang == 'en') {
      return 'Login with Facebook';
    } else if (lang == 'es') {
      return 'Sign in with con Facebook';
    } else {
      return 'Sign in with Facebook';
    }
  }

  String loginwith() {
    if (lang == 'en') {
      return 'Login++ with';
    } else if (lang == 'es') {
      return 'Iniciar con';
    } else {
      return 'Login with';
    }
  }

  String signinapple() {
      // return 'Sign with Apple';
    if (lang == 'en') {
      return 'Sign with Apple';
    } else if (lang == 'es') {
      return 'Iniciar sesion con Apple';
    } else {
      return 'Sign with Apple';
    }
  }

  String shortDescription() {
    // return 'Join this adventure and start to send packages in record time.';
    if (lang == 'en') {
      return 'Enter your email to login';
    } else if (lang == 'es') {
      return 'Coloca tu correo electrónico para ingresar';
    } else {
      return 'Enter your email to login';
    }
  }


  String joinThisAdventure() {
   //  return 'Join this adventure and start to send packages in record time.';
    if (lang == 'en') {
      return 'Join this adventure and start to send packages in record time.';
    } else if (lang == 'es') {
      return 'Súmate a esta aventura y empieza a enviar paquetes en un tiempo récord.';
    } else {
      return 'Join this adventure and start to send packages in record time.';
    }
  }

  String email() {
     //  return 'Email';
    if (lang == 'en') {
      return 'Email';
    } else if (lang == 'es') {
      return 'Correo electrónico';
    } else {
      return 'Email';
    }
  }

  String password() {
     //  return 'Password';
    if (lang == 'en') {
      return 'Password';
    } else if (lang == 'es') {
      return 'Contraseña';
    } else {
      return 'Password';
    }
  }

  String forgotYourPassword() {
     //  return 'Forgot your password?';
    if (lang == 'en') {
      return 'Forgot your password?';
    } else if (lang == 'es') {
      return '¿Olvidaste tu contraseña?';
    } else {
      return 'Forgot your password?';
    }
  }

  String dontHaveAnAccount() {
     //  return 'Don\'t have an account';
    if (lang == 'en') {
      return 'Don\'t have an account';
    } else if (lang == 'es') {
      return 'No tengo una cuenta';
    } else {
      return 'Don\'t have an account';
    }
  }

  String joinMaando() {
     //  return 'Join Maando';
    if (lang == 'en') {
      return 'Join Maando';
    } else if (lang == 'es') {
      return 'Únete a Maando';
    } else {
      return 'Join Maando';
    }
  }

  String emailIsNotCorrect() {
     //  return 'Email is not correct.';
    if (lang == 'en') {
      return 'Email is not correct.';
    } else if (lang == 'es') {
      return 'El correo electrónico no es correcto.';
    } else {
      return 'Email is not correct.';
    }
  }

  String enterMinimumCharactersTakes() {
     //  return 'Enter minimum 6 characters: takes: ';
    if (lang == 'en') {
      return 'Enter minimum 6 characters: takes: ';
    } else if (lang == 'es') {
      return 'Ingrese un mínimo de 6 caracteres: tiene:';
    } else {
      return 'Enter minimum 6 characters: takes: ';
    }
  }

  String incorrectPassword() {
     //  return 'Incorrect password';
    if (lang == 'en') {
      return 'Incorrect password';
    } else if (lang == 'es') {
      return 'Contraseña incorrecta';
    } else {
      return 'Incorrect password';
    }
  }

  String errorSystem() {
      // return 'Error in the system';
    if (lang == 'en') {
      return 'Error in the system';
    } else if (lang == 'es') {
      return 'Error del sistema';
    } else {
      return 'Error in the system';
    }
  }

  String incorrectUser() {
      // return 'User does not exist';
    if (lang == 'en') {
      return 'User does not exist';
    } else if (lang == 'es') {
      return 'El usuario no existe';
    } else {
      return 'User does not exist';
    }
  }

  String loginTouchID() {
      // return 'Login with Touch ID';
    if (lang == 'en') {
      return 'Login with Touch ID';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Touch ID';
    } else {
      return 'Login with Touch ID';
    }
  }

  String loginFaceID() {
      // return 'Login with Face ID';
    if (lang == 'en') {
      return 'Login with Face ID';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Face ID';
    } else {
      return 'Login with Face ID';
    }
  }
}

LoginText loginText = LoginText();
