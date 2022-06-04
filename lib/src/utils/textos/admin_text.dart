import 'dart:io';

class AdminText {
  String lang = Platform.localeName.substring(0, 2);

  String users() {
    // return 'Users';
    if (lang == 'en') {
      return 'Users';
    } else if (lang == 'es') {
      return 'Usuarios';
    } else {
      return 'Users';
    }
  }

  String notApproved() {
    // return 'Not approved';
    if (lang == 'en') {
      return 'Not approved';
    } else if (lang == 'es') {
      return 'No aprobados';
    } else {
      return 'Not approved';
    }
  }

  String founder() {
    // return 'Founder';
    if (lang == 'en') {
      return 'Founder';
    } else if (lang == 'es') {
      return 'Fundador';
    } else {
      return 'Founder';
    }
  }

  String teamMaando() {
    // return 'Team Maando';
    if (lang == 'en') {
      return 'Team Maando';
    } else if (lang == 'es') {
      return 'Equipo Maando';
    } else {
      return 'Team Maando';
    }
  }

  String flights() {
    // return 'Flights';
    if (lang == 'en') {
      return 'Flights';
    } else if (lang == 'es') {
      return 'Vuelos';
    } else {
      return 'Flights';
    }
  }

  String payments() {
    // return 'Paiments';
    if (lang == 'en') {
      return 'Paiments';
    } else if (lang == 'es') {
      return 'Pagos';
    } else {
      return 'Paiments';
    }
  }

  String active() {
    // return 'Active';
    if (lang == 'en') {
      return 'Active';
    } else if (lang == 'es') {
      return 'Activo';
    } else {
      return 'Active';
    }
  }

  String inactive() {
    // return 'Inactive';
    if (lang == 'en') {
      return 'Inactive';
    } else if (lang == 'es') {
      return 'Inactivo';
    } else {
      return 'Inactive';
    }
  }

  String code() {
    // return 'Code';
    if (lang == 'en') {
      return 'Code';
    } else if (lang == 'es') {
      return 'Código';
    } else {
      return 'Code';
    }
  }

  String isPaid() {
    // return 'Is paid';
    if (lang == 'en') {
      return 'Is paid';
    } else if (lang == 'es') {
      return 'Está pago';
    } else {
      return 'Is paid';
    }
  }

  String noPaid() {
    // return 'Not paid';
    if (lang == 'en') {
      return 'Not paid';
    } else if (lang == 'es') {
      return 'No está pago';
    } else {
      return 'Not paid';
    }
  }
  
  String markAsPaid() {
    // return 'Not paid';
    if (lang == 'en')  {
      return 'Mark as paid';
    } else if (lang == 'es') {
      return 'Marcar como pagado';
    } else {
      return 'Mark as paid';
    }
  }
  
  String airport() {
    // return 'Airport';
    if (lang == 'en')  {
      return 'Airport';
    } else if (lang == 'es') {
      return 'Aeropuerto';
    } else {
      return 'Airport';
    }
  }

  String searchUser() {
    // return 'Search user';
    if (lang == 'en')  {
      return 'Search user';
    } else if (lang == 'es') {
      return 'Buscar usuario';
    } else {
      return 'Search user';
    }
  }

}


AdminText adminText = AdminText();
