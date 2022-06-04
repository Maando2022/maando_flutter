import 'package:firebase_auth/firebase_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';



Future<dynamic> handleAppleSignIn() async{

  final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]);

   final oAuthProvider = OAuthProvider('apple.com');
 
   final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    return {
          'user': authResult.user,
          'idToken': appleIdCredential.identityToken
        };
  }






  Future<dynamic>registerWithApple() async{
      final appleIdCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]);

   final oAuthProvider = OAuthProvider('apple.com');
 
   final credential = oAuthProvider.credential(
      idToken: appleIdCredential.identityToken,
      accessToken: appleIdCredential.authorizationCode,
    );

    final authResult = await FirebaseAuth.instance.signInWithCredential(credential);

    return {
          'user': authResult.user,
          'idToken': appleIdCredential.identityToken
        };
  }



