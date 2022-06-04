import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

// https://pub.dev/packages/firebase_storage/versions/3.1.5
// https://firebase.flutter.dev/docs/storage/usage

class SubirImagen {
  Future subirImagen(File data, String email, BuildContext context) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('$email');

      final UploadTask uploadTask = storageReference.putFile(data);
      // print('ESTA ES LA DATA => $data');

      // final StreamSubscription<StorageEvent> streamSubscription =
      //     uploadTask.events.listen((event) {
      //   // You can use this to notify yourself or your user in any kind of way.
      //   // For example: you could use the uploadTask.events stream in a StreamBuilder instead
      //   // to show your user what the current status is. In that case, you would not need to cancel any
      //   // subscription as StreamBuilder handles this automatically.

      //   // Here, every StorageTaskEvent concerning the upload is printed to the logs.

      //   //  loadingGeneral(context, pr,'Cargando imagen...');
      //   print('EVENT ${event.type}');
      //   // print('EVENT ${event.type.runtimeType}');
      // });

      // Cancel your subscription when done.

      //  await uploadTask.onComplete.then((value) => pr.hide());
      //  streamSubscription.cancel();

      return true;
    } catch (e) {
      return e;
    }
  }




  // *******************

 
  Future subirAvatar(File data, String email, BuildContext context) async {
    // print('LA DATA $data');
    // print('LA EMAIL $email');
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('$email/avatars/avatar');

      final UploadTask uploadTask = storageReference.putFile(data);
      // print('ESTA ES LA DATA => $data');

      // ignore: cancel_subscriptions
      // final StreamSubscription<StorageEvent> streamSubscription =
      //   uploadTask.snapshot.listen((event) {
      //   print('EVENT ${event.type}');
      // });

      return true;
    } catch (e) {
      return e;
    }
  }

  Future obtenerImagen(String email, String id, int index) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('$email/$id/${index.toString()}');
    if (ref != null) {

      try {
        return await ref.getDownloadURL();
      } catch (e) {
        return await FirebaseStorage.instance.ref().child('general/logo2@3x.png').getDownloadURL();
      }
    } else {
      return await FirebaseStorage.instance.ref().child('general/logo2@3x.png').getDownloadURL();
    }
  }


  // ******************
    Future obtenerAvatar(String email) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('$email/avatars/avatar');
    if (ref != null) {

      try {
        return await ref.getDownloadURL();
      } catch (e) {
        return await FirebaseStorage.instance.ref().child('general/icon - userx.png').getDownloadURL();
      }
    } else {
      return await FirebaseStorage.instance .ref() .child('general/icon - userx.png').getDownloadURL();
    }
  }


    // ******************
    Future deleteAd(String email, String id) async {
      print('LA RUTA $email/$id/');
      final Reference ref = FirebaseStorage.instance.ref().child('$email/$id');
      return await ref.delete();
        // return FirebaseStorage.instance.ref().child('$email/$id').delete();
    }


    // ***********  CHAT
  Future subirImageChat(File data, String email, String id, BuildContext context) async {
    try {
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('$email/chats/$id');

      final UploadTask uploadTask = storageReference.putFile(data);
      // print('ESTA ES LA DATA => $data');

      // ignore: cancel_subscriptions
      // final StreamSubscription<StorageEvent> streamSubscription =
      //   uploadTask.snapshot.listen((event) {
      //   print('EVENT ${event.type}');
      // });

      return true;
    } catch (e) {
      return e;
    }
  }

   // ******************
    Future obtenerImageChat(String email, String id) async {
    final Reference ref =
        FirebaseStorage.instance.ref().child('$email/chats/$id');
    if (ref != null) {

      try {
        return await ref.getDownloadURL();
      } catch (e) {
        return await FirebaseStorage.instance.ref().child('general/logo2@3x.png').getDownloadURL();
      }
    } else {
      return await FirebaseStorage.instance .ref() .child('general/logo2@3x.png').getDownloadURL();
    }
  }

    // ******************
    Future deleteChat(String email, String id) async {
      print('LA RUTA $email/$id/');
      final Reference ref = FirebaseStorage.instance.ref().child('$email/chats/$id');
      return await ref.delete();
        // return FirebaseStorage.instance.ref().child('$email/$id').delete();
    }
}





SubirImagen firebaseStorage = new SubirImagen();
