// https://pub.dev/packages/dash_chat/example

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dash_chat/dash_chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/chat_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/services/cloud_stotage.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/push_notificatios.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/hexa_color.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notifications_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_chat.dart';
import 'package:maando/src/widgets/loading/error.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:photo_view/photo_view.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:uuid/uuid.dart';

class Chat extends StatefulWidget {
  // const Chat({Key? key}) : super(key: key);
  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  final GlobalKey<DashChatState> _chatViewKey = GlobalKey<DashChatState>();

  late ChatUser miUsuario;

  late ChatUser otroUsuario ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


  miUsuario = ChatUser(
    name: blocSocket.user["fullName"],
    uid: preference.prefsInternal.get('email') as String,
    avatar: blocSocket.user["avatar"],
  );
  otroUsuario = ChatUser(
    name: blocChat.fullNameDestiny,
    uid: blocChat.emailDestiny,
    avatar: blocChat.avatarDestiny,
  );

    Http().listMyChats(context: context, emailEmiter: preference.prefsInternal.get('email') as String, emailDestiny: blocChat.emailDestiny)
      .then((value){
        final valueMap = json.decode(value);
        if(valueMap["ok"] == true){
          List<ChatMessage> listMessages = [];
          for(var m in valueMap["misChats"]){
             listMessages.add(ChatMessage(
              text: m["body"],
              id: m["_id"],
              // createdAt: convertirStringToDateTime(m["created_on"].toString()),
              createdAt: convertirMilliSecondsToDateTime(int.parse(m["created_on"])),
              user: (m["userEmit"]["email"] == preference.prefsInternal.get('email')) ? miUsuario : otroUsuario,
              image: (m["image"] == '' || m["image"] == null) ? null : m["image"]
            ));
          }
          blocChat.changeChats(listMessages);
        }else{
          blocChat.changeChats([]);
        }
      });
    
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);

    final user = ModalRoute.of(context)?.settings.arguments as dynamic;
    // print('USER DESTINO >>>> ${user["email"]}');

    return Scaffold(
            appBar: AppBar(
            toolbarHeight: height * 0.07,
            leading: IconButton(
                        icon: Icon(Icons.arrow_back, color: Colors.black,),
                        onPressed: () {
                          Navigator.pop(context);
                        }
                      ),
              centerTitle: true,
              title: Text(shortString(user['name'], 20),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: responsive.ip(3))
                    ),
              backgroundColor: Color.fromRGBO(255, 206, 6, 1),
              bottomOpacity: 0.0,
              elevation: 0.0,
              ),
      body: Container(
              height: height,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // _avatar(height, width, responsive, user),
                    SizedBox(height: height * 0.05),
                    _chats(height, width, responsive, user)
                  ],
                ),
              ),
            )
    );
  }

  Widget _avatar(double height, double width, Responsive responsive, dynamic user){
      String avatar = (user["avatar"] == null || user["avatar"] == '') 
        ? "https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc"
        : user["avatar"];

    return Container(
      height: responsive.ip(13),
      width: responsive.ip(13),
      decoration: BoxDecoration(
        border: Border.all(color: HexColor('#F2CB05'), width: responsive.ip(1)),
        borderRadius: BorderRadius.circular(200)
      ),
      child: CircleAvatar(
                  child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: avatar,
                          placeholder: (context, url) => FadeInImage(
                              image: NetworkImage(avatar),
                              placeholder:
                                  AssetImage('assets/images/general/jar-loading.gif'),
                              fit: BoxFit.contain,
                            ),
                          imageBuilder: (context, imageProvider) => PhotoView(
                            imageProvider: imageProvider,
                          )
                        ),
                    ),
                    backgroundColor: Colors.white,
                )
    );
  }

  Widget _chats(double height, double width, Responsive responsive, dynamic user){
    return StreamBuilder(
      stream: blocChat.chatsStream,
      builder: (_, AsyncSnapshot snapshot) {
        if(snapshot.hasData){
          return Container(
                      height: height * 0.8,
                      width: width * 0.9,
                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                      child: _chat(height, width, responsive)
                  );
        }else if(snapshot.hasError){
          return Container();
        }else{
          return Container(
                    margin: EdgeInsets.only(top: height * 0.3),
                    child: Center(
                        child: CircularProgressIndicator()),
                  );
        }
      }
    );
  }





  Widget _chat(double height, double width, Responsive responsive){
    return DashChat(
                key: _chatViewKey,
                inverted: false,
                onSend: onSend,
                sendOnEnter: true,
                textInputAction: TextInputAction.send,
                user: miUsuario,
                inputDecoration:
                    InputDecoration.collapsed(
                      hintText: ""
                    ),
                dateFormat: DateFormat('dd-MMM-yyyy'),
                timeFormat: DateFormat('HH:mm'),
                messages: blocChat.chats,
                showUserAvatar: true,
                showAvatarForEveryMessage: true,
                scrollToBottom: false,
                onPressAvatar: (ChatUser user) {
                  print("OnPressAvatar: ${user.name}");
                },
                onLongPressAvatar: (ChatUser user) {
                  print("OnLongPressAvatar: ${user.name}");
                },
                onLongPressMessage: (chatMessage)=>ActionSheetChat(context: context,listActions: _listaAcciones(context, chatMessage)).sheetHeader(),
                inputMaxLines: 5,
                messageContainerPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                alwaysShowSend: true,
                inputTextStyle: TextStyle(fontSize: 16.0, color: Colors.black),
                inputContainerStyle: BoxDecoration(
                  border: Border.all(width: 1.0, color: HexColor('#F2CB05')),
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                onQuickReply: (Reply reply) {
              
                  Timer(Duration(milliseconds: 300), () {
                    _chatViewKey.currentState!.scrollController
                      ..animateTo(
                        _chatViewKey.currentState!.scrollController.position
                            .maxScrollExtent,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );

                    if (i == 0) {
                      systemMessage();
                      Timer(Duration(milliseconds: 600), () {
                        systemMessage();
                      });
                    } else {
                      systemMessage();
                    }
                  });
                },
                onLoadEarlier: () {
                  print("laoding...");
                },
                shouldShowLoadEarlier: false,
                // messagePadding: EdgeInsets.all(responsive.ip(0.9)),
                // messageContainerDecoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(6),
                // ),
                showTraillingBeforeSend: true,
                // sendButtonBuilder: (message){
                //   return IconButton(
                //     icon: Icon(Icons.send, color: HexColor('#F2CB05')),
                //     onPressed: (){
                //         print(message);
                //     },
                //   );
                // },
                trailing: <Widget>[
                  IconButton(
                    icon: Icon(Icons.photo),
                    onPressed: _enviarChatConImagen,
                  )
                ],
              );
  }



   void onSend(ChatMessage message) {
    final id = Uuid().v4();
    message.user = miUsuario;
    message.id = id;
    Http().chatCreate(
      emailEmiter: preference.prefsInternal.getString('email'),
      emailDestinity: blocChat.emailDestiny,
      id: id,
      title: 'Title',
      image: '',
      body: message.text
    ).then((value){
      // print('>>>>>>>  RESPUESTA SERVIDOR ${value}');
      final valueMap = json.decode(value);
      if(valueMap["ok"] == true){
        blocChat.changeChats(blocChat.chats..add(message));
        Http().notificationOneToken(context: context, email: blocChat.emailDestiny, title: preference.prefsInternal.getString('fullName'), body: message.text, data: {'page': 'chat', 'arg': message.user.uid});
      }else{
        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
      }
    });
  }


  void _enviarChatConImagen() async {
    final _picker = ImagePicker();
                      final PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery,
                      imageQuality: 80,
                        maxHeight: 400,
                        maxWidth: 400,) as PickedFile;
                      if (pickedFile != null) {
                        final id = Uuid().v4();
                        showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                         firebaseStorage.subirImageChat(File(pickedFile.path), prefsInternal.prefsInternal.getString('email') as String, id, context)
                           .then((imgConfirmation){
                            //  print('imgConfirmation >>>>>>>>>  $imgConfirmation');
                             Future.delayed(Duration(seconds: 5),(){
                               firebaseStorage.obtenerImageChat(prefsInternal.prefsInternal.getString('email') as String, id)
                             .then((valueImage){
                              //  print('valueImage >>>>>>>>>  $valueImage');
                              //  CREAMOS EL MENSAJE
                              ChatMessage messageImage = ChatMessage(
                                  text: "",
                                  user: miUsuario,
                                  id: id,
                                  createdAt: DateTime.now(),
                                  image: valueImage,
                              );
                                  Http().chatCreate(
                                    emailEmiter: preference.prefsInternal.getString('email'),
                                    emailDestinity: blocChat.emailDestiny,
                                    id: id,
                                    title: 'Title',
                                    image: valueImage,
                                    body: messageImage.text
                                  ).then((value){
                                    Navigator.pop(context);
                                    // print('>>>>>>>  RESPUESTA SERVIDOR ${value}');
                                    final valueMap = json.decode(value);
                                    if(valueMap["ok"] == true){
                                      blocChat.changeChats(blocChat.chats..add(messageImage));
                                      Http().notificationOneToken(context: context, email: blocChat.emailDestiny, title: preference.prefsInternal.getString('fullName'), body: messageImage.text, data: {'page': 'chat', 'arg': messageImage.user.uid});
                                    }else{
                                      firebaseStorage.deleteChat(prefsInternal.prefsInternal.getString('email') as String, id);
                                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
                                    }
                                  });
                             });
                             });
                           });
                      }else{

                      }
  }


  int i = 0;
   void systemMessage() {
    Timer(Duration(milliseconds: 300), () {
      if (i < 6) {
        i++;
      }
      Timer(Duration(milliseconds: 300), () {
        _chatViewKey.currentState!.scrollController
          ..animateTo(
            _chatViewKey
                .currentState!.scrollController.position.maxScrollExtent,
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
          );
      });
    });
  }


    // *************************
  List<ActionSheetAction> _listaAcciones(BuildContext context, ChatMessage message) {
    if(validateAdmin.isAdmin(preference.prefsInternal.get('email') as String) == true && message.user.uid == preference.prefsInternal.get('email')){
      return [
        ActionSheetAction(
          text: generalText.copy(),
          defaultAction: true,
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: message.text))
              .then((_){
              toastService.showToastCenter(context: context, text: generalText.copied(), durationSeconds: 4);
              Navigator.pop(context);
            });
          },
          hasArrow: true,
        ),
        ActionSheetAction(
          text: generalText.delete(),
          defaultAction: true,
          onPressed: () {
            Navigator.pop(context);
            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
            Http().chatDelete(context: context, email: preference.prefsInternal.get('email') as String, id: message.id)
              .then((value){
                // print('RESPUESTA DEL SERVIDOR >>>>>>>>> $value');
                Navigator.pop(context);
                FocusScope.of(context).requestFocus(new FocusNode());
                final valueMap = json.decode(value);
                if(valueMap["ok"] == true){
                    final chatsBlocAux = blocChat.chats;
                    chatsBlocAux.removeWhere((item) => item.id == message.id);
                    blocChat.changeChats(chatsBlocAux);
                    Http().notificationOneToken(context: context, email: blocChat.emailDestiny, title: preference.prefsInternal.getString('fullName'), body: 'Chat removed', data: {'page': 'chat', 'arg': ''});
                  }else{
                    showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: true, builder: (BuildContext context){ return loadingError(context, valueMap["message"]);});
                  }
              });
          },
          hasArrow: true,
        ),
      ];
    }else{
      return [
        ActionSheetAction(
          text: generalText.copy(),
          defaultAction: true,
          onPressed: () {
            Clipboard.setData(new ClipboardData(text: message.text))
              .then((_){
              toastService.showToastCenter(context: context, text: generalText.copied(), durationSeconds: 4);
              Navigator.pop(context);
            });
          },
          hasArrow: true,
        ),
      ];
    }
  }
}