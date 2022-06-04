// @dart=2.9
import 'dart:convert';
import 'package:maando/src/pages/admin/unapproved_packages.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/pages/admin/flights.dart';
import 'package:maando/src/pages/admin/payments.dart';
import 'package:maando/src/pages/admin/users.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';

class Admin extends StatefulWidget {
  Admin({Key key}) : super(key: key);

  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {

  int cont = 15;
  List<bool> activeIcon = [true, false, false];
  bool activeNavigationBar = true;
  int _currentIndex;
  String pageNavigationBar = 'users';  // users, flight, payments, UnapprovePpackages
  Http _http = Http();


 @override
    void initState() {
      // TODO: implement initState
      super.initState();
      try{
        if(blocAdmin.tap == null) blocAdmin.changeTap(0);
      }catch(e){
        blocAdmin.changeTap(0);
      }
      _currentIndex = blocAdmin.tap;
    }

  Widget pageNavigator(){
    if(blocAdmin.tap == 0){
      return UnapprovePpackages();
    }if(blocAdmin.tap == 1){
      return Users();
    }if(blocAdmin.tap == 2){
      return Fligths();
    }if(blocAdmin.tap == 3){
      return Payments();
    }else{
      return Users();
    }
  }


  
  Widget build(BuildContext context) {

    conectivity.validarConexion(context, 'admin');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);


    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: onBabTapped,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.local_post_office_rounded), label: adminText.notApproved()),
          BottomNavigationBarItem(icon: Icon(Icons.supervised_user_circle), label: adminText.users()),
          BottomNavigationBarItem(icon: Icon(Icons.flight_outlined), label: adminText.flights()),
          BottomNavigationBarItem(icon: Icon(Icons.attach_money), label: adminText.payments()),
          // BottomNavigationBarItem(icon: Icon(Icons.school), title: Text('D')),
      ]),
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                    height: height * 0.1),
                _admin(context, responsive),
                 // AQUI VA EL CONTENIDO
                 pageNavigator()                     
              ],
            ),

            // AQUI VA EL BOTON DE ABAJO
            _appBar(),
          ],
        ));
  }

  onBabTapped(int index){
    setState(() {
          _currentIndex = index;
          if(index == 0){
            blocAdmin.changeTap(0);
                _http
                .getUserAdmin(context: context, email: preference.prefsInternal.get('email'), cont: cont)
                .then((users) {
              final valueMap = json.decode(users);
              if (valueMap['ok'] == false) {
              } else {
                blocAdmin.changeUsers(valueMap["users"]);
                blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
                // print('>>>>> >>>>>> >>>>>> ${valueMap["totalUsers"]}');
              }
            });
          }else if(index == 1){
            blocAdmin.changeTap(1);
          }else if(index == 2){
            blocAdmin.changeTap(2);
          }else if(index == 3){
            blocAdmin.changeTap(3);
          }else{
            blocAdmin.changeTap(0);
          }
      });
  }




  // ******************
  Widget _appBar() {
    return StreamBuilder<bool>(
        stream: blocGeneral.viewNavBarStream,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshoptNavBar) {
          if (snapshoptNavBar.hasError) {
            return Container();
          } else if (snapshoptNavBar.hasData) {
            if (snapshoptNavBar.data == true) {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.06,
                  margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: variableGlobal.margenTopGeneral(context),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                      arrwBackYellowPersonalizado(context, 'principal'),
                    ],
                  ));
            } else {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: variableGlobal.margenTopGeneral(context),
                  ),
                  child: Container());
            }
          } else {
            return Container(
                margin: EdgeInsets.only(
                  left: variableGlobal.margenPageWith(context),
                  right: variableGlobal.margenPageWith(context),
                  top: variableGlobal.margenTopGeneral(context),
                ),
                child: Container());
          }
        });
  }

  // *********************
    Widget _admin(BuildContext context, Responsive responsive) {
    return Container(
      margin:
          EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
      child: Text(generalText.admin(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1.0),
              fontSize: responsive.ip(3.5)
)),
    );
  }
}





// =============================================
// =============================================

