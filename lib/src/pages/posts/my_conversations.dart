import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/chat_bloc.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/hexa_color.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:photo_view/photo_view.dart';

class MyConversations extends StatelessWidget {
  // const MyConversations({Key? key}) : super(key: key);

  int countConversations = 10;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);
    
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
              title: Text(postText.myConversatiosn(),
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
                    SizedBox(height: height * 0.05),
                    FutureBuilder(
                      future: Http().myConversations(context: context, email: preference.prefsInternal.getString('email'), count: countConversations),
                      builder: (_, AsyncSnapshot snapshot){
                        if(snapshot.hasData){
                          final valueMap = json.decode(snapshot.data);
                          if(valueMap["ok"] == true){
                            List<Widget> listaConversaciones = [];
                            for(var c in valueMap["chats"]){
                              listaConversaciones.add(_conversation(context, height, width, responsive, c));
                            }
                           return Container(
                             height: height * 0.9,
                             child: SingleChildScrollView(
                               child: Column(
                                 children: listaConversaciones
                               ),
                             ),
                           );
                          }else{
                            return Container();
                          }
                        }else if(snapshot.hasError){
                            return Container();
                        }else{
                          return Container(
                            margin: EdgeInsets.only(top: height * 0.3),
                            child: Center(
                                child: CircularProgressIndicator()),
                          );
                        }
                      },
                    )
                  ],
                )
              )
              )
    );
  }

  Widget _conversation(BuildContext context, double height, double width, Responsive responsive, dynamic user){
    return CupertinoButton(
      onPressed: (){
        blocChat.changeEmailDestiny(user["email"]);
        blocChat.changeFullNameDestiny(user["fullName"]);
        blocChat.changeAvatarDestiny(user["avatar"]);
        Navigator.pushNamed(context, 'chat', arguments: user);
      },
      padding: EdgeInsets.all(0),
      minSize: 0,
      child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        _avatar(height, width, responsive, user),
                        Container(
                          child: Text(shortString(user['name'], 25),
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: responsive.ip(2.2))
                              ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }



   Widget _avatar(double height, double width, Responsive responsive, dynamic user){
      String avatar = (user["avatar"] == null || user["avatar"] == '') 
        ? "https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc"
        : user["avatar"];

    return Container(
      height: responsive.ip(8),
      width: responsive.ip(8),
      margin: EdgeInsets.all(responsive.ip(0.9)),
      decoration: BoxDecoration(
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
  
}