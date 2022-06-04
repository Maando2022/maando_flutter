// @dart=2.9
import 'dart:convert';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/textos/admin_text.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  ScrollController _scrollController = ScrollController();
  TextEditingController controladorSearchUser = TextEditingController();
  List<dynamic> aiports = blocGeneral.aiportsDestination;
  Http _http = Http();
  int cont = 100;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocGeneral.changeViewNavBar(true);
    _http
        .getUserAdmin(email: preference.prefsInternal.get('email'), cont: cont)
        .then((users) {
      final valueMap = json.decode(users);
      if (valueMap['ok'] == false) {
      } else {
        blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
        blocAdmin.changeUsers(valueMap["users"]);
      }
    });

    // *********

    _scrollController
      ..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 500), () {
          blocGeneral.changeViewNavBar(true);
        });

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta abajo
          cont = cont + 100;
          _http
              .getUserAdmin(
                  email: preference.prefsInternal.get('email'), cont: cont)
              .then((users) {
            final valueMap = json.decode(users);
            // print('LOS USERS  =====>>> ${valueMap}');
            if (valueMap['ok'] == false) {
              // logout();
              // Timer(Duration(milliseconds: 100), () {
              //   Navigator.pushNamed(context, 'login');
              // });
            } else {
              blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
              blocAdmin.changeUsers(valueMap["users"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });


  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container();
                      }else{
                           return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
                                        child: StreamBuilder(
                                          stream: blocAdmin.totalUsersStream,
                                          builder: (_, AsyncSnapshot snapshot){
                                            if(snapshot.hasData){
                                            return (
                                              preference.prefsInternal.getString('email') == 'jdv@jdvgroup.co' ||
                                              preference.prefsInternal.getString('email') == 'jdv@maando.com' ||
                                              preference.prefsInternal.getString('email') == 'david@jdvgroup.co' ||
                                              preference.prefsInternal.getString('email') == 'david@maando.com'
                                            ) ? Text('${snapshot.data} ${adminText.users()}') : Text('');
                                            }else if(snapshot.hasError){
                                              return Text('');
                                            }else{
                                              return Text('...');
                                            }
                                          },
                                        )
                                        ),
                                      _seachUser(responsive),
                                      // Container(
                                      //   height: height * 0.65,
                                      //   width: width,
                                      //   child: 
                                      //   listUsers(responsive, height, width),
                                      // ),
                                      listUsers(responsive, height, width),
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

  // **********
  Widget listUsers(Responsive responsive, double height, double width) {
    return StreamBuilder(
        stream: blocAdmin.usersStream,
        builder: (BuildContext context, snapshotUser) {
          if (snapshotUser.hasData) {
            String phoneCode = '';
            String phoneWhatsApps = '';
          List<CupertinoButton> usersWidget = [];
            for(var u in snapshotUser.data){

              usersWidget.add(CupertinoButton(
                  color: (u["active"] == false)
                      ? Color.fromRGBO(229, 81, 63, 0.5)
                      : null,
                  padding: EdgeInsets.all(0),
                  // onPressed: () => _viewDetailUser(u, phoneCode, phoneWhatsApps),
                  onPressed: (){
                    aiports.forEach((country) {
                      if (u["country"] == country["name"]) {
                        phoneCode = '+(${country["indicative-code"]})';
                        phoneWhatsApps = '${u["phone"]}';
                      }
                    });
                    _viewDetailUser(u, phoneCode, phoneWhatsApps);
                  },
                  child: ListTile(
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(u["email"]),
                        Text('$phoneCode$phoneWhatsApps'),
                        SizedBox(
                          height: height * 0.01,
                        )
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                    leading: CircleAvatar(
                      child: (u["avatar"] == null ||
                              u["avatar"] == '')
                          ? Text(
                              u["name"]
                                  .substring(0, 2)
                                  .toUpperCase(),
                              style: TextStyle(
                                  fontSize: responsive.ip(2),
                                  // height: 1.6,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            )
                          : Container(),
                      backgroundImage: 
                          NetworkImage((u["avatar"] == null || u["avatar"] == '') ? 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Fbackground_void.jpg?alt=media&token=69026fb3-874c-4068-9596-9e79abfeba00' : u["avatar"]),
                    ),
                    title: Text(u["name"].toString()),
                  ),
                ));
            }
            return KeyboardVisibilityBuilder(
              builder: (context, isKeyboardVisible) {
                return Container(
                          height: (isKeyboardVisible == false) ? height * 0.65 : height * 0.35,
                          child: SingleChildScrollView(
                            controller: _scrollController,
                            child: Wrap(
                              // direction: Axis.vertical,
                              children: usersWidget,
                            ),
                          ),
                        );
              }
            );
          } else if (snapshotUser.hasError) {
            return Center(
                child: Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Error!!',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(0, 0, 0, 1.0),
                          fontSize: responsive.ip(3))),
                ],
              ),
            ));
          } else {
            return Container(
              margin: EdgeInsets.only(top: 100.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }


  _viewDetailUser(dynamic user, String phoneCode, String phoneWhatsApps) {
    Navigator.pushNamed(context, 'user_datail',
        arguments: json.encode({
          'user': user,
          'phoneCode': phoneCode,
          'phoneWhatsApps': phoneWhatsApps
        }));
  }

  // *********

   Widget _seachUser(Responsive responsive) {
    String text =
        (_validarSearchUser(blocAdmin) == false) ? adminText.searchUser() : '';
    if(blocAdmin.searchUserStreamValue != false) controladorSearchUser.text = (_validarSearchUser(blocAdmin) == false) ? blocAdmin.searchUser : blocAdmin.searchUser;
    controladorSearchUser.selection = TextSelection.collapsed(offset: controladorSearchUser.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: blocAdmin.searchUserStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorSearchUser,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: text,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error),
                onChanged: (value){
                  Http().searchUser(value.trim()).then((valueResp){
                    final valueMap = json.decode(valueResp);
                    if(valueMap["ok"] == true){
                      if(value.trim().length <= 0){
                        _http
                            .getUserAdmin(
                                email: preference.prefsInternal.get('email'), cont: cont)
                            .then((users) {
                          final valueMap = json.decode(users);
                          // print('LOS USERS  =====>>> ${valueMap}');
                          if (valueMap['ok'] == false) {
                            // logout();
                            // Timer(Duration(milliseconds: 100), () {
                            //   Navigator.pushNamed(context, 'login');
                            // });
                          } else {
                            blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
                            blocAdmin.changeUsers(valueMap["users"]);
                          }
                        });
                      }
                      blocAdmin.changeUsers(valueMap["users"]);
                    }else{}
                  });
                },
                onTap: () {
                  text = '';
                }),
          );
        });
  }

  bool _validarSearchUser(AdminBloc bloc) {
    bool validate = false;
    try{
      if (bloc.searchUserStreamValue == false) {
          validate = false;
      } else {
        if (bloc.searchUser.length <= 0) {
          validate = false;
        } else {
          validate = true;
        }
      }
    }catch(e){
      validate = false;
    }
    return validate;
  }

}
