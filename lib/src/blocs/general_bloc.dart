// @dart=2.9
import 'dart:async';
import 'package:maando/src/utils/validaciones/post_validation.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:io';

class GeneralBloc with PostValidation {
  var _tokenExpiredController = BehaviorSubject<Timer>();
  var _navigationController = BehaviorSubject<List<bool>>(); // 0 para Home, 1 para Sending y 2 para Taking
  var _sendRequestController = BehaviorSubject<bool>();  //  Mostrar modal
  var _argPageController = BehaviorSubject<Map<String, dynamic>>(); // Se guarga calquier entidad (vuelo, anuncio, etc)
  var _arrayAdController = BehaviorSubject<List<dynamic>>(); // se usapara guardar los matches de os vuelos (anuncios)
  var _arrayFlightSearchController = BehaviorSubject<List<dynamic>>();
  var _registerDeviceController = BehaviorSubject<dynamic>();
  var _homeStoreController = BehaviorSubject<String>(); // controlamos si estamos en home (packages and flight) o store
  var _adController = BehaviorSubject<Map<String, dynamic>>();
  var _flightController = BehaviorSubject<Map<String, dynamic>>();
  var _matchController = BehaviorSubject<dynamic>();
  var _arrayMatchController = BehaviorSubject<List<dynamic>>();
  var _viewNavBarController = BehaviorSubject<bool>();
  var _uploadImagesController = BehaviorSubject<List<bool>>();
  var _avatarFileController = BehaviorSubject<File>();
  var _aiportsOriginController = BehaviorSubject<List<dynamic>>();  // LISTA DE PAISES, CUIDADES Y AEROPUERTOS
  var _aiportsDestinationController = BehaviorSubject<List<dynamic>>();
  // ******
  var _arrayHomeController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los anuncios y los vuelos del home
  var _arrayTripsController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los vuelos del home
  var _arrayPackagesController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los anuncios del home
  var _arrayPackagesNotApprovedController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los anuncios del no aprobados
  var _arrayStoreController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los anuncios del home
  var _arrayPostsController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los pots
  var _arrayPostsToAdmindsController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los pots de usuario a administradores
  var _arrayCommentsController = BehaviorSubject<List<dynamic>>(); // se usa para guardar los comentarios
  var _arrayMyFlightsIntransitController = BehaviorSubject<List<dynamic>>(); // se usa para guardar mis vuelos en trancito (vuelos)
  // ************  POST
  var _orderByController = BehaviorSubject<String>(); // daterange, all, myposts, email, descending, keyword
  var _dateFromController = BehaviorSubject<DateTime>();
  var _dateToController = BehaviorSubject<DateTime>();
  // ************
  var _arrayMyAdsController = BehaviorSubject<List<dynamic>>();
  var _arrayMyFlightsController = BehaviorSubject<List<dynamic>>();
  var _adminsController = BehaviorSubject<List<dynamic>>();

  //  INSERTAR VALORES AL STREAM
  Function(Timer) get tokenExpiredStream => _tokenExpiredController.sink.add;
  Function(Timer) get changeTokenExpired => _tokenExpiredController.sink.add;
  Function(List<bool>) get changeNavigation => _navigationController.sink.add;
  Function(bool) get changeSendRequest => _sendRequestController.sink.add;
  Function(Map<String, dynamic>) get changeArgPage => _argPageController.sink.add;
  Function(List<dynamic>) get changeArrayAd => _arrayAdController.sink.add;
  Function(List<dynamic>) get changeArrayFlightSearch => _arrayFlightSearchController.sink.add;
  Function(dynamic) get changeRegiterDevice => _registerDeviceController.sink.add;
  Function(String) get changeHomeStore => _homeStoreController.sink.add;
  Function(Map<String, dynamic>) get changeAd => _adController.sink.add;
  Function(Map<String, dynamic>) get changeFlight => _flightController.sink.add;
  Function(dynamic) get changeMatch => _matchController.sink.add;
  Function(List<dynamic>) get changeListMatch => _arrayMatchController.sink.add;
  Function(bool) get changeViewNavBar => _viewNavBarController.sink.add;
  Function(List<bool>) get changeUploadImages => _uploadImagesController.sink.add;
  Function(File) get changeAvatarFile => _avatarFileController.sink.add;
  Function(List<dynamic>) get changeAiportsOrigin => _aiportsOriginController.sink.add;
  Function(List<dynamic>) get changeAiportsDestination => _aiportsDestinationController.sink.add;
  // ******
  Function(List<dynamic>) get changeHome => _arrayHomeController.sink.add;
  Function(List<dynamic>) get changeTrips => _arrayTripsController.sink.add;
  Function(List<dynamic>) get changePackages=> _arrayPackagesController.sink.add;
  Function(List<dynamic>) get changePackagesNotApproved=> _arrayPackagesNotApprovedController.sink.add;
  Function(List<dynamic>) get changeStore=> _arrayStoreController.sink.add;
  Function(List<dynamic>) get changePosts => _arrayPostsController.sink.add;
  Function(List<dynamic>) get changePostsToAdmins => _arrayPostsToAdmindsController.sink.add;
  Function(List<dynamic>) get changeComments => _arrayCommentsController.sink.add;

  Function(List<dynamic>) get changeListMyFlightsIntransit => _arrayMyFlightsIntransitController.sink.add;
  // **************  POST
  Function(String) get changeOrderBy => _orderByController.sink.add;
  Function(DateTime) get changeDateFrom => _dateFromController.sink.add;
  Function(DateTime) get changeDateTo => _dateToController.sink.add;
  // *******************
  Function(List<dynamic>) get changeListMyAds => _arrayMyAdsController.sink.add;
  Function(List<dynamic>) get changeListMyFlights => _arrayMyFlightsController.sink.add;
  Function(List<dynamic>) get changeAdmins => _adminsController.sink.add;

  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  Timer get tokenExpired => _tokenExpiredController.value;
  List<bool> get navigation => _navigationController.value;
  bool get sendRequest => _sendRequestController.value;
  Map<String, dynamic> get argPage => _argPageController.value;
  List<dynamic> get arrayAd => _arrayAdController.value;
  List<dynamic> get arrayFlightSearch => _arrayFlightSearchController.value;
  dynamic get registerDevice => _registerDeviceController.value;
  String get homeStore => _homeStoreController.value;
  Map<String, dynamic> get ad => _adController.value;
  Map<String, dynamic> get flight => _flightController.value;
  dynamic get match => _matchController.value;
  List<dynamic> get listMatch => _arrayMatchController.value;
  bool get viewNavBar => _viewNavBarController.value;
  List<bool> get upLoadImages => _uploadImagesController.value;
  File get avatarFile => _avatarFileController.value;
  List<dynamic> get aiportsOrigin => _aiportsOriginController.value;
  List<dynamic> get aiportsDestination => _aiportsDestinationController.value;
  // *****************
  List<dynamic> get home => _arrayHomeController.value;
  List<dynamic> get trips => _arrayTripsController.value;
  List<dynamic> get packages => _arrayPackagesController.value;
  List<dynamic> get packagesNotApprved => _arrayPackagesNotApprovedController.value;
  List<dynamic> get store => _arrayStoreController.value;
  List<dynamic> get posts => _arrayPostsController.value;
  List<dynamic> get postsToAdmins => _arrayPostsToAdmindsController.value;
  List<dynamic> get comments => _arrayCommentsController.value;
  List<dynamic> get listMyFlightsIntransit =>  _arrayMyFlightsIntransitController.value;
  // **************** POST
  String get orderBy => _orderByController.value;
  DateTime get dateFrom => _dateFromController.value;
  DateTime get dateTo => _dateToController.value;
  // ****************
  List<dynamic> get listMyAds => _arrayMyAdsController.value;
  List<dynamic> get listMyFlights => _arrayMyFlightsController.value;
  List<dynamic> get admins => _adminsController.value;



  Stream<List<bool>> get navigationStream => _navigationController.stream;
  Stream<bool> get sendRequestStream => _sendRequestController.stream;
  Stream<Map<String, dynamic>> get argPageStream => _argPageController.stream;
  Stream<List<dynamic>> get arrayAdStream => _arrayAdController.stream;
  Stream<List<dynamic>> get arrayFlightSearchStream => _arrayFlightSearchController.stream;
  Stream<Map<String, dynamic>> get adStream => _adController.stream;
  Stream<Map<String, dynamic>> get flightStream => _flightController.stream;
  Stream<dynamic> get matchStream => _matchController.stream;
  Stream<List<dynamic>> get listMatchStream => _arrayMatchController.stream;
  Stream<bool> get viewNavBarStream => _viewNavBarController.stream;
  Stream<List<bool>> get uploadImagesStream => _uploadImagesController.stream;
  Stream<File> get avatarFileStream => _avatarFileController.stream;
  Stream<List<dynamic>> get aiportsOriginStream => _aiportsOriginController.stream;
  Stream<List<dynamic>> get aiportsDestinationStream => _aiportsDestinationController.stream;
  // ************
  Stream<List<dynamic>> get homeStream => _arrayHomeController.stream;
  Stream<List<dynamic>> get tripsStream => _arrayTripsController.stream;
  Stream<List<dynamic>> get packagesStream => _arrayPackagesController.stream;
  Stream<List<dynamic>> get packagesNotApprovedStream => _arrayPackagesNotApprovedController.stream;
  Stream<List<dynamic>> get storeStream => _arrayStoreController.stream;
  Stream<String> get homeStoreStream => _homeStoreController.stream;
  Stream<List<dynamic>> get postsStream => _arrayPostsController.stream;
  Stream<List<dynamic>> get postsToAdminsStream => _arrayPostsToAdmindsController.stream;
  Stream<List<dynamic>> get commetsStream => _arrayCommentsController.stream;
  Stream<List<dynamic>> get arrayMyFlightsIntransitStream => _arrayMyFlightsIntransitController.stream;
  // ***************  POST
  Stream<String> get orderByStream => _orderByController.stream.transform(validarAux);
  Stream<DateTime> get dateFromStream => _dateFromController.stream;
  Stream<DateTime> get dateToStream => _dateToController.stream;
  Stream<bool> get c => CombineLatestStream.combine2(dateFromStream, dateToStream, (f, t) => true);
  // ********************
  Stream<List<dynamic>> get arrayMyAdsStream => _arrayMyAdsController.stream;
  Stream<List<dynamic>> get arrayMyFlightsStream => _arrayMyFlightsController.stream;
  Stream<List<dynamic>> get adminsStream => _adminsController.stream;


  // HASVALUE
  bool get orderByStreamValue => _orderByController.stream.hasValue;
  bool get dateFromStreamValue => _dateFromController.stream.hasValue;
  bool get dateToStreamValue => _dateToController.stream.hasValue;

  homePrincipal() {
    changeNavigation([true, false, false]);
  }

  shipmentPrincipal() {
    changeNavigation([false, true, false]);
  }

  servicePrincipal() {
    changeNavigation([false, false, true]);
  }

  dispose() {
    _tokenExpiredController?.close();
    _navigationController?.close();
    _sendRequestController?.close();
    _argPageController?.close();
    _arrayAdController?.close();
    _arrayFlightSearchController?.close();
    _registerDeviceController?.close();
    _homeStoreController?.close();
    _adController?.close();
    _flightController?.close();
    _flightController?.close();
    _matchController?.close();
    _arrayMatchController?.close();
    _viewNavBarController?.close();
    _uploadImagesController?.close();
    _avatarFileController?.close();
    _aiportsOriginController?.close();
    _aiportsDestinationController?.close();
    _arrayHomeController?.close();
    _arrayTripsController?.close();
    _arrayPackagesController?.close();
    _arrayPackagesNotApprovedController?.close();
    _arrayStoreController?.close();
    _arrayPostsController?.close();
    _arrayPostsToAdmindsController?.close();
    _arrayCommentsController?.close();
    _arrayMyFlightsIntransitController?.close();
    _orderByController?.close();
    _dateFromController?.close();
    _dateToController?.close();
    _arrayMyAdsController?.close();
    _arrayMyFlightsController?.close();
    _adminsController?.close();
  }

  streamNull() {
    _tokenExpiredController = BehaviorSubject<Timer>();
    _navigationController = BehaviorSubject<List<bool>>();
    _sendRequestController = BehaviorSubject<bool>();
    _argPageController = BehaviorSubject<Map<String, dynamic>>();
    _arrayAdController = BehaviorSubject<List<dynamic>>();
    _arrayFlightSearchController = BehaviorSubject<List<dynamic>>();
    _registerDeviceController = BehaviorSubject<dynamic>();
    _homeStoreController = BehaviorSubject<String>();
    _adController = BehaviorSubject<Map<String, dynamic>>();
    _flightController = BehaviorSubject<Map<String, dynamic>>();
    _matchController = BehaviorSubject<dynamic>();
    _arrayMatchController = BehaviorSubject<List<dynamic>>();
    _viewNavBarController = BehaviorSubject<bool>();
    _uploadImagesController = BehaviorSubject<List<bool>>();
    _avatarFileController = BehaviorSubject<File>();
    _arrayHomeController = BehaviorSubject<List<dynamic>>();
    _arrayTripsController = BehaviorSubject<List<dynamic>>();
    _arrayPackagesController = BehaviorSubject<List<dynamic>>();
    _arrayPackagesNotApprovedController = BehaviorSubject<List<dynamic>>();
    _arrayStoreController = BehaviorSubject<List<dynamic>>();
    _arrayPostsController = BehaviorSubject<List<dynamic>>();
    _arrayPostsToAdmindsController = BehaviorSubject<List<dynamic>>();
    _arrayCommentsController = BehaviorSubject<List<dynamic>>();
    _arrayMyFlightsIntransitController = BehaviorSubject<List<dynamic>>();
    _orderByController = BehaviorSubject<String>();
    _dateFromController = BehaviorSubject<DateTime>();
    _dateToController = BehaviorSubject<DateTime>();
    _arrayMyAdsController = BehaviorSubject<List<dynamic>>();
    _arrayMyFlightsController = BehaviorSubject<List<dynamic>>();
    _adminsController = BehaviorSubject<List<dynamic>>();
  }
}

GeneralBloc blocGeneral = GeneralBloc();
