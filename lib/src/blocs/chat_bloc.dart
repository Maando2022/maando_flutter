// @dart=2.9
import 'dart:async';
import 'package:dash_chat/dash_chat.dart';
import 'package:rxdart/rxdart.dart';

class ChatBloc {

  var _chatsController = BehaviorSubject<List<ChatMessage>>();
  var _chatController= BehaviorSubject<ChatMessage>();
  var _emailDestinyController= BehaviorSubject<String>();
  var _fullNameDestinyController= BehaviorSubject<String>();
  var _avatarDestinyController= BehaviorSubject<String>();

  Function(List<ChatMessage>) get changeChats => _chatsController.sink.add;
  Function(ChatMessage) get changeChat => _chatController.sink.add;
  Function(String) get changeEmailDestiny => _emailDestinyController.sink.add;
  Function(String) get changeFullNameDestiny => _fullNameDestinyController.sink.add;
  Function(String) get changeAvatarDestiny=> _avatarDestinyController.sink.add;

  List<ChatMessage> get chats => _chatsController.value;
  ChatMessage get chat => _chatController.value;
  String get emailDestiny => _emailDestinyController.value;
  String get fullNameDestiny => _fullNameDestinyController.value;
  String get avatarDestiny => _avatarDestinyController.value;


  Stream<List<ChatMessage>> get chatsStream => _chatsController.stream;
  Stream<ChatMessage> get chatStream => _chatController.stream;
  Stream<String> get emailDestinyStream => _emailDestinyController.stream;
  Stream<String> get fullNameDestinyStream => _fullNameDestinyController.stream;
  Stream<String> get avatarDestinyStream => _avatarDestinyController.stream;

  

  streamNull(){
     _chatsController = BehaviorSubject<List<ChatMessage>>();
     _chatController= BehaviorSubject<ChatMessage>();
     _emailDestinyController= BehaviorSubject<String>();
     _fullNameDestinyController= BehaviorSubject<String>();
     _avatarDestinyController= BehaviorSubject<String>();
  }

  dispose() {
    _chatsController?.close();
    _chatController?.close();
    _emailDestinyController?.close();
    _fullNameDestinyController?.close();
    _avatarDestinyController?.close();
  }
}

ChatBloc blocChat = ChatBloc();
