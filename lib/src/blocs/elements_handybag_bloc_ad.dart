// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:maando/src/services/packageResource.dart';

class ElementsBlocHandybag {

  final _perfumController = BehaviorSubject<dynamic>();
  final _watchController = BehaviorSubject<dynamic>();
  final _mobileController = BehaviorSubject<dynamic>();
  final _tabletController = BehaviorSubject<dynamic>();
  final _makeupController = BehaviorSubject<dynamic>();
  final _clothesController = BehaviorSubject<dynamic>();
  final _booksController = BehaviorSubject<dynamic>();
  final _documentsController = BehaviorSubject<dynamic>();
  final _pairShoesController = BehaviorSubject<dynamic>();

  //  INSERTAR VALORES AL STREAM
  Function(dynamic) get changePerfum => _perfumController.sink.add;
  Function(dynamic) get changeWatch => _watchController.sink.add;
  Function(dynamic) get changeMobile => _mobileController.sink.add;
  Function(dynamic) get changeTablet => _tabletController.sink.add;
  Function(dynamic) get changeMakeup => _makeupController.sink.add;
  Function(dynamic) get changeClothes => _clothesController.sink.add;
  Function(dynamic) get changeBooks => _booksController.sink.add;
  Function(dynamic) get changeDocuments => _documentsController.sink.add;
  Function(dynamic) get changePairShoes => _pairShoesController.sink.add;


  // OBTENER LOS VALORES
  dynamic get perfum => _perfumController.value;
  dynamic get watch => _watchController.value;
  dynamic get mobile => _mobileController.value;
  dynamic get tablet => _tabletController.value;
  dynamic get makeup => _makeupController.value;
  dynamic get clothes => _clothesController.value;
  dynamic get books => _booksController.value;
  dynamic get documents => _documentsController.value;
  dynamic get pairShoes => _pairShoesController.value;



  Stream<dynamic> get perfumStream => _perfumController.stream;
  Stream<dynamic> get watchStream => _watchController.stream;
  Stream<dynamic> get mobileStream => _mobileController.stream;
  Stream<dynamic> get tabletStream => _tabletController.stream;
  Stream<dynamic> get makeupStream => _makeupController.stream;
  Stream<dynamic> get clothesStream => _clothesController.stream;
  Stream<dynamic> get booksStream => _booksController.stream;
  Stream<dynamic> get documentsStream => _documentsController.stream;
  Stream<dynamic> get pairShoesStream => _pairShoesController.stream;



  inicializarElementos(){
      changePerfum(packageResource.elements()[0]);
      changeWatch(packageResource.elements()[1]);
      changeMobile(packageResource.elements()[2]);
      changeTablet(packageResource.elements()[3]);
      changeMakeup(packageResource.elements()[4]);
      changeClothes(packageResource.elements()[5]);
      changeBooks(packageResource.elements()[6]);
      changeDocuments(packageResource.elements()[7]);
      changePairShoes(packageResource.elements()[8]);
     }



      llenarListaElementosHandybag(BuildContext context){
          final bloc = ProviderApp.ofFlightForm(context);
            bloc.changeListElementsHandybag([
              packageResource.elements()[0],
              packageResource.elements()[1],
              packageResource.elements()[2],
              packageResource.elements()[3],
              packageResource.elements()[4],
              packageResource.elements()[5],
              packageResource.elements()[6],
              packageResource.elements()[7],
              packageResource.elements()[8],
            ]);
          }

      vaciarElementos(){
        changePerfum(null);
        changeWatch(null);
        changeMobile(null);
        changeTablet(null);
        changeMakeup(null);
        changeClothes(null);
        changeBooks(null);
        changeDocuments(null);
        changePairShoes(null);
      }



  dispose() {
    _perfumController?.close();
    _watchController?.close();
    _mobileController?.close();
    _tabletController?.close();
    _makeupController?.close();
    _clothesController?.close();
    _booksController?.close();
    _documentsController?.close();
    _pairShoesController?.close();
  }
}

ElementsBlocHandybag elementsBlocHandybagAd = ElementsBlocHandybag();
