// @dart=2.9
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/sub_comments/sub_comments.dart';
import 'package:maando/src/services/toast.dart';
import 'package:maando/src/utils/admins.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/notifications_text.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/action_sheet/action_sheet_post.dart';
import 'package:platform_action_sheet/platform_action_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class Comment extends StatefulWidget {

  final dynamic comment;

  Comment({@required this.comment});


  @override
  _CommentState createState() => _CommentState();
}

class _CommentState extends State<Comment> {

  Http _http = Http();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive responsive = Responsive.of(context);
    final bloc = ProviderApp.ofPost(context);

    String phoneWhatsApps = '';

    blocGeneral.aiportsOrigin.forEach((country) {
      if (widget.comment["user"]["country"] == country["name"]) {
        phoneWhatsApps = '+${country["indicative-code"]}${widget.comment["user"]["phone"]}';
      }
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        GestureDetector(
          onLongPress: (){
              ActionSheetPost(context: context,listActions: _listaAcciones(context, bloc, height, width, responsive)).sheetHeader();
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.008),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color.fromRGBO(173, 181, 189, 0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    width: MediaQuery.of(context).size.width * 0.07,
                    height: MediaQuery.of(context).size.width * 0.08,
                    margin: EdgeInsets.only(top: height * 0.015, left: MediaQuery.of(context).size.width * 0.02),
                    child: CircleAvatar(
                                child: (widget.comment["user"]["avatar"] == null || widget.comment["user"]["avatar"] == '')
                                ? Text(widget.comment["user"]["name"].substring(0, 2).toUpperCase(), style: TextStyle(
                                            fontSize: responsive.ip(2),
                                            // height: 1.6,
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.start,
                                      )
                                : Container(),
                                backgroundImage: NetworkImage(widget.comment["user"]["avatar"]),
                              ),
                ),
                Container(
                    width: width * 0.7,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.01),
                    margin: EdgeInsets.only(left:  width * 0.015, top: height * 0.01),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         SizedBox(height: height * 0.01),
                         CupertinoButton(
                           padding: EdgeInsets.all(0),
                           minSize: 0,
                           onPressed: validateAdmin.isAdmin(preference.prefsInternal.get('email'))
                                ? () async {
                                  String message = "";
                                  String url;
                                  if (Platform.isIOS) {
                                    url =
                                        "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                                    await canLaunch(url)
                                        ? launch(url)
                                        : print('Error al enviar mensaje de WhatsApps');
                                  } else {
                                    url =
                                            "whatsapp://send?phone=$phoneWhatsApps&text=${Uri.encodeFull(message)}";
                                        await canLaunch(url)
                                            ? launch(url)
                                            : print('Error al enviar mensaje de WhatsApps');
                                      }
                                } : null,
                               child: Text(widget.comment["user"]["name"],
                                style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(0, 0, 0, 1.0),
                                        fontSize: responsive.ip(1.8))),
                         ),
                         Text('${obtenerTiempoDePublicacion(widget.comment["created_on"])["number"]} ${obtenerTiempoDePublicacion(widget.comment["created_on"])["time"]}',
                              style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: responsive.ip(1.8))),
                        SizedBox(height: height * 0.005),
                         Container(
                           child: Text(widget.comment["body"],
                                    style: TextStyle(
                                            fontWeight: FontWeight.w200,
                                            fontSize: responsive.ip(1.6))),
                         ),
                         SizedBox(height: height * 0.02),
                       ],
                     )
                  ),
                
              ],
            ),
          ),
        ),
        FutureBuilder(
          future: Http().getSubComments(
            context: context,
            email: preference.prefsInternal.getString('email'),
            postId: widget.comment["post"]["_id"]
            ),
          builder: (BuildContext context, AsyncSnapshot snapshotSubComments){
            if(snapshotSubComments.hasData){
              final valueMap = json.decode(snapshotSubComments.data);

              if(valueMap["ok"]==true){
                List<Widget> listSubCommentsWidget = [];
                for(var sc in valueMap["subComments"]){
                  if(sc["comment"]["_id"] == widget.comment["_id"]){
                     listSubCommentsWidget.add(SubComment(subComment: sc));
                  }
                }
                return Column(
                  children: listSubCommentsWidget
                );
              }else{
                return Container();
              }
            }else if(snapshotSubComments.hasError){
              return Container(
                        child: Center(
                          child: Text(
                            'Error loading data',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
            }else{
              return Container();
            }
          }
        ),
      ],
    );
  }





  // *************************
List<ActionSheetAction> _listaAcciones(BuildContext context, PostBloc bloc, double height, double width, Responsive responsive){

    final preference = Preferencias();

      return (
        preference.prefsInternal.get('email') == widget.comment["user"]["email"]||
        preference.prefsInternal.get('email') == 'davgui242011@gmail.com' ||
        preference.prefsInternal.get('email') == 'david@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'david@maando.com' ||
        preference.prefsInternal.get('email') == 'jdv@maando.com' ||
        preference.prefsInternal.get('email') == 'jdv@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'friends@maando.com' ||
        preference.prefsInternal.get('email') == 'rosanna@maando.com' ||
        preference.prefsInternal.get('email') == 'daniel@maando.com' ||
        preference.prefsInternal.get('email') == 'alia@maando.com' ||
        preference.prefsInternal.get('email') == 'milan@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'renzo@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'marcela@maando.com' ||
        preference.prefsInternal.get('email') == 'carolina@jdvgroup.co' ||
        preference.prefsInternal.get('email') == 'info@jdvgroup.co'
        ) 
      ?  [
         ActionSheetAction(
            text: generalText.comment(),
            defaultAction: true,
            onPressed: (){
              Navigator.pop(context);
              showDialog(context:context,
              builder: (context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                            content: Container(
                              height: height * 0.35,
                              width: width * 0.25,
                              child: Column(
                                children: [
                                  Container(
                                    height: 20.0,
                                    child:
                                    Row(
                                      children: [
                                        Container(
                                          child: Container(
                                            height: 20.0,
                                            width: 20.0,
                                            child: Container(
                                              width: MediaQuery.of(context).size.height * 0.03,
                                              height: MediaQuery.of(context).size.height * 0.03,
                                              padding: EdgeInsetsDirectional.only(top: 0.0),
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: AssetImage('assets/images/close/close button 1.png'),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                              child: CupertinoButton(
                                                  child: Container(),
                                                  onPressed: () => {
                                                  // blocNavigator.servicePrincipal(),
                                                    Navigator.pop(context)
                                                  }),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Center(
                                              child: Container(
                                              height: 20.0,
                                              width: 20.0,
                                              margin: EdgeInsets.only(right: 20.0),
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(image:AssetImage('assets/images/face_1/icono1.png'))
                                              ),
                                            ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 15.0),
                                    child: TextField(
                                      textInputAction: TextInputAction.go,
                                      maxLines: null,
                                      maxLength: 200,
                                      decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: postText.shareYourThoughts(),
                                          hintStyle: TextStyle(
                                              color: Colors.grey
                                          )
                                      ),
                                      onChanged: (value) => {
                                        bloc.changeSubComment(value)
                                      }),
                                    ),
                                  
                              Expanded(
                                child: Container(),
                              ),
                              Container(
                                  alignment: Alignment.bottomCenter,
                                  height: 40.0,
                                  child: RaisedButton(
                                    onPressed: //snapshot.hasData ?
                                        (){
                                      if(bloc.subComment.trim().length <= 0) return;
                                            
                                            Navigator.pop(context);
                                            _http.postCreateSubComment(
                                                context: context,
                                                email: preference.prefsInternal.get('email'),
                                                postId: widget.comment["post"]["_id"],
                                                commentId: widget.comment["_id"],
                                                body: bloc.subComment.trim()).then((value) {
                                                bloc.changeSubComment('');  
                                              if(json.decode(value)["ok"] == true){
                                                
                                                // var emailPost = widget.comment['user']['email'];
                                                // var emailComment = widget.comment["post"]['user']['email'];

                                                // Http().notificationOneToken(context: context, email: widget.comment["post"]["user"]["email"], title: notificationText.maandoUpdate(), body: notificationText.nnewCommentHasBeenAddedToYourPost(bloc.subComment.trim()), data: {'datos': 'Aqui van los datos'});
                                                // Http().notificationOneToken(context: context, email: widget.comment["comment"]["user"]["email"], title: notificationText.maandoUpdate(), body: notificationText.nnewCommentHasBeenAddedToYourPost(bloc.subComment.trim()), data: {'datos': 'Aqui van los datos'});
                                                bloc.changeSubComment('');
                                                setState(() {
                                                  
                                                });
                                                // blocSocket.socket.addEntityToPosts(json.decode(value)
                                                return;
                                              }else{

                                              }
                                            });
                                        },
                                    child: Container(

                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(postText.publish(),
                                              style: TextStyle(
                                                color: Color.fromRGBO(255, 206, 6, 1),
                                                fontSize: responsive.ip(2)
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
                                ),

                                ],
                              ),
                            )
                        );
          });
 
            },
            hasArrow: true,
        ),
        ActionSheetAction(
            text: generalText.delete(),
            defaultAction: true,
            onPressed: (){
              FocusScope.of(context).requestFocus(new FocusNode());
                Navigator.pop(context);
                _http.deleteComment(context: context, email: preference.prefsInternal.get('email'), postId: widget.comment["post"]["_id"], commentId: widget.comment["_id"])
                .then((value){
                  if(json.decode(value)["ok"] == true){
                    if(preference.prefsInternal.get('email') != widget.comment["user"]["email"]) _http.notificationOneToken(context: context, email: widget.comment["user"]["email"], title: notificationText.maandoUpdate(), body: notificationText.yourMessageHasBeenDeletedByTheMaandoTeam(), data: {'datos': 'Aqui van los datos'});
                    final commentBlocAux = blocGeneral.comments;
                    commentBlocAux.removeWhere((item) => item["_id"] == widget.comment["_id"]);
                    blocGeneral.changeComments(commentBlocAux);
                  }
                });
            },
            hasArrow: true,
        ),
        ActionSheetAction(
            text: generalText.copy(),
            defaultAction: true,
            onPressed: (){
                Clipboard.setData(new ClipboardData(text: widget.comment["body"]))
                .then((_){
                   toastService.showToastCenter(context: context, text: generalText.copied(), durationSeconds: 4);
                  Navigator.pop(context);
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
                Clipboard.setData(new ClipboardData(text: widget.comment["body"]))
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
