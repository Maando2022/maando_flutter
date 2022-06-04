// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/comments/comment.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_post.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:maando/src/utils/responsive.dart';

class PostToAdmin extends StatefulWidget {
  final String postId;
  final String emailUser;
  final String date;
  final String content;

  PostToAdmin({@required this.postId, @required this.emailUser, @required this.date, @required this.content});

  @override
  _PostToAdminState createState() => _PostToAdminState();
}

class _PostToAdminState extends State<PostToAdmin> {

bool verMas = false;
 bool viewComments = false;
Http _http = Http();
final preference = Preferencias();
List<Widget> commets;
TextEditingController controladorComment = TextEditingController();
String comment = '';


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _http.getComments(context: context, email: preference.prefsInternal.get('email'))
      .then((value) {
        if(json.decode(value)["ok"]){
          blocGeneral.changeComments(json.decode(value)["comments"]);
        }else{

        }
      });

  }


  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofPost(context);
    

     return Container(
     margin: EdgeInsets.symmetric(horizontal: variableGlobal.margenPageWithFlight(context), vertical: MediaQuery.of(context).size.height * 0.01),
    padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.03, vertical: MediaQuery.of(context).size.height * 0.013),
    decoration: BoxDecoration(
      color: Color.fromRGBO(255, 255, 255, 1),
     borderRadius: BorderRadius.circular(4.0),),
     child: Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
     
      //  ****** EL CUERPO DE LA PUBLICACION
       Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.83,
              child: 
             (verMas == true) 
            ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: responsive.ip(2)),
                ),
                SizedBox(height: height * 0.01,),
                _cabecera(bloc, responsive),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                    StreamBuilder(
                    stream: blocGeneral.commetsStream,
                    // ignore: missing_return
                    builder: (BuildContext context, snapshot) {

                      if(snapshot.hasData){
                      
                        List<dynamic> listCommentsOfPost = [];
                        

                        for(var c in snapshot.data){
                          if(c["post"]["_id"] == widget.postId){
                            listCommentsOfPost.add(c);
                          }
                        }

                       return CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed:
                          (listCommentsOfPost.length <= 0) ? 
                          null : 
                          () {
                            setState(() {viewComments = !viewComments; });
                          },
                          child: Container(
                              width: width * 0.3,
                              child: Row(
                                children: [
                                  Text(
                                    "${listCommentsOfPost.length} ${postText.replies()}",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                          color: Color.fromRGBO(0, 0, 0, 1.0),
                                          fontWeight: FontWeight.w600,
                                          fontSize: responsive.ip(1.5))
                                  ),
                                  SizedBox(width: width * 0.01,),
                                  (listCommentsOfPost.length <= 0) ? Container() :(viewComments == true) ? arrawup(context) : arrawdown(context)
                                ],
                              ),
                            ),
                          );
                      }else if(snapshot.hasError){
                        return Container();
                      }else{
                        return Text(
                          " ...",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.w100,
                                fontSize: responsive.ip(1.8))
                        );
                      }
                    }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                          _likeAndDislike(responsive, height, width),
                      CupertinoButton(
                          padding: EdgeInsets.all(0),
                          onPressed: (){
                            setState(() {
                              verMas = !verMas;
                             });
                          },
                          child: 
                          textExpanded(postText.readLees(), width * 0.2, width * 0.038, Colors.blue)
                        ),
                      ],
                    ),
                    ],
                  ),
                ),
              ],
            )
            : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  shortString(widget.content, 100),
                  textAlign: TextAlign.start,
                   style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: responsive.ip(2)),
                ),
                SizedBox(height: height * 0.02,),
                _cabecera(bloc, responsive),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  StreamBuilder(
                    stream: blocGeneral.commetsStream,
                    builder: (BuildContext context, snapshot) {

                      if(snapshot.hasData){
                      
                        List<dynamic> listCommentsOfPost = [];

                        for(var c in snapshot.data){
                          if(c["post"]["_id"] == widget.postId){
                            listCommentsOfPost.add(c);
                          }
                        }

                    return CupertinoButton(
                            padding: EdgeInsets.all(0),
                            onPressed: (listCommentsOfPost.length <= 0) ? 
                            null : 
                            (){
                              setState(() {viewComments = !viewComments; });
                            },
                            child: Container(
                                width: width * 0.3,
                                child: Row(
                                  children: [
                                    Text(
                                      "${listCommentsOfPost.length}  ${postText.replies()}",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                            color: Color.fromRGBO(0, 0, 0, 1.0),
                                            fontWeight: FontWeight.w400,
                                            fontSize: responsive.ip(1.5))
                                    ),
                                     SizedBox(width: width * 0.01,),
                                (listCommentsOfPost.length <= 0) ? Container() :  (viewComments == true) ? arrawup(context) : arrawdown(context)
                                  ],
                                ),
                              ),
                            );
           
                      }else if(snapshot.hasError){
                        return Container();
                      }else{
                        return Text(
                          " ...",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 1.0),
                                fontWeight: FontWeight.bold,
                                fontSize: responsive.ip(1.8))
                        );
                      }
                    }),
                    Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                            _likeAndDislike(responsive, height, width),
                            (widget.content.length <= 100) ? 
                            textExpanded('', width * 0.2, width * 0.038, Colors.blue) :
                            CupertinoButton(
                                padding: EdgeInsets.all(0),
                                onPressed: (){
                                  setState(() {
                                    verMas = !verMas;
                                  });
                                },
                                child: textExpanded(postText.readMore(), width * 0.2, responsive.ip(1.5), Colors.blue)
                              ),
                       ],
                    ),
                    ],
                  ),
                )
              ],
             )
           ),
          ],
        ), 

       SizedBox(height: MediaQuery.of(context).size.height * 0.01,),         
        // *************************************  LOS COMENTARIOS
         (viewComments == true) 
         ? 
         StreamBuilder(
            stream: blocGeneral.commetsStream,
            // ignore: missing_return
            builder: (BuildContext context, snapshot) {

              if(snapshot.hasData){
                commets = [];
                for(var c in snapshot.data){
                  if(c["post"]["_id"] == widget.postId){
                    // listCommentsOfPost.add(c);
                    commets.add(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Comment(comment: c),
                        ],
                      )
                    );
                  }
                }


             return Column(
                children: commets,
              );
              }else if(snapshot.hasError){
                return Container();
              }else{
                return Text(
                  " ...",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                        color: Color.fromRGBO(0, 0, 0, 1.0),
                        fontWeight: FontWeight.bold,
                        fontSize: responsive.ip(1.8))
                );
              }
          
          }) : Container()
       ],
     ),
  );
  }

  Widget _cabecera(PostBloc bloc, Responsive responsive) {
    String img = "https://m.youtube.com/channel/UCl6xpgyegfR3P2BNYFa1DCw";
    return Stack(
      children: [
        Column(
          children: [
            Row(
                   children: [
                    Container(
                        width: MediaQuery.of(context).size.width * 0.1,
                        height: MediaQuery.of(context).size.width * 0.1,
                        child: CircleAvatar(
                            child: Container(),
                            backgroundImage: NetworkImage(img),
                          )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                      //  Container(
                      //     width: MediaQuery.of(context).size.width * 0.6,
                      //     child: Text(
                      //       widget.name,
                      //       textAlign: TextAlign.start,
                      //       style: TextStyle(
                      //             color: Color.fromRGBO(0, 0, 0, 1.0),
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: responsive.ip(1.8))
                      //      ),
                      //   ),
                       Container(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Text(
                            widget.date,
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                  color: Color.fromRGBO(173, 181, 189, 1),
                                  fontWeight: FontWeight.w100,
                                  fontSize: responsive.ip(1.5))
                           ),
                        ),
                  ],
                ),
                 ],
               ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _formComment(context, responsive)
          ],
        ),
           Positioned(
             top: MediaQuery.of(context).size.height * 0.017,
             right: 0,
             child: botonTresPuntosGrises(
               context, 
               MediaQuery.of(context).size.width * 0.06, (){
                 ActionSheetPost(context: context,listActions: _listaAcciones(context, bloc)).sheetHeader();
               }
           )
        ),
      ],
    );
  }

// *********************


Widget _likeAndDislike(Responsive responsive, double height, double width){

  return FutureBuilder<dynamic>(
      future: _http.getReactions(context: context, email: preference.prefsInternal.get('email')),
      builder: (BuildContext context, snapshot) {

        if(snapshot.hasData){
           final valueMap = json.decode(snapshot.data);
        
           bool myLike = false;
           dynamic reaction;
           List likesOfPost = [];
      
            if(valueMap["ok"] == true){
              

              for(var l in valueMap["reactions"]){
                  if(l["post"]["_id"] == widget.postId){
                    myLike = true;
                    reaction = l;
                    likesOfPost.add(l);
                    break;
                  }
                }


                return Container(
                  width: width * 0.13,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                        // ******  BOTONES DE LIKE
                        (myLike==true) ?
                        CupertinoButton(
                          onPressed: (){
                            if(widget.emailUser == preference.prefsInternal.get('email')){
                              return;
                            }
                             _http.deleteReaction(
                               context: context, 
                              email: preference.prefsInternal.get('email'),
                              reactionId: reaction["_id"]).then((value){
                                setState(() {});
                              }); 
                          },
                          padding: EdgeInsets.all(0),
                          minSize: 0,
                          child: Container(
                              width: width * 0.06,
                              height: width * 0.06,
                              // color: Colors.yellow,
                              child: Image.asset(
                                  'assets/images/post/like@3x.png',
                                  fit: BoxFit.contain,)
                              ),
                        ) : 
                        CupertinoButton(
                          onPressed: (){
                            if(widget.emailUser == preference.prefsInternal.get('email')){
                              return;
                            }
                            _http.createReaccion(
                              context: context, 
                              email: preference.prefsInternal.get('email'),
                              postId: widget.postId,
                              reaccionType: 1,
                              reaccionActive: true,
                              reaccionA: 1).then((value){
                                
                                setState(() {});
                              });   
                          },
                          padding: EdgeInsets.all(0),
                          minSize: 0,
                          child: Container(
                              width: width * 0.06,
                              height: width * 0.06,
                              // color: Colors.yellow,
                              child: Image.asset(
                                  'assets/images/post/like@3x.png',
                                  fit: BoxFit.contain,)
                              ),
                        ),
                        SizedBox(width: width * 0.015),
                        Text('${likesOfPost.length}',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1.0),
                                  fontWeight: FontWeight.w500,
                                  fontSize: responsive.ip(2))
                      ),
                    ],
                  ),
                );
            }else{
              return Container();
            }
        }else if(snapshot.hasError){
          return Container();
        }else{
          return Container(child: Text('...'),);
        }
       
      });

   }




  //  ********************************
 Widget _formComment(BuildContext context, Responsive responsive){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
      Container(
        height: (comment.trim().length <= 0) ? MediaQuery.of(context).size.height * 0.1 : MediaQuery.of(context).size.height * 0.18,
        width: MediaQuery.of(context).size.width * 0.68,
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
        decoration: BoxDecoration(
          color: Color.fromRGBO(173, 181, 189, 0.1),
          borderRadius: BorderRadius.circular(20)
        ),
        child: Form(
                child: TextFormField(
                  controller: controladorComment,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: responsive.ip(2)),
                    cursorColor: Colors.deepOrange,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    maxLength: 200,
                    decoration: InputDecoration(
                      counterText: "",
                      labelText: postText.replyToMessage(),
                      border: InputBorder.none,
                      labelStyle: TextStyle(
                          fontSize: responsive.ip(1.5),
                          fontWeight: FontWeight.w600,
                          color: Color.fromRGBO(173, 181, 189, 1)),
                    ),
                    onChanged: (value) {
                      setState(() {comment = value;});
                    },
                    onTap: () {
                      // text = '';
                    }),
              ),
      ),
        Container(
          child: CupertinoButton(
                onPressed: (controladorComment.text.length <= 0) ? 
                null 
                :
                 (){
                  if(comment.trim().length <= 0) return;
                  controladorComment.text = '';
                    controladorComment.clear();
                      showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                      _http.postCreateComment(context: context, email: preference.prefsInternal.get('email'), postId: widget.postId, body: comment.trim())
                      .then((value){
                        comment = '';
                        Navigator.pop(context);
                        if(json.decode(value)["ok"] == true){
                          final commetsBlocAux = blocGeneral.comments;
                          commetsBlocAux.insert(0, json.decode(value)["comment"]);
                          blocGeneral.changeComments(commetsBlocAux);
                        }
                      });
            },
            padding: EdgeInsets.all(0),
            child: (comment.trim().length <= 0) ? Container() : Icon(Icons.send, color: Color.fromRGBO(33, 36, 41, 1), size: MediaQuery.of(context).size.width * 0.08))
          )
      ],
    );
  }





List<ActionSheetAction> _listaAcciones(BuildContext context, PostBloc bloc){

    final preference = Preferencias();

      return (widget.emailUser == preference.prefsInternal.get('email')) 
      ? [
         ActionSheetAction(
            text: generalText.edit(),
            defaultAction: true,
            onPressed: (){
              bloc.changePost(widget.content);
                Navigator.pushNamed(context, 'create_post', arguments: json.encode({'content': widget.content, '_id': widget.postId}));
            },
            hasArrow: true,
          ),
        ActionSheetAction(
            text: generalText.copy(),
            defaultAction: true,
            onPressed: (){
                Clipboard.setData(new ClipboardData(text: widget.content))
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
            onPressed: (){
                blocGeneral.changeOrderBy('daterange');
                showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                _http.postDelete(context: context, email: preference.prefsInternal.get('email'), postId: widget.postId)
                .then((value){
                  // print(value);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if(json.decode(value)["ok"] == true){
                    final postBlocAux = blocGeneral.posts;
                    postBlocAux.removeWhere((item) => item["_id"] == widget.postId);
                    blocGeneral.changePosts(postBlocAux);
                  }
                });
            },
            hasArrow: true,
          ),
      ] :
      [
        ActionSheetAction(
            text: generalText.copy(),
            defaultAction: true,
            onPressed: (){
                Clipboard.setData(new ClipboardData(text: widget.content))
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