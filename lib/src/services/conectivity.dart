import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/widgets/botones.dart';

class Conectivity {
  validarConexion(BuildContext context, String page) async {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        print('Conectado desde wifi');
      } else if (result == ConnectivityResult.mobile) {
        print('Conectado desde los datos');
      } else if (result == ConnectivityResult.none) {
        print('Sin internet');
        prefsInternal.guardarPaginaAnterior(context, page);
        // Navigator.pushReplacementNamed(context, 'desconectado');
      }
    });
  }

  conexionRestablecida(BuildContext context, String page) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.wifi) {
        // print('Conectado desde wifi');
        if (returnPage(page) == 'principal') {
          blocNavigator.homePrincipal();
          Navigator.pushReplacementNamed(context, returnPage(page));
        } else {
          Navigator.pushReplacementNamed(context, returnPage(page));
        }
      } else if (result == ConnectivityResult.mobile) {
        // print('Conectado desde los datos');
        if (returnPage(page) == 'principal') {
          blocNavigator.homePrincipal();
          Navigator.pushReplacementNamed(context, returnPage(page));
        } else {
          Navigator.pushReplacementNamed(context, returnPage(page));
        }
      } else if (result == ConnectivityResult.none) {
        // print('Sin internet');
      }
    });
  }

  String returnPage(String page) {
    if (page == 'after_singup_page') {
      return 'after_singup_page';
    } else if (page == 'flight_detail') {
      return 'flight_detail';
    } else if (page == 'create_ad_title') {
      return 'create_ad_title';
    } else if (page == 'create_ad_type_package') {
      return 'create_ad_type_package';
    } else if (page == 'create_ad_elements_compact') {
      return 'create_ad_elements_compact';
    } else if (page == 'create_ad_elements_handybag') {
      return 'create_ad_elements_handybag';
    } else if (page == 'create_ad_10_date_time') {
      return 'create_ad_10_date_time';
    } else if (page == 'create_ad_10_country_city') {
      return 'create_ad_10_country_city';
    } else if (page == 'create_ad_10_fecha_pais_ciudad_diligenciado') {
      return 'create_ad_10_fecha_pais_ciudad_diligenciado';
    } else if (page == 'create_ad_10_add_pictures_1') {
      return 'create_ad_10_add_pictures_1';
    } else if (page == 'create_ad_10_add_pictures_2') {
      return 'create_ad_10_add_pictures_2';
    } else if (page == 'create_ad_10_insurances') {
      return 'create_ad_10_insurances';
    } else if (page == 'create_ad_10_find_service_maches') {
      return 'create_ad_10_find_service_maches';
    } else if (page == 'search_9_4') {
      return 'search_9_4';
    } else if (page == 'detail_8_3') {
      return 'detail_8_3';
    } else if (page == 'reviews_12_3') {
      return 'reviews_12_3';
    } else if (page == 'add_rate_review') {
      return 'add_rate_review';
    } else if (page == 'review_successfuly') {
      return 'review_successfuly';
    } else if (page == 'request_to') {
      return 'request_to';
    } else if (page == 'create_flight_2_form') {
      return 'create_flight_2_form';
    } else if (page == 'create_flight_3_diligenciado') {
      return 'create_flight_3_diligenciado';
    } else if (page == 'create_flight_type_package') {
      return 'create_flight_type_package';
    } else if (page == 'create_flight_5_add_elements_compac') {
      return 'create_flight_5_add_elements_compac';
    } else if (page == 'create_flight_5_add_elements_handybag') {
      return 'create_flight_5_add_elements_handybag';
    } else if (page == 'create_flight_6_insurance') {
      return 'create_flight_6_insurance';
    } else if (page == 'flight_published_12') {
      return 'flight_published_12';
    } else if (page == 'match_ad_12_2') {
      return 'match_ad_12_2';
    } else if (page == 'match_flight_12_2') {
      return 'match_flight_12_2';
    } else if (page == 'world_matters') {
      return 'world_matters';
    } else if (page == 'sustainability') {
      return 'sustainability';
    } else if (page == 'notification') {
      return 'notification';
    } else if (page == 'video_prueba') {
      return 'video_prueba';
    }else if (page == 'lanzamiento') {
      return 'lanzamiento';
    }else if (page == 'entrepreneurs') {
      return 'entrepreneurs';    
    }else if (page == 'security') {
      return 'security';
    }else if (page == 'well_being') {
      return 'well_being';
    }else if (page == 'how_it_works') {
      return 'how_it_works';   

    } else {
      return 'lanzamiento';
    }
  }
}

Conectivity conectivity = Conectivity();
