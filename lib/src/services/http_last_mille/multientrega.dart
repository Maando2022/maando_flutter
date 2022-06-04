
import 'package:maando/src/enviromets/url_server.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpLastMultientrega {

  final String _url = urlserver.url;


  // MULTIENTREGA ************************
  Future<dynamic> generateTokenMultientrega() async {
    final url = Uri.parse('$_url/generateTokenMultientrega');

    final resp =
        await http.get(url);
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> getProvinciasMultientrega(String token) async {
    final url = Uri.parse('$_url/getProvinciasMultientrega');   

    final Map<String, dynamic> data = {'token': token}; 

    final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json'
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> getDistritosMultientrega(String token, String idProvincia) async {
    final url = Uri.parse('$_url/getDistritosMultientrega');   

    final Map<String, dynamic> data = {'token': token, 'id_provincia': idProvincia}; 

    final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json'
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> getCorregimientosMultientrega(String token, String idDistrito) async {
    final url = Uri.parse('$_url/getCorregimientosMultientrega');   

    final Map<String, dynamic> data = {'token': token, 'id_distrito': idDistrito}; 

    final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json'
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }

  Future<dynamic> getBarriosMultientrega(String token, String idCorregimiento) async {
    final url = Uri.parse('$_url/getBarriosMultientrega');   

    final Map<String, dynamic> data = {'token': token, 'id_corregimiento': idCorregimiento}; 

    final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json'
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }


    Future<dynamic> createServiceMultientrega(
      String token, 
      dynamic delivery,
      String externalReference,
      String address,
      String additionalInformation,
      String email,
      String telefono,
      String contacto,
      String idBarrio,
      String intermediario,
      String numVuelo,
      String fechaHoraLlegada,
      ) async {
    final url = Uri.parse('$_url/createServiceMultientrega');   

    final Map<String, dynamic> data = {
      'token': token, 
      'delivery': delivery,
      'external_reference': externalReference,
      'address': address,
      'additional_information': additionalInformation,
      'email': email,
      'telefono': telefono,
      'contacto': contacto,
      'id_barrio': idBarrio,
      'intermediario': intermediario,
      'num_vuelo': numVuelo,
      'fecha_hora_llegada': fechaHoraLlegada,
      }; 

    final resp = await http.post(url, body: json.encode(data), headers: {
        'content-type': 'application/json'
      });
    final decodedData = Utf8Codec().decode(resp.bodyBytes);
    return decodedData;
  }
}