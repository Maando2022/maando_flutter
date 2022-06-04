// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/chat_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/comments/comment.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notifications_text.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_post.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:maando/src/widgets/loading/loading.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:url_launcher/url_launcher.dart';

class Post extends StatefulWidget {
  final String postId;
  final String emailUser;
  final String img;
  final String name;
  final String phoneWhatsApps;
  final String date;
  final String content;

  Post({
    @required this.postId, 
    @required this.emailUser, 
    @required this.img, 
    @required this.name, 
    @required this.phoneWhatsApps, 
    @required this.date, 
    @required this.content});

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {

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
                _cabecera(bloc, responsive),
                SizedBox(height: height * 0.01,),
                Text(widget.content,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: responsive.ip(2)),
                ),
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
                _cabecera(bloc, responsive),
                SizedBox(height: height * 0.02,),
                Text(
                  shortString(widget.content, 100),
                  textAlign: TextAlign.start,
                   style: TextStyle(
                          color: Color.fromRGBO(173, 181, 189, 1),
                          fontWeight: FontWeight.w100,
                          fontSize: responsive.ip(2)),
                ),
                           SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              _formComment(context, responsive),
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
                            child: (widget.img == null || widget.img == '')
                            ? Text(widget.name.substring(0, 2).toUpperCase(), 
                            style: TextStyle(
                                      fontSize: responsive.ip(2),
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.start,
                                )
                            : Container(),
                            backgroundImage: NetworkImage((widget.img == null || widget.img == '') ? 'https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Fbackground_void.jpg?alt=media&token=69026fb3-874c-4068-9596-9e79abfeba00' : widget.img),
                          )
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.04,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       CupertinoButton(
                         padding: EdgeInsets.all(0),
                         minSize: 0,
                         onPressed: validateAdmin.isAdmin(preference.prefsInternal.get('email'))
                         ? () async {
                                  // FlutterOpenWhatsapp.sendSingleMessage(phoneWhatsApps, "${generalText.myNameIs()} ${preference.prefsInternal.get('fullName')}");
                                  String message = "";
                                  String url;
                                  if (Platform.isIOS) {
                                    url =
                                        "whatsapp://send?phone=${widget.phoneWhatsApps}&text=${Uri.encodeFull(message)}";
                                    await canLaunch(url)
                                        ? launch(url)
                                        : print('Error al enviar mensaje de WhatsApps');
                                  } else {
                                    url =
                                        "whatsapp://send?phone=${widget.phoneWhatsApps}&text=${Uri.encodeFull(message)}";
                                    await canLaunch(url)
                                        ? launch(url)
                                        : print('Error al enviar mensaje de WhatsApps');
                                  }
                                } : null,
                            child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            child: Text(
                              widget.name,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                    color: Color.fromRGBO(0, 0, 0, 1.0),
                                    fontWeight: FontWeight.bold,
                                    fontSize: responsive.ip(1.8))
                             ),
                          ),
                       ),
                       _validarAdminAdFounder(responsive),
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
                  if(l["user"]["email"] == prefsInternal.prefsInternal.get('email')){
                    myLike = true;
                    reaction = l;
                    break;
                  }
                }
              for(var l in valueMap["reactions"]){
                  if(l["post"]["_id"] == widget.postId){
                    reaction = l;
                    break;
                  }
              }
              for(var l in valueMap["reactions"]){
                if(l["post"]["_id"] == widget.postId){
                   likesOfPost.add(l);
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
                    textInputAction: TextInputAction.go,
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
                  showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                  controladorComment.text = '';
                    controladorComment.clear();
                      _http.postCreateComment(context: context, email: preference.prefsInternal.get('email'), postId: widget.postId, body: comment.trim())
                      .then((value){
                        comment = '';
                        Navigator.pop(context);
                        if(json.decode(value)["ok"] == true){
                          Http().notificationOneToken(context: context, email: widget.emailUser, title: preference.prefsInternal.get('email'), body: notificationText.nnewCommentHasBeenAddedToYourPost(comment.trim()), data: {'datos': 'Aqui van los datos'});
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
      return (
        preference.prefsInternal.getString('email') == widget.emailUser || validateAdmin.isAdmin(preference.prefsInternal.getString('email')) == true)
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
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                blocGeneral.changeOrderBy('daterange');
                _http.postDelete(context: context, email: preference.prefsInternal.get('email'), postId: widget.postId)
                .then((value){
                  // print('>>>>>>>>>>>>>>>> $value');
                  Navigator.pop(context);
                  Navigator.pop(context);
                  if(json.decode(value)["ok"] == true){
                    if(preference.prefsInternal.get('email') != widget.emailUser) _http.notificationOneToken(context: context, email: widget.emailUser, title: notificationText.maandoUpdate(), body: notificationText.yourMessageHasBeenDeletedByTheMaandoTeam(), data: {'datos': 'Aqui van los datos'});
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

 Widget _validarAdminAdFounder(Responsive responsive){
   if(widget.emailUser == 'alia@maando.com' || 
        widget.emailUser == 'jdv@maando.com' || 
        widget.emailUser == 'jdv@jdvgroup.co'){
     return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                adminText.founder(),
                textAlign: TextAlign.start,
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(1.8))
                ),
            );
   }else if(widget.emailUser == 'david@jdvgroup.co' || 
      widget.emailUser == 'david@jdvgroup.co' || 
      widget.emailUser == 'david@maando.com' || 
      widget.emailUser == 'friends@maando.com' ||
      widget.emailUser == 'rosanna@maando.com' ||
      widget.emailUser == 'daniel@maando.com' ||
      widget.emailUser == 'milan@jdvgroup.co' ||
      widget.emailUser == 'renzo@jdvgroup.co' ||
      widget.emailUser == 'carolina@jdvgroup.co' ||
      widget.emailUser == 'alex@maando.com' ||
      widget.emailUser == 'caro@jdvgroup.co' ||
      widget.emailUser == 'info@jdvgroup.co' 
   ){
     return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Text(
                adminText.teamMaando(),
                textAlign: TextAlign.start,
                style: TextStyle(
                      color: Color.fromRGBO(173, 181, 189, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: responsive.ip(1.8))
                ),
            );
   }else{
     return Container();
   }
 }

}