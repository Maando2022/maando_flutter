// @dart=2.9
import 'dart:convert';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';

class CreatePost extends StatefulWidget {

  @override
  _CreatePostState createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {


  Http _http = Http();
  dynamic post;
  TextEditingController controladorPost = TextEditingController();
  String content = '';


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofPost(context);
    bloc.changeAux('123456');

     post = json.decode(ModalRoute.of(context).settings.arguments);
      if(post != null && (bloc.post == null)){
       bloc.changePost(post["content"]);
     }


    return  Scaffold(
      backgroundColor: Color.fromRGBO(251, 251, 251, 1),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                _appBar(),
                SizedBox(height:  height * 0.02),
                _title(context, responsive),
                ],
              ),
              _crearPost(bloc, responsive),
              SizedBox(height:  height * 0.1),
            ],
          ),
          Positioned(
            top: variableGlobal.topNavigation(context),
            right:variableGlobal.margenPageWith(context),
            left: variableGlobal.margenPageWith(context),
              child: _buttonCreatePost(context, bloc, responsive)
            )
        ],
      )
    );
  }



  // **********************
  Widget _appBar(){
  return StreamBuilder<bool>(
        stream: blocGeneral.viewNavBarStream,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshoptNavBar) {
          if (snapshoptNavBar.hasError) {
            return Container();
          } else if (snapshoptNavBar.hasData) {
            if (snapshoptNavBar.data == true) {
              return Container(
                      margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context), right: variableGlobal.margenPageWith(context), top: variableGlobal.margenTopGeneral(context)),
                      child: Stack(
                        children: [
                          Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          iconFace1(context),
                        ],
                      ),
                          Center(
                              child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                closeCreatePost(context, 'assets/images/close/close button 1@3x.png'),
                              ],
                            ),
                          ])),
                        ],
                      )
                   );
            }else{
              return Container();
            }
          }else{
            return Container();
          }
        });
    }


  // ****************************************************
  Widget _title(BuildContext context, Responsive responsive){
    return Container(
        margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
      child: Text(postText.editPost(),
              style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(0, 0, 0, 1.0),
                      fontSize: responsive.ip(3.5))),
    );
  }



 bool _validarPost(PostBloc bloc) {
    bool validate = false;
    if (bloc.post == null) {
      validate = false;
    } else {
      if (bloc.post.length <= 0) {
        validate = false;
      } else {
        validate = true;
      }
    }
    return validate;
  }

  // *******************************************************************
  Widget _crearPost(PostBloc bloc, Responsive responsive) {

    String text = (_validarPost(bloc) == false) ? postText.shareYouyThoghts() : '';

    controladorPost.text = (_validarPost(bloc) == false) ? '' : bloc.post;
    controladorPost.selection = TextSelection.collapsed(offset: controladorPost.text.length);

      return StreamBuilder(
              stream: bloc.formValidarStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Container(
                      margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context), right: variableGlobal.margenPageWith(context)),
                        child: Form(
                          child: TextFormField(
                            controller: controladorPost,
                              style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.w400),
                              cursorColor: Colors.deepOrange,
                              keyboardType: TextInputType.multiline,
                              maxLines: 7,
                              maxLength: 200,
                              decoration: InputDecoration(
                                  labelText: text,
                                  border: InputBorder.none,
                                  labelStyle: TextStyle(
                                      fontSize: responsive.ip(2.5),
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromRGBO(173, 181, 189, 1)),
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                                      errorText: snapshot.error),
                                      
                              onChanged: (value) => {
                                    bloc.changePost(value),
                                    content = value
                                  },
                              onTap: () {
                              
                              }),
                        ),
                      );
        });
  }


   // ************************** BOTON DE IR A CREAR UN POST ****************************
Widget _buttonCreatePost(BuildContext context, PostBloc bloc, Responsive responsive){
  return StreamBuilder(
        stream: bloc.postStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Container(
      height: MediaQuery.of(context).size.height * 0.08,
          child: RaisedButton(
                      onPressed: snapshot.hasData ? (){
                        if(this.post == null){
                              if(bloc.post.trim().length <= 0) return;

                               showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});

                                _http.postCreate(
                                  context: context, 
                                  email: preference.prefsInternal.get('email'),
                                  body: bloc.post.trim(),
                                  title: 'Title').then((value) {
                                     Navigator.pop(context);
                                    if(json.decode(value)["ok"] == true){
                                      final postBlocAux = blocGeneral.posts;
                                      postBlocAux.insert(0, json.decode(value)["newPost"]);
                                      blocGeneral.changePosts(postBlocAux);
                                      bloc.changePost('');
                                      Navigator.pushNamed(context, 'post');
                                    }
                                  });
                        }else{
                            if(bloc.post.trim().length <= 0) return;
                            showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                           _http.postUpdate(context: context, email: preference.prefsInternal.get('email'), postId: this.post["_id"], content: content.trim())
                            .then((value){
                              Navigator.pop(context);

                              if(json.decode(value)["ok"] == true){
                                final postBlocAux = blocGeneral.posts;
                                    for(var p in postBlocAux){
                                      if(p["_id"] == this.post["_id"]){
                                        p["body"] = content.trim();
                                        break;
                                      }
                                    }
                                blocGeneral.changePosts(postBlocAux);
                                bloc.changePost('');
                                blocSocket.socket.deleteOrUpdateEntityToPosts(json.decode(value)["post"]); // enviamos un socket para que actualize el post en los demas dispositivos
                                Navigator.pushReplacementNamed(context, 'post');
                              }
                            });
                        }

                      } : null,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(postText.edit(),
                                style: TextStyle(
                                  color: Color.fromRGBO(255, 206, 6, 1),
                                  fontSize: responsive.ip(2.5),
                                  fontWeight: FontWeight.bold,
                                )),
                            // page1(context)
                          ],
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          side: BorderSide(color: Colors.black, width: 0.5)),
                      // elevation: 5.0,
                      color: Color.fromRGBO(33, 36, 41, 1.0),
                      textColor: Colors.white,
                    ),
            );
        });
   }

}