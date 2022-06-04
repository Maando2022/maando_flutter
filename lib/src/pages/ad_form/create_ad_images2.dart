// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/services/toast.dart';
import 'dart:ui';
import 'package:maando/src/widgets/modal_suggestion_price.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/blocs/ad_form_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/pages/ad_form/create_ad_images1.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/blocs/general_bloc.dart';

class CreateAdImages2 extends StatefulWidget {
  CreateAdImages2({Key key}) : super(key: key);

  @override
  _CreateAdImages2State createState() => _CreateAdImages2State();
}

class _CreateAdImages2State extends State<CreateAdImages2> {
  List<PickedFile> imagenes = [];
  int _currentIndex = 0;

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocGeneral.changeSendRequest(false);
  }



  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_images2');

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);


    return StreamBuilder(
      stream: blocGeneral.sendRequestStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshopt) {
        if (snapshopt.hasData) {
          if (snapshopt.data == true) {
            return _scaffold2(context, responsive, height, width, bloc);
          } else {
            return _scaffold1(context, responsive, height, width, bloc);
          }
        } else if (snapshopt.hasError) {
          return Container();
        } else {
          return Container(
            child: Center(child: CircularProgressIndicator()),
          );
        }
      });
  }




 Widget _scaffold1(BuildContext context, Responsive responsive, double height, double width, AdFormBloc bloc){
    return Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(),
                label: adsText.camera(),
              ),
              BottomNavigationBarItem(
                icon: Container(),
                label: adsText.gallery(),
              )
            ],
          ),
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.only(
                top: variableGlobal.margenTopGeneral(context),
                right: width * 0.04,
                left: width * 0.04),
            child: Stack(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                          child: Center(
                              child: Column(children: <Widget>[
                        Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  iconFace1(context),
                                ],
                              ),
                              closeAd(context,'assets/images/close/close button 1@3x.png'),
                            ],
                          ),
                      ]))),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        child: Text(adsText.createAd(),
                            style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(3.5),
                                )),
                      ),
                      SizedBox(
                        height: height * 0.02,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            circuloVerde(context, 3, 3),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Text(adsText.photos(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontWeight: FontWeight.w500,
                                        fontSize: responsive.ip(2.2))),
                                SizedBox(
                                  height: height * 0.01,
                                ),
                                Text(
                                    '${generalText.next()}: ${adsText.adReadyForPublish()}',
                                    style: TextStyle(
                                        color:
                                            Color.fromRGBO(173, 181, 189, 1.0),
                                        fontWeight: FontWeight.w500,
                                        fontSize: responsive.ip(2)))
                              ],
                            ),
                          ],
                        ),
                      ),
                      // ***************************  PARTE DEL MEDIO
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          StreamBuilder(
                              stream: bloc.listImagesStream,
                              builder: (BuildContext context, snapshopt) {
                                if(snapshopt.hasData){
                                  return  Row(
                                            children: _listaImagenes(height, width, bloc),
                                          );
                                }else if(snapshopt.hasError){
                                  return Container();
                                }else{
                                  return Container();
                                }
                              }),
                         
                          SizedBox(
                            height: height * 0.05,
                          ),
                           Text(adsText.pressAndHoldToRemoveAnImage(), 
                           style: TextStyle(
                              color: Color.fromRGBO(173, 181, 189, 1.0),
                              fontSize: responsive.ip(1.8),
                              fontWeight: FontWeight.w500,
                            )),
                          Container(
                            margin: EdgeInsets.only(top: height * 0.0),
                            child: CupertinoButton(
                              padding: EdgeInsets.all(0),
                              child: Text(adsText.addMorePhotos(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(173, 181, 189, 1.0),
                                    fontSize: responsive.ip(3.5),
                                    fontWeight: FontWeight.normal,
                                  )),
                              color: Color.fromRGBO(251, 251, 251, 1.0),
                              onPressed: (_currentIndex == 0)
                                  ? _tomarFoto
                                  : _seleccionarFoto,
                            ),
                          ),
                        ],
                      ),
                    ]),
                // *************************************  NEXT, CANCEL
                Container(
                  margin: EdgeInsets.only(top: height * 0.73),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      back(context, CreateAdImages1()),
                      (bloc.listImages == null || bloc.listImages.length <= 0)
                          ? toast(context, responsive, height, width)
                          // : showModal(context, responsive, height, width)
                         : next(context, 'create_ad_resume'),
                    ],
                  ),
                )
              ],
            ),
          )
          ));
  }
  // *************************
  Widget _scaffold2(BuildContext context, Responsive responsive, double height, double width, AdFormBloc bloc){
    return Scaffold(
          backgroundColor: Color.fromRGBO(251, 251, 251, 1),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Container(),
                label: adsText.camera(),
              ),
              BottomNavigationBarItem(
                icon: Container(),
                label: adsText.gallery(),
              )
            ],
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: Container(
                margin: EdgeInsets.only(
                    top: variableGlobal.margenTopGeneral(context),
                    right: width * 0.04,
                    left: width * 0.04),
                child: Stack(
                  children: [
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                              child: Center(
                                  child: Column(children: <Widget>[
                            Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      iconFace1(context),
                                    ],
                                  ),
                                  closeAd(context,'assets/images/close/close button 1@3x.png'),
                                ],
                              ),
                          ]))),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            child: Text(adsText.createAd(),
                                style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(3.5),
                                    )),
                          ),
                          SizedBox(
                            height: height * 0.02,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                circuloVerde(context, 3, 3),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text(adsText.photos(),
                                        style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1.0),
                                            fontWeight: FontWeight.w500,
                                            fontSize: responsive.ip(2.2))),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Text(
                                        '${generalText.next()}: ${adsText.adReadyForPublish()}',
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(173, 181, 189, 1.0),
                                            fontWeight: FontWeight.w500,
                                            fontSize: responsive.ip(2)))
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // ***************************  PARTE DEL MEDIO
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              StreamBuilder(
                                  stream: bloc.listImagesStream,
                                  builder: (BuildContext context, snapshopt) {
                                    if(snapshopt.hasData){
                                      return  Row(
                                                children: _listaImagenes(height, width, bloc),
                                              );
                                    }else if(snapshopt.hasError){
                                      return Container();
                                    }else{
                                      return Container();
                                    }
                                  }),
                              SizedBox(
                                height: height * 0.05,
                              ),
                               Text(adsText.pressAndHoldToRemoveAnImage(), 
                               style: TextStyle(
                                  color: Color.fromRGBO(173, 181, 189, 1.0),
                                  fontSize: responsive.ip(1.8),
                                  fontWeight: FontWeight.w500,
                                )),
                              Container(
                                margin: EdgeInsets.only(top: height * 0.0),
                                child: CupertinoButton(
                                  padding: EdgeInsets.all(0),
                                  child: Text(adsText.addMorePhotos(),
                                      style: TextStyle(
                                        color: Color.fromRGBO(173, 181, 189, 1.0),
                                        fontSize: responsive.ip(3.5),
                                        fontWeight: FontWeight.normal,
                                      )),
                                  color: Color.fromRGBO(251, 251, 251, 1.0),
                                  onPressed: (_currentIndex == 0)
                                      ? _tomarFoto
                                      : _seleccionarFoto,
                                ),
                              ),
                            ],
                          ),
                        ]),
                    // *************************************  NEXT, CANCEL
                    Container(
                      margin: EdgeInsets.only(top: height * 0.73),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          back(context, CreateAdImages1()),
                          (bloc.listImages == null || bloc.listImages.length <= 0)
                              ? toast(context, responsive, height, width)
                              : showModal(context, responsive, height, width)
                              // : next(context, 'create_ad_resume'),
                        ],
                      ),
                    )
                  ],
                ),
              )),
               BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: Container(
                color: Colors.white.withOpacity(0.2),
                child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: height * 0.18, horizontal: width * 0.04),
                    child: Center(
                        child: ModalConSuggestionPrice())),
              ),
            )
            ],
          ));
  }

  // *************************

  List<Widget> _listaImagenes(double height, double width, AdFormBloc bloc) {
    List<Widget> lista = [];
    if (bloc.listImages == null) {
      lista.add(Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: width * 0.2),
            width: width * 0.23,
            height: width * 0.23,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/general/Mask Group@3x.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: CupertinoButton(
                child: Container(),
                onPressed: () => {print('Aqui se hace la búsqueda')}),
          ),
        ],
      ));
    } else {
      if (bloc.listImages.length == 1) {
        lista.add(Row(
          children: <Widget>[
            GestureDetector(
              onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[0]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[0].path)),
                      fit: BoxFit.cover,
                    )),
                margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
              ),
            )
          ],
        ));
      } else if (bloc.listImages.length == 2) {
        lista.add(Row(
          children: <Widget>[
            GestureDetector(
              onLongPress: (){
                    bloc.listImages.remove(bloc.listImages[0]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                 margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[0].path)),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            GestureDetector(
              onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[1]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[1].path)),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
          ],
        ));
      } else if (bloc.listImages.length == 3) {
        lista.add(Row(
          children: <Widget>[
            GestureDetector(
              onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[0]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[0].path)),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            GestureDetector(
              onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[1]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[1].path)),
                      fit: BoxFit.cover,
                    )),
              ),
            ),
            GestureDetector(
              onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[2]);
                   bloc.changeListImages(bloc.listImages);              
              },
              child: Container(
                margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                width: width * 0.23,
                height: width * 0.23,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: FileImage(File(bloc.listImages[2].path)),
                      fit: BoxFit.cover,
                    )),
              ),
            )
          ],
        ));
      } else if (bloc.listImages.length == 4) {
        lista.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onLongPress: (){
                  bloc.listImages.remove(bloc.listImages[0]);
                   bloc.changeListImages(bloc.listImages);              
                },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[0].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                  onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[1]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[1].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[2]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[2].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[3]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[3].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            )
          ],
        ));
      } else if (bloc.listImages.length == 5) {
        lista.add(Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[0]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[0].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[1]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[1].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[2]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[2].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[3]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[3].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
                GestureDetector(
                   onLongPress: (){
                      bloc.listImages.remove(bloc.listImages[4]);
                      bloc.changeListImages(bloc.listImages);              
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: height * 0.03, right: width * 0.02),
                    width: width * 0.23,
                    height: width * 0.23,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                          image: FileImage(File(bloc.listImages[4].path)),
                          fit: BoxFit.cover,
                        )),
                  ),
                ),
              ],
            )
          ],
        ));
      } else {
        lista.add(Container());
      }
    }
    return lista;
  }

  // *******************
  _seleccionarFoto() async {
    final bloc = ProviderApp.ofAdForm(context);
    if (bloc.listImages != null) {
      if (bloc.listImages.length >= 5) {
        toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
        return;
      }
    }

    final _picker = ImagePicker();
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 80, maxHeight: 400, maxWidth: 400);

    if (pickedFile != null) {
      if (bloc.listImages == null || bloc.listImages.length == 0) {
        bloc.changeListImages([File(pickedFile.path)]);
      } else {
        List<File> imagesFiles = bloc.listImages;
        imagesFiles.add(File(pickedFile.path));
        bloc.changeListImages(imagesFiles);
      }
      setState(() {});
    } else {
      return;
    }
  }

  _tomarFoto() async {
    final bloc = ProviderApp.ofAdForm(context);
    if (bloc.listImages != null) {
      if (bloc.listImages.length >= 5) {
        toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
        return;
      }
    }

    final _picker = ImagePicker();
    final PickedFile pickedFile =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 80, maxHeight: 400, maxWidth: 400);

    if (pickedFile != null) {
      if (bloc.listImages == null || bloc.listImages.length == 0) {
        bloc.changeListImages([File(pickedFile.path)]);
      } else {
        List<File> imagesFiles = bloc.listImages;
        imagesFiles.add(File(pickedFile.path));
        bloc.changeListImages(imagesFiles);
      }
      setState(() {});
    } else {
      return;
    }
  }

  // ***************************

  Widget toast(BuildContext context, Responsive responsive, double height, double width) {
    return StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
      return RaisedButton(
        onPressed: () {
          toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Center(
            child: Text('Next',
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.bold,
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

  Widget showModal(BuildContext context, Responsive responsive, double height, double width) {
    return RaisedButton(
        onPressed: () {
          blocGeneral.changeSendRequest(true);
        },
        child: Container(
          width: width * 0.35,
          height: height * 0.07,
          // margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
          child: Center(
            child: Text('Next',
                style: TextStyle(
                  color: Color.fromRGBO(33, 36, 41, 0.5),
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        color: Color.fromRGBO(251, 251, 251, 1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
            side:
                BorderSide(width: 1.5, color: Color.fromRGBO(255, 206, 6, 1))),
      );
  }

  // ***************************

  double _margenDinamico(BuildContext context, double height, double width) {
    final bloc = ProviderApp.ofAdForm(context);

    if (bloc.listImages.length >= 6) {
      return height * 0.0;
    } else if ((bloc.listImages.length >= 0 && bloc.listImages.length <= 3) &&
        (height <= 850)) {
      return height * 0.20;
    } else if ((bloc.listImages.length >= 4 && bloc.listImages.length <= 5) &&
        (height <= 850)) {
      return height * 0.05;
    } else if ((bloc.listImages.length >= 0 && bloc.listImages.length <= 3) &&
        (height >= 850)) {
      return height * 0.272;
    } else if ((bloc.listImages.length >= 4 && bloc.listImages.length <= 5) &&
        (height >= 850)) {
      return height * 0.125;
    } else {
      return height * 0.135;
    }
  }
}
