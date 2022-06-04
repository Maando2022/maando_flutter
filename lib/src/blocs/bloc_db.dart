// @dart=2.9
import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:mongo_dart/mongo_dart.dart';

class DBBloc {

  var _dbController = BehaviorSubject<Db>();
  var _dbControllerUsers = BehaviorSubject<DbCollection>();

  Function(Db) get changeDb => _dbController.sink.add;
  Function(DbCollection) get changeDbUsers => _dbControllerUsers.sink.add;

  Db get db => _dbController.value;
  DbCollection get dbUsers => _dbControllerUsers.value;

  Stream<Db> get dbStream => _dbController.stream;
  Stream<DbCollection> get dbUsersStream => _dbControllerUsers.stream;

  dispose() {
    _dbController?.close();
    _dbControllerUsers?.close();
  }
}

DBBloc bdBloc = DBBloc();
