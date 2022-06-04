// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/recursos.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/register_accout_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final preference = new Preferencias();
  Http _http = Http();
  String phoneCode = '';
  dynamic user;

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    
     blocGeneral.aiportsDestination.forEach((country) {
        if (preference.prefsInternal.get('country') == country["name"]) {
          phoneCode = '+(${country["indicative-code"]}) ${preference.prefsInternal.get('phone')}';
        }
      });

      if(preference.prefsInternal.get('country') == ''){
           preference.prefsInternal.setString('country', generalText.selectACountry());
      }
      if(preference.prefsInternal.get('city') == ''){
           preference.prefsInternal.setString('city', generalText.selectACity());
      }
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
                            return Scaffold(
                                        resizeToAvoidBottomInset: false,
                                        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
                                        body: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                      top: variableGlobal.margenTopGeneral(context),
                                      right:
                                          variableGlobal.margenPageWith(context),
                                      left:
                                          variableGlobal.margenPageWith(context)),
                                  child: Stack(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              iconFace1(context),
                                            ],
                                          ),
                                          close(context,
                                              'assets/images/close/close button 1@3x.png'),
                                        ],
                                      ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: height * 0.02,
                                      vertical:
                                          variableGlobal.margenPageWith(context)),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[
                                      Text(
                                        generalText.editProfile(),
                                        style: TextStyle(
                                          fontSize: responsive.ip(3.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                      SizedBox(
                                        height: height * 0.021,
                                      ),
                                      Container(
                                          width: width * 0.003,
                                          // height: miheight * 0.005,
                                          child: lineYellowNoti(context))
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _avatar(height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _email(responsive, height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _fullName(responsive, height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _phone(responsive, height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _country(responsive, height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),
                                _city(responsive, height, width),
                                SizedBox(
                                  height: height * 0.021,
                                ),


                              ],
                            ),
                                        ),
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



  // *************************************
  Widget _avatar(double height, double width){
    return Container(
      decoration: BoxDecoration(
        color: Color.fromRGBO(173, 181, 189, 0.2),
        borderRadius: BorderRadius.circular(12)
      ),
      padding: EdgeInsets.all(width * 0.03),
      margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWith(context)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  width: width * 0.3,
                  height: width * 0.3,
                child: StreamBuilder(
                          stream: blocGeneral.avatarFileStream,
                          builder: (BuildContext context, AsyncSnapshot snapshotAvatar) {
                            if(snapshotAvatar.hasData){
                              if(snapshotAvatar.data == null){
                                  return CircleAvatar(
                                    backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                    backgroundImage: NetworkImage(preference.prefsInternal.get('urlAvatar')),
                                    child: ( preference.prefsInternal.get('urlAvatar') == null || preference.prefsInternal.get('urlAvatar') == '')
                                    ? Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(urlAvatarVoid),
                                          fit: BoxFit.contain,
                                        ),
                                      ))
                                    : Container(),
                                  );
                              }else{
                                return Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: FileImage(
                                                    File(snapshotAvatar.data.path)), fit: BoxFit.cover,)
                                  ),
                                  
                                );
                              }
                            }else if(snapshotAvatar.hasError){
                                return CircleAvatar(
                                    backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                    backgroundImage: NetworkImage(preference.prefsInternal.get('urlAvatar')),
                                    child: ( preference.prefsInternal.get('urlAvatar') == null || preference.prefsInternal.get('urlAvatar') == '')
                                    ? Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(urlAvatarVoid),
                                          fit: BoxFit.contain,
                                        ),
                                      ))
                                    : Container(),
                                  );
                            }else{
                              return CircleAvatar(
                                    backgroundColor: Color.fromRGBO(173, 181, 189, 0.0),
                                    backgroundImage: NetworkImage(preference.prefsInternal.get('urlAvatar')),
                                    child: ( preference.prefsInternal.get('urlAvatar') == null || preference.prefsInternal.get('urlAvatar') == '')
                                    ? Container(
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(urlAvatarVoid),
                                          fit: BoxFit.contain,
                                        ),
                                      ))
                                    : Container(),
                                  );
                            }
                          })
              ),
            ],
          ),
          (preference.prefsInternal.get('provider') == 'form' || preference.prefsInternal.get('provider') == 'apple') ? 
          Positioned(
            bottom: 0,
            child: CupertinoButton(
                  onPressed: (){
                    _seleccionarFotoGallery(context);
                  },
                  padding: EdgeInsets.all(0),
                  child: Container(
                    height: width * 0.1,
                    width: width * 0.1,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100.0),
                      color: Color.fromRGBO(255, 206, 6, 1.0),
                      image: DecorationImage(image: AssetImage('assets/images/general/icon edit 1@3x.png'),
                      colorFilter: ColorFilter.mode(Color.fromRGBO(33, 36, 41, 0.2), BlendMode.darken),
                      fit: BoxFit.contain)
                    )
                  ),
                ),
          ) : Container()
        ],
      ),
    );
  }


  // *******************
  Widget _email(Responsive responsive, double height, double width){
    return Container(
      color: Color.fromRGBO(173, 181, 189, 0.1),
      child: ListTile(
              title: Text(createAccountText.email(),
              style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5))),
               subtitle: Text(
                      '${preference.prefsInternal.get('email')}',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontSize: responsive.ip(2.5))),
              trailing: Icon(Icons.arrow_forward_ios, size: width * 0.05, color: Color.fromRGBO(173, 181, 189, 1)),
              enabled: false,
              onTap: () {
              },
            ),
    );
  }

  
  // *******************
  Widget _fullName(Responsive responsive, double height, double width){
    return ListTile(
            enabled: (preference.prefsInternal.get('provider') =='apple'  || preference.prefsInternal.get('provider')=='form') ? true : false,
            title: Text(createAccountText.fullName(),
            style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5))),
             subtitle: Text(
                    '${preference.prefsInternal.get('fullName')}',
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: responsive.ip(2.5))),
            trailing: Icon(Icons.arrow_forward_ios, size: width * 0.05, color: Color.fromRGBO(173, 181, 189, 1)),
            onTap: () {
              Navigator.pushNamed(context, 'edit_name');
            },
          );
  }


  // *******************
  Widget _phone(Responsive responsive, double height, double width){
    return ListTile(
            title: Text(createAccountText.mobileNumber(),
            style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(173, 181, 189, 1),
                        fontSize: responsive.ip(2.5))),
             subtitle: Text((phoneCode == '') ? generalText.enterMobilePhoneNumber() : phoneCode,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontSize: responsive.ip(2.5))),
            trailing: Icon(Icons.arrow_forward_ios, size: width * 0.05, color: Color.fromRGBO(173, 181, 189, 1)),
            onTap: (){
              if(preference.prefsInternal.get('country') == '' || preference.prefsInternal.get('country') == generalText.selectACountry()){
                toastService.showToastCenter(context: context, text: generalText.selectACountry(), durationSeconds: 2);
              }else{
                Navigator.pushNamed(context, 'edit_phone');
              }
            },
          );
  }

  // *******************
  Widget _country(Responsive responsive, double height, double width){
    return ListTile(
                  title: Text(generalText.country(),
                  style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5))),
                  subtitle: Text(
                          '${preference.prefsInternal.get('country')}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: responsive.ip(2.5))),
                  trailing: Icon(Icons.arrow_forward_ios, size: width * 0.05, color: Color.fromRGBO(173, 181, 189, 1)),
                  onTap: () {
                     Navigator.pushNamed(context, 'edit_country');
                  },
                );
  }

  // *******************
  Widget _city(Responsive responsive, double height, double width){
    return ListTile(
                  title: Text(generalText.city(),
                  style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color.fromRGBO(173, 181, 189, 1),
                              fontSize: responsive.ip(2.5))),
                  subtitle: Text(
                          '${preference.prefsInternal.get('city')}',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontSize: responsive.ip(2.5))),
                  trailing: Icon(Icons.arrow_forward_ios, size: width * 0.05, color: Color.fromRGBO(173, 181, 189, 1)),
                  onTap: () {
                    if(preference.prefsInternal.get('country') == '' || preference.prefsInternal.get('country') == generalText.selectACountry()){
                      toastService.showToastCenter(context: context, text: generalText.selectACountry(), durationSeconds: 2);
                    }else{
                      Navigator.pushNamed(context, 'edit_city');
                    }
                  },
                );
  }
  

  // *******************
  _seleccionarFotoGallery(BuildContext context) async {
    // _pr = new ProgressDialog(context);
    // loadingGeneral(context, _pr, 'Loading image...');
    // // _pr.show();
    final _picker = ImagePicker();
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File(pickedFile.path);
      blocGeneral.changeAvatarFile(File(pickedFile.path));
      firebaseStorage
          .subirAvatar(File(pickedFile.path),
              preference.prefsInternal.get('email'), context)
          .then((_) {
             Future.delayed(Duration(seconds: 30), (){
              firebaseStorage.obtenerAvatar(preference.prefsInternal.get('email'))
                .then((img) async {
                  // _pr.hide();
                  print('LA URL DE LA IMAGEN $img');
                  await _http
                      .updateAvatarSocialMedia(
                        context: context,
                          email: preference.prefsInternal.get('email'),
                          urlAvatar: img)
                      .then((__) async {
                        preference.prefsInternal.setString('urlAvatar', await img);
                      });
                });
             });
      });
      setState(() {});
    } else {
      // _pr.hide();
      return;
    }
  }
}

