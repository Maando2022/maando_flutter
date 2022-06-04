// @dart=2.9
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User get user {
    return _auth.currentUser;
  }


Future<dynamic> registerWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn());
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final OAuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User user = userCredential.user;
      if (user.uid == _auth.currentUser.uid) return user;
    } catch (e) {
      print('Error in signInGoogle Method: ${e.toString()}');
    }
    return null;
  }


// **********************+
Future<dynamic> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = (await _googleSignIn.signIn());

      final GoogleSignInAuthentication googleSignInAuthentication =
        await googleUser.authentication;
      
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

      final authResult = await FirebaseAuth.instance.signInWithCredential(credential);
        return {
          'user': authResult.user, 
          'email': googleUser.email, 'idToken': googleSignInAuthentication.idToken, 'urlAvatar': googleUser.photoUrl};
    } catch (e) {
      print('Error in signInGoogle Method: ${e.toString()}');
      return null as GoogleSignInAccount;
    }
    
  }

Future<Null> handleSignOutGoogle() async {
 try {
      await _googleSignIn.signOut().then((value) => print('Usuario deslogeado ${value?.email}'));
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
}
