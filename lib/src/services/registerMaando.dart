// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/success.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<dynamic> loginMaando(String email, String password) async {
  // final AuthResult authResult = await _auth.createUserWithEmailAndPassword(

  try {
    final UserCredential authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final User user = authResult.user;

    return {
      'user': user
      // , 'idToken': googleSignInAuthentication.idToken
    };
  } catch (e) {
    return e;
  }
}

Future<dynamic> registerMaando(String email, String password) async {
  try {
    final UserCredential authResult = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = authResult.user; 
    return {
      'user': user
    };
  } catch (e) {
    return e;
  }
}

Future<dynamic> resetpassword(String email, BuildContext context) async {
  try {
    _auth.sendPasswordResetEmail(email: email).then((value) {
      print('RESET PASSWORD');
      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingSuccess(context, generalText.resetPassword());})
          .then((value) {
        Navigator.pushReplacementNamed(context, 'login');
      });
    }).catchError((onError) => {
          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, generalText.errorEmail());})
        });

    // _auth.confirmPasswordReset('oobCode', '123456').then((value) {
    //   print('RESET PASSWORD');
    // });

    // _auth.sendPasswordResetEmail(email: null).then((value) {
    //   print('RESET PASSWORD');
    // });

    //   final AuthResult authResult = await _auth.(
    //       email: email, password: password);
    //   final FirebaseUser user = authResult.user;
    //   prefsInternal.guardarUIDFB(user.uid);

    //   return {
    //     'user': user
    //     // , 'idToken': googleSignInAuthentication.idToken
    //   };
  } catch (e) {
    return e;
  }
}
