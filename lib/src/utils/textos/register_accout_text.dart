import 'dart:io';

class CreateAccountText {
  String lang = Platform.localeName.substring(0, 2);

  String createAccount() {
     // return 'Create account';
    if (lang == 'en') {
      return 'Create account';
    } else if (lang == 'es') {
      return 'Crear cuenta';
    } else {
      return 'Create account';
    }
  }

  String completeRegistration() {
     //  return 'Complete registration';
    if (lang == 'en') {
      return 'Complete registration';
    } else if (lang == 'es') {
      return 'Completar registro';
    } else {
      return 'Complete registration';
    }
  }

  String registertWith() {
      // return 'Register with';
    if (lang == 'en') {
      return 'Register with';
    } else if (lang == 'es') {
      return 'Iniciar sesión con Apple';
    } else {
      return 'Register with';
    }
  }

  String signupApple() {
      // return 'Register with Apple';
    if (lang == 'en') {
      return 'Sign up with Apple';
    } else if (lang == 'es') {
      return 'Registrate con Apple';
    } else {
      return 'Sign up with Apple';
    }
  }

  String registertWithGoogle() {
      // return 'Register with Google';
    if (lang == 'en') {
      return 'Sign up Google';
    } else if (lang == 'es') {
      return 'Registrar con Google';
    } else {
      return 'Sign up Google';
    }
  }

  String registertWithFacebook() {
      // return 'Register with Facebook';
    if (lang == 'en') {
      return 'Sign up Facebook';
    } else if (lang == 'es') {
      return 'Registrar con Facebook';
    } else {
      return 'Sign up Facebook';
    }
  }

  String terminos2() {
      // return 'Terms and Conditions';
    if (lang == 'en') {
      return 'Terms and Conditions';
    } else if (lang == 'es') {
      return 'Términos y Condiciones.';
    } else {
      return 'Terms and Conditions';
    }
  }

  String terminos1() {
      // return 'I agree to the ';
    if (lang == 'en') {
      return 'I agree to the ';
    } else if (lang == 'es') {
      return 'Estoy de acuerdo con ';
    } else {
      return 'I agree to the ';
    }
  }

  String shortDescription() {
      // return 'Join this adventure and start to send packages in record time.';
    if (lang == 'en') {
      return 'We are a collaboration platform specialized in package delivery between friends that travel. Register now';
    } else if (lang == 'es') {
      return 'Somos una plataforma de colaboración, especializada en envíos de paquetería entre amigos que viajan de un lado a otro.';
    } else {
      return 'We are a collaboration platform specialized in package delivery between friends that travel. Register now';
    }
  }

  String fullName() {
      // return 'Full name';
    if (lang == 'en') {
      return 'Full name';
    } else if (lang == 'es') {
      return 'Nombre completo';
    } else {
      return 'Full name';
    }
  }

  String email() {
      // return 'Email address';
    if (lang == 'en') {
      return 'Email address';
    } else if (lang == 'es') {
      return 'Dirección de correo electrónico';
    } else {
      return 'Email address';
    }
  }

  String mobileNumber() {
      // return 'Mobile number';
    if (lang == 'en') {
      return 'Mobile number';
    } else if (lang == 'es') {
      return 'Número de teléfono móvil';
    } else {
      return 'Mobile number';
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

  String haveAnAccont() {
      // return 'Have an account?';
    if (lang == 'en') {
      return 'Have an account?';
    } else if (lang == 'es') {
      return '¿Tienes una cuenta?';
    } else {
      return 'Have an account?';
    }
  }

  String login() {
      // return 'Login';
    if (lang == 'en') {
      return 'Login';
    } else if (lang == 'es') {
      return 'Iniciar sesión';
    } else {
      return 'Login';
    }
  }

  String login2() {
      // return 'Enter your email to login';
    if (lang == 'en') {
      return 'Enter your email to login';
    } else if (lang == 'es') {
      return 'Ingresar';
    } else {
      return 'Enter your email to login';
    }
  }

  String emailIsNotCorrect() {
      // return 'Email is not correct.';
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
      return 'Ingrese un mínimo de 6 caracteres: tiene: ';
    } else {
      return 'Enter minimum 6 characters: takes: ';
    }
  }

  String validateFullName() {
      // return 'Enter minimum 3 characters: takes: ';
    if (lang == 'en') {
      return 'Enter minimum 3 characters: takes: ';
    } else if (lang == 'es') {
      return 'Ingrese un mínimo de 3 caracteres: tiene: ';
    } else {
      return 'Enter minimum 3 characters: takes: ';
    }
  }

  String validatePhoneNumber() {
      // return 'Only numbers';
    if (lang == 'en') {
      return 'Only numbers';
    } else if (lang == 'es') {
      return 'Sólo números';
    } else {
      return 'Only numbers';
    }
  }

  String acceptTermsAndConditions() {
     //  return 'Accept terms and conditions';
    if (lang == 'en') {
      return 'Accept terms and conditions';
    } else if (lang == 'es') {
      return 'Aceptar términos y condiciones';
    } else {
      return 'Accept terms and conditions';
    }
  }

  String confirmPassword() {
      // return 'Confirm password';
    if (lang == 'en') {
      return 'Confirm password';
    } else if (lang == 'es') {
      return 'Confirmar contraseña';
    } else {
      return 'Confirm password';
    }
  }
}

CreateAccountText createAccountText = CreateAccountText();
