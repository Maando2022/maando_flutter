// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:maando/src/utils/validaciones/post_validation.dart';

class PosToAdmintBloc with PostValidation{
  final  _postToAdminController = BehaviorSubject<String>();
  final  _commentController = BehaviorSubject<String>();
  final _auxController = BehaviorSubject<String>();



  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get postToAdminStream => _postToAdminController.stream.transform(validarContent);
  Stream<String> get commentStream => _commentController.stream.transform(validarContent);
  Stream<String> get auxStream => _auxController.stream.transform(validarAux);
  Stream<bool> get formValidarStream =>  CombineLatestStream.combine2(postToAdminStream, auxStream, (p, a) => true);


  //  INSERTAR VALORES AL STREAM
  Function(String) get changePostToAdmin => _postToAdminController.sink.add;
  Function(String) get changeComment => _commentController.sink.add;
  Function(String) get changeAux => _auxController.sink.add;
  


  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get postToAdmin => _postToAdminController.value;
  String get comment => _commentController.value;




  dispose() {
    _postToAdminController?.close();
    _commentController?.close();
    _auxController?.close();
  }
}

PosToAdmintBloc blocPostToAdmin = PosToAdmintBloc();
