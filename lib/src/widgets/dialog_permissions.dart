import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:permission_handler/permission_handler.dart';
  
  
  class DialogPermission {

    showPermissionLocationDialog(BuildContext context, String text) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                child: Column(
                  children: [
                    iconFace1(context),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Text(generalText.modaLocationInTheBackground(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: responsive.ip(2.2),
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                  ],
                ),
              ),
              // content: Container(
              //   height:  MediaQuery.of(context).size.height * 0.22,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Text(text)
              //     ],
              //   ),
              // ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                   openAppSettings();
                      
                  },
                ),
              ],
            ));
    }



    showPermissionGalleryDialog(BuildContext context, String text) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                child: Column(
                  children: [
                    iconFace1(context),
                    Text(generalText.maandoRequiresThaYouGrantGallery(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.ip(2.2),
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                  ],
                ),
              ),
              // content: Container(
              //   height:  MediaQuery.of(context).size.height * 0.22,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Text(text)
              //     ],
              //   ),
              // ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Shut down'),
                  onPressed: () {
                    Navigator.pop((context));
                  }
                 ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                   openAppSettings();
                      
                  },
                ),
              ],
            ));
    }


    showPermissionCameraDialog(BuildContext context, String text) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                child: Column(
                  children: [
                    iconFace1(context),
                    Text(generalText.maandoRequiresThaYouGrantCamera(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.ip(2.2),
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                  ],
                ),
              ),
              // content: Container(
              //   height:  MediaQuery.of(context).size.height * 0.22,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Text(text)
              //     ],
              //   ),
              // ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Shut down'),
                  onPressed: () {
                    Navigator.pop((context));
                  }
                 ),
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                   openAppSettings();
                      
                  },
                ),
              ],
            ));
    }


    showPermissionOpenAppSetting(BuildContext context, String text) {
      final Responsive  responsive = Responsive.of(context);
      showDialog(
        context: context,
        
        barrierDismissible: false,
        builder: (_) => new AlertDialog(
          scrollable: true,

              title: Container(
                child: Column(
                  children: [
                    iconFace1(context),
                    Text(text,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: responsive.ip(2.2),
                        fontWeight: FontWeight.w400,
                        color: Colors.black)),
                  ],
                ),
              ),

              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () {
                     Navigator.pop((context));
                      openAppSettings();
                  },
                ),
              ],
            ));
    }

  }

  DialogPermission dialogPermissions = DialogPermission();