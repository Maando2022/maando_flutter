import 'package:maando/src/utils/textos/ads_package_type.dart';
import 'package:maando/src/utils/textos/general_text.dart';

class PackageResource {


  List packages(){
    return [
              {"code": "Package-Compact", "name": adspacktypeText.compactName(), "description":  adspacktypeText.compactDescription()},
              {"code": "Package-Handybag", "name": adspacktypeText.handybagName(), "description": adspacktypeText.handybagDescription()}
            ];
  }

    List elements(){
    return [
              {"code": "Element-Perfum", "name": "Perfum", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Watch", "name": "Watch", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Mobile", "name": "Mobile", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Tablet", "name": "Tablet", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Makeup", "name": "Makeup", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Clothes", "name": "Clothes", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Books", "name": "Books", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-Documents", "name": "Documents", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0},
              {"code": "Element-PairShoes", "name": "Pair of shoes", "select": false, "high": 0.0, "width": 0.0, "long": 0.0, "weight": 0.0}
            ];
  }


    List insurances(){
    return [
              {"code": "Insurance-Premium", "name": "Premium", "description": "Insurance description Premiun", "price": "5.34", "select": false},
              {"code": "Insurance-Normal", "name": "Normal", "description": "Insurance description Normal", "price": "2.67", "select": false},
              {"code": "Insurance-Basic", "name": "Basic", "description": "Insurance description Basic", "price": "1.34", "select": false},
              {"code": "Insurance-Free", "name": "Free", "description": "Insurance description Free", "price": "0.00", "select": false}
            ];
    }


  List speciaService(){
    return [
              {"code": "Insurance-Premium", "name": "Premium", "description": generalText.antiDrugAntiExplosiveScreeningOfPackage(), "price": "12", "select": false},
              {"code": "Insurance-Free", "name": generalText.free(), "description": generalText.iTrustThisPerson(), "price": "0.00", "select": false}
          ];
    }
}

PackageResource packageResource = new PackageResource();