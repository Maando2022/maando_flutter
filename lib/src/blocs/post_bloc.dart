// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:maando/src/utils/validaciones/post_validation.dart';

class PostBloc with PostValidation{
  final  _postController = BehaviorSubject<String>();
  final  _commentController = BehaviorSubject<String>();
  final  _subCommentController = BehaviorSubject<String>();
  final _auxController = BehaviorSubject<String>();



  //  RECUPERAR LOS DAOS DEL STREAM
  Stream<String> get postStream => _postController.stream.transform(validarContent);
  Stream<String> get commentStream => _commentController.stream.transform(validarContent);
  Stream<String> get subCommentStream => _subCommentController.stream.transform(validarContent);
  Stream<String> get auxStream => _auxController.stream.transform(validarAux);
  Stream<bool> get formValidarStream =>  CombineLatestStream.combine2(postStream, auxStream, (p, a) => true);


  //  INSERTAR VALORES AL STREAM
  Function(String) get changePost => _postController.sink.add;
  Function(String) get changeComment => _commentController.sink.add;
  Function(String) get changeSubComment => _subCommentController.sink.add;
  Function(String) get changeAux => _auxController.sink.add;
  


  // OBTENER LOS VALORES DE EL EMAIL Y PASSWORD
  String get post => _postController.value;
  String get comment => _commentController.value;
  String get subComment => _subCommentController.value;




  dispose() {
    _postController?.close();
    _commentController?.close();
    _subCommentController?.close();
    _auxController?.close();
  }
}

PostBloc blocPost = PostBloc();
