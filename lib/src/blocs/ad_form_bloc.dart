// @dart=2.9
import 'dart:async';
import 'dart:io';
import 'package:maando/src/utils/validaciones/ad_validation.dart';
import 'package:maando/src/utils/validaciones/create_account_validation.dart';
import 'package:rxdart/rxdart.dart';

class AdFormBloc with AdValidation, CreateAccountValidation {
  var _auxController = BehaviorSubject<String>();
  var _titleController = BehaviorSubject<String>();
  var _dateTimeDepartureController = BehaviorSubject<DateTime>();
  var _dateTimeController = BehaviorSubject<DateTime>();
  var _countryDepartureController = BehaviorSubject<String>();
  var _countryController = BehaviorSubject<String>();
  var _cityDepartureController = BehaviorSubject<String>();
  var _cityController = BehaviorSubject<String>();
  var _placeOfDeliveryController = BehaviorSubject<String>();  // Direccion completa (cuando no hay ultima milla)
  var _lastMilleController = BehaviorSubject<String>(); //  El tipo de útima milla que se usa (código de empresa según el pais)
  


  // MULTIENTREGA
  var _division1Controller = BehaviorSubject<dynamic>(); // Provincias
  var _division2Controller = BehaviorSubject<dynamic>(); // Distritos
  var _division3Controller = BehaviorSubject<dynamic>(); // Corregimientos
  var _division4Controller = BehaviorSubject<dynamic>(); // Barrios
  var _addressController = BehaviorSubject<String>();   // referencia de la direcion (diagonal al edificio azul)
  var _phoneDeliveryController = BehaviorSubject<String>();
  var _contactController = BehaviorSubject<String>();
  // *****
  // MENSAJEROSURBANOS
  var _address1Controller = BehaviorSubject<String>(); // direccion del aeropuerto
  var _address2Controller = BehaviorSubject<String>(); // direccion del destinatario
  var _addressGeocodingController = BehaviorSubject<String>(); // direccion dada por geocoding
  var _locationController = BehaviorSubject<Map<String, dynamic>>(); // latitude and  longitude geocoding

  var _listImagesController = BehaviorSubject<List<File>>();
  var _uploadImagesController = BehaviorSubject<bool>();
  var _priceController = BehaviorSubject<String>();
  var _insuranceController = BehaviorSubject<String>();



  //  RECUPERAR LOS DAOS DEL STREAM =====================================================================================
  Stream<String> get auxStream => _auxController.stream.transform(validarTitle);
  Stream<String> get titleStream => _titleController.stream.transform(validarTitle);
  Stream<DateTime> get dateTimeStream =>  _dateTimeController.stream.transform(validarDateTime);
  Stream<DateTime> get dateTimeDepartureStream => _dateTimeDepartureController.stream.transform(validarDateTime);
  Stream<String> get countryDepartureStream => _countryDepartureController.stream.transform(validarCountryCity);
  Stream<String> get countryStream => _countryController.stream.transform(validarCountryCity);
  Stream<String> get cityDepartureStream => _cityDepartureController.stream;
  Stream<String> get cityStream => _cityController.stream.transform(validarCountryCity);
  Stream<String> get placeOfDeliveryStream => _placeOfDeliveryController.stream.transform(validarPlaceOfDelivery);
  Stream<String> get lastMilleStream => _lastMilleController.stream;
    // MULTIENTREGA
  Stream<dynamic> get division1Stream => _division1Controller.stream;
  Stream<dynamic> get division2Stream => _division2Controller.stream;
  Stream<dynamic> get division3Stream => _division3Controller.stream;
  Stream<dynamic> get division4Stream => _division4Controller.stream;
  Stream<String> get addressStream => _addressController.stream.transform(validarPlaceOfDelivery);
  Stream<String> get phoneDeliveryStream => _phoneDeliveryController.stream.transform(validarPhone);
  Stream<String> get contactStream => _contactController.stream.transform(validarFullName);
  Stream<bool> get placesValidarStream => CombineLatestStream.combine7(division1Stream, division2Stream, division3Stream,
                                   division4Stream, addressStream, phoneDeliveryStream, contactStream, (d1, d2, d3, d4, a, p, c) => true);
  // -----------------
  // MENSAJEROS URBANOS
  Stream<String> get address1Stream => _address1Controller.stream.transform(validarPlaceOfDelivery);
  Stream<String> get address2Stream => _address2Controller.stream.transform(validarPlaceOfDelivery);
  Stream<String> get addressGeocodingStream => _addressGeocodingController.stream.transform(validarPlaceOfDelivery);
  Stream<bool> get addresstream => CombineLatestStream.combine3(address1Stream, address2Stream, addressGeocodingStream, (a1, a2, ag) => true);
  Stream<Map<String, dynamic>> get locationGeocodingStream => _locationController.stream;
  

  Stream<List<File>> get listImagesStream => _listImagesController.stream;
  Stream<bool> get uploadImagesStream => _uploadImagesController.stream;
  Stream<String> get insuranceStream => _insuranceController.stream;
  Stream<String> get priceStream => _priceController.stream.transform(validarPrice);
  Stream<bool> get formValidarStream => CombineLatestStream.combine4(titleStream, dateTimeStream, countryStream, cityStream, (title, dateTime, country, city) => true);



  // HASVALUE
  bool get auxStreamHasValue => _auxController.stream.hasValue;
  bool get titleStreamHasValue => _titleController.stream.hasValue;
  bool get dateTimeStreamHasValue => _dateTimeController.stream.hasValue;
  bool get dateTimeDepartureStreamHasValue => _dateTimeDepartureController.stream.hasValue;
  bool get countryDepartureStreamHasValue => _countryDepartureController.stream.hasValue;
  bool get countryStreamHasValue => _countryController.stream.hasValue;
  bool get cityDepartureStreamHasValue => _cityDepartureController.stream.hasValue;
  bool get cityStreamHasValue => _cityController.stream.hasValue;
  bool get placeOfDeliveryStreamHasValue => _placeOfDeliveryController.stream.hasValue;
  bool get lastMilleStreamHasValue => _lastMilleController.stream.hasValue;
  bool get divicion1StreamHasValue => _division1Controller.stream.hasValue;
  bool get divicion2StreamHasValue => _division2Controller.stream.hasValue;
  bool get divicion3StreamHasValue => _division3Controller.stream.hasValue;
  bool get divicion4StreamHasValue => _division4Controller.stream.hasValue;
  bool get addressStreamHasValue => _addressController.stream.hasValue;
  bool get phoneDeliveryStreamHasValue => _phoneDeliveryController.stream.hasValue;
  bool get contactStreamHasValue => _contactController.stream.hasValue;
  bool get address1StreamHasValue => _address1Controller.stream.hasValue;
  bool get address2StreamHasValue => _address2Controller.stream.hasValue;
  bool get addresGeocodingStreamHasValue => _addressGeocodingController.stream.hasValue;
  bool get locationStreamHasValue => _locationController.stream.hasValue;
  bool get listImagesStreamHasValue => _listImagesController.stream.hasValue;
  bool get uploadImagesStreamHasValue => _uploadImagesController.stream.hasValue;
  bool get priceStreamHasValue => _priceController.stream.hasValue;
  bool get insuranceStreamHasValue => _insuranceController.stream.hasValue;

  //  INSERTAR VALORES AL STREAM  ==================================================================================================
  Function(String) get changeAux => _auxController.sink.add;
  Function(String) get changeTitle => _titleController.sink.add;
  Function(DateTime) get changeDateTime => _dateTimeController.sink.add;
  Function(DateTime) get changeDateTimeDeparture => _dateTimeDepartureController.sink.add;
  Function(String) get changeCountryDeparture => _countryDepartureController.sink.add;
  Function(String) get changeCountry => _countryController.sink.add;
  Function(String) get changeCityDeparture => _cityDepartureController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changePlaceOfDelivery => _placeOfDeliveryController.sink.add;
  Function(String) get changelastMille => _lastMilleController.sink.add;

    // MULTIENTREGA
  Function(dynamic) get changeDivision1 => _division1Controller.sink.add;
  Function(dynamic) get changeDivision2 => _division2Controller.sink.add;
  Function(dynamic) get changeDivision3 => _division3Controller.sink.add;
  Function(dynamic) get changeDivision4 => _division4Controller.sink.add;
  Function(String) get changeAddress => _addressController.sink.add;
  Function(String) get changePhoneDelivery => _phoneDeliveryController.sink.add;
  Function(String) get changeContact => _contactController.sink.add;
  // ********
  // MENSAJEROS URBANOS
   Function(String) get changeAddress1 => _address1Controller.sink.add;
   Function(String) get changeAddress2 => _address2Controller.sink.add;
   Function(String) get changeAddressGeocoding => _addressGeocodingController.sink.add;
   Function(Map<String, dynamic>) get changeLocationGeocoding => _locationController.sink.add;

  Function(List<File>) get changeListImages => _listImagesController.sink.add;
  Function(bool) get changeUploadImages => _uploadImagesController.sink.add;
  Function(String) get changePrice => _priceController.sink.add;
  Function(String) get changeInsurance => _insuranceController.sink.add;



  // OBTENER LOS VALORES  =====================================================================================
  String get aux => _auxController.value;
  String get title => _titleController.value;
  DateTime get dateTime => _dateTimeController.value;
  DateTime get dateTimeDeparture => _dateTimeDepartureController.value;
  String get countryDeparture => _countryDepartureController.value;
  String get country => _countryController.value;
  String get cityDepature => _cityDepartureController.value;
  String get city => _cityController.value;
  String get placeOfDelivery => _placeOfDeliveryController.value;
  String get lastMille => _lastMilleController.value;

  // MULTIENTREGA
  dynamic get division1 => _division1Controller.value;
  dynamic get division2 => _division2Controller.value;
  dynamic get division3 => _division3Controller.value;
  dynamic get division4 => _division4Controller.value;
  String get address => _addressController.value;
  String get phoneDelivery => _phoneDeliveryController.value;
  String get contact => _contactController.value;
  // *******
  // MENSAJEROS URBANOS
  String get address1 => _address1Controller.value;
  String get address2 => _address2Controller.value;
  String get addressGeocoding => _addressGeocodingController.value;
  Map<String, dynamic> get locationGeocoding => _locationController.value;
  

  List<File> get listImages => _listImagesController.value;
  bool get uplodImages => _uploadImagesController.value;
  String get price => _priceController.value;
  String get insurance => _insuranceController.value;


  streamNull() {
  _auxController = BehaviorSubject<String>();
  _titleController = BehaviorSubject<String>();
  _dateTimeDepartureController = BehaviorSubject<DateTime>();
  _dateTimeController = BehaviorSubject<DateTime>();
  _countryDepartureController = BehaviorSubject<String>();
  _countryController = BehaviorSubject<String>();
  _cityDepartureController = BehaviorSubject<String>();
  _cityController = BehaviorSubject<String>();
  _placeOfDeliveryController = BehaviorSubject<String>();
  _lastMilleController = BehaviorSubject<String>();
  _division1Controller = BehaviorSubject<dynamic>();
  _division2Controller = BehaviorSubject<dynamic>();
  _division3Controller = BehaviorSubject<dynamic>();
  _division4Controller = BehaviorSubject<dynamic>();
  _address1Controller = BehaviorSubject<String>();
  _address2Controller = BehaviorSubject<String>();
  _addressGeocodingController = BehaviorSubject<String>();
  _locationController = BehaviorSubject<Map<String, dynamic>>();
  _addressController = BehaviorSubject<String>();
  _phoneDeliveryController = BehaviorSubject<String>();
  _contactController = BehaviorSubject<String>();
  _listImagesController = BehaviorSubject<List<File>>();
  _uploadImagesController = BehaviorSubject<bool>();
  _priceController = BehaviorSubject<String>();
  _insuranceController = BehaviorSubject<String>();
  }


  dispose() {
    _auxController?.close();
    _titleController?.close();
    _dateTimeController?.close();
    _dateTimeDepartureController?.close();
    _countryDepartureController.close();
    _countryController?.close();
    _cityController?.close();
    _placeOfDeliveryController?.close();
    _lastMilleController?.close();
    _division1Controller?.close();
    _division2Controller?.close();
    _division3Controller?.close();
    _division4Controller?.close();
    _addressController?.close();
    _contactController?.close();
    _address1Controller?.close();
    _address2Controller?.close();
    _addressGeocodingController?.close();
    _locationController.close();
    _phoneDeliveryController?.close();
    _cityDepartureController?.close();
    _listImagesController?.close();
    _uploadImagesController?.close();
    _priceController?.close();
    _insuranceController?.close();
  }




}

AdFormBloc adFromBloc = AdFormBloc();
