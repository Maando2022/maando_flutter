
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:maando/src/services/http.dart';
// import 'package:maando/src/utils/textos/general_text.dart';
// import 'package:maando/src/utils/last_mille.dart';
// import 'package:maando/src/services/shared_pref.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// // ****************
// import 'package:braintree_payment/braintree_payment.dart';

// class Braintree {
//   String type;
//   Http _http = Http();
//   final preference = Preferencias();
//   var request;

// String clientNonce = "eyJ2ZXJzaW9uIjoyLCJhdXRob3JpemF0aW9uRmluZ2VycHJpbnQiOiJleUowZVhBaU9pSktWMVFpTENKaGJHY2lPaUpGVXpJMU5pSXNJbXRwWkNJNklqSXdNVGd3TkRJMk1UWXRjMkZ1WkdKdmVDSXNJbWx6Y3lJNkltaDBkSEJ6T2k4dllYQnBMbk5oYm1SaWIzZ3VZbkpoYVc1MGNtVmxaMkYwWlhkaGVTNWpiMjBpZlEuZXlKbGVIQWlPakUyTVRjNE9UWTJORE1zSW1wMGFTSTZJak5qWW1RMllqWm1MV0psTnprdE5EUmtOUzFpTmpRMExUWTNORFV4WmpkbE5tRTFZU0lzSW5OMVlpSTZJbVJ3Y3pWME0zRjZjR015ZVdabWFtTWlMQ0pwYzNNaU9pSm9kSFJ3Y3pvdkwyRndhUzV6WVc1a1ltOTRMbUp5WVdsdWRISmxaV2RoZEdWM1lYa3VZMjl0SWl3aWJXVnlZMmhoYm5RaU9uc2ljSFZpYkdsalgybGtJam9pWkhCek5YUXpjWHB3WXpKNVptWnFZeUlzSW5abGNtbG1lVjlqWVhKa1gySjVYMlJsWm1GMWJIUWlPbVpoYkhObGZTd2ljbWxuYUhSeklqcGJJbTFoYm1GblpWOTJZWFZzZENKZExDSnpZMjl3WlNJNld5SkNjbUZwYm5SeVpXVTZWbUYxYkhRaVhTd2liM0IwYVc5dWN5STZleUpqZFhOMGIyMWxjbDlwWkNJNklqSXhNekk1TXpVMU55SjlmUS40OWpRZlFWU0lrT2RPY3FWNjRsMjlRT0RLcGhsME1iQm1fQ3NXU0JYRll5YV9CYUEzUzJUWWFXTEF4YnlkZGp2SU53eVdFdFRNQXdYUDJUZ3JNaGJoUT9jdXN0b21lcl9pZD0iLCJjb25maWdVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZHBzNXQzcXpwYzJ5ZmZqYy9jbGllbnRfYXBpL3YxL2NvbmZpZ3VyYXRpb24iLCJncmFwaFFMIjp7InVybCI6Imh0dHBzOi8vcGF5bWVudHMuc2FuZGJveC5icmFpbnRyZWUtYXBpLmNvbS9ncmFwaHFsIiwiZGF0ZSI6IjIwMTgtMDUtMDgiLCJmZWF0dXJlcyI6WyJ0b2tlbml6ZV9jcmVkaXRfY2FyZHMiXX0sImhhc0N1c3RvbWVyIjp0cnVlLCJjbGllbnRBcGlVcmwiOiJodHRwczovL2FwaS5zYW5kYm94LmJyYWludHJlZWdhdGV3YXkuY29tOjQ0My9tZXJjaGFudHMvZHBzNXQzcXpwYzJ5ZmZqYy9jbGllbnRfYXBpIiwiZW52aXJvbm1lbnQiOiJzYW5kYm94IiwibWVyY2hhbnRJZCI6ImRwczV0M3F6cGMyeWZmamMiLCJhc3NldHNVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImF1dGhVcmwiOiJodHRwczovL2F1dGgudmVubW8uc2FuZGJveC5icmFpbnRyZWVnYXRld2F5LmNvbSIsInZlbm1vIjoib2ZmIiwiY2hhbGxlbmdlcyI6W10sInRocmVlRFNlY3VyZUVuYWJsZWQiOnRydWUsImFuYWx5dGljcyI6eyJ1cmwiOiJodHRwczovL29yaWdpbi1hbmFseXRpY3Mtc2FuZC5zYW5kYm94LmJyYWludHJlZS1hcGkuY29tL2RwczV0M3F6cGMyeWZmamMifSwicGF5cGFsRW5hYmxlZCI6dHJ1ZSwicGF5cGFsIjp7ImJpbGxpbmdBZ3JlZW1lbnRzRW5hYmxlZCI6dHJ1ZSwiZW52aXJvbm1lbnROb05ldHdvcmsiOnRydWUsInVudmV0dGVkTWVyY2hhbnQiOmZhbHNlLCJhbGxvd0h0dHAiOnRydWUsImRpc3BsYXlOYW1lIjoiTWFhbmRvIiwiY2xpZW50SWQiOm51bGwsInByaXZhY3lVcmwiOiJodHRwOi8vZXhhbXBsZS5jb20vcHAiLCJ1c2VyQWdyZWVtZW50VXJsIjoiaHR0cDovL2V4YW1wbGUuY29tL3RvcyIsImJhc2VVcmwiOiJodHRwczovL2Fzc2V0cy5icmFpbnRyZWVnYXRld2F5LmNvbSIsImFzc2V0c1VybCI6Imh0dHBzOi8vY2hlY2tvdXQucGF5cGFsLmNvbSIsImRpcmVjdEJhc2VVcmwiOm51bGwsImVudmlyb25tZW50Ijoib2ZmbGluZSIsImJyYWludHJlZUNsaWVudElkIjoibWFzdGVyY2xpZW50MyIsIm1lcmNoYW50QWNjb3VudElkIjoibWFhbmRvIiwiY3VycmVuY3lJc29Db2RlIjoiVVNEIn19";
// braintreeService(BuildContext context, dynamic match)async {

//      EasyLoading.show(status: 'Loading...');
//     _http.clientTokenBraintree().then((value) async {
//       EasyLoading.dismiss();
//       if (value["ok"] == false) {
//         print('Error al obtener el tokenId');
//       } else {
//         try {
//             BraintreePayment braintreePayment = new BraintreePayment();
//                 await braintreePayment.showDropIn(
//                    nonce: value["clientToken"], amount: "2.0", enableGooglePay: true, inSandbox: true, nameRequired: true).then((valueBraintree){
                     
//                      if(valueBraintree["status"] == 'success'){
//                       EasyLoading.show(status: 'Loading...');
//                      _http.requestPaidAd(
//                        context: context, 
//                        email: preference.prefsInternal.get('email'),
//                        idMatch: match["_id"],
//                        idAd: match["ad"]["_id"],
//                        dataPay: json.encode(valueBraintree)
//                        ).then((valueApi){
//                          var valueMap = json.decode(valueApi);
//                          if(valueMap["ok"] == true){
//                            lastMilleResourse.createservice(valueMap["ad"], valueMap["flight"]);
//                          }
                         
//                        });
//                      }

//                 });

//         }catch(e){
//             print('Error al pasas a paypal ${e.toString()}');
//         }
//       }
//     });

  
// }

  
        
// }

// Braintree braintree = Braintree();


