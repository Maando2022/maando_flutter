// @dart=2.9
import 'dart:convert';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class CreateAdWhatCanISend extends StatefulWidget {
  @override
  _CreateAdWhatCanISendState createState() => _CreateAdWhatCanISendState();
}

class _CreateAdWhatCanISendState extends State<CreateAdWhatCanISend> {
  TextEditingController controladorTitle = TextEditingController();
  Http _http = Http();
  final formKey = GlobalKey<FormState>();
  dynamic listItems = [];
  int since = 10;
  String search;
  // ************************************************

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

    return Scaffold(
        resizeToAvoidBottomInset:
            false, // los widgets no cambian de tamaño de alto cuando sale el teclado
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: Stack(
          children: [
            // **********************************************************
            Container(
              margin: EdgeInsets.only(
                  top: width * 0.5,
                  right: variableGlobal.margenPageWith(context),
                  left: variableGlobal.margenPageWith(context)),
              child: _crearItems(responsive),
            ),
            // *********************************************
            Positioned(
              left: variableGlobal.margenPageWith(context),
              right: variableGlobal.margenPageWith(context),
              top: variableGlobal.margenPageWithFlightTop(context),
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
                      closeWhatCanISend(context,
                          'assets/images/close/close button 1@3x.png'),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        child: Text(adsText.whatCanISend(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3.5))),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.015,
                  ),
                  _inputSearch(responsive),
                ],
              ),
            ),
            // *********************************************
          ],
        ));
  }

  Widget _inputSearch(Responsive responsive) {
    return Container(
      child: Form(
        key: formKey,
        child: TextFormField(
            style: TextStyle(
                fontSize: responsive.ip(3),
                fontWeight: FontWeight.w500,
                color: Color.fromRGBO(173, 181, 189, 1)),
            textInputAction: TextInputAction.done,
            cursorColor: Colors.deepOrange,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: generalText.search(),
              border: InputBorder.none,
              labelStyle: TextStyle(
                  fontSize: responsive.ip(3),
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(173, 181, 189, 1)),
            ),
            onChanged: (value) {
              setState(() {
                _http.itemsToBring(10, value).then((value) {
                  search = value;
                  listItems = json.decode(value);
                });
              });
            }),
      ),
    );
  }

  // ***************************************************************************
  Widget _crearItems(Responsive responsive) {
    return (search == null)
        ? FutureBuilder<dynamic>(
            future: _http.itemsToBring(since, ''),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Container();
              } else if (snapshot.hasData) {
                listItems = json.decode(snapshot.data);
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: listItems["count"],
                            itemBuilder: (context, index) {
                              return _item(responsive,
                                  listItems["array"][index]["name"],
                                  listItems["array"][index]["carryOnBags"],
                                  listItems["array"][index]["checkedBags"],
                                  '');
                            }),
                      ),
                    ],
                  ),
                );
              } else {
                return Container(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            })
        : SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listItems["count"],
                      itemBuilder: (context, index) {
                        return _item(responsive,
                            listItems["array"][index]["name"],
                            listItems["array"][index]["carryOnBags"],
                            listItems["array"][index]["checkedBags"],
                            '');
                      }),
                ),
              ],
            ),
          );
  }

  // ******************************************************************************************
  // ******************************************************************************************

  Widget _item(Responsive responsive, String name, String carryOnBags, String checkedBags, String description) {
    return ExpansionTile(
      title: Text(
        name,
        style: TextStyle(
            color: Colors.black,
            fontSize: responsive.ip(2.5),
            fontWeight: FontWeight.w600),
      ),
      onExpansionChanged: (exp) {
        print(exp);
      },
      children: [
        Container(
          margin:
              EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.045),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'Carry On Bags:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.ip(1.8),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    carryOnBags,
                    style: TextStyle(
                        fontSize: responsive.ip(1.8),
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.008,
              ),
              Row(
                children: [
                  Text(
                    'Checked Bags:',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: responsive.ip(1.8),
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    checkedBags,
                    style: TextStyle(
                        fontSize: responsive.ip(1.8),
                        color: Color.fromRGBO(173, 181, 189, 1)),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
      initiallyExpanded: false,
      subtitle: Container(),
      // trailing: Icon(Icons.keyboard_arrow_down, color: Color.fromRGBO(173, 181, 189, 1),),
    );
  }
}
