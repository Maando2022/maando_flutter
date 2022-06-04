// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/flight_form_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/flight_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/encabezado_flight.dart';

class CreateFlightForm extends StatefulWidget {
  const CreateFlightForm({Key key}) : super(key: key);

  @override
  _CreateFlightFormState createState() => _CreateFlightFormState();
}

class _CreateFlightFormState extends State<CreateFlightForm> {
  final formKey = GlobalKey<FormState>();

  String textFechaSalida = 'Departure date';
  String textFechaLlegada = 'Arrival date';

  List<dynamic> aiportsOrigin = blocGeneral.aiportsOrigin;
  List<dynamic> aiportsDestination = blocGeneral.aiportsDestination;
  List<String> ciudadesOrigen = [];
  List<String> ciudadesDestino = [];

  TextEditingController controladorCityAirportSalida = TextEditingController();
  TextEditingController controladorCityAirportLlegada = TextEditingController();
  TextEditingController controladorFechaSalida = TextEditingController();
  TextEditingController controladorFechallegada = TextEditingController();
  TextEditingController controladorNumeroVuelo = TextEditingController();
  TextEditingController controladorReservationCode = TextEditingController();

  List<Widget> resultsDeparture = [];
  List<Widget> resultsDestination = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // LLENAMOS LAS CIUDADES DE ORIGEN Y DESTINO
    for (int i = 0; i < aiportsOrigin.length; i++) {
      for (var co in aiportsOrigin[i]["aiports"]) {
        ciudadesOrigen.add("${co["city"]} (${co["code"]})");
      }
    }
    for (int i = 0; i < aiportsDestination.length; i++) {
      for (var cd in aiportsDestination[i]["aiports"]) {
        ciudadesDestino.add("${cd["city"]} (${cd["code"]})");
      }
    }

// ORGANIZAMOS EN ORDEN ALFABETICO
    ciudadesOrigen.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    ciudadesDestino.sort((a, b) {
      return a.toLowerCase().compareTo(b.toLowerCase());
    });

    // AÑADIMOS AL PRINCIPIO DE LA LISTA LAS LEYENDAS
  //   ciudadesOrigen.insert(0, flightText.cityDepartureAirport());
  //   ciudadesDestino.insert(0, flightText.cityDestinationeAirport());
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_flight_form');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofFlightForm(context);

      return StreamBuilder<List<dynamic>>(
                stream: blocGeneral.aiportsOriginStream,
                builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                    if(snapshotConutriesOrigin.hasData){
                        if(snapshotConutriesOrigin.data.length <= 0){
                          return Container();
                        }else{
                             return Stack(
                               children: [
                                 Container(
                                   height: double.infinity,
                                   child: Scaffold(
                                       backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                                       body: SingleChildScrollView(
                                         child: Stack(
                                           children: [
                                             Container(
                                               margin: EdgeInsets.only(
                                                   top: variableGlobal.margenTopGeneral(context),
                                                   right: width * 0.05,
                                                   left: width * 0.05),
                                               child: Column(
                                                 children: [
                                                   SizedBox(height: height * 0.25),
                                                   // ***************************  PARTE DEL MEDIO
                                                   _flightForm(context, responsive, height, width, bloc),
                                                 ],
                                               ),
                                             ),
                                             Container(
                                               margin: EdgeInsets.only(
                                                   top: variableGlobal.margenTopGeneral(context),
                                                   right: width * 0.05,
                                                   left: width * 0.05),
                                               child: Column(
                                                 crossAxisAlignment: CrossAxisAlignment.end,
                                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                 children: [
                                                   Column(children: <Widget>[
                                                     EncabezadoFlightFlightForm(
                                                         head: flightText.publishFlight(),
                                                         to: 1,
                                                         from: 2,
                                                         title: flightText.numberFlight(),
                                                         subtitle:
                                                             '${generalText.next()}: ${generalText.typePackage()}'),
                                                   ]),
                                                   // *************************************  NEXT, CANCEL
                                                   // Container(
                                                   //     margin: EdgeInsets.only(top: height * 0.7),
                                                   //     child: ),
                                                   
                                                 ],
                                               ),
                                             ),
                                           ],
                                         ),
                                       )),
                                 ),
                                 Positioned(
                                   bottom: 0.03,
                                   right: width * 0.05,
                                   child: _crearBotonNext(responsive, height, width, bloc)
                                   )
                               ],
                             );
                        }
                    }else if(snapshotConutriesOrigin.hasError){
                        return Container();
                    }else{
                        return Container();
                    }
                  },
            );
  }

  // **********************************
  Widget _flightForm(BuildContext context, Responsive responsive, double height,
      double width, bloc) {
    return Container(
      child: Column(
        children: <Widget>[
          _crearCityAirportSalida(responsive, height, width, bloc),
          SizedBox(height: (height < 1000.0) ? height * 0.025 : 0),
          _showDatePickerSalida(context, responsive, bloc),
          SizedBox(height: (height < 1000.0) ? height * 0.025 : 0),
          _crearCityAirportLlegada(responsive, height, width, bloc),
          SizedBox(height: (height < 1000.0) ? height * 0.025 : 0),
          _showDatePickerLlegada(context, responsive, bloc),
          SizedBox(height: (height < 1000.0) ? height * 0.025 : 0),
          _crearNumeroVuelo(responsive, bloc),
          SizedBox(height: (height < 1000.0) ? height * 0.025 : 0),
          _crearCodigoReserva(responsive, bloc),
          SizedBox(height: height * 0.2),
        ],
      ),
    );
  }

  Widget _crearCityAirportSalida( Responsive responsive, double height, double width, FlightFormBloc bloc) {

    controladorCityAirportSalida.text = (_validarCiudadSalida(bloc) == false) ? '' : bloc.cityDeparture;
    controladorCityAirportSalida.selection = TextSelection.collapsed(offset: controladorCityAirportSalida.text.length);

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
                    controller: controladorCityAirportSalida,
                    textInputAction: TextInputAction.done,
                    cursorColor: Color.fromRGBO(173, 181, 189, 1),
                    keyboardType: TextInputType.text,
                    // maxLength: 12,
                    decoration: InputDecoration(
                        hintText: flightText.cityDepartureAirport(),
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
                          for(var c in ciudadesOrigen){
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

  Widget _crearCityAirportLlegada(Responsive responsive, double height, double width, FlightFormBloc bloc) {
      
    controladorCityAirportLlegada.text = (_validarCiudadLlegada(bloc) == false) ? '' : bloc.cityDestination;
    controladorCityAirportLlegada.selection = TextSelection.collapsed(offset: controladorCityAirportLlegada.text.length);

    return StreamBuilder(
        stream: bloc.cityDestinationStream,
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
                    controller: controladorCityAirportLlegada,
                    textInputAction: TextInputAction.done,
                    cursorColor: Color.fromRGBO(173, 181, 189, 1),
                    keyboardType: TextInputType.text,
                    // maxLength: 12,
                    decoration: InputDecoration(
                        hintText: flightText.cityDestinationeAirport(),
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
                          bloc.changeCityDestination(value.trim());
                          resultsDestination = [];
                          for(var c in ciudadesDestino){
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

  // *************************

  DateTime fechaSalida;
  Widget _showDatePickerSalida(
   BuildContext context, Responsive responsive, FlightFormBloc bloc) {
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
                    // contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
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

  DateTime fechaLlegada;
  Widget _showDatePickerLlegada(
      BuildContext context, Responsive responsive, FlightFormBloc bloc) {
    textFechaLlegada = (_validarFechaLlegada(bloc) == false)
        ? flightText.arrivailDate()
        : formatearfecha(bloc.dateTimeDestination);
    return GestureDetector(
      child: StreamBuilder(
          stream: bloc.dateTimeDestinationStream,
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
                    // contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
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
                      // height: 0,
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

  // ----------------------

  void _activarDatePickerSalida(FlightFormBloc bloc) {
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
          // print(date);
          fechaSalida = date;
          bloc.changeDateTimeDeparture(date);
          textFechaSalida = formatearfecha(date);
        });
      },
    );
  }

  void _activarDatePickerLlegada(FlightFormBloc bloc) {
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
          bloc.changeDateTimeDestination(date);
          textFechaLlegada = formatearfecha(date);
        });
      },
    );
  }

  // *******************************

  Widget _crearNumeroVuelo(Responsive responsive, FlightFormBloc bloc) {
    controladorNumeroVuelo.text =
        (_validarNumeroVuelo(bloc) == false) ? '' : bloc.flightNumber;
    controladorNumeroVuelo.selection = TextSelection.collapsed(
        offset: controladorNumeroVuelo.text
            .length); //  esa linea sirve para que el cursor quede delante del texto
    return StreamBuilder(
        stream: bloc.flightNumberStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: variableGlobal.highInputFormFlight(context),
            width: MediaQuery.of(context).size.width * 0.99,
            child: TextFormField(
              cursorColor: Colors.black,
              style: TextStyle(
                  fontSize: responsive.ip(2.3),
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(173, 181, 189, 1)),
              controller: controladorNumeroVuelo,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                hintText: flightText.numberFlight(),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1),
                  height: 0,
                  fontSize: responsive.ip(2.3),
                  fontWeight: FontWeight.w400,
                ),
                errorText: snapshot.error,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(173, 181, 189, 1)),
                ),
                border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(15.0),
                    ),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
              ),
              onChanged: (value) => {
                setState(() {
                  bloc.changeflightNumber(value.trim());
                }),
              },
            ),
          );
        });
  }

  // *******************************

  Widget _crearCodigoReserva(Responsive responsive, FlightFormBloc bloc) {
    controladorReservationCode.text =
        (_validarCodigoReserva(bloc) == false) ? '' : bloc.reservationCode;
    controladorReservationCode.selection = TextSelection.collapsed(
        offset: controladorReservationCode.text
            .length); //  esa linea sirve para que el cursor quede delante del texto
    return StreamBuilder(
        stream: bloc.reservationCodeStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: variableGlobal.highInputFormFlight(context),
            width: MediaQuery.of(context).size.width * 0.99,
            child: TextFormField(
              keyboardType: TextInputType.text,
              cursorColor: Colors.black,
              // textAlignVertical: TextAlignVertical.top,
              style: TextStyle(
                  // height: 0,
                  fontSize: responsive.ip(2.3),
                  fontWeight: FontWeight.w400,
                  color: Color.fromRGBO(173, 181, 189, 1)),
              controller: controladorReservationCode,
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.03),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
                hintText: flightText.reservationCode(),
                hintStyle: TextStyle(
                  color: Color.fromRGBO(173, 181, 189, 1),
                  height: 0,
                  fontSize: responsive.ip(2.3),
                  fontWeight: FontWeight.w400,
                ),
                errorText: snapshot.error,
                enabledBorder: const OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                  borderSide:
                      const BorderSide(color: Color.fromRGBO(173, 181, 189, 1)),
                ),
                border: new OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      const Radius.circular(15.0),
                    ),
                    borderSide:
                        BorderSide(color: Color.fromRGBO(173, 181, 189, 1))),
              ),
              onChanged: (value) => {
                setState(() {
                  bloc.changeReservationCode(value.trim());
                }),
              },
            ),
          );
        });
  }

  // ***************************
  Widget toast(BuildContext context, Responsive responsive, double height, double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          final bloc = ProviderApp.ofFlightForm(context);
          print(bloc.cityDeparture);
          print(bloc.cityDestination);
          print(bloc.dateTimeDeparture);
          print(bloc.dateTimeDestination);
          print(bloc.flightNumber);
          print(bloc.reservationCode);
          toastService.showToastCenter(context: context, text: generalText.invalidData(), durationSeconds: 4);
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

  // ****************************

  Widget _crearBotonNext(
      Responsive responsive, double height, double width, FlightFormBloc bloc) {
    return Column(
      children: [
        StreamBuilder(
            stream: bloc.formValidarStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              bool validaCiudadDeparture = false;
              bool validaCiudadDestination = false;
              for(var cd in ciudadesOrigen){
                if(bloc.cityDepartureStreamValue != false && bloc.cityDeparture == cd){
                  validaCiudadDeparture = true;
                  break;
                }
              }
              for(var cd in ciudadesDestino){
                if(bloc.cityDestinationStreamValue != false && bloc.cityDestination == cd){
                  validaCiudadDestination = true;
                  break;
                }
              }
              
              return (snapshot.hasData &&
                      (validaCiudadDeparture == true && validaCiudadDestination == true))
                  ? next(context, 'create_flight_type_package')
                  : toast(context, responsive, height, width);
            }),
        SizedBox(height: height * 0.05),
      ],
    );
  }

  // *******************

  bool _validarCiudadSalida(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.cityDepartureStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarCiudadLlegada(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.cityDestinationStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarFechaSalida(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.dateTimeDepartureStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarFechaLlegada(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.dateTimeDestinationStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarNumeroVuelo(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.flightNumberStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarCodigoReserva(FlightFormBloc bloc) {
    bool validate = false;
    if (bloc.reservationCodeStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }



    // *******************
  Widget _resultCityDeparture(Responsive responsive, String text, double miheight, FlightFormBloc bloc) {
    return CupertinoButton(
            padding: EdgeInsets.all(responsive.ip(1)),
            minSize: 0,
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

    Widget _resultCityDestination(Responsive responsive, String text, double miheight, FlightFormBloc bloc) {
   return CupertinoButton(
            padding: EdgeInsets.all(responsive.ip(1)),
            minSize: 0,
            onPressed: (){
                bloc.changeCityDestination(text);
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
