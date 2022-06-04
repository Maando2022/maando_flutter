// @dart=2.9
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/widgets/dialog_permissions.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/ad_form/create_ad_delivery_address.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/ads_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/utils/responsive.dart';

class CreateAdImages1 extends StatefulWidget {
  CreateAdImages1({Key key}) : super(key: key);

  @override
  _CreateAdImages1State createState() => _CreateAdImages1State();
}

class _CreateAdImages1State extends State<CreateAdImages1> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'create_ad_images1');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofAdForm(context);

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
              icon: Container(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              label: adsText.camera(),
            ),
            BottomNavigationBarItem(
              icon: Container(
                height: MediaQuery.of(context).size.width * 0.05,
              ),
              label: adsText.gallery(),
            )
          ],
        ),
        body: Container(
          margin: EdgeInsets.only(
              top: variableGlobal.margenTopGeneral(context),
              right: width * 0.02,
              left: width * 0.02),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                                  fontSize: responsive.ip(3.5))),
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
                                          color: Color.fromRGBO(
                                              173, 181, 189, 1.0),
                                          fontWeight: FontWeight.w500,
                                          fontSize: responsive.ip(2)))
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.12,
                        ),
                        // ***************************  PARTE DEL MEDIO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    CupertinoButton(
                                        padding: EdgeInsets.all(0),
                                        minSize: 0,
                                        child: Container(
                                          width: MediaQuery.of(context).size.width * 0.1,
                                          height: MediaQuery.of(context).size.width * 0.1,
                                          // padding: EdgeInsets.symmetric(
                                          //     vertical: height * 0.02),
                                          child: Image.asset(
                                            'assets/images/general/icon-add.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        onPressed: (_currentIndex == 0)
                                            ? (Platform.isIOS) ? _tomarFotoIOS : _tomarFotoAndroid
                                            : _seleccionarFoto),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * 0.015,
                            ),
                            Container(
                              child: CupertinoButton(
                                child: Text(
                                    adsText.upLoadPictureOfThePackage(),
                                    style: TextStyle(
                                        color: Color.fromRGBO(
                                            173, 181, 189, 1.0),
                                        fontSize: responsive.ip(3.5))),
                                color: Color.fromRGBO(251, 251, 251, 1.0),
                                padding: EdgeInsets.symmetric(
                                    horizontal: width * 0.005),
                                onPressed: (_currentIndex == 0)
                                    ? (Platform.isIOS) ? _tomarFotoIOS : _tomarFotoAndroid
                                    : _seleccionarFoto,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Container(
                              child: Text(adsText.yourCanUpload(),
                                  style: TextStyle(
                                      color:
                                          Color.fromRGBO(173, 181, 189, 1.0),
                                      fontWeight: FontWeight.normal,
                                      fontSize:responsive.ip(1.8))),
                            ),
                          ],
                        ),
                      ]),
                  // *************************************  NEXT, CANCEL
                  Container(
                    margin: EdgeInsets.only(
                        bottom: variableGlobal.margenBotonesAbajo(context)),
                    child: StreamBuilder(
                        stream: bloc.listImagesStream,
                        builder: (context, snapshot) {
                          return Container(
                            margin: EdgeInsets.only(
                                bottom: height * 0.02), //huaweio-p30
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                back(context, CreateAdDelivaryAddress()),
                                (snapshot.data == null)
                                    ? Container()
                                    : next(context, 'create_ad_images2'),
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  // *******************
  _seleccionarFoto() async {
    final bloc = ProviderApp.ofAdForm(context);
    final PermissionStatus status = await Permission.storage.request();
    switch(status){
          case PermissionStatus.granted:
            // ignore: todo
            // TODO: El usuario otorgó acceso a la función solicitada..
                if (bloc.listImagesStreamHasValue != false) {
                  if (bloc.listImages.length >= 5) {
                    toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
                    return;
                  }
                }

                final _picker = ImagePicker();
                final PickedFile pickedFile =
                    await _picker.getImage(source: ImageSource.gallery, imageQuality: 80, maxHeight: 400, maxWidth: 400);

                if (pickedFile != null) {
                  if (bloc.listImagesStreamHasValue == false || bloc.listImages.length == 0) {
                    
                    // Http().subirImagen(img: File(pickedFile.path)).then((value){
                    //   print('LA IMAGEN  ==========================>>>>>   ${value}');
                    // });
                    bloc.changeListImages([File(pickedFile.path)]);
                  } else {
                    List<File> imagesFiles = bloc.listImages;
                    imagesFiles.add(File(pickedFile.path));
                    bloc.changeListImages(imagesFiles);
                  }
                  Navigator.pushNamed(context, 'create_ad_images2');
                } else {
                  return;
                }
            break;
          case PermissionStatus.denied:
            // ignore: todo
            // TODO: El usuario denegó el acceso a la función solicitada..
            print('El usuario denegó el acceso a la función solicitada');
            dialogPermissions.showPermissionGalleryDialog(context, 'El usuario denegó el acceso a la función solicitada.');
            break;
          case PermissionStatus.restricted:
            // ignore: todo
            // TODO: El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...
            print('El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...');
            dialogPermissions.showPermissionGalleryDialog(context, "El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS. ");
            break;
          case PermissionStatus.limited:
            // ignore: todo
            // TODO: El usuario ha autorizado esta aplicación para acceso limitado. Solo compatible con iOS (iOS14 +).
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
                  if (bloc.listImagesStreamHasValue == false || bloc.listImages.length == 0) {
                    bloc.changeListImages([File(pickedFile.path)]);
                  } else {
                    List<File> imagesFiles = bloc.listImages;
                    imagesFiles.add(File(pickedFile.path));
                    bloc.changeListImages(imagesFiles);
                  }
                  Navigator.pushNamed(context, 'create_ad_images2');
                } else {
                  return;
                }
            break;
          case PermissionStatus.permanentlyDenied:
            // ignore: todo
            // TODO: El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android..
            // dialogPermissions.showPermissionLocationDialog(context, 'El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android.');
            dialogPermissions.showPermissionOpenAppSetting(context, generalText.grantPermissionsFromTheAppSettings());
            break;
        }
  }


  _tomarFotoIOS() async {
    final bloc = ProviderApp.ofAdForm(context);
    if (bloc.listImages != null) {
          if (bloc.listImages.length >= 5) {
            toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
            return;
          }
        }

        final _picker = ImagePicker();
        final PickedFile pickedFile =
            await _picker.getImage(source: ImageSource.camera);

        if (pickedFile != null) {
          if (bloc.listImagesStreamHasValue == false || bloc.listImages.length == 0) {
            bloc.changeListImages([File(pickedFile.path)]);
          } else {
            List<File> imagesFiles = bloc.listImages;
            imagesFiles.add(File(pickedFile.path));
            bloc.changeListImages(imagesFiles);
          }
          Navigator.pushNamed(context, 'create_ad_images2');
        } else {
          return;
        }
  }

  _tomarFotoAndroid() async {

   final bloc = ProviderApp.ofAdForm(context);
    final PermissionStatus status = await Permission.camera.request();
    switch(status){
          case PermissionStatus.granted:
            // ignore: todo
            // TODO: El usuario otorgó acceso a la función solicitada..
                    if (bloc.listImages != null) {
                      if (bloc.listImages.length >= 5) {
                        toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
                        return;
                      }
                    }

                    final _picker = ImagePicker();
                    final PickedFile pickedFile =
                        await _picker.getImage(source: ImageSource.camera);

                    if (pickedFile != null) {
                      if (bloc.listImagesStreamHasValue == false || bloc.listImages.length == 0) {
                        bloc.changeListImages([File(pickedFile.path)]);
                      } else {
                        List<File> imagesFiles = bloc.listImages;
                        imagesFiles.add(File(pickedFile.path));
                        bloc.changeListImages(imagesFiles);
                      }
                      Navigator.pushNamed(context, 'create_ad_images2');
                    } else {
                      return;
                    }
            break;
          case PermissionStatus.denied:
            // ignore: todo
            // TODO: El usuario denegó el acceso a la función solicitada..
            print('El usuario denegó el acceso a la función solicitada');
            dialogPermissions.showPermissionGalleryDialog(context, 'El usuario denegó el acceso a la función solicitada.');
            break;
          case PermissionStatus.restricted:
            // ignore: todo
            // TODO: El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...
            print('El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS...');
            dialogPermissions.showPermissionGalleryDialog(context, "El sistema operativo denegó el acceso a la función solicitada. El usuario no puede cambiar el estado de esta aplicación, posiblemente debido a restricciones activas, como controles parentales. Solo compatible con iOS. ");
            break;
          case PermissionStatus.limited:
            // ignore: todo
            // TODO: El usuario ha autorizado esta aplicación para acceso limitado. Solo compatible con iOS (iOS14 +).
                 if (bloc.listImages != null) {
                    if (bloc.listImages.length >= 5) {
                      toastService.showToastCenter(context: context, text: adsText.youCannotSelectMoreThan5Images(), durationSeconds: 4);
                      return;
                    }
                  }

                  final _picker = ImagePicker();
                  final PickedFile pickedFile =
                      await _picker.getImage(source: ImageSource.camera);

                  if (pickedFile != null) {
                    if (bloc.listImagesStreamHasValue == false || bloc.listImages.length == 0) {
                      bloc.changeListImages([File(pickedFile.path)]);
                    } else {
                      List<File> imagesFiles = bloc.listImages;
                      imagesFiles.add(File(pickedFile.path));
                      bloc.changeListImages(imagesFiles);
                    }
                    Navigator.pushNamed(context, 'create_ad_images2');
                  } else {
                    return;
                  }
            break;
          case PermissionStatus.permanentlyDenied:
            // ignore: todo
            // TODO: El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android..
            // dialogPermissions.showPermissionLocationDialog(context, 'El usuario denegó el acceso a la función solicitada y seleccionó no volver a mostrar una solicitud de este permiso. El usuario aún puede cambiar el estado del permiso en la configuración. Solo compatible con Android.');
            dialogPermissions.showPermissionOpenAppSetting(context, generalText.grantPermissionsFromTheAppSettings());
            break;
        }
      
  }
}
