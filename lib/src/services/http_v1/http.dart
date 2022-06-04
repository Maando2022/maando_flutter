// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:maando/src/blocs/notifications_bloc.dart';
import 'package:maando/src/enviromets/url_server.dart';
import 'package:maando/src/services/shared_pref.dart';

class Http extends ChangeNotifier {
  final String _url = urlserver.url;

  final String _url1 =
      'https://gtjrbm1idd.execute-api.us-east-1.amazonaws.com/maando/v1';

  final preference = new Preferencias();

  Future<dynamic> senderEmailRegister({String email, String first_name, String last_name}) async {
    final url = Uri.parse('$_url/subscribeKlaviyo');

    final Map<String, dynamic> data = {
      'email': email,
      'first_name': first_name,
      'last_name': last_name
    };

    try {
      final resp = await http.post(url,
          body: json.encode(data),
          headers: {'content-type': 'application/json', 'langcode': Platform.localeName.substring(0, 2)});

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      // print('ENVI DE EMAILLLLL   $decodedData');
      return decodedData;
    } catch (e) {
      return null;
    }
  }


  Future<dynamic> updatePosition(
      {String email, double latitude, double longitude}) async {
    final url = Uri.parse('$_url/updatePosition');

    final Map<String, dynamic> data = {
      'email': email,
      'latitude': latitude,
      'longitude': longitude
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> updateAvatarSocialMedia(
      {BuildContext context, String email, String urlAvatar}) async {
    final url = Uri.parse('$_url/updateAvatarSocialMedia');

    final Map<String, dynamic> data = {'email': email, 'urlAvatar': urlAvatar};

    try {
      final resp = await http.post(url, body: data);

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> updateProfile({
    BuildContext context,
    String email,
    String fullName,
    String phone,
    String country,
    String city,
  }) async {
    final url = Uri.parse('$_url/updateProfile');

    final Map<String, dynamic> data = {
      'email': email,
      'fullName': fullName,
      'phone': phone,
      'country': country,
      'city': city,
    };

    try {
      final resp = await http.post(url, body: data);

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> updatePayMethod({
    BuildContext context,
    String email,
    String pay,
  }) async {
    final url = Uri.parse('$_url/updatePayMethod');

    final Map<String, dynamic> data = {'email': email, 'pay': pay};

    try {
      final resp = await http.post(url, body: data);

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> findUsersFormBiometric({
    BuildContext context,
  }) async {
    final url = Uri.parse('$_url/findUsersFormBiometric');

    final Map<String, dynamic> data = {
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> loginBiometrics({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/loginBiometrics');

    final Map<String, dynamic> data = {
      'email': email,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> registerGoogle(
      {BuildContext context, String token, String uid, String name, String email}) async {
    final url = Uri.parse('$_url/registroUsuarioGoogle');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'token': token,
      'uid': uid,
      'name': name,
      'email': email,
      'uid_device': blocNotifications.tokenNotification
    };
    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      ;
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> registerFacebook(
      {BuildContext context,
      String tokenFacebook,
      String tokenFirebase,
      String uid}) async {
    final url = Uri.parse('$_url/registroUsuarioFacebook');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'tokenFacebook': tokenFacebook,
      'tokenFirebase': tokenFirebase,
      'uid': uid,
      'uid_device': blocNotifications.tokenNotification
    };
    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> registerApple(
      {BuildContext context, String token, String uid}) async {
    final url = Uri.parse('$_url/registroUsuarioApple');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'token': token,
      'uid': uid,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> createAccountForm(
      {BuildContext context,
      String email,
      String name,
      String phone,
      String country,
      String city,
      String password,
      String token,
      String fbToken,
      String uid}) async {
    final url = Uri.parse('$_url/registroUsuarioForm');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'phone': phone,
      'country': country,
      'city': city,
      'password': password,
      'token': token,
      'uid_device': blocNotifications.tokenNotification,
      'uid': uid
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> completarRegistro({
    BuildContext context,
    String email,
    String name,
    String phone,
    String country,
    String city,
  }) async {
    final url = Uri.parse('$_url/completarRegistro');

    final Map<String, dynamic> data = {
      'email': email,
      'name': name,
      'phone': phone,
      'country': country,
      'city': city,
      'uid_device': blocNotifications.tokenNotification,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> updateIdSocketUser({String email, String idToken}) async {
    final url = Uri.parse('$_url/updateIdSocketUser');

    final Map<String, dynamic> data = {'email': email, 'idToken': idToken};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> findUserForEmail({String email}) async {
    final url = Uri.parse('$_url/findUserForEmail');

    final Map<String, dynamic> data = {'email': email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<String> findAvatarUserGoogleFacebook(
      {BuildContext context, String email}) async {
    final url = Uri.parse('$_url/findUserForEmail');

    final Map<String, dynamic> data = {'email': email};
    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return json.decode(decodedData)["user"]["avatar"];
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> signOut({String email}) async {
    final url = Uri.parse('$_url/signOut');

    final Map<String, dynamic> data = {'email': email};

    try {
      final resp = await http.post(url, body: data, headers: {
        // 'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      print(decodedData);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> loginGoogle(
      {BuildContext context, String emailGoogle}) async {
    final url = Uri.parse('$_url/loginGoogle');

    final Map<String, dynamic> data = {
      'email': emailGoogle,
      'uid_device': blocNotifications.tokenNotification,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> loginFacebook(
      {BuildContext context, String tokenFacebook}) async {
    final url = Uri.parse('$_url/loginFacebook');

    final Map<String, dynamic> data = {
      'token': tokenFacebook,
      'uid_device': blocNotifications.tokenNotification,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> loginApple({BuildContext context, String idToken}) async {
    final url = Uri.parse('$_url/loginApple');

    final Map<String, dynamic> data = {
      'token': idToken,
      'uid_device': blocNotifications.tokenNotification,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> loginForm(
      {BuildContext context, String email, String password}) async {
    final url = Uri.parse('$_url/loginForm');

    final Map<String, dynamic> data = {
      'email': email,
      'password': password,
      'uid_device': blocNotifications.tokenNotification,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> eliminarUidFirebase({String uid}) async {
    final url = Uri.parse('$_url/eliminarUidFirebase');

    final Map<String, dynamic> data = {'uid': uid};
    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> history(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/history');

    final Map<String, dynamic> data = {'cont': cont};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
        'email': email
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> home({BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/home');

    final Map<String, dynamic> data = {
      'cont': cont,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
        'email': email
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> ads({BuildContext context, int cont}) async {
    final url = Uri.parse('$_url/ads');

    final Map<String, dynamic> data = {
      'cont': cont,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }
  // *************************************************************************
  Future<dynamic> adsSinContext({int cont}) async {
    final url = Uri.parse('$_url/ads');

    final Map<String, dynamic> data = {
      'cont': cont,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> adsNotApproved({BuildContext context, int cont}) async {
    final url = Uri.parse('$_url/adsNotApproved');

    final Map<String, dynamic> data = {
      'cont': cont,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> approveAd({BuildContext context, String id}) async {
    final url = Uri.parse('$_url/approveAd');

    final Map<String, dynamic> data = {
      '_id': id
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }
  
  // *************************************************************************
  Future<dynamic> flights({BuildContext context, int cont}) async {
    final url = Uri.parse('$_url/flights');

    final Map<String, dynamic> data = {
      'cont': cont,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ******************************************
  Future<dynamic> searchMatchesToAd(
      {BuildContext context,
      String email,
      String arrivalDate,
      String departureDate,
      String city,
      String cityDeparture}) async {
    final url = Uri.parse('$_url/searchMatchesToAd');

    final Map<String, dynamic> data = {
      'departureDate': departureDate,
      'arrivalDate': arrivalDate,
      'email': email,
      'cityDeparture': cityDeparture,
      'city': city
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ******************************************
  Future<dynamic> searchMatchesToFlight(
      {BuildContext context,
      String email,
      String departureDate,
      String destinationDate,
      String cityDepartureAirport,
      String cityDestinationAirport}) async {
    final url = Uri.parse('$_url/searchMatchesToFlight');

    final Map<String, dynamic> data = {
      'departureDate': departureDate,
      'destinationDate': destinationDate,
      'cityDepartureAirport': cityDepartureAirport,
      'cityDestinationAirport': cityDestinationAirport
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
        'email': email
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> itemsToBring(int since, String search) async {
    final url =
        Uri.parse('$_url/itemsToBring?since=${since.toString()}&search=$search&email=${preference.prefsInternal.getString("email")}');

    try {
      final resp = await http.get(url, headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }


  Future<dynamic> searchUser(String search) async {
    final url = Uri.parse('$_url/searchUser');
      final Map<String, dynamic> data = {'search': search};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> searchAds(String search) async {
    final url = Uri.parse('$_url/searchAds');
      final Map<String, dynamic> data = {'search': search};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> searchFlight(String search) async {
    final url = Uri.parse('$_url/searchFlight');
      final Map<String, dynamic> data = {'search': search};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> searchStore(String search) async {
    final url = Uri.parse('$_url/searchStore');
      final Map<String, dynamic> data = {'search': search};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************  PRODUCTOS DE ENVIO  *************************
  Future<dynamic> getAsinProducts({String keyword}) async {
    final url = Uri.parse('$_url/getAsinProducts');

    final Map<String, dynamic> data = {
      'keyword': keyword,
      'email': preference.prefsInternal.getString("email")
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> getShippingProducts(
      {BuildContext context, String asin}) async {
    final url = Uri.parse('$_url/getShippingProducts');

    final Map<String, dynamic> data = {
      'asin': asin,
      'email': preference.prefsInternal.getString("email"),
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  // *************************************************************************
  Future<dynamic> createAd(
      {BuildContext context,
      String id,
      String emailOwner,
      String title,
      List<String> images,
      int numImages,
      String insurance,
      String countryDeparture,
      String country,
      String cityDeparture,
      String city,
      int price,
      String arrivalDate,
      String departureDate,
      dynamic delivery,
      }) async {
    final url = Uri.parse('$_url/createAd');

    final Map<dynamic, dynamic> data = {
      "_id": id,
      "emailOwner": emailOwner,
      "title": title,
      "images": images,
      "numImages": numImages,
      "insurance": insurance,
      "cityDeparture": cityDeparture,
      "city": city,
      "countryDeparture": countryDeparture,
      "country": country,
      "price": price,
      "arrivalDate": arrivalDate,
      "departureDate": departureDate,
      "delivery": delivery,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      // if(json.decode(decodedData)["authorized"] == false) return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> deleteAd(
      {BuildContext context, String id, String email}) async {
    final url = Uri.parse('$_url/deleteAd');

    final Map<dynamic, dynamic> data = {"_idAd": id, "email": email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false) return Navigator.pushReplacementNamed(context, 'login');
        return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> deleteFlight(
      {BuildContext context, String id, String email}) async {
    final url = Uri.parse('$_url/deleteFlight');

    final Map<dynamic, dynamic> data = {"_idFlight": id, "email": email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> createFlight(
      {BuildContext context,
      String id,
      String email,
      String cityDepartureAirport,
      String cityDestinationAirport,
      String departureDate,
      String destinationDate,
      String flightNumber,
      String reservationCode,
      bool typePackageCompact,
      bool typePackageHandybag,
      List<dynamic> elementsCompact,
      List<dynamic> elementsHandybag,
      String insurance}) async {

        final url = Uri.parse('$_url/createFlight');

        final Map<dynamic, dynamic> data = {
          "_id": id,
          "emailOwner": email,
          "cityDepartureAirport": cityDepartureAirport,
          "cityDestinationAirport": cityDestinationAirport,
          "departureDate": departureDate,
          "destinationDate": destinationDate,
          "flightNumber": flightNumber,
          "reservationCode": reservationCode,
          "typePackageCompact": typePackageCompact,
          "typePackageHandybag": typePackageHandybag,
          "elementsCompact": elementsCompact,
          "elementsHandybag": elementsHandybag,
          "insurance": insurance
        };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
        'email': email
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> verMisAnuncios({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/misAd');
    try {
      final Map<dynamic, dynamic> data = {
        'email': email,
        'currentDate': DateTime.now().toString()
      };

      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return jsonDecode(decodedData);
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> verMisVuelos({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/misFlight');

    try {
      final Map<dynamic, dynamic> data = {
        'email': email,
        'currentDate': DateTime.now().toString()
      };

      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return jsonDecode(decodedData);
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************

  Future<dynamic> createMatchSendFromAd({
    BuildContext context,
    String email,
    String emailAd,
    String emailFlight,
    String idFlight,
    String idAd,
  }) async {
    final url = Uri.parse('$_url/createMatchSendFromAd');
    final Map<dynamic, dynamic> data = {
      "email": email,
      "emailAd": emailAd,
      "emailFlight": emailFlight,
      "idFlight": idFlight,
      "idAd": idAd
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> createMatchSendFromFlight({
    BuildContext context,
    String email,
    String emailAd,
    String emailFlight,
    String idFlight,
    String idAd,
  }) async {
    final url = Uri.parse('$_url/createMatchSendFromFlight');
    final Map<dynamic, dynamic> data = {
      "email": email,
      "emailAd": emailAd,
      "emailFlight": emailFlight,
      "idFlight": idFlight,
      "idAd": idAd,
      "stateFlight": 'request_sendFlight'
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      print(decodedData);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************

  Future<dynamic> findMatchSendAd(
      {BuildContext context, String email, String id}) async {
    final url = Uri.parse('$_url/findMatchSendAd');
    final Map<dynamic, dynamic> data = {"email": email, "_id": id};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************

  Future<dynamic> findMatchSendFlight(
      {BuildContext context, String email, String id}) async {
    final url = Uri.parse('$_url/findMatchSendFlight');
    final Map<dynamic, dynamic> data = {"email": email, "_id": id};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************
  Future<dynamic> findMatchForEmailOfAd(
      {BuildContext context, String email}) async {
    final url = Uri.parse('$_url/findMatchForEmailOfAd');
    final Map<dynamic, dynamic> data = {"email": email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
      return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************
  Future<dynamic> findMatchForEmailOfFlight(
      {BuildContext context, String email}) async {
    final url = Uri.parse('$_url/findMatchForEmailOfFlight');
    final Map<dynamic, dynamic> data = {"email": email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************
  Future<dynamic> findMatchForEmailOfAdOrFlight(
      {BuildContext context, String email}) async {
    final url = Uri.parse('$_url/findMatchForEmailOfAdOrFlight');
    final Map<dynamic, dynamic> data = {"email": email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************
  Future<dynamic> findMatch({BuildContext context, String id}) async {
    final url = Uri.parse('$_url/findMatch');
    final Map<dynamic, dynamic> data = {"id": id};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **********************************************************
  Future<dynamic> updateCreateOrReview(
      {BuildContext context,
      String email,
      String id,
      String review,
      int rating}) async {
    final url = Uri.parse('$_url/updateCreateOrReview');
    final Map<dynamic, dynamic> data = {
      "email": email,
      "id": id,
      "review": review,
      "rating": rating,
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> pushNotificationsOneUser(
      {String email,
      String title,
      String body,
      Map<String, dynamic> data,
      String uiddevice}) async {
    final url = Uri.parse('$_url/pushNotificationsOneUser');
    final Map<dynamic, dynamic> dataReq = {
      "email": email,
      "title": title,
      "body": body,
      "data": data,
      "uid_device": uiddevice,
    };

    try {
      final resp = await http.post(url, body: json.encode(dataReq), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // *************************************************************************
  Future<dynamic> pushNotificationsMultipleUsers(
      {String email,
      String title,
      String body,
      Map<String, dynamic> data,
      List<String> uiddevices}) async {
    final url = Uri.parse('$_url/pushNotificationsMultipleUsers');
    final Map<dynamic, dynamic> dataReq = {
      "email": email,
      "title": title,
      "body": body,
      "data": data,
      "uid_devices": uiddevices,
    };

    try {
      final resp = await http.post(url, body: json.encode(dataReq), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2)
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> getMessagesUser({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/getMessagesUser');

    final Map<String, dynamic> data = {'email': email};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> deleteMessageUser(
      {BuildContext context, String email, String idMessage}) async {
    final url = Uri.parse('$_url/deleteMessageUser');

    final Map<String, dynamic> data = {'email': email, 'idMessage': idMessage};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ********************************
  Future<dynamic> viewMessageUser(
      {BuildContext context, String email, String idMessage}) async {
    final url = Uri.parse('$_url/viewMessageUser');

    final Map<String, dynamic> data = {'email': email, 'idMessage': idMessage};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

// ****************************************************************************************
  //   ************************************  CAMBIOS DE ESTADO DEL MATCH DESDE EL AD
  // **************************************************************************************
  Future<dynamic> requestAcceptedAd(
      {BuildContext context, String email, String idMatch}) async {
    final url = Uri.parse('$_url/requestAcceptedAd');

    final Map<String, dynamic> data = {'email': email, '_idMatch': idMatch};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **************************************************************************************
  Future<dynamic> requestRejectedAd(
      {BuildContext context,
      String email,
      String idMatch,
      String idAd,
      String idFlight}) async {
    final url = Uri.parse('$_url/requestRejectedAd');

    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      '_idAd': idAd,
      '_idFlight': idFlight
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **************************************************************************************
  Future<dynamic> requestRetractedAd(
      {BuildContext context,
      String email,
      String idMatch,
      String idAd,
      String idFlight}) async {
    final url = Uri.parse('$_url/requestRetractedAd');

    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      '_idAd': idAd,
      '_idFlight': idFlight
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **************************************************************************************
  Future<dynamic> requestPaidAd(
      {BuildContext context,
      String email,
      String idMatch,
      String idAd,
      String dataPay}) async {
    final url = Uri.parse('$_url/requestPaidAd');

    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      '_idAd': idAd,
      'dataPay': dataPay
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ****************************************************************************************
  //   ************************************  CAMBIOS DE ESTADO DEL MATCH DESDE EL FLIGHT
  // **************************************************************************************
  Future<dynamic> requestAcceptedFlight(
      {BuildContext context, String email, String idMatch}) async {
    final url = Uri.parse('$_url/requestAcceptedFlight');

    final Map<String, dynamic> data = {'email': email, '_idMatch': idMatch};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **************************************************************************************
  Future<dynamic> requestRejectedFlight(
      {BuildContext context,
      String email,
      String idMatch,
      String idAd,
      String idFlight}) async {
    final url = Uri.parse('$_url/requestRejectedFlight');

    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      '_idAd': idAd,
      '_idFlight': idFlight
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // **************************************************************************************
  Future<dynamic> requestRetractedFlight(
      {BuildContext context,
      String email,
      String idMatch,
      String idAd,
      String idFlight}) async {
    final url = Uri.parse('$_url/requestRetractedFlight');

    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      '_idAd': idAd,
      '_idFlight': idFlight
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }
  // **************************************************************************************
  // ***************************************** POST **************************

  Future<dynamic> postCreate(
      {BuildContext context, String email, String title, String body}) async {
    final url = Uri.parse('$_url/postCreate');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'title': title,
      'body': body,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postGetAll(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/postGetAll');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'cont': cont,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postGetDateRange(
      {BuildContext context, String email, int from, int to}) async {
    final url = Uri.parse('$_url/postGetDateRange');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'from': from,
      'to': to,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postGetAllPostByUserEmail(
      {BuildContext context, String email, String useremail}) async {
    final url = Uri.parse('$_url/postGetAllPostByUserEmail');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'useremail': useremail,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postGetAllPostByKeyWord(
      {BuildContext context, String email, String keyword}) async {
    final url = Uri.parse('$_url/postGetAllPostByKeyWord');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'keyword': keyword,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postUpdate(
      {BuildContext context,
      String email,
      String postId,
      String content}) async {
    final url = Uri.parse('$_url/postUpdate');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'content': content,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postDelete(
      {BuildContext context, String email, String postId}) async {
    final url = Uri.parse('$_url/postDelete');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ***********************************************  COMMENT
  Future<dynamic> postCreateComment(
      {BuildContext context, String email, String postId, String body}) async {
    final url = Uri.parse('$_url/postCreateComment');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'body': body,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> getComments({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/getComments');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> editComment(
      {BuildContext context,
      String email,
      String commentId,
      String postId,
      String content}) async {
    final url = Uri.parse('$_url/editComment');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'commentId': commentId,
      'postId': postId,
      'content': content,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> deleteComment(
      {BuildContext context,
      String email,
      String postId,
      String commentId}) async {
    final url = Uri.parse('$_url/deleteComment');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'commentId': commentId,
      'postId': postId,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ************

  Future<dynamic> createReaccion({
    BuildContext context,
    String email,
    String postId,
    int reaccionType,
    bool reaccionActive,
    int reaccionA,
  }) async {
       
    final url = Uri.parse('$_url/createReaccion');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'reaccionType': reaccionType,
      'reaccionActive': reaccionActive,
      'reaccionA': reaccionA,
      'uid_device': blocNotifications.tokenNotification
    };



    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> getReactions({BuildContext context, String email}) async {
    final url = Uri.parse('$_url/getReactions');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> deleteReaction(
      {BuildContext context, String email, String reactionId}) async {
    final url = Uri.parse('$_url/deleteReaction');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'reactionId': reactionId,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

 
  // ****************************************************************************************
  // ***************************************** SUBCOMMETS ***********************************
  Future<dynamic> postCreateSubComment(
      {BuildContext context, String email, String postId, String commentId, String body}) async {
    final url = Uri.parse('$_url/postCreateSubComment');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'commentId': commentId,
      'body': body,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }


  Future<dynamic> getSubComments({BuildContext context, String postId, String email}) async {
      final url = Uri.parse('$_url/getSubComments');
      preference.guardarTokenNotification(blocNotifications.tokenNotification);
      final Map<String, dynamic> data = {
        'email': email,
        'postId': postId,
        'uid_device': blocNotifications.tokenNotification
      };

      try {
        final resp = await http.post(url, body: json.encode(data), headers: {
          'content-type': 'application/json',
          'langcode': Platform.localeName.substring(0, 2),
        });
        final decodedData = Utf8Codec().decode(resp.bodyBytes);
        if (json.decode(decodedData)["authorized"] == false)
          return Navigator.pushReplacementNamed(context, 'login');
        return decodedData;
      } catch (e) {
        print(e.toString());
        return json.encode({'ok': false, 'message': 'Error of internet!'});
      }
    }

  Future<dynamic> deleteSubComment(
      {BuildContext context,
      String email,
      String postId,
      String commentId,
      String subCommentId}) async {
    final url = Uri.parse('$_url/deleteSubComment');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'postId': postId,
      'commentId': commentId,
      'subCommentId': subCommentId,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

    // **************************************************************************************
  // ***************************************** POST TO ADMIN **************************

  Future<dynamic> postToAdminCreate(
      {BuildContext context, String email, String title, String body}) async {
    final url = Uri.parse('$_url/postCreateToAdmin');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'title': title,
      'body': body,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> postToAdminGetAll(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/postToAdminGetAll');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'cont': cont,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });

      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }


  // ****************************************************
  // ****************************************************  ADMIN
  Future<dynamic> getAdmins() async {
    final url = Uri.parse('$_url/getAdmins');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': preference.prefsInternal.getString('email')
    };

    try {
      final resp = await http.post(url, body: data);
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
    }
  }

  Future<dynamic> getUserAdmin(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/getUserAdmin');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'cont': cont,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> activeInactiveUser(
      {BuildContext context, String email, String emailUser}) async {
    final url = Uri.parse('$_url/activeInactiveUser');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'emailUser': emailUser,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> markMatchAsPaid(
      {BuildContext context, String email, String idMatch}) async {
    final url = Uri.parse('$_url/markMatchAsPaid');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      '_idMatch': idMatch,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> getMatchesAdmin(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/getMatchesAdmin');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'cont': cont,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> getMatchesPaymentsAdmin(
      {BuildContext context, String email, int cont}) async {
    final url = Uri.parse('$_url/getMatchesPaymentsAdmin');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'cont': cont,
      'uid_device': blocNotifications.tokenNotification,
      'currentDate': new DateTime.now().toString()
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> findAd({String idAd}) async {
    final url = Uri.parse('$_url/findAd');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {'_idAd': idAd};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> findFlight({String idFlight}) async {
    final url = Uri.parse('$_url/findFlight');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {'_idFlight': idFlight};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ****************************************************

  Future<dynamic> updateStatusFlight({String idFlight, String statusFlight, DateTime date}) async {
    final url = Uri.parse('$_url/updateStatusFlight');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {'_idFlight': idFlight, 'statusFlight': statusFlight, 'date': date.toString()};

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  // ****************************************************


  
  Future<dynamic> paymentPaypay(String adId, String value) async {
    final url = Uri.parse('$_url/generate-token-paypal-prueba');

    Map<String, String> headers = {
      'langcode': Platform.localeName.substring(0, 2)
    };

    final resp =
        await http.post(url, body: {'sender_batch_id': adId, 'value': value}, headers: headers);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }


  Future<dynamic> generateOrderPaypal(String value) async {
    final url = Uri.parse('$_url/generate-order-paypal');

    Map<String, String> headers = {
      'langcode': Platform.localeName.substring(0, 2)
    };

    final resp =
        await http.post(url, body: {'value': value}, headers: headers);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> updatePayToken(String email, String payToken, String idMatch, String idAd) async {
    final url = Uri.parse('$_url/updatePayToken');

    Map<String, String> headers = {
      'langcode': Platform.localeName.substring(0, 2)
    };

    final resp =
        await http.post(url, body: {'email': email,'payToken': payToken, 'idMatch': idMatch, 'idAd': idAd}, headers: headers);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> register({BuildContext context, String deviceId}) async {
    final url = Uri.parse('$_url1/register');

    Map<String, String> headers = {
      'authorization': preference.prefsInternal.getString('authorization'),
      'uidfb': preference.prefsInternal.getString('uidfb'),
      'langcode': Platform.localeName.substring(0, 2)
    };

    final resp =
        await http.post(url, body: {'deviceId': deviceId}, headers: headers);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  // *************************************************************************

  Future<dynamic> clientTokenBraintree() async {
    final url = Uri.parse('$_url/clientToken');

    final resp = await http.get(url);

    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    print('decodedData====================>> $decodedData');
    return jsonDecode(decodedData);
  }




   Future<dynamic> twMaandoPruebaImage({File img}) async {
    final url = Uri.parse('$_url/tw_maando_prueba_upload_image');
      
      final fileImage = await http.MultipartFile.fromPath('image', img.path);
      final data = http.MultipartRequest('POST', url);
    
      data.files.add(fileImage);
      try {
        final streamRresponse = await data.send();
        final resp = await http.Response.fromStream(streamRresponse);
        final decodedData = Utf8Codec().decode(resp.bodyBytes);
        return decodedData;
      } catch (e) {
        print(e.toString());
        return json.encode({'ok': false, 'message': 'Error of internet!'});
      }

  }



    // ***********************************************  NOTIFICATIONS PUSH
  Future<dynamic> notificationOneToken(
      {BuildContext context, String email, String title, String body, dynamic data}) async {
    final url = Uri.parse('$_url/notificationOneToken');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> dataPost = {
      'email': email,
      'title': title,
      'body': body,
      'data': data
    };

    try {
      final resp = await http.post(url, body: json.encode(dataPost), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }


  Future<dynamic> getProductsAmazonAssociates() async {
    final url = Uri.parse('$_url/getProductsAmazonAssociates');

    final resp = await http.get(url);

    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return jsonDecode(decodedData);
  }

 // LISTA DE PAISES DE ORIGEN Y DESTINO
  Future<dynamic> getAiports() async {
    final url = Uri.parse('$_url/getAiports');


    final resp = await http.get(url);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return jsonDecode(decodedData);
  }

 // LISTA DE TELEONOS DE CONTACTO
  Future<dynamic> getContactsPhone() async {
    final url = Uri.parse('$_url/getContactsPhone');

    final resp = await http.get(url);

    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return jsonDecode(decodedData);
  }

  
 // LISTAR LUGARES  https://developers.google.com/maps/documentation/places/web-service/autocomplete
  Future<dynamic> places(String search) async {
    final url = Uri.parse('https://maps.googleapis.com/maps/api/place/textsearch/json?query=$search&key=AIzaSyA5Mhsy6cvg-IzuUJvb8uo5dmZfD4YTvoQ');

    final resp = await http.get(url);

    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return jsonDecode(decodedData);
  }




  // *******************
  // ******  CHATS
  // *******************


   Future<dynamic> listMyChats(
      {BuildContext context, String emailEmiter, String emailDestiny}) async {
    final url = Uri.parse('$_url/listMyChats');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> dataPost = {
      'emailEmiter': emailEmiter,
      'emailDestiny': emailDestiny
    };

    try {
      final resp = await http.post(url, body: json.encode(dataPost), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

   Future<dynamic> listMyChatsSinContext(
      {String emailEmiter, String emailDestiny}) async {
    final url = Uri.parse('$_url/listMyChats');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> dataPost = {
      'emailEmiter': emailEmiter,
      'emailDestiny': emailDestiny
    };

    try {
      final resp = await http.post(url, body: json.encode(dataPost), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

   Future<dynamic> myConversations(
      {BuildContext context, String email, int count = 10}) async {
        final url = Uri.parse('$_url/myConversations');
        preference.guardarTokenNotification(blocNotifications.tokenNotification);
        final Map<String, dynamic> dataPost = {
          'email': email,
          'count': count,
        };

    try {
      final resp = await http.post(url, body: json.encode(dataPost), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

  Future<dynamic> chatCreate(
      {
        BuildContext context, 
        String id, 
        String title, 
        String emailEmiter, 
        String emailDestinity, 
        String image, 
        String body
        }) async {
    final url = Uri.parse('$_url/chatCreate');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'id': id,
      'title': title,
      'body': body,
      'emailEmiter': emailEmiter,
      'emailDestinity': emailDestinity,
      'image': image
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }


  Future<dynamic> chatDelete(
      {BuildContext context, String email, String id}) async {
    final url = Uri.parse('$_url/chatDelete');
    preference.guardarTokenNotification(blocNotifications.tokenNotification);
    final Map<String, dynamic> data = {
      'email': email,
      'id': id,
      'uid_device': blocNotifications.tokenNotification
    };

    try {
      final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json',
        'langcode': Platform.localeName.substring(0, 2),
      });
      final decodedData = Utf8Codec().decode(resp.bodyBytes);
      if (json.decode(decodedData)["authorized"] == false)
        return Navigator.pushReplacementNamed(context, 'login');
      return decodedData;
    } catch (e) {
      print(e.toString());
      return json.encode({'ok': false, 'message': 'Error of internet!'});
    }
  }

}

