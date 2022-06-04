import 'dart:io';

class GeneralText {
  String lang = Platform.localeName.substring(0, 2);

  // LOST CONNECTION ***********************************************

  String closingSession() {
    // return 'Closing session';
    if (lang == 'en') {
      return 'Closing session';
    } else if (lang == 'es') {
      return 'Cerrando sesión';
    } else {
      return 'Closing session';
    }
  }

  String nowMaandoIsLoading() {
    // return 'Closing session';
    if (lang == 'en') {
      return 'Now Maando is loading...\n\n';
    } else if (lang == 'es') {
      return 'Maando está cargando...\n\n';
    } else {
      return 'Now Maando is loading...\n\n';
    }
  }
  String pleaseWaitForAnAmazingExperience() {
    // return 'Closing session';
    if (lang == 'en') {
      return 'Please wait for an amazing experience.';
    } else if (lang == 'es') {
      return 'Ya tendrás una experiencia increíble.';
    } else {
      return 'Please wait for an amazing experience.';
    }
  }

  String allGood() {
    // return 'All good?';
    if (lang == 'en') {
      return 'All good?';
    } else if (lang == 'es') {
      return '¿Todo bien?';
    } else {
      return 'All good?';
    }
  }

  String oopslooksLike() {
    // return 'Oops! Looks like we have lost connection with the server.';
    if (lang == 'en') {
      return 'Oops! Looks like we have lost connection with the server.';
    } else if (lang == 'es') {
      return '¡Ups! Parece que hemos perdido la conexión con el servidor.';
    } else {
      return 'Oops! Looks like we have lost connection with the server.';
    }
  }

  String reload() {
    // return 'Reload';
    if (lang == 'en') {
      return 'Reload';
    } else if (lang == 'es') {
      return 'Recargar';
    } else {
      return 'Reload';
    }
  }

  String search() {
    // return 'Search';
    if (lang == 'en') {
      return 'Search';
    } else if (lang == 'es') {
      return 'Buscar';
    } else {
      return 'Search';
    }
  }

  String searchDeliveryAddress() {
    // return 'Find delivery address';
    if (lang == 'en') {
      return 'Find delivery address';
    } else if (lang == 'es') {
      return 'Buscar dirección de entrega';
    } else {
      return 'Find delivery address';
    }
  }

  String home() {
    // return 'Home';
    if (lang == 'en') {
      return 'Home';
    } else if (lang == 'es') {
      return 'Inicio';
    } else {
      return 'Home';
    }
  }

  String store() {
    // return 'Home';
    if (lang == 'en') {
      return 'Store';
    } else if (lang == 'es') {
      return 'Tienda';
    } else {
      return 'Store';
    }
  }

  String clear() {
    // return 'Clear';
    if (lang == 'en') {
      return 'Clear';
    } else if (lang == 'es') {
      return 'Limpiar';
    } else {
      return 'Clear';
    }
  }

  String flight() {
    // return 'Flight';
    if (lang == 'en') {
      return 'Flight';
    } else if (lang == 'es') {
      return 'Vuelo';
    } else {
      return 'Flight';
    }
  }

  String departure() {
    // return 'Departure';
    if (lang == 'en') {
      return 'Departure';
    } else if (lang == 'es') {
      return 'Salida';
    } else {
      return 'Departure';
    }
  }

  String destination() {
    // return 'Destination';
    if (lang == 'en') {
      return 'Destination';
    } else if (lang == 'es') {
      return 'Destino';
    } else {
      return 'Destination';
    }
  }

  String typePackage() {
    // return 'Package type';
    if (lang == 'en') {
      return 'Package type';
    } else if (lang == 'es') {
      return 'Tipo de paquete';
    } else {
      return 'Package type';
    }
  }

  String customerratings() {
    // return 'Customer ratings';
    if (lang == 'en') {
      return 'Customer ratings';
    } else if (lang == 'es') {
      return 'Valoraciones de clientes';
    } else {
      return 'Customer ratings';
    }
  }

  String seeCustomerReviews() {
    // return 'See customer reviews';
    if (lang == 'en') {
      return 'See customer reviews';
    } else if (lang == 'es') {
      return 'Ver opiniones de clientes';
    } else {
      return 'See customer reviews';
    }
  }

  String departsArrives() {
    // return 'Departs / Arrives';
    if (lang == 'en') {
      return 'Departs / Arrives';
    } else if (lang == 'es') {
      return 'Salida / Llegada';
    } else {
      return 'Departs / Arrives';
    }
  }

  String hi() {
    // return 'Hi';
    if (lang == 'en') {
      return 'Hi';
    } else if (lang == 'es') {
      return 'Hola';
    } else {
      return 'Hi';
    }
  }

  String needToTransport() {
    // return 'Need to transport';
    if (lang == 'en') {
      return 'Need to transport';
    } else if (lang == 'es') {
      return 'Necesidad de transporte';
    } else {
      return 'Need to transport';
    }
  }

  String of() {
    // return 'of';
    if (lang == 'en') {
      return 'of';
    } else if (lang == 'es') {
      return 'de';
    } else {
      return 'of';
    }
  }

  String next() {
    // return 'Next';
    if (lang == 'en') {
      return 'Next';
    } else if (lang == 'es') {
      return 'Siguiente';
    } else {
      return 'Next';
    }
  }

  String sendrequest() {
    // return 'Send request';
    if (lang == 'en') {
      return 'Send request';
    } else if (lang == 'es') {
      return 'Enviar petición';
    } else {
      return 'Send request';
    }
  }

  String cancel() {
    // return 'Cancel';
    if (lang == 'en') {
      return 'Cancel';
    } else if (lang == 'es') {
      return 'Cancelar';
    } else {
      return 'Cancel';
    }
  }

  String add() {
    // return 'Add';
    if (lang == 'en') {
      return 'Add';
    } else if (lang == 'es') {
      return 'Añadir';
    } else {
      return 'CancAddel';
    }
  }

  String back() {
    // return 'Back';
    if (lang == 'en') {
      return 'Back';
    } else if (lang == 'es') {
      return 'Anterior';
    } else {
      return 'Back';
    }
  }

  String weWillGetItThereFast() {
    // return 'Together, we all win!';
    if (lang == 'en') {
      return 'Together, we all win!';
    } else if (lang == 'es') {
      return '¡Juntos, todos ganamos!';
    } else {
      return 'Together, we all win!';
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

  String loadingPlaces() {
    // return 'Loading places...';
    if (lang == 'en') {
      return 'Loading places...';
    } else if (lang == 'es') {
      return 'Cargando lugares...';
    } else {
      return 'Loading places...';
    }
  }

  
  List<String> titlesDropdownPlaces() {
    // return ['Province', 'District', 'Correction', 'Neighborhood', 'Adrress'];
    if (lang == 'en') {
      return ['Province', 'District', 'Correction', 'Neighborhood', 'Adrress'];
    } else if (lang == 'es') {
      return ['Provincia', 'Distrito', 'Corregimiento', 'Barrio', 'Dirección'];
    } else {
      return ['Province', 'District', 'Correction', 'Neighborhood', 'Adrress'];
    }
  }

  String destinaTionMobileNumber() {
    // return 'Destination mobile number ';
    if (lang == 'en') {
      return 'Destination mobile number ';
    } else if (lang == 'es') {
      return 'Número de móvil de destino';
    } else {
      return 'Destination mobile number ';
    }
  }


  String deliveryContactName() {
    // return 'Delivery contact name';
    if (lang == 'en') {
      return 'Delivery contact name';
    } else if (lang == 'es') {
      return 'Nombre de contacto de entrega';
    } else {
      return 'Delivery contact name';
    }
  }

  String dateToDeliver() {
    // return 'Date to deliver';
    if (lang == 'en') {
      return 'Date to deliver';
    } else if (lang == 'es') {
      return 'Fecha de entrega';
    } else {
      return 'Date to deliver';
    }
  }

  String deliveryLocation() {
    // return 'Delivery location';
    if (lang == 'en') {
      return 'Delivery location';
    } else if (lang == 'es') {
      return 'Lugar de entrega';
    } else {
      return 'Delivery location';
    }
  }

  String readyForPublish() {
    // return 'Ready for publish';
    if (lang == 'en') {
      return 'Ready for publish';
    } else if (lang == 'es') {
      return 'Listo para publicar';
    } else {
      return 'Ready for publish';
    }
  }

  String takeService() {
    // return 'Take service';
    if (lang == 'en') {
      return 'Take service';
    } else if (lang == 'es') {
      return 'Tomar servicio';
    } else {
      return 'Take service';
    }
  }

  String errorSystemTryEnterngAgain() {
    // return 'Error in the system. try entering again.';
    if (lang == 'en') {
      return 'Error in the system. try entering again.';
    } else if (lang == 'es') {
      return 'Error en el sistema. intente ingresar nuevamente.';
    } else {
      return 'Error in the system. try entering again.';
    }
  }

  String invalidData() {
    // return 'Invalid data';
    if (lang == 'en') {
      return 'Invalid data';
    } else if (lang == 'es') {
      return 'Datos inválidos';
    } else {
      return 'Invalid data';
    }
  }

  String information() {
    // return 'Information';
    if (lang == 'en') {
      return 'Information';
    } else if (lang == 'es') {
      return 'Información';
    } else {
      return 'Information';
    }
  }

  String yourCurrentPaymentMethodIs(String method) {
    // return 'Your current payment method is: $method';
    if (lang == 'en') {
      return 'Your current payment method is: $method';
    } else if (lang == 'es') {
      return 'Su método de pagos actual es: $method';
    } else {
      return 'Your current payment method is: $method';
    }
  }

  String checketYourPaymentMethods() {
    // return 'Check your payment methods in the side menu.';
    if (lang == 'en') {
      return 'Check your payment methods in the side menu.';
    } else if (lang == 'es') {
      return 'Revise en el menú lateral sus métodos de pago.';
    } else {
      return 'Check your payment methods in the side menu.';
    }
  }
  
  String updateYourProfile() {
    // return 'Update your profile (phone, country and city).';
    if (lang == 'en') {
      return 'Update your profile (phone, country and city).';
    } else if (lang == 'es') {
      return 'Actualiza tu perfil (teléfono, país y ciudad).';
    } else {
      return 'Update your profile (phone, country and city).';
    }
  }

  String theIsNoTypePackage() {
    // return 'There is no kind of package';
    if (lang == 'en') {
      return 'There is no kind of package';
    } else if (lang == 'es') {
      return 'No hay ningún tipo de paquete';
    } else {
      return 'There is no kind of package';
    }
  }

  String theIsNoInsurance() {
    // return 'There is no insurance';
    if (lang == 'en') {
      return 'There is no insurance';
    } else if (lang == 'es') {
      return 'No hay seguro';
    } else {
      return 'There is no insurance';
    }
  }

  String insurance() {
    // return 'Insurance';
    if (lang == 'en') {
      return 'Insurance';
    } else if (lang == 'es') {
      return 'Seguro';
    } else {
      return 'Insurance';
    }
  }

  // *************** ELEMENTS

  String addElements() {
   //  return 'Add elements';
    if (lang == 'en') {
      return 'Add elements';
    } else if (lang == 'es') {
      return 'Agregar elementos';
    } else {
      return 'Add elements';
    }
  }

  String theElementsOnTheList() {
   //  return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    if (lang == 'en') {
      return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    } else if (lang == 'es') {
      return 'Los elementos de la siguiente lista pueden transportarse en un tamaño de equipaje compacto.';
    } else {
      return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    }
  }

  String theElementsOnTheListCompact() {
    // return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    if (lang == 'en') {
      return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    } else if (lang == 'es') {
      return 'Los elementos de la siguiente lista pueden transportarse en un tamaño de equipaje compacto.';
    } else {
      return 'The elements on the list below are allowed to be transported in a compact luggage size.';
    }
  }

  String theElementsOnTheLWeve() {
    // return 'We’ve found a match';
    if (lang == 'en') {
      return 'We’ve found a match';
    } else if (lang == 'es') {
      return 'Hemos encontrado una coincidencia';
    } else {
      return 'We’ve found a match';
    }
  }

  String resetPassword() {
    // return 'A password reset email has been sent to the email address provided.';
    if (lang == 'en') {
      return 'A password reset email has been sent to the email address provided.';
    } else if (lang == 'es') {
      return 'Se le ha enviado un correo electrónico de restablecimiento de contraseña a la dirección de correo electrónico proporcionada.';
    } else {
      return 'A password reset email has been sent to the email address provided.';
    }
  }

  String errorEmail() {
    // return 'The email you provide is not correct.';
    if (lang == 'en') {
      return 'The email you provide is not correct.';
    } else if (lang == 'es') {
      return 'El correo electrónico que proporciona no es correcto.';
    } else {
      return 'The email you provide is not correct.';
    }
  }

  String country() {
    // return 'Country';
    if (lang == 'en') {
      return 'Country';
    } else if (lang == 'es') {
      return 'País';
    } else {
      return 'Country';
    }
  }

  String city() {
    // return 'City';
    if (lang == 'en') {
      return 'City';
    } else if (lang == 'es') {
      return 'Cuidad';
    } else {
      return 'City';
    }
  }

  String atTheFrontDoor() {
    // return 'At the front door';
    if (lang == 'en') {
      return 'At the front door';
    } else if (lang == 'es') {
      return 'En la puerta de entrada ';
    } else {
      return 'At the front door';
    }
  }

  String takingOff() {
    // return 'Taking off';
    if (lang == 'en') {
      return 'Taking off';
    } else if (lang == 'es') {
      return 'Despegando ';
    } else {
      return 'Taking off';
    }
  }

  String landing() {
    // return 'Landing';
    if (lang == 'en') {
      return 'Landing';
    } else if (lang == 'es') {
      return 'Aterrizando';
    } else {
      return 'Landing';
    }
  }

  String atTheExitDoor() {
    // return 'At the exit door';
    if (lang == 'en') {
      return 'At the exit door';
    } else if (lang == 'es') {
      return 'En la puerta de salida';
    } else {
      return 'At the exit door';
    }
  }

  String delivered() {
    // return 'delivered';
    if (lang == 'en') {
      return 'delivered';
    } else if (lang == 'es') {
      return 'Entregado';
    } else {
      return 'delivered';
    }
  }

  String transportationPackageCost() {
    // return 'Transportation package cost';
    if (lang == 'en') {
      return 'Transportation package cost';
    } else if (lang == 'es') {
      return 'Costo del transporte del paquete';
    } else {
      return 'Transportation package cost';
    }
  }

  String ourCompetitorsRate() {
    // return 'Our competitors rate:';
    if (lang == 'en') {
      return 'Our competitors rate:';
    } else if (lang == 'es') {
      return 'Nuestra competencia califica:';
    } else {
      return 'Our competitors rate:';
    }
  }

  String send() {
    // return 'Send';
    if (lang == 'en') {
      return 'Send';
    } else if (lang == 'es') {
      return 'Enviar';
    } else {
      return 'Send';
    }
  }

  String logOut() {
    // return 'Log Out';
    if (lang == 'en') {
      return 'Log Out';
    } else if (lang == 'es') {
      return 'Cerrar sesión';
    } else {
      return 'Log Out';
    }
  }

  String servicesHistory() {
   //  return 'Service History';
    if (lang == 'en') {
      return 'Service History';
    } else if (lang == 'es') {
      return 'Historial de servicio';
    } else {
      return 'Service History';
    }
  }

  String paymentMethods() {
    // return 'Payment method';
    if (lang == 'en') {
      return 'Payment method';
    } else if (lang == 'es') {
      return 'Método de pago';
    } else {
      return 'Payment method';
    }
  }

  String youMuchHaveAApypalAccountToReceivePaymentForYourService() {
    // return 'You must have a PayPal account to receive payment for your service.';
    if (lang == 'en') {
      return 'You must have a PayPal account to receive payment for your service.';
    } else if (lang == 'es') {
      return 'Debes tener una cuenta de PayPal para recibir el pago por tu servicio.';
    } else {
      return 'You must have a PayPal account to receive payment for your service.';
    }
  }

  String selectYourPreferredMethodOfPayment() {
    // return 'Select your preferred  method of payment.';
    if (lang == 'en') {
      return 'Select your preferred  method of payment.';
    } else if (lang == 'es') {
      return 'Seleccione su método de pago preferido.';
    } else {
      return 'Select your preferred  method of payment.';
    }
  }

  String maandoRequiresThaYouGrantGeoLocation() {
    // return 'Maando requires that you grant GeoLocation permissions to your device in order to be attentive to the sending of your packages.';
    if (lang == 'en') {
      return 'Maando requires that you grant GeoLocation permissions to your device in order to be attentive to the sending of your packages.';
    } else if (lang == 'es') {
      return 'Maando requiere que usted conseda permisos de GeoLocalización de a su dispositivo para poder estar atento a el envio de sus paquetes.';
    } else {
      return 'Maando requires that you grant GeoLocation permissions to your device in order to be attentive to the sending of your packages.';
    }
  }

  String maandoRequiresThaYouGrantGallery() {
    // return 'Maando requires that you grant permission to access photos and files on your device in order to post an ad.';
    if (lang == 'en') {
      return 'Maando requires that you grant permission to access photos and files on your device in order to post an ad.';
    } else if (lang == 'es') {
      return 'Maando requiere que usted conseda permisos de  acceder a fotos y archivos de a su dispositivo para poder publicar un anuncio.';
    } else {
      return 'Maando requires that you grant permission to access photos and files on your device in order to post an ad.';
    }
  }

  String maandoRequiresThaYouGrantCamera() {
    // return 'Maando requires that you grant permission to access the camera on your device in order to post an ad.';
    if (lang == 'en') {
      return 'Maando requires that you grant permission to access the camera on your device in order to post an ad.';
    } else if (lang == 'es') {
      return 'Maando requiere que usted conseda permisos de  acceder a la cámara de a su dispositivo para poder publicar un anuncio.';
    } else {
      return 'Maando requires that you grant permission to access the camera on your device in order to post an ad.';
    }
  }

  String grantPermissionsFromTheAppSettings() {
    // return 'Grant permissions from the app settings.';
    if (lang == 'en') {
      return 'Grant permissions from the app settings.';
    } else if (lang == 'es') {
      return 'Otorgar permisos desde las configuraciones de la app.';
    } else {
      return 'Grant permissions from the app settings.';
    }
  }

  String selecAPaymentMethod() {
    // return 'Select a payment method';
    if (lang == 'en') {
      return 'Select a payment method';
    } else if (lang == 'es') {
      return 'Seleccione un método de pago';
    } else {
      return 'Select a payment method';
    }
  }

  String profile() {
    // return 'Profile';
    if (lang == 'en') {
      return 'Profile';
    } else if (lang == 'es') {
      return 'Perfil';
    } else {
      return 'Profile';
    }
  }

  String admin() {
    // return 'Admin';
    if (lang == 'en') {
      return 'Admin';
    } else if (lang == 'es') {
      return 'Administrador';
    } else {
      return 'Admin';
    }
  }

  String history() {
    // return 'History';
    if (lang == 'en') {
      return 'History';
    } else if (lang == 'es') {
      return 'Historial';
    } else {
      return 'History';
    }
  }

  String searchMatches() {
    // return 'Search Matches';
    if (lang == 'en') {
      return 'Search Matches';
    } else if (lang == 'es') {
      return 'Buscar coincidencias';
    } else {
      return 'Search Matches';
    }
  }

  String deleteAd() {
    // return 'Delete ad';
    if (lang == 'en') {
      return 'Delete ad';
    } else if (lang == 'es') {
      return 'Eliminar anuncio';
    } else {
      return 'Delete ad';
    }
  }

  String approveRequest() {
    // return 'Approve request';
    if (lang == 'en') {
      return 'Approve request';
    } else if (lang == 'es') {
      return 'Aprobar solicitud';
    } else {
      return 'Approve request';
    }
  }

  String yourRequestIsPendingApproval() {
    // return 'Your request is pending approval';
    if (lang == 'en') {
      return 'Your request is pending approval.';
    } else if (lang == 'es') {
      return 'Su solicitud está pendiente a aprobación.';
    } else {
      return 'Your request is pending approval.';
    }
  }

  String arequestToSendAPackageHasBeenPublishedPendingForApproval() {
    // return 'A request to send a package has been published, pending for approval.';
    if (lang == 'en') {
      return 'A request to send a package has been published, pending for approval.';
    } else if (lang == 'es') {
      return 'Se ha publicado una solicitud de envio de paquete, pendiente por aprobación.';
    } else {
      return 'A request to send a package has been published, pending for approval.';
    }
  }

  String deleteFlight() {
    // return 'Delete flight';
    if (lang == 'en') {
      return 'Delete flight';
    } else if (lang == 'es') {
      return 'Eliminar vuelo';
    } else {
      return 'Delete flight';
    }
  }

  String delete() {
    // return 'Delete';
    if (lang == 'en') {
      return 'Delete';
    } else if (lang == 'es') {
      return 'Eliminar';
    } else {
      return 'Delete';
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
  String trips() {
    // return 'Edit';
    if (lang == 'en') {
      return 'Trips';
    } else if (lang == 'es') {
      return 'Viajes';
    } else {
      return 'Trips';
    }
  }
  String packages() {
    // return 'Edit';
    if (lang == 'en') {
      return 'Packages';
    } else if (lang == 'es') {
      return 'Paquetes';
    } else {
      return 'Packages';
    }
  }

  String comment() {
    // return 'Comment';
    if (lang == 'en') {
      return 'Comment';
    } else if (lang == 'es') {
      return 'Comentar';
    } else {
      return 'Comment';
    }
  }

  String viewNotification() {
    // return 'See notification';
    if (lang == 'en') {
      return 'See notification';
    } else if (lang == 'es') {
      return 'Ver notificación';
    } else {
      return 'See notification';
    }
  }

  String seeDetail() {
    // return 'See detail';
    if (lang == 'en') {
      return 'See detail';
    } else if (lang == 'es') {
      return 'Ver detalle';
    } else {
      return 'See detail';
    }
  }



  String copy() {
   //  return 'Copy';
    if (lang == 'en') {
      return 'Copy';
    } else if (lang == 'es') {
      return 'Copiar';
    } else {
      return 'Copy';
    }
  }

  String copied() {
   //  return 'Copied';
    if (lang == 'en') {
      return 'Copied';
    } else if (lang == 'es') {
      return 'Copiado';
    } else {
      return 'Copied';
    }
  }

  String noresults() {
    // return 'No results.';
    if (lang == 'en') {
      return 'No results.';
    } else if (lang == 'es') {
      return 'No hay resultados.';
    } else {
      return 'No results.';
    }
  }

  String title() {
    // return 'Title';
    if (lang == 'en') {
      return 'Title';
    } else if (lang == 'es') {
      return 'Título';
    } else {
      return 'Title';
    }
  }

  String options() {
   //  return 'Options';
    if (lang == 'en') {
      return 'Options';
    } else if (lang == 'es') {
      return 'Opciones';
    } else {
      return 'Options';
    }
  }

  String flightMatchList() {
    // return 'Flight match list.';
    if (lang == 'en') {
      return 'Flight match list.';
    } else if (lang == 'es') {
      return 'Lista de coincidencias de vuelos.';
    } else {
      return 'Flight match list.';
    }
  }

  String adsMatchList() {
   //  return 'List of ad matches.';
    if (lang == 'en') {
      return 'List of ad matches.';
    } else if (lang == 'es') {
      return 'Lista de coincidencias de anuncios.';
    } else {
      return 'List of ad matches.';
    }
  }

  String listOfpendingFlights() {
   //  return 'Pending flights';
    if (lang == 'en') {
      return 'Pending flights';
    } else if (lang == 'es') {
      return 'Vuelos pendientes.';
    } else {
      return 'Pending flights.';
    }
  }

  String listOfpendingAds() {
   //  return 'Pending announcements';
    if (lang == 'en') {
      return 'Pending announcements';
    } else if (lang == 'es') {
      return 'Anuncios pendientes';
    } else {
      return 'Pending announcements';
    }
  }

  String confirmSubmirRequestFlight() {
   //  return 'Are you sure you want to submit the request to take your package on this flight?';
    if (lang == 'en') {
      return 'Are you sure you want to submit the request to take your package on this flight?';
    } else if (lang == 'es') {
      return '¿Está seguro que desea enviar la solicitud de llevar su paquete en este vuelo?';
    } else {
      return 'Are you sure you want to submit the request to take your package on this flight?';
    }
  }

  String suggestOffer() {
   //  return 'Suggest offer';
    if (lang == 'en') {
      return 'Suggest offer';
    } else if (lang == 'es') {
      return 'Sugerir oferta';
    } else {
      return 'Suggest offer';
    }
  }


  String ifYourServiceDoesntHaveToBeImmediate() {
    // return 'If your service doesn’t have to be immediate, we have deals from 30 USD and will get to its destination in 9 working days.';
    if (lang == 'en') {
      return 'If your service doesn’t have to be immediate, we have deals from 30 USD and will get to its destination in 9 working days.';
    } else if (lang == 'es') {
      return 'Si tu servicio no es inmediato, puedes hacer una oferta a partir de 30 USD y llegará a tu destino en 9 días hábiles.';
    } else {
      return 'If your service doesn’t have to be immediate, we have deals from 30 USD and will get to its destination in 9 working days.';
    }
  }

  String onlyForPackagesThatHaveNoUrgency() {
    // return 'Only for packages that have no urgency.';
    if (lang == 'en') {
      return 'Only for packages that have no urgency.';
    } else if (lang == 'es') {
      return 'Únicamente para paquetes que no tengan urgencia.';
    } else {
      return 'Only for packages that have no urgency.';
    }
  }

  String ourDealsStartsIn30USD() {
    // return 'Our deals starts in 30 USD.';
    if (lang == 'en') {
      return 'Our deals starts in 30 USD.';
    } else if (lang == 'es') {
      return 'Nuestros acuerdos inician en 30 USD.';
    } else {
      return 'Our deals starts in 30 USD.';
    }
  }

  String suggest() {
   //  return 'Suggest';
    if (lang == 'en') {
      return 'Suggest';
    } else if (lang == 'es') {
      return 'Sugerir';
    } else {
      return 'Suggest';
    }
  }

  String skip() {
    // return 'Skip';
    if (lang == 'en') {
      return 'Skip';
    } else if (lang == 'es') {
      return 'Saltar';
    } else {
      return 'Skip';
    }
  }

  String submit() {
    // return 'Submit';
    if (lang == 'en') {
      return 'Submit';
    } else if (lang == 'es') {
      return 'Enviar';
    } else {
      return 'Submit';
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


  
  String myNameIs() {
   //  return 'Hello my name is';
    if (lang == 'en') {
      return 'Hello my name is';
    } else if (lang == 'es') {
      return 'Hola, mi nombre es';
    } else {
      return 'Hello my name is';
    }
  }

  String chooseThePackageYouWantToTakeWithThisFlight() {
    // return 'Choose the package you want to take with this flight.';
    if (lang == 'en') {
      return 'Choose the package you want to take with this flight.';
    } else if (lang == 'es') {
      return 'Escoja el paquete que desée llevar con este vuelo.';
    } else {
      return 'Choose the package you want to take with this flight.';
    }
  }

  String youDoNnotHaveAdsTthatWatchThisFlight() {
    // return 'You do not have ads that match this flight.';
    if (lang == 'en') {
      return 'You do not have ads that match this flight.';
    } else if (lang == 'es') {
      return 'No tienes anuncios que coincidan con este vuelo.';
    } else {
      return 'You do not have ads that match this flight.';
    }
  }

  String loadingStatus() {
   //  return 'Loading status ...';
    if (lang == 'en') {
      return 'Loading status ...';
    } else if (lang == 'es') {
      return 'Cargando el estado ...';
    } else {
      return 'Loading status ...';
    }
  }

  String errorLoadingState() {
    // return 'Failed to load status';
    if (lang == 'en') {
      return 'Failed to load status';
    } else if (lang == 'es') {
      return 'Error al cargar el estado';
    } else {
      return 'Failed to load status';
    }
  }

  String numberRequestPending(int numero) {
   //  return 'You have $numero pending requests';
    if (lang == 'en') {
      return 'You have $numero pending requests';
    } else if (lang == 'es') {
      return 'Tienes $numero solicitudes pendientes';
    } else {
      return 'You have $numero pending requests';
    }
  }

  String success() {
    // return 'Success';
    if (lang == 'en') {
      return 'Success';
    } else if (lang == 'es') {
      return 'Éxito';
    } else {
      return 'Success';
    }
  }

  String paymentsSuccessful() {
    // return 'Successful payment';
    if (lang == 'en') {
      return 'Successful payment';
    } else if (lang == 'es') {
      return 'Pago exitoso';
    } else {
      return 'Successful payment';
    }
  }

  String ad() {
    // return 'Ad';
    if (lang == 'en') {
      return 'Ad';
    } else if (lang == 'es') {
      return 'Anuncio';
    } else {
      return 'Ad';
    }
  }

  String editProfile() {
    // return 'Edit profile';
    if (lang == 'en') {
      return 'Edit profile';
    } else if (lang == 'es') {
      return 'Editar perfil';
    } else {
      return 'Edit profile';
    }
  }

  String editName() {
    // return 'Edit name';
    if (lang == 'en') {
      return 'Edit name';
    } else if (lang == 'es') {
      return 'Editar nombre';
    } else {
      return 'Edit name';
    }
  }

  String editPhone() {
    // return 'Edit phone';
    if (lang == 'en') {
      return 'Edit phone';
    } else if (lang == 'es') {
      return 'Editar teléfono';
    } else {
      return 'Edit phone';
    }
  }

  String stripeAccount() {
   //  return 'Stripe account';
    if (lang == 'en') {
      return 'Stripe account';
    } else if (lang == 'es') {
      return 'Cuenta de Stripe';
    } else {
      return 'Stripe account';
    }
  } 

  String paypalAccount() {
    // return 'Paypal account';
    if (lang == 'en') {
      return 'Paypal account';
    } else if (lang == 'es') {
      return 'Cuenta de Paypal';
    } else {
      return 'Paypal account';
    }
  } 

  String numberAccount() {
    // return 'Number account';
    if (lang == 'en') {
      return 'Number account';
    } else if (lang == 'es') {
      return 'Número de cuenta';
    } else {
      return 'Number account';
    }
  }

  String typeAccount() {
    // return 'Type account';
    if (lang == 'en') {
      return 'Type account';
    } else if (lang == 'es') {
      return 'Tipo de cuenta';
    } else {
      return 'Type account';
    }
  }

  String bank() {
    // return 'Bank';
    if (lang == 'en') {
      return 'Bank';
    } else if (lang == 'es') {
      return 'Banco';
    } else {
      return 'Bank';
    }
  }

  String codeBicOrSwitf() {
    // return 'BIC or SWIFT code';
    if (lang == 'en') {
      return 'BIC or SWIFT code';
    } else if (lang == 'es') {
      return 'Código BIC o SWIFT';
    } else {
      return 'BIC or SWIFT code';
    }
  }

  String ibanCode() {
   //  return 'IBAN code';
    if (lang == 'en') {
      return 'IBAN code';
    } else if (lang == 'es') {
      return 'Código IBAN';
    } else {
      return 'IBAN code';
    }
  }

  String editCountry() {
    // return 'Edit country';
    if (lang == 'en') {
      return 'Edit country';
    } else if (lang == 'es') {
      return 'Editar país';
    } else {
      return 'Edit country';
    }
  }

  String editCity() {
    // return 'Edit city';
    if (lang == 'en') {
      return 'Edit city';
    } else if (lang == 'es') {
      return 'Editar cuidad';
    } else {
      return 'Edit city';
    }
  }

  String modaLocationInTheBackground() {
    // return 'This application collects location data to allow tracking of the shipment of your packages, even when the application is closed or not in use.';
    if (lang == 'en') {
      return 'This application collects location data to track your packages, even when the application is closed or not in use.';
    } else if (lang == 'es') {
      return 'Esta aplicación recopila datos de ubicación para permitir el rastreo del envío de sus paquetes, incluso cuando la aplicación está cerrada o no está en uso.';
    } else {
      return 'This application collects location data tto track your packages, even when the application is closed or not in use.';
    }
  }


  String selectACountry() {
      // return 'Select a country';
    if (lang == 'en') {
      return 'Select a country';
    } else if (lang == 'es') {
      return 'Seleccione un país';
    } else {
      return 'Select a country';
    }
  }

  String selectACity() {
      // return 'Select a city';
    if (lang == 'en') {
      return 'Select a city';
    } else if (lang == 'es') {
      return 'Seleccione una ciudad';
    } else {
      return 'Select a city';
    }
  }

  String enterMobilePhoneNumber() {
      // return 'Enter mobile phone number';
    if (lang == 'en') {
      return 'Enter mobile phone number';
    } else if (lang == 'es') {
      return 'Ingrese número de teléfono móvil';
    } else {
      return 'Enter mobile phone number';
    }
  }

  String iTrustThisPerson() {
      // return 'I trust this person';
    if (lang == 'en') {
      return 'I trust this person';
    } else if (lang == 'es') {
      return 'Confío en esta persona';
    } else {
      return 'I trust this person';
    }
  }

  String antiDrugAntiExplosiveScreeningOfPackage() {
      // return 'Anti-drug & Anti-explosive screening of package';
    if (lang == 'en') {
      return 'Anti-drug & Anti-explosive screening of package';
    } else if (lang == 'es') {
      return 'Antidrogas y antiexplosivo del paquete';
    } else {
      return 'Anti-drug & Anti-explosive screening of package';
    }
  }

  String free() {
      // return 'Free';
    if (lang == 'en') {
      return 'Free';
    } else if (lang == 'es') {
      return 'Gratis';
    } else {
      return 'Free';
    }
  }

    String makeYourPurchasesThrough() {
    // return 'Make your purchases through us and send them to our office: 745 Fifth Avenue, Suite 500. New York, NY 10151 Maando LLC. Once we have them, they will arrive at your home in Colombia 96 hours later.';
    if (lang == 'en') {
      return 'Make your purchases through us and send them to our office: 745 Fifth Avenue, Suite 500. New York, NY 10151 Maando LLC. Once we have them, they will arrive at your home in Colombia 96 hours later.';
    } else if (lang == 'es') {
      return 'Realice sus compras a través de nosotros y envíelos a nuestra oficina: 745 Fifth Avenue, Suite 500. New York, NY 10151 Maando LLC. Una vez las recibamos, llegarán a tu domicilio en Colombia 96 horas después.';
    } else {
      return 'Make your purchases through us and send them to our office: 745 Fifth Avenue, Suite 500. New York, NY 10151 Maando LLC. Once we have them, they will arrive at your home in Colombia 96 hours later.';
    }
  }

    String checkHereTheShippingRateBeforeMakingTheurPchase() {
      // return 'Check here the shipping rate before making the purchase.';
    if (lang == 'en') {
      return 'Check here the shipping rate before making the purchase.';
    } else if (lang == 'es') {
      return 'Consulta aquí la tarifa del envío antes de realizar la compra.';
    } else {
      return 'Check here the shipping rate before making the purchase.';
    }
  }

    String needHelp() {
      // return 'Need help?';
    if (lang == 'en') {
      return 'Need help?';
    } else if (lang == 'es') {
      return '¿Necesitas ayuda?';
    } else {
      return 'Need help?';
    }
  }

  String yourShippingRequestHasBeenApproved({String title = ''}) {
      // return 'Your "$title" shipping request has been approved';
    if (lang == 'en') {
      return 'Your "$title" shipping request has been approved';
    } else if (lang == 'es') {
      return 'Su solicitud de envío "$title" ha sido aprobada';
    } else {
      return 'Your "$title" shipping request has been approved';
    }
  }

  String yourShippingRequestHasNotBeenApproved({String title = ''}) {
      // return 'Your "$title" shipping request has been approved';
    if (lang == 'en') {
      return 'Your "$title" shipping request has not been approved';
    } else if (lang == 'es') {
      return 'Su solicitud de envío "$title" no ha sido aprobada';
    } else {
      return 'Your "$title" shipping request has not been approved';
    }
  }
  
}

GeneralText generalText = GeneralText();
