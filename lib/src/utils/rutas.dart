// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/pages/ad_form/create_ad_what_can_i_send.dart';
import 'package:maando/src/pages/admin/admin.dart';
import 'package:maando/src/pages/admin/flight_detail.dart';
import 'package:maando/src/pages/admin/flight_map.dart';
import 'package:maando/src/pages/admin/payment_detail.dart';
import 'package:maando/src/pages/admin/user_detail.dart';
import 'package:maando/src/pages/admin/user_map.dart';
import 'package:maando/src/pages/after_signup_page.dart';
import 'package:maando/src/pages/complete_registration_page.dart';
import 'package:maando/src/pages/create_account_page.dart';


// ****************  AD
import 'package:maando/src/pages/ad_form/create_ad_images1.dart';
import 'package:maando/src/pages/ad_form/create_ad_images2.dart';
import 'package:maando/src/pages/ad_form/create_ad_insurance.dart';
import 'package:maando/src/pages/ad_form/create_ad_publish_and_maches.dart';
import 'package:maando/src/pages/ad_form/create_ad_resume.dart';
import 'package:maando/src/pages/ad_form/create_ad_title_date_destination.dart';
import 'package:maando/src/pages/ad_form/create_ad_delivery_address.dart';
import 'package:maando/src/pages/ad_form/create_ad_page_price.dart';
// ****************  FLIGHT
import 'package:maando/src/pages/flight_form/create_flight_add_elementsCompact.dart';
import 'package:maando/src/pages/flight_form/create_flight_add_elementsHandybag.dart';
import 'package:maando/src/pages/flight_form/create_flight_insurance.dart';
import 'package:maando/src/pages/flight_form/create_flight_page2_form.dart';
import 'package:maando/src/pages/flight_form/create_flight_publish_and_maches.dart';
import 'package:maando/src/pages/flight_form/create_flight_resume.dart';
import 'package:maando/src/pages/flight_form/create_flight_type_package.dart';
import 'package:maando/src/pages/flight_form/create_flight_what_can_i_bring.dart';
import 'package:maando/src/pages/history/history.dart';
import 'package:maando/src/pages/home/ad_detail_page.dart';
import 'package:maando/src/pages/home/detail_flight_home.dart';
import 'package:maando/src/pages/home/flight_detail_page.dart';
import 'package:maando/src/pages/home/principal_page.dart';
import 'package:maando/src/pages/login_face_id_page.dart';
import 'package:maando/src/pages/login_page.dart';
import 'package:maando/src/pages/login_touch_id_page.dart';
import 'package:maando/src/pages/lost_connection_page.dart';
import 'package:maando/src/pages/match_flight_page_12_2.dart';
import 'package:maando/src/pages/notification_page.dart';
import 'package:maando/src/pages/onboarding-nuevo/onboarding-nuevo-001.dart';
import 'package:maando/src/pages/onboarding-nuevo/onboarding-nuevo-002.dart';
import 'package:maando/src/pages/onboarding-nuevo/onboarding-nuevo-003.dart';
import 'package:maando/src/pages/onboarding-nuevo/onboarding-nuevo-004.dart';
import 'package:maando/src/pages/onboarding/onboarding01_page.dart';
import 'package:maando/src/pages/onboarding/onboarding02_page.dart';
import 'package:maando/src/pages/onboarding/onboarding_page.dart';
import 'package:maando/src/pages/post_to_admin/posts_to_admins.dart';
import 'package:maando/src/pages/posts/chat.dart';
import 'package:maando/src/pages/posts/create_post.dart';
import 'package:maando/src/pages/posts/date_range.dart';
import 'package:maando/src/pages/posts/my_conversations.dart';
import 'package:maando/src/pages/posts/posts.dart';
import 'package:maando/src/pages/posts/posts2.dart';
import 'package:maando/src/pages/profile/edit_city.dart';
import 'package:maando/src/pages/profile/edit_country.dart';
import 'package:maando/src/pages/profile/edit_phone.dart';
import 'package:maando/src/pages/profile/edit_name.dart';
import 'package:maando/src/pages/profile/pay_method_paypal.dart';
import 'package:maando/src/pages/profile/pay_method_stripe.dart';
import 'package:maando/src/pages/profile/profile.dart';
import 'package:maando/src/pages/pruebas/elemet_of_ad.dart';
import 'package:maando/src/pages/request_to_transport_page.dart';
import 'package:maando/src/pages/reset_password_page.dart';
import 'package:maando/src/pages/review/review_successfuly_page.dart';
import 'package:maando/src/pages/review/reviews_page_12_3.dart';
import 'package:maando/src/pages/search/result_search_flight.dart';
import 'package:maando/src/pages/search/search_page_9-4.dart';
import 'package:maando/src/pages/review/add_rate_review_page.dart';
import 'package:maando/src/pages/subpages/detail_in_transit_page_8_3.dart';
import 'package:maando/src/pages/subpages/matches/detail_ad_match.dart';
import 'package:maando/src/pages/subpages/matches/detail_flight_match.dart';
import 'package:maando/src/pages/subpages/matches/list_ads.dart';
import 'package:maando/src/pages/subpages/matches/list_flights.dart';
import 'package:maando/src/pages/subpages/pending.dart/ads_pending.dart';
import 'package:maando/src/pages/subpages/pending.dart/flights_pending.dart';
import 'package:maando/src/pages/subpages/timeline_flight.dart';
import 'package:maando/src/pages/subpages/timeline_ad.dart';
import 'package:maando/src/pages/subpages/timeline_map.dart';
import '../pages/login_face_id_page.dart';
import '../pages/login_page.dart';
import '../pages/login_touch_id_page.dart';
import '../pages/onboarding/onboarding_page.dart';
import '../pages/reset_password_page.dart';
import '../pages/match_ad_page_12_2.dart';

Map<String, Widget Function(BuildContext)> routes() {
  return {
    'login': (BuildContext context) => LoginPage(),
    'create_account': (BuildContext context) => CreatreAccountPage(),
    'complete_registration': (BuildContext context) => CompleteRegistrationPage(),
    //***********  On boarding */
    'onboarding': (BuildContext context) => OnboardingPage(),
    'onboarding01': (BuildContext context) => Onboarding01Page(),
    'onboarding02': (BuildContext context) => Onboarding02Page(),

    //***************** */
    'login_face_id': (BuildContext context) => LoginFaceIDPage(),
    'login_touch_id': (BuildContext context) => LoginTouchIDPage(),
    'reset_password': (BuildContext context) => ResetPasswordPage(),
    // *******************
    'after_singup_page': (BuildContext context) => AfterSignUpPage(),
    // ******************************** AD FORM ************************************************* AD FROM CREATE
    'create_ad_title_date_destination': (BuildContext context) => CreateAdTitleDateDestination(),
    'create_ad_delivery_address': (BuildContext context) => CreateAdDelivaryAddress(),
    'create_ad_images1': (BuildContext context) => CreateAdImages1(),
    'create_ad_images2': (BuildContext context) => CreateAdImages2(),
    'create_ad_price': (BuildContext context) => CreateAdPrice(),
    'create_ad_insurance': (BuildContext context) => CreateAdInsurance(),
    'create_ad_resume': (BuildContext context) => CreateAdResune(),
    'create_ad_publish_and_maches': (BuildContext context) => CreateAdPublisAndMaches(),
    'create_flight_what_can_i_send': (BuildContext context) => CreateAdWhatCanISend(),
  // *************************************************************************************  FLIGHT FROM CREATE
    'create_flight_what_can_i_bring': (BuildContext context) => CreateAdWhatCanIBring(),
    'create_flight_form': (BuildContext context) => CreateFlightForm(),
    'create_flight_type_package': (BuildContext context) => CreateFlightTyPePackage(),
    'create_flight_add_elements_compact': (BuildContext context) => CreateFlightAddElementsCompact(),
    'create_flight_add_elements_handybag': (BuildContext context) => CreateFlightAddElementsHandybag(),
    'create_flight_resume': (BuildContext context) => CreateFlightResume(),
    'create_flight_insurance': (BuildContext context) => CreateFlightInsurance(),
    'create_flight_publish_and_maches': (BuildContext context) => CreateFlightPubishAndMaches(),
    // ************************************************************************************* LISTA DE VUELOS MACHADOS DESDE  EL BOTON DE BUSQUEDA
    'search_9_4': (BuildContext context) => Search_page_9_4(),
    'result_flight_search': (BuildContext context) => Result_Flight_Search(),
    'detail_8_3': (BuildContext context) => Detail_in_transit_page_8_3(),
    'ad_detail': (BuildContext context) => AdDetailPage(),
    'flight_detail': (BuildContext context) => FlightDetailPage(),
    'detail_flight_home': (BuildContext context) => DetailFlightHome(),
    // *************************************************************************  LISTA DE VUELOS MAtCHADOS DESDE SHIPMENTS_service
    'timelineFlight': (BuildContext context) => TimeLine(),
    'timelineAd': (BuildContext context) => TimeLineAd(),
    'timelineMap': (BuildContext context) => TimeLineMap(),
    // *************************************************************************  LISTA DE VUELOS MAtCHADOS DESDE SHIPMENTS_service
    'list_flights': (BuildContext context) => ListaFlights(),
    'detail_flight_match': (BuildContext context) => DetailFlightMatch(),
    // *************************************************************************  LISTA DE ANUNCIOS MAtCHADOS DESDE shipmentSERVICE
    'list_ads': (BuildContext context) => ListaAds(),
    'detail_ad_match': (BuildContext context) => DetailAdMatch(),
    // *************************************************************************  PAGINAS REFERENTES A LOS VUELOS Y ANUNCIOS PENDIENTES DESDE SHIPMENTService
    'list_flight_pending': (BuildContext context) => ListFlightPending(),
    // *************************************************************************  PAGINAS DE VUELOS Y ANUNCIOS QUE YA SE HA REALIZADO
    'history': (BuildContext context) => History(),
    // *******************
    'list_ad_pending': (BuildContext context) => ListAdPending(),
    'reviews_12_3': (BuildContext context) => Reviews_page_12_3(),
    'add_rate_review': (BuildContext context) => Add_rate_review(),
    'review_successfuly': (BuildContext context) => Review_Successfuly(),
    'lost_connection': (BuildContext context) => Lost_Conecction(),
    'request_to': (BuildContext context) => RoquestToTransport(),
    // **************************************************************
    'match_ad_12_2': (BuildContext context) => Match_Ad_page_12_2(),
    'match_flight_12_2': (BuildContext context) => Match_Flight_page_12_2(),
    // **************************************************************
    'principal': (BuildContext context) => PrincipalPage(),
    //********************************************************************* */
    'notification': (BuildContext context) => NotificationPage(),
    // 'entrepreneurs': (BuildContext context) => EntrepreneursPage(),
    //**ORBOARDIN NUEVOS**************************∫*********************** */
    'omb_new_001': (BuildContext context) => OnboardingNuevo001Page(),
    'omb_new_002': (BuildContext context) => OnboardingNuevo002Page(),
    'omb_new_003': (BuildContext context) => OnboardingNuevo003Page(),
    'omb_new_004': (BuildContext context) => OnboardingNuevo004Page(),
    // ******************************************** POSTS
      'post': (BuildContext context) => Posts(),
      'post2': (BuildContext context) => Posts2(),
      'chat': (BuildContext context) => Chat(),
      'my_conversations': (BuildContext context) => MyConversations(),
      'posts_to_admins': (BuildContext context) => PostsToAdmins(),
      'create_post': (BuildContext context) => CreatePost(),
      'date_range': (BuildContext context) => DateRange(),

      // ******************************************** ADMIN
      'admin': (BuildContext context) => Admin(),
      'user_datail': (BuildContext context) => User(),
      'flight_datail': (BuildContext context) => Flight(),
      'payment_datail': (BuildContext context) => PaymentDetail(),
      'user_map': (BuildContext context) => UserMap(),
      'flight_map': (BuildContext context) => FlightMap(),


      // ******************************************** ADMIN
      'profile_page': (BuildContext context) => ProfilePage(),
      'edit_phone': (BuildContext context) => EditPhone(),
      'edit_name': (BuildContext context) => EditName(),
      'edit_country': (BuildContext context) => EditCountry(),
      'edit_city': (BuildContext context) => EditCity(),
      'pay_method_stripe': (BuildContext context) => PayMethodStripe(),
      'pay_method_paypal': (BuildContext context) => PayMethodPaypal(),
      

      // *************************************************************************************  PRUEBAS
      'element_of_ad': (BuildContext context) => ElementsOfAd(),
      'select_element_of_ad': (BuildContext context) => SelectElements(),
  };
}

// onGenerateRoute(settings) {
//   print(settings.name);
//   switch (settings.name) {
//     case 'shipments_service_page':
//       return PageTransition(
//           child: ShipmentsServivesPage(), type: PageTransitionType.upToDown);
//       break;
//     case 'create_ad1_15':
//       return PageTransition(
//           child: CreateAd_10_0(), type: PageTransitionType.leftToRight);
//       break;
//     default:
//       return null;
//   }
// }
