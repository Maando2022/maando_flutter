import 'dart:io';

class OnboardingText {
  String lang = Platform.localeName.substring(0, 2);

  String togetherWeAllWin() {
    // return 'Together, we all win! ';
    if (lang == 'en') {
      return 'Together, we all win.';
    } else if (lang == 'es') {
      return 'Juntos, todos ganamos.';
    } else {
      return 'Together, we all win.';
    }
  }

  String getPaidAnyWhereYouGo() {
    // return '';
    if (lang == 'en') {
      return 'Get paid anywhere you go.';
    } else if (lang == 'es') {
      return 'Reciba pagos donde quiera que vaya.';
    } else {
      return 'Get paid anywhere you go.';
    }
  }

  String createAccount() {
    // return 'Create account';
    if (lang == 'en') {
      return 'Create account';
    } else if (lang == 'es') {
      return 'Crear una cuenta';
    } else {
      return 'Create account';
    }
  }

  String shipmentsInRecordTime() {
    // return 'Small packages deliveries in less than 24 hours between continents.';
    if (lang == 'en') {
      return 'Shipments in record time.';
    } else if (lang == 'es') {
      return 'Envíos en tiempo record.';
    } else {
      return 'Shipments in record time.';
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

  String beTransporterAgent() {
    // return '';
    if (lang == 'en') {
      return 'Be a transporter agent.';
    } else if (lang == 'es') {
      return 'Ser una agente de transporte.';
    } else {
      return 'Be a transporter agent.';
    }
  }

  String publishYourFlight() {
    
    // return 'MAANDO puts money in your pocket, while you’re having fun travelling.';
    if (lang == 'en') {
      return 'Publish your flights, deliver,\nand make traveling your business.';
    } else if (lang == 'es') {
      return 'Publique sus vuelos, entregue y\nhaga de los viajes su negocio.';
    } else {
      return 'Publish your flights, deliver,\nand make traveling your business.';
    }
  }

  String insureYourShipments() {
    // return "Get things where they need to be fast, and earn or save money.";
    if (lang == 'en') {
      return 'Get things where they need to be fast, and earn or save money.';
    } else if (lang == 'es') {
      return 'Consiga las cosas rápidamente donde sea necesario y gane o ahorre dinero.';
    } else {
      return 'Get things where they need to be fast, and earn or save money.';
    }
  }

  String trustingEachOtherAgain() {
    // return '';
    if (lang == 'en') {
      return 'Trusting each other again.';
    } else if (lang == 'es') {
      return 'Confiando el uno en el otro otra vez.';
    } else {
      return 'Trusting each other again.';
    }
  }
}

OnboardingText onboardingText = OnboardingText();
