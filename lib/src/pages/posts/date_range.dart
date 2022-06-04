// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';


class DateRange extends StatefulWidget {

  @override
  _DateRangeState createState() => _DateRangeState();
}

class _DateRangeState extends State<DateRange> {


  Http _http = Http();
  dynamic post;
  TextEditingController controladorFechaFrom = TextEditingController();
  TextEditingController controladorFechaTo = TextEditingController();
  String textFechaFrom = postText.from();
  String textFechaTo = postText.to();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;



    return  Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                _appBar(),
                SizedBox(height:  height * 0.02),
                _title(context),
                ],
              ),
              Column(
                children: [
              _showDatePickerFrom(context),
               SizedBox(height:  height * 0.07),
              _showDatePickerTo(context),
                ],
              ),
              SizedBox(height:  height * 0.1),
            ],
          ),
          Positioned(
            top: variableGlobal.topNavigation(context),
            right: width * 0.04,
            left: width * 0.04,
              child: _order(context)
            )
        ],
      )
    );
  }



  // **********************
  Widget _appBar(){
  return StreamBuilder<bool>(
        stream: blocGeneral.viewNavBarStream,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshoptNavBar) {
          if (snapshoptNavBar.hasError) {
            return Container();
          } else if (snapshoptNavBar.hasData) {
            if (snapshoptNavBar.data == true) {
              return Container(
                      margin: EdgeInsets.only(left: variableGlobal.margenPageWithFlight(context), right: variableGlobal.margenPageWithFlight(context), top: variableGlobal.margenTopGeneral(context)),
                      child: Center(
                          child: Column(children: <Widget>[
                        Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            closeCreatePost(context, 'assets/images/close/close button 1@3x.png'),
                            iconFace1(context),
                            SizedBox(width: MediaQuery.of(context).size.width * 0.07,)
                          ],
                        ),
                      ]))
                   );
            }else{
              return Container();
            }
          }else{
            return Container();
          }
        });
    }


  // ****************************************************
  Widget _title(BuildContext context){
    return Container(
        margin: EdgeInsets.only(left: variableGlobal.margenPageWithFlight(context)),
      child: Text(postText.dateRange(),
              style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: MediaQuery.of(context).size.width * 0.1)),
    );
  }

// *******************************************

  bool _validarFrom() {
    bool validate = false;
    if (blocGeneral.dateFromStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  bool _validarTo() {
    bool validate = false;
    if (blocGeneral.dateToStreamValue == false) {
      validate = false;
    } else {
      validate = true;
    }
    return validate;
  }

  // *******************************************************************
  DateTime fechaFrom;
  Widget _showDatePickerFrom(BuildContext context) {
    textFechaFrom = (_validarFrom() == false) ? postText.from() : formatearfecha(blocGeneral.dateFrom);
    return GestureDetector(
      child: StreamBuilder(
          stream: blocGeneral.dateFromStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              margin: EdgeInsets.only(left: variableGlobal.margenPageWithFlight(context), right: variableGlobal.margenPageWithFlight(context)),
              height: variableGlobal.highInputFormFlight(context),
              child: TextFormField(
                  showCursor: false,
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(173, 181, 189, 1)),
                  controller: controladorFechaFrom,
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
                    hintText: textFechaFrom,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      height: 0,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
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
                    _activarDatePickerFrom();
                  },
                  onTap: () {
                    _activarDatePickerFrom();
                  }),
            );
          }),
    );
  }

  // **********************************************
    DateTime fechaTo;
  Widget _showDatePickerTo(BuildContext context) {
    textFechaTo = (_validarTo() == false) ? postText.to() : formatearfecha(blocGeneral.dateTo);
    return GestureDetector(
      child: StreamBuilder(
          stream: blocGeneral.dateToStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
              margin: EdgeInsets.only(left: variableGlobal.margenPageWithFlight(context), right: variableGlobal.margenPageWithFlight(context)),
              height: variableGlobal.highInputFormFlight(context),
              child: TextFormField(
                  showCursor: false,
                  readOnly: true,
                  cursorColor: Colors.black,
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w600,
                      color: Color.fromRGBO(173, 181, 189, 1)),
                  controller: controladorFechaTo,
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
                    hintText: textFechaTo,
                    hintStyle: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      height: 0,
                      fontSize: MediaQuery.of(context).size.width * 0.05,
                      fontWeight: FontWeight.w500,
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
                    _activarDatePickerTo();
                  },
                  onTap: () {
                    _activarDatePickerTo();
                  }),
            );
          }),
    );
  }

   void _activarDatePickerFrom() {
        final f = new DateFormat('yyyy-MM-dd hh:mm');
        DateTime horaActual = DateTime.now();
        String horaActualString = f.format(horaActual);
        String date;
        String dateMax;
        String dateMin;

        if (fechaTo == null) {
          date = horaActualString;
          dateMin = f.format(DateTime.now());
          dateMax = f.format(DateTime(2030, 12, 31));
        } else {
           date = f.format(fechaTo);
           dateMin = f.format(DateTime.now());
           dateMax = f.format(fechaTo);
        }

        DatePicker.showDateTimePicker(
          context,
          showTitleActions: true,
          minTime: DateTime(2021, 03, 01),
          maxTime: DateTime(2030, 12, 31),
          currentTime: DateTime.parse(date),
          locale: LocaleType.en,
          onChanged: (date) {},
          onConfirm: (date) {
            setState(() {
              fechaFrom = date;
              blocGeneral.changeDateFrom(date);
              textFechaFrom = formatearfecha(date);
            });
          },
        );
  }

  void _activarDatePickerTo() {
        final f = new DateFormat('yyyy-MM-dd hh:mm');
        var horaActual = DateTime.now();
        var horaActualString = f.format(horaActual);

        String date;
        String dateMax;
        String dateMin;

        if (fechaFrom == null) {
          date = horaActualString;
          dateMin = f.format(DateTime.now());
          dateMax = f.format(DateTime(2030, 12, 31));
        } else {
          date = f.format(fechaFrom);
          dateMin = f.format(fechaFrom);
          dateMax = f.format(DateTime(2030, 12, 31));
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
              fechaTo = date;
              blocGeneral.changeDateTo(date);
              textFechaTo = formatearfecha(date);
            });
          },
        );
  }


   // ************************** BOTON PARA ORDENAR PORUN RANGO DE FECHAS  ****************************
Widget _order(BuildContext context){
  return StreamBuilder(
        stream: blocGeneral.dateToStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.symmetric(
          horizontal: variableGlobal.margenPageWith(context)),
          child: RaisedButton(
                      onPressed: snapshot.hasData ? (){
                        final preference = Preferencias();           

                       _http.postGetDateRange(context: context, email: preference.prefsInternal.get('email'), from: blocGeneral.dateFrom?.millisecondsSinceEpoch, to: blocGeneral.dateTo?.millisecondsSinceEpoch).then((home){
                          final valueMap = json.decode(home);
                          // print('LOS POST  =====>>> ${valueMap}');
                          if (valueMap['ok'] == false) {
                            
                            }else{
                              blocGeneral.changeOrderBy('daterange');
                              blocGeneral.changePosts(valueMap["posts"]);
                              Navigator.pushNamed(context, 'post');
                            }
                        });

                      } : null,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(postText.order(),
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 206, 6, 1),
                                  fontSize: MediaQuery.of(context).size.width * 0.05,
                                  fontWeight: FontWeight.bold,
                                )),
                            // page1(context)
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black, width: 0.5)),
                      // elevation: 5.0,
                      color: Color.fromRGBO(33, 36, 41, 1.0),
                      textColor: Colors.white,
                    ),
            );
        });
   }

}
