// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/separadores.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/date.dart';

class CreateAdTitleDateDestination extends StatefulWidget {
  // const CreateAd_10_0({Key key}) : super(key: key);
  @override
  _CreateAdTitleDateDestinationState createState() =>
      _CreateAdTitleDateDestinationState();
}

class _CreateAdTitleDateDestinationState
    extends State<CreateAdTitleDateDestination> {
  TextEditingController controladorTitle = TextEditingController();
  TextEditingController controladorCityDeparture = TextEditingController();
  TextEditingController controladorCitDestination = TextEditingController();
  TextEditingController controladorFechaSalida = TextEditingController();
  TextEditingController controladorFechallegada = TextEditingController();

  final formKey = GlobalKey<FormState>();
  DateTime fecha;
  String textFechaSalida = 'Departure date';
  String textFechaLlegada = 'Arrival date';
  // ************************************************

  List<dynamic> aiportsDeparture = blocGeneral.aiportsOrigin;
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  // List<String> listaPaises = [];
  List<String> listaCiudadesDeparture = [];
  List<String> listaCiudades = [];

  // *****
  List<Widget> resultsDeparture = [];
  List<Widget> resultsDestination = [];

  @protected
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_title_date_destination');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);
    bloc.changeAux('1234567777');

// VALIDAMOS CUAL ES EL PAIS SELECCIONADO Y LISTAMOS LAS CIUDADES
    listaCiudadesDeparture = [];
    listaCiudades = [];

// LLENAMOS LA SIUDADES DE SALIDA
    for (int i = 0; i < aiportsDeparture.length; i++) {
      for (var c in aiportsDeparture[i]["aiports"]) {
        listaCiudadesDeparture.add(c["city"]);
      }
    }

    // LLENAMOS LA CIUDADES DE LLEGADA
    for (int i = 0; i < aiports.length; i++) {
      for (var c in aiports[i]["aiports"]) {
        listaCiudades.add(c["city"]);
      }
    }

    // ORGANIZAMOS EN ORDEN ALFABETICO
    listaCiudadesDeparture.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    listaCiudades.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    // listaCiudadesDeparture.insert(0, adsText.departureCity()); // AGREGAMOS EL TEXTO INICIAL AL ARREGLO (Departure city)
    // listaCiudades.insert(0, adsText .destinationCity()); // AGREGAMOS EL TEXTO INICIAL AL ARREGLO (Destination city)

    // *******

    // if (bloc.cityDepature == null) {
    //   bloc.changeCityDeparture(adsText.departureCity());
    // } else {
    //   bloc.changeCityDeparture(bloc.cityDepature);
    // }
    // if (bloc.city == null) {
    //   bloc.changeCity(adsText.destinationCity());
    // } else {
    //   bloc.changeCity(bloc.city);
    // }

    // if (bloc.cityDepature == null)
    //   bloc.changeCityDeparture(listaCiudadesDeparture[0]);
    // if (bloc.city == null) bloc.changeCity(listaCiudades[0]);


    listaCiudadesDeparture = listaCiudadesDeparture.toSet().toList();   //  Eliminamos elementos repetidos
    listaCiudades = listaCiudades.toSet().toList();


    // bloc.changeTitle('title');
    // bloc.changeDateTimeDeparture(DateTime.now());
    // bloc.changeDateTime(DateTime.now());
    // bloc.changeCityDeparture('Los Angeles');
    // bloc.changeCity('Cartagena');
    // bloc.changePlaceOfDelivery('Cartagena');

    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.aiportsOriginStream,
        builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
            if(snapshotConutriesOrigin.hasData){
                if(snapshotConutriesOrigin.data.length <= 0){
                  return Container();
                }else{
                      return Scaffold(
                          resizeToAvoidBottomInset:
                              false, // los widgets no cambian de tamaño de alto cuando sale el teclado
                          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                          body: Stack(
                            children: [
                              // **********************************************************
                              Container(
                                height: double.infinity,
                                margin: EdgeInsets.only(
                                    top: width * 0.3,
                                    right: variableGlobal.margenPageWith(context),
                                    left: variableGlobal.margenPageWith(context)),
                                child: SingleChildScrollView(
                                  child: Column(
                                    // mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: height * 0.15,
                                      ),
                                      _crearWhatCanIsend(height, width, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      _crearTitle(bloc, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      _crearCiudadDepature(bloc, height, width, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      _showDatePickerSalida(context, bloc, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      separador1(context),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      _crearCiudad(bloc, height, width, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.03),
                                      _showDatePickerLlegada(context, bloc, responsive),
                                      SizedBox(
                                          height: MediaQuery.of(context).size.height * 0.4),
                                    ],
                                  ),
                                ),
                              ),
                              // *********************************************
                              Container(
                                margin: EdgeInsets.only(
                                  left: variableGlobal.margenPageWith(context),
                                  right: variableGlobal.margenPageWith(context),
                                  top: variableGlobal.margenPageWithFlightTop(context),
                                ),
                                child: Column(
                                  //Columna 001
                                  children: <Widget>[
                                    Stack(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            iconFace1(context),
                                          ],
                                        ),
                                        closeAd(context,
                                            'assets/images/close/close button 1@3x.png'),
                                      ],
                                    ), //cierre de boton cerra y logo
                                    SizedBox(
                                      height: height * 0.02,
                                    ),

                                    Row(
                                      // row create ad
                                      children: <Widget>[
                                        Container(
                                          child: Text(adsText.titulo_1(),
                                              style: TextStyle(
                                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: responsive.ip(3.5))),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    //cierre row create ad

                                    Row(
                                      //row de circulo verde
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        circuloVerde(context, 1, 3),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: <Widget>[
                                            Text(adsText.titleDateAndDestination(),
                                                style: TextStyle(
                                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: responsive.ip(2.2))),
                                            Text(
                                                '${generalText.next()}: ${adsText.deliveryAddress()}',
                                                style: TextStyle(
                                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: responsive.ip(2)))
                                          ],
                                        )
                                      ],
                                    ), //cierre row circulo verde
                                  ],
                                ),
                              ),
                              Positioned(
                                width: width,
                                top: variableGlobal.topNavigation(context),
                                child: Container(
                                  margin: EdgeInsets.only(
                                    left: variableGlobal.margenPageWith(context),
                                    right: variableGlobal.margenPageWith(context),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      StreamBuilder(
                                          stream: bloc.formValidarStream,
                                          builder:
                                              (BuildContext context, AsyncSnapshot snapshot) {
                                                bool validaCiudadDeparture = false;
                                                bool validaCiudadDestination = false;
                                              for(var cd in listaCiudadesDeparture){
                                                if(bloc.cityDepartureStreamHasValue != false){
                                                  if(bloc.cityDepature == cd){
                                                  validaCiudadDeparture = true;
                                                  break;
                                                }
                                                }
                                              }
                                              for(var cd in listaCiudades){
                                                if(bloc.cityStreamHasValue != false){
                                                  if(bloc.city == cd){
                                                  validaCiudadDestination = true;
                                                  break;
                                                }
                                                }
                                              }
                                            if (validaCiudadDeparture == false ||
                                                validaCiudadDestination == false ||
                                                bloc.dateTimeDepartureStreamHasValue == false ||
                                                bloc.dateTimeStreamHasValue == false ||
                                                bloc.titleStreamHasValue == false ||
                                                bloc.title.trim().length < 2 ||
                                                bloc.title.trim().length > 12) {
                                              return toast(context, responsive, height, width);
                                            } else {
                                              return next(
                                                  context, 'create_ad_delivery_address');
                                            }
                                          }),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ));
                }
            }else if(snapshotConutriesOrigin.hasError){
                return Container();
            }else{
                return Container();
            }
          },
    );


  }

  bool _validarTitulo(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.titleStreamHasValue == false) {
      validate = false;
    } else {
      if (bloc.title.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

  bool _validarCityDeparture(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.cityDepartureStreamHasValue == false) {
      validate = false;
    } else {
      if (bloc.cityDepature.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

  bool _validarCityDestination(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.cityStreamHasValue == false) {
      validate = false;
    } else {
      if (bloc.city.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }


  Widget _crearWhatCanIsend(double height, double width, Responsive responsive){
    return GestureDetector(
          onTap: (){
            // dialogWhatCanISend.showMaterialDialog(context);
            Navigator.pushNamed(context, 'create_flight_what_can_i_send');
          },
          child: Container(
                  height: variableGlobal.highInputFormFlight(context),
                  width: width * 0.99,
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color.fromRGBO(173, 181, 189, 1)),
                    borderRadius: BorderRadius.circular(15)
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: width * 0.03),
                    child: Row(
                      children: [
                        Text(adsText.whatCanISend(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.3), 
                          fontWeight: FontWeight.w400),),
                          SizedBox(width: width * 0.03),
                          Icon(Icons.info_outline, color: Color.fromRGBO(255, 206, 6, 1.0), size: responsive.ip(3))
                      ],
                    ),
                  ),
      ),
    );
  }

  Widget _crearTitle(AdFormBloc bloc, Responsive responsive) {
    String text = (_validarTitulo(bloc) == false) ? adsText.pregunta_01() : '';

    controladorTitle.text = (_validarTitulo(bloc) == false) ? '' : bloc.title;
    controladorTitle.selection =
        TextSelection.collapsed(offset: controladorTitle.text.length);

    return StreamBuilder(
        stream: bloc.titleStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: variableGlobal.highInputFormFlight(context),
            width: MediaQuery.of(context).size.width * 0.99,
            child: TextFormField(
                style: TextStyle(
                fontSize: responsive.ip(2.3), fontWeight: FontWeight.w400),
                controller: controladorTitle,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.text,
                // maxLength: 12,
                decoration: InputDecoration(
                    labelText: text,
                    labelStyle: TextStyle(
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(173, 181, 189, 1),
                    ),
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      height: 0,
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                      enabledBorder: const OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(173, 181, 189, 1)),
                    ),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(15.0),
                      ),
                      borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                    errorText: snapshot.error),
                onChanged: (value) => {
                      bloc.changeTitle(value.trim()),
                    },
                onTap: () {
                  text = '';
                }),
          );
        });
  }


  // *************************
  DateTime fechaSalida;
  Widget _showDatePickerSalida(
   BuildContext context, AdFormBloc bloc, Responsive responsive) {
      textFechaSalida = (_validarFechaSalida(bloc) == false)
        ? flightText.departureDate()
        : formatearfecha(bloc.dateTimeDeparture);
    return GestureDetector(
      child: StreamBuilder(
          stream: bloc.dateTimeDepartureStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              height: variableGlobal.highInputFormFlight(context),
              width: MediaQuery.of(context).size.width * 0.99,
              child: TextFormField(
                  showCursor: false,
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(173, 181, 189, 1)),
                  controller: controladorFechaSalida,
                  decoration: InputDecoration(
                    // suffixIcon: Icon(Icons.keyboard_arrow_down,
                    //     color: Color.fromRGBO(230, 230, 230, 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                    hintText: textFechaSalida,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      height: 2.5,
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                    ),
                    errorText: snapshot.error,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(173, 181, 189, 1)),
                    ),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                  ),
                  onChanged: (value) {
                    _activarDatePickerSalida(bloc);
                  },
                  onTap: () {
                    _activarDatePickerSalida(bloc);
                  }),
            );
          }),
    );
  }

  // ****************************

  DateTime fechaLlegada;
  Widget _showDatePickerLlegada(
      BuildContext context, AdFormBloc bloc, Responsive responsive) {
    textFechaLlegada = (_validarFechaLlegada(bloc) == false)
        ? flightText.arrivailDate()
        : formatearfecha(bloc.dateTime);
    return GestureDetector(
      child: StreamBuilder(
          stream: bloc.dateTimeStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              height: variableGlobal.highInputFormFlight(context),
              width: MediaQuery.of(context).size.width * 0.99,
              child: TextFormField(
                  showCursor: false,
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(173, 181, 189, 1)),
                  controller: controladorFechallegada,
                  decoration: InputDecoration(
                    // suffixIcon: Icon(Icons.keyboard_arrow_down,
                    //     color: Color.fromRGBO(230, 230, 230, 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                    focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                    hintText: textFechaLlegada,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      height: 2.5,
                      fontSize: responsive.ip(2.3),
                      fontWeight: FontWeight.w400,
                    ),
                    errorText: snapshot.error,
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(15.0),
                      ),
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(173, 181, 189, 1)),
                    ),
                    border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(15.0),
                        ),
                        borderSide: BorderSide(
                            color: Color.fromRGBO(173, 181, 189, 1))),
                  ),
                  onChanged: (value) {
                    _activarDatePickerLlegada(bloc);
                  },
                  onTap: () {
                    _activarDatePickerLlegada(bloc);
                  }),
            );
          }),
    );
  }

  // *****************************
  void _activarDatePickerSalida(AdFormBloc bloc) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    var horaActual = DateTime.now();
    var horaActualString = f.format(horaActual);

    String date;
    String dateMax;
    String dateMin;

    if (fechaLlegada == null) {
      date = horaActualString;
      dateMin = f.format(DateTime.now());
      dateMax = f.format(DateTime(2030, 12, 31));
    } else {
      date = f.format(fechaLlegada);
      dateMin = f.format(DateTime.now());
      dateMax = f.format(fechaLlegada);
    }

    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.parse(dateMin),
      maxTime: DateTime.parse(dateMax),
      currentTime: DateTime.parse(date),
      locale: LocaleType.en,
      onChanged: (date) {},
      onConfirm: (date) {
        setState(() {
          fechaSalida = date;
          print(date);
          bloc.changeDateTimeDeparture(date);
          textFechaSalida = formatearfecha(date);
        });
      },
    );
  }

  void _activarDatePickerLlegada(AdFormBloc bloc) {
    final f = new DateFormat('yyyy-MM-dd hh:mm');
    DateTime horaActual = DateTime.now();
    String horaActualString = f.format(horaActual);
    String date;
    String dateMax;
    String dateMin;

    if (fechaSalida == null) {
      date = horaActualString;
      dateMin = f.format(DateTime.now());
      dateMax = f.format(DateTime(2030, 12, 31));
    } else {
      date = f.format(fechaSalida);
      dateMin = f.format(fechaSalida);
      dateMax = f.format(DateTime(2030, 12, 31));
    }

    DatePicker.showDateTimePicker(
      context,
      showTitleActions: true,
      minTime: DateTime.parse(date),
      maxTime: DateTime(2025, 12, 31),
      currentTime: DateTime.parse(date),
      locale: LocaleType.en,
      onChanged: (date) {},
      onConfirm: (date) {
        setState(() {
          fechaLlegada = date;
          bloc.changeDateTime(date);
          textFechaLlegada = formatearfecha(date);
        });
      },
    );
  }

  // **********
  bool _validarFechaSalida(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.dateTimeDepartureStreamHasValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarFechaLlegada(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.dateTimeStreamHasValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  // *****************************
  Widget _crearCiudadDepature(AdFormBloc bloc, height, width, Responsive responsive) {
  
    controladorCityDeparture.text = (_validarCityDeparture(bloc) == false) ? '' : bloc.cityDepature;
    controladorCityDeparture.selection = TextSelection.collapsed(offset: controladorCityDeparture.text.length);

    return StreamBuilder(
        stream: bloc.cityDepartureStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: variableGlobal.highInputFormFlight(context),
                width: MediaQuery.of(context).size.width * 0.99,
                child: TextFormField(
                    style: TextStyle(
                    fontSize: responsive.ip(2.3), fontWeight: FontWeight.w400, color: Color.fromRGBO(173, 181, 189, 1)),
                    controller: controladorCityDeparture,
                    textInputAction: TextInputAction.done,
                    cursorColor: Color.fromRGBO(173, 181, 189, 1),
                    keyboardType: TextInputType.text,
                    // maxLength: 12,
                    decoration: InputDecoration(
                        hintText: adsText.departureCity(),
                        // labelText: text,
                        labelStyle: TextStyle(
                          fontSize: responsive.ip(2.3),
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(173, 181, 189, 1),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          height: 0,
                          fontSize: responsive.ip(2.3),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                          enabledBorder: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(173, 181, 189, 1)),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                          borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                        errorText: snapshot.error),
                        onChanged: (value){
                          bloc.changeCityDeparture(value.trim());
                          resultsDeparture = [];
                          for(var c in listaCiudadesDeparture){
                            if (c.toLowerCase().contains(value.toLowerCase().trim()) == true) {
                              resultsDeparture.add(_resultCityDeparture(responsive, c, width, bloc));
                            }
                          }
                        },
                    onTap: () {
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(173, 181, 189, 1).withOpacity(0.1),
                  // border: Border.all(color: Color.fromRGBO(173, 181, 189, 1))
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: resultsDeparture,
                ),
              )
            ],
          );
        });
  }
  // ******************************

  Widget _crearCiudad(AdFormBloc bloc, height, width, Responsive responsive) {
   
    controladorCitDestination.text = (_validarCityDestination(bloc) == false) ? '' : bloc.city;
    controladorCitDestination.selection = TextSelection.collapsed(offset: controladorCitDestination.text.length);

    return StreamBuilder(
        stream: bloc.cityStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: variableGlobal.highInputFormFlight(context),
                width: MediaQuery.of(context).size.width * 0.99,
                child: TextFormField(
                    style: TextStyle(
                    fontSize: responsive.ip(2.3), fontWeight: FontWeight.w400, color: Color.fromRGBO(173, 181, 189, 1)),
                    controller: controladorCitDestination,
                    textInputAction: TextInputAction.done,
                    cursorColor: Color.fromRGBO(173, 181, 189, 1),
                    keyboardType: TextInputType.text,
                    // maxLength: 12,
                    decoration: InputDecoration(
                        hintText: adsText.destinationCity(),
                        // labelText: text,
                        labelStyle: TextStyle(
                          fontSize: responsive.ip(2.3),
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(173, 181, 189, 1),
                        ),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          height: 0,
                          fontSize: responsive.ip(2.3),
                          fontWeight: FontWeight.w400,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0),
                          borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                          enabledBorder: const OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          borderSide: const BorderSide(
                              color: Color.fromRGBO(173, 181, 189, 1)),
                        ),
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(15.0),
                          ),
                          borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                        errorText: snapshot.error),
                        onChanged: (value){
                          bloc.changeCity(value.trim());
                          resultsDestination = [];
                          for(var c in listaCiudades){
                            if (c.toLowerCase().contains(value.toLowerCase().trim()) == true) {
                              resultsDestination.add(_resultCityDestination(responsive, c, width, bloc));
                            }
                          }
                        },
                    onTap: () {
                    }),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.99,
                margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                decoration: BoxDecoration(
                  // color: Color.fromRGBO(173, 181, 189, 1).withOpacity(0.1),
                  // border: Border.all(color: Color.fromRGBO(173, 181, 189, 1))
                  ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: resultsDestination,
                ),
              )
            ],
          );
        });
  }

  // ******************************************************************************************
  Widget toast(BuildContext context, Responsive responsive, double height,
      double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          toastService.showToastCenter(context: context, text: adsText.dataInvalid(), durationSeconds: 4);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          child: Center(
            child: Text(generalText.next(),
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.w400,
                )),
          ),
        ),
        color: Color.fromRGBO(251, 251, 251, 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side:
                BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
      );
    });
  }


   // *******************
  Widget _resultCityDeparture(Responsive responsive, String text, double miheight, AdFormBloc bloc) {
    return CupertinoButton(
            padding: EdgeInsets.all(responsive.ip(2)),
            onPressed: (){
                bloc.changeCityDeparture(text);
                resultsDeparture = [];
                  FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
            margin: EdgeInsets.only(bottom: miheight * 0.04),
            child: Text(
              text,
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1),
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.w500),
            ),
          ),
    );
  }

    Widget _resultCityDestination(Responsive responsive, String text, double miheight, AdFormBloc bloc) {
   return CupertinoButton(
            padding: EdgeInsets.all(responsive.ip(2)),
            onPressed: (){
                bloc.changeCity(text);
                resultsDestination = [];
                FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
            margin: EdgeInsets.only(bottom: miheight * 0.04),
            child: Text(
              text,
              style: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1),
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.w500),
            ),
          ),
    );
  }
}

