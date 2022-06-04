

import 'package:mongo_dart/mongo_dart.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/blocs/bloc_db.dart';

class MongoDb {

uploadDB() async {
     final Db db = await Db.create("mongodb+srv://maando:iahDuqHhEnVd0qfZ@cluster0.jmwxe.mongodb.net/maando?retryWrites=true&w=majority");
     await db.open();
     bdBloc.changeDb(db);
     bdBloc.changeDbUsers(bdBloc.db.collection('users'));
    //  Http().findUserForEmail(email: 'david@maando.com').then((value) =>  print('Desde Http =============>>>>>>>>>>  ${json.decode(value)["user"]["email"]}'));
    //   await collection
    //   .find(where.eq("email", 'david@maando.com'))
    //   .forEach((v) => print('Desde mongooo =============>>>>>>>>>>  ${v["email"]}'));
  }

}

MongoDb mongoDB = MongoDb();