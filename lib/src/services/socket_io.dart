// @dart=2.9
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/enviromets/url_server.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

enum ServerStaus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStaus _serverStatus = ServerStaus.Connecting;
  IO.Socket _socket;

  ServerStaus get serverStatus => this._serverStatus;
  IO.Socket get socket => this._socket;

  SocketService() {
    this._initConfig();
  }

  void _initConfig() {
    this._socket = IO.io(urlserver.url, {
      'transports': ['websocket'],
      'autoConnect': true,
    });


    this._socket.on('connect', (_) {
      this._serverStatus = ServerStaus.Online;
      notifyListeners();
      print('Usuario conetado (desde la app) --------------------------------------------------------------------------------------------');
      
    });
    // *******************
    this._socket.on('disconnect', (_) {
      this._serverStatus = ServerStaus.Offline;
      notifyListeners();
    });


    // *******************
    this._socket.emit('updateIdSocket',{});
    // *******************
    this._socket.on('updateIdSocket', (clientId) {
      notifyListeners();
      Http().updateIdSocketUser(email: prefsInternal.prefsInternal.get('email'), idToken: clientId)
        .then((res){
          //  print('El cliente (desde la app) -------------------------------------------------------------------------------------------- $clientId');
        });
    });

 
    // ******************* OBTENEMOS EL USUARIO
    this._socket.on('get-user', (email) {
      notifyListeners();
      if(email == null){

      }else{
        Http().findUserForEmail(email: email).then((user){
          var userMap = json.decode(user);
          if(userMap["ok"] == true){
            blocSocket.changeUser(userMap["user"]);
          }
        });

      }
    });

    // ******************* ESTAMOS OBSERVANDO LOA ANUNCIOS Y VUELOS QUE SE PUBLICAN
    this._socket.on('addEntityToHome', (entity) {
      notifyListeners();
      if(entity == null){
        
      }else{
        if(entity["entity"]["type"] == "ad"){
          blocGeneral.changePackages(blocGeneral.packages..add(entity["entity"]));
        }else{
          blocGeneral.changeTrips(blocGeneral.trips..add(entity["entity"]));
        }
      }
    });

    // ******************* ESTAMOS OBSERVANDO LOS POST
    this._socket.on('addEntityToPosts', (entity) {
      notifyListeners();
      if(entity == null){
        
      }else{
        blocGeneral.changePosts(blocGeneral.posts..insert(0, entity["entity"]));  // Agregamos el nievo post al inicio de la lista
        blocGeneral.changePosts(blocGeneral.posts.toSet().toList()); 
        return;
      }
    });

    // ******************* ESTAMOS OBSERVANDO LOS POST ELIMINADOS O ACTUALIZADOS
    this._socket.on('deleteOrUpdateEntityToPosts', (entity) {
      notifyListeners();
      if(entity == null){
        
      }else{

        for(int i=0; i<blocGeneral.posts.length; i++){
          if(blocGeneral.posts[i]["_id"]==entity["entity"]["_id"]){
            blocGeneral.posts[i] = entity["entity"];
            blocGeneral.posts.replaceRange(i, blocGeneral.posts.length, blocGeneral.posts);
            blocGeneral.changePosts(blocGeneral.posts);
            break;
          }
        }

        
      }
    });

  }








  getUserEmiter(String email){  
        this._socket.emit('get-user', {'email': email});
  }

  addEntityToHome(dynamic entity){  
        this._socket.emit('addEntityToHome', {'entity': entity});
  }

  addEntityToPosts(dynamic entity){  
        this._socket.emit('addEntityToPosts', {'entity': entity});
        return;
  }

  deleteOrUpdateEntityToPosts(dynamic entity){  
        this._socket.emit('deleteOrUpdateEntityToPosts', {'entity': entity});
  }

}
