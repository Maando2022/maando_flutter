// @dart=2.9
import 'dart:convert';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:maando/src/services/loginGoogle.dart';


// https://tomeko.net/online_tools/hex_to_base64.php

FirebaseAuth _auth = FirebaseAuth.instance;

registerFacebook() async {
    try{
      final LoginResult result = await FacebookAuth.instance.login();
      if(result.status == 200){
        // correcto
        final userData = await FacebookAuth.instance.getUserData();
        print('DATOS DEO USUARIO  >>>>>>>>>>>>>>>>>>>   $userData');
      }else if(result.status == 400){
        //cancelado por el usuario
      }else{
        print('Fallo el procrso de login');
      }
    }catch(e){
      print('ERO FACEBOOCK $e');
    }
  }



// **********************+
Future<dynamic> signInWithFacebook() async {
     try{
      final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile

      if (result.status == LoginStatus.success) {

           AuthCredential credential =  FacebookAuthProvider.credential(result.accessToken.token);
           final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

          //  final graphResponse = await http.get(Uri.parse('https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email,picture&access_token=${credential.token}'));
          //  final profile = json.decode(graphResponse.body);


           return {
             'email': authResult.user.email,
             'urlAvatar': authResult.user.photoURL, 
             'token': result.accessToken.token, 
             'user': authResult.user, 
             'tokenFacebook': result.accessToken.token
             };
      } else {
          print(result.status);
          print(result.message);
          return null;
      }
    }catch(e){
      print('ERO FACEBOOCK $e');
      return null;
    }
  }


Future<Null> logOutFacebook() async {
   try {
      await FacebookAuth.instance.logOut().then((value) => null);
    } catch (e) {
      print(e.toString());
    }
}
