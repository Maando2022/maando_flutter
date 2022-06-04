// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/services/http_last_mille/multientrega.dart';
import 'dart:convert';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/blocs/last_mille/multientrega.dart';
import 'package:maando/src/widgets/loading/success.dart';
import 'package:maando/src/widgets/separadores.dart';



class Multientrega extends StatefulWidget {
  const Multientrega({Key key}) : super(key: key);

  @override
  _MultientregaState createState() => _MultientregaState();
}

class _MultientregaState extends State<Multientrega> {

    String tokenMultientrega = '';

    final formKey = GlobalKey<FormState>();
    TextEditingController controladorPlaceOfDelivery = TextEditingController();
    TextEditingController controladorPhoneDelivery = TextEditingController();
    TextEditingController controladorContact = TextEditingController();



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);
      HttpLastMultientrega().generateTokenMultientrega().then((value){
      dynamic valueMap = json.decode(value);
      if(multientregaBloc.deliveryAddressDivision1 == null){
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.loadingPlaces());});
      }
      if(valueMap["ok"] == true){
        tokenMultientrega = valueMap["token"];
            HttpLastMultientrega().getProvinciasMultientrega(tokenMultientrega).then((valueProvincias){
              dynamic valueMapProvincias = json.decode(valueProvincias);
              if(valueMapProvincias["ok"] == false) return;
              if(multientregaBloc.deliveryAddressDivision1 == null){
                multientregaBloc.changeDeliveryAdrressDivision1(valueMapProvincias["provincias"]);
                bloc.changeDivision1(multientregaBloc.deliveryAddressDivision1[0]);
              }
              // ***
              HttpLastMultientrega().getDistritosMultientrega(tokenMultientrega, valueMapProvincias["provincias"][0]["Id"]).then((valueDistritos){
                dynamic valueMapDistritos = json.decode(valueDistritos);
                if(valueMapDistritos["ok"] == false) return;
                if(multientregaBloc.deliveryAddressDivision2 == null){
                  multientregaBloc.changeDeliveryAdrressDivision2(valueMapDistritos["distritos"]);
                  bloc.changeDivision2(multientregaBloc.deliveryAddressDivision2[0]);
                }

                  // ***
                  HttpLastMultientrega().getCorregimientosMultientrega(tokenMultientrega, valueMapDistritos["distritos"][0]["Id"]).then((valueCorregimientos){
                    dynamic valueMapCorregimientos = json.decode(valueCorregimientos);
                    if(valueMapCorregimientos["ok"] == false) return;
                    if(multientregaBloc.deliveryAddressDivision3 == null){
                      multientregaBloc.changeDeliveryAdrressDivision3(valueMapCorregimientos["corregimientos"]);
                      bloc.changeDivision3(multientregaBloc.deliveryAddressDivision3[0]);
                    }

                        // ***
                      HttpLastMultientrega().getBarriosMultientrega(tokenMultientrega, valueMapCorregimientos["corregimientos"][0]["Id"]).then((valueBarrios){
                        dynamic valueMapBarrios = json.decode(valueBarrios);
                        if(valueMapBarrios["ok"] == false) return;
                        if(multientregaBloc.deliveryAddressDivision4 == null){
                          multientregaBloc.changeDeliveryAdrressDivision4(valueMapBarrios["barrios"]);
                          bloc.changeDivision4(multientregaBloc.deliveryAddressDivision4[0]);
                        }
                      });
                  });
              });
            });
    
      }else{

      }
    });


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleDropdown(responsive, height, width, generalText.titlesDropdownPlaces()[0]),
        _division1(responsive, bloc, height, width),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        _titleDropdown(responsive, height, width, generalText.titlesDropdownPlaces()[1]),
        _division2(responsive, bloc, height, width),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        _titleDropdown(responsive, height, width, generalText.titlesDropdownPlaces()[2]),
        _division3(responsive, bloc, height, width),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        _titleDropdown(responsive, height, width, generalText.titlesDropdownPlaces()[3]),
        _division4(responsive, bloc, height, width),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        _crearPlaceOfDelivery(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        separador1(context),
        SizedBox(height: MediaQuery.of(context).size.height * 0.06),

        _crearPhoneDelivery(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        _crearContact(responsive, bloc),
        SizedBox(height: MediaQuery.of(context).size.height * 0.5),
      ],
    );
  }

Widget _titleDropdown(Responsive responsive, double height, double width, String title){
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.01),
      child: Text(title,
          style: TextStyle(
              color: Color.fromRGBO(173, 181, 189, 1.0),
              fontWeight: FontWeight.w500,
              fontSize: responsive.ip(2))),
    );
  }

 Widget _division1(Responsive responsive, AdFormBloc bloc, double height, double width){
  return StreamBuilder(
      stream:  bloc.division1Stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
            return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.w400),
                        hintText: 'Please select city',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          value: snapshot.data,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                          style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5),
                              height: 0,
                              fontWeight: FontWeight.w400),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(173, 181, 189, 1),
                          ),
                          onChanged: (dynamic newValue) {
                            bloc.changeDivision2(null);
                            bloc.changeDivision3(null);
                            bloc.changeDivision4(null);
                            FocusScope.of(context).requestFocus(new FocusNode());
                            bloc.changeDivision1(newValue);

                            HttpLastMultientrega().getDistritosMultientrega(tokenMultientrega, newValue["Id"]).then((valueDistritos){
                              dynamic valueMapDistritos = json.decode(valueDistritos);
                              if(valueMapDistritos["ok"] == false) return;
                              multientregaBloc.changeDeliveryAdrressDivision2(valueMapDistritos["distritos"]);
                              bloc.changeDivision2(multientregaBloc.deliveryAddressDivision2[0]);

                                // ***
                                HttpLastMultientrega().getCorregimientosMultientrega(tokenMultientrega, valueMapDistritos["distritos"][0]["Id"]).then((valueCorregimientos){
                                  dynamic valueMapCorregimientos = json.decode(valueCorregimientos);
                                  if(valueMapCorregimientos["ok"] == false) return;
                                  multientregaBloc.changeDeliveryAdrressDivision3(valueMapCorregimientos["corregimientos"]);
                                  bloc.changeDivision3(multientregaBloc.deliveryAddressDivision3[0]);

                                      // ***
                                    HttpLastMultientrega().getBarriosMultientrega(tokenMultientrega, valueMapCorregimientos["corregimientos"][0]["Id"]).then((valueBarrios){
                                      dynamic valueMapBarrios = json.decode(valueBarrios);
                                      if(valueMapBarrios["ok"] == false) return;
                                      multientregaBloc.changeDeliveryAdrressDivision4(valueMapBarrios["barrios"]);
                                      bloc.changeDivision4(multientregaBloc.deliveryAddressDivision4[0]);
                                    });
                                });
                            });
                          },
                          items: multientregaBloc.deliveryAddressDivision1
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value["Nombre"]),
  
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              );
    
        }else if(snapshot.hasError){
          return Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: height * 0.2),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(generalText.weWillGetItThereFast(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontSize: responsive.ip(3))),
                        ],
                      ),
                    ),
                  );
        }else{
          return _loadinDropdown(responsive);
        }
      });
  }

Widget _division2(Responsive responsive, AdFormBloc bloc, double height, double width){
  return StreamBuilder(
      stream:  bloc.division2Stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
            return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.w400),
                        hintText: 'Please select city',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          value: snapshot.data,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                          style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5),
                              height: 0,
                              fontWeight: FontWeight.w400),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(173, 181, 189, 1),
                          ),
                          onChanged: (dynamic newValue) {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            bloc.changeDivision2(newValue);
                            bloc.changeDivision3(null);
                            bloc.changeDivision4(null);

                            // ***
                                HttpLastMultientrega().getCorregimientosMultientrega(tokenMultientrega, newValue["Id"]).then((valueCorregimientos){
                                  dynamic valueMapCorregimientos = json.decode(valueCorregimientos);
                                  if(valueMapCorregimientos["ok"] == false) return;
                                  multientregaBloc.changeDeliveryAdrressDivision3(valueMapCorregimientos["corregimientos"]);
                                  bloc.changeDivision3(multientregaBloc.deliveryAddressDivision3[0]);

                                      // ***
                                    HttpLastMultientrega().getBarriosMultientrega(tokenMultientrega, valueMapCorregimientos["corregimientos"][0]["Id"]).then((valueBarrios){
                                      dynamic valueMapBarrios = json.decode(valueBarrios);
                                      if(valueMapBarrios["ok"] == false) return;
                                      multientregaBloc.changeDeliveryAdrressDivision4(valueMapBarrios["barrios"]);
                                      bloc.changeDivision4(multientregaBloc.deliveryAddressDivision4[0]);
                                    });
                                });
                          },
                          items: multientregaBloc.deliveryAddressDivision2
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value["Nombre"]),
  
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              );
    
        }else if(snapshot.hasError){
          return Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: height * 0.2),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(generalText.weWillGetItThereFast(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontSize: responsive.ip(3))),
                        ],
                      ),
                    ),
                  );
        }else{
          return _loadinDropdown(responsive);
        }
      });
  }

Widget _division3(Responsive responsive, AdFormBloc bloc, double height, double width){
  return StreamBuilder(
      stream:  bloc.division3Stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
            return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.w400),
                        hintText: 'Please select city',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          value: snapshot.data,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                          style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5),
                              height: 0,
                              fontWeight: FontWeight.w400),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(173, 181, 189, 1),
                          ),
                          onChanged: (dynamic newValue) {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            bloc.changeDivision3(newValue);
                            bloc.changeDivision4(null);

                            HttpLastMultientrega().getBarriosMultientrega(tokenMultientrega, newValue["Id"]).then((valueBarrios){
                              dynamic valueMapBarrios = json.decode(valueBarrios);
                              if(valueMapBarrios["ok"] == false) return;
                              multientregaBloc.changeDeliveryAdrressDivision4(valueMapBarrios["barrios"]);
                              bloc.changeDivision4(multientregaBloc.deliveryAddressDivision4[0]);
                            });
                          },
                          items: multientregaBloc.deliveryAddressDivision3
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value["Nombre"]),
  
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              );
    
        }else if(snapshot.hasError){
          return Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: height * 0.2),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(generalText.weWillGetItThereFast(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontSize: responsive.ip(3))),
                        ],
                      ),
                    ),
                  );
        }else{
          return _loadinDropdown(responsive);
        }
      });
  }

Widget _division4(Responsive responsive, AdFormBloc bloc, double height, double width){
  return StreamBuilder(
      stream:  bloc.division4Stream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
            Navigator.pop(context);
            return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.w400),
                        hintText: 'Please select city',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<dynamic>(
                          isExpanded: true,
                          value: snapshot.data,
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                          style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5),
                              height: 0,
                              fontWeight: FontWeight.w400),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(173, 181, 189, 1),
                          ),
                          onChanged: (dynamic newValue) {
                            FocusScope.of(context).requestFocus(new FocusNode());
                            bloc.changeDivision4(newValue);
                          },
                          items: multientregaBloc.deliveryAddressDivision4
                              .map<DropdownMenuItem<dynamic>>((dynamic value) {
                            return DropdownMenuItem<dynamic>(
                              value: value,
                              child: Text(value["Nombre"]),
  
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              );
    
        }else if(snapshot.hasError){
          return Center(
                    child: Container(
                      margin:
                          EdgeInsets.only(top: height * 0.2),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.center,
                        children: [
                          Text(generalText.weWillGetItThereFast(),
                          textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontSize: responsive.ip(3))),
                        ],
                      ),
                    ),
                  );
        }else{
          return _loadinDropdown(responsive);
        }
      });
  }


// ***************************
  bool _validarAddress(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.address == null) {
      validate = false;
    } else {
      if (bloc.address.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
 Widget _crearPlaceOfDelivery(Responsive responsive, AdFormBloc bloc) {
    String text =
        (_validarAddress(bloc) == false) ? generalText.titlesDropdownPlaces()[4] : '';

    controladorPlaceOfDelivery.text = (_validarAddress(bloc) == false) ? '' : bloc.address;
    controladorPlaceOfDelivery.selection = TextSelection.collapsed(offset: controladorPlaceOfDelivery.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: bloc.addressStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorPlaceOfDelivery,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                // maxLines: 3,
                // maxLength: 150,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: text,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error),
                        
                onChanged: (value){
                      bloc.changeAddress(value);
                    },
                onTap: () {
                  text = '';
                }),
          );
        });
  }


// ***************************
  Widget _crearPhoneDelivery(Responsive responsive, AdFormBloc bloc) {
    return StreamBuilder(
        stream: bloc.phoneDeliveryStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.08,
            child: TextField(
                controller: controladorPhoneDelivery,
                keyboardType: TextInputType.phone,
                style: TextStyle(
                    fontSize: responsive.ip(3),
                    fontWeight: FontWeight.normal,
                    color: Color.fromRGBO(173, 181, 189, 1)),
                decoration: InputDecoration(
                  hintText: generalText.destinaTionMobileNumber(),
                  enabledBorder: const OutlineInputBorder(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    borderSide: const BorderSide(
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(173, 181, 189, 1),
                    fontSize: responsive.ip(3),
                    fontWeight: FontWeight.normal,
                  ),
                  errorText: snapshot.error,
                  border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                          color: Color.fromRGBO(173, 181, 189, 1))),
                ),
                onChanged: (value) => {bloc.changePhoneDelivery(value)}),
          );
        });
  }

// ***************************
  bool _validarContact(AdFormBloc bloc) {
    bool validate = false;
    if (bloc.contact == null) {
      validate = false;
    } else {
      if (bloc.contact.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }
 Widget _crearContact(Responsive responsive, AdFormBloc bloc) {
    String text =
        (_validarContact(bloc) == false) ? generalText.deliveryContactName() : '';

    controladorContact.text = (_validarContact(bloc) == false) ? '' : bloc.contact;
    controladorContact.selection = TextSelection.collapsed(offset: controladorContact.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: bloc.contactStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(3), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorContact,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                // maxLines: 3,
                // maxLength: 150,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: text,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error),
                        
                onChanged: (value){
                      bloc.changeContact(value);
                    },
                onTap: () {
                  text = '';
                }),
          );
        });
  }

// ******************
  Widget _loadinDropdown(Responsive responsive){
  List<String> listVoid = ['...'];
  return Container(
                height: MediaQuery.of(context).size.height * 0.08,
                child: InputDecorator(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5),
                          fontWeight: FontWeight.w500,
                        ),
                        errorStyle: TextStyle(
                            color: Colors.redAccent,
                            fontSize: responsive.ip(2.5),
                            fontWeight: FontWeight.w400),
                        hintText: 'Please select city',
                        border:
                            OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: '...',
                          icon: Icon(Icons.keyboard_arrow_down),
                          iconSize: MediaQuery.of(context).size.width * 0.05,
                          style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5),
                              height: 0,
                              fontWeight: FontWeight.w400),
                          elevation: 16,
                          underline: Container(
                            height: 2,
                            color: Color.fromRGBO(173, 181, 189, 1),
                          ),
                          onChanged: (dynamic newValue) {
    
                          },
                          items: listVoid
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
  
                            );
                          }).toList(),
                        ),
                      ),
                    ),
              );
 }



}