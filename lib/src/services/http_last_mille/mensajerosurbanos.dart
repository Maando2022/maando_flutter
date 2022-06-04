
import 'package:maando/src/enviromets/url_server.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpMensajerosurbanos {

  final String _url = urlserver.url;


  Future<dynamic> generateTokenMensajerosUrbanos() async {
    final url = Uri.parse('$_url/generateTokenMesajerosUrbanos');

    final resp =
        await http.get(url);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

    Future<dynamic> createServiceMesajerosUrbanos(String token, String ad) async {
    final url = Uri.parse('$_url/createServiceMesajerosUrbanos');


    final Map<String, dynamic> data = {'ad': ad}; 

    final resp = await http.post(url, body: data, headers: {
        // 'content-type': 'application/json',
        'token': token
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

 
}