import 'package:maando/src/blocs/general_bloc.dart';

class ValidateAdmins{


  // Future adminsFuture = Http().getAdmins();
  //  Future get adminsFuture => Http().getAdmins();



  List<String> admins = [
      'davgui242011@gmail.com',
      'david@jdvgroup.co',
      'david@maando.com',
      'jdv@maando.com',
      'jdv@jdvgroup.co',
      'friends@maando.com',
      'rosanna@maando.com',
      'daniel@maando.com',
      'alia@maando.com',
      'apple@apple.com'
  ];

  bool isAdmin(String email){
    bool validate = false;
    for(String admin in blocGeneral.admins){
      if(email == admin){
        validate = true;
      }
    }

    // print('LOS ADMINS  =============>>>>>>>>>>  ${validate}');
    return validate;
  }

}

ValidateAdmins validateAdmin = ValidateAdmins();