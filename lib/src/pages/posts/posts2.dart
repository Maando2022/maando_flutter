// @dart=2.9
import 'dart:async';
import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:maando/src/blocs/admin.dart';
import 'package:maando/src/blocs/chat_bloc.dart';
import 'package:maando/src/utils/config.dart';
import 'package:maando/src/utils/hexa_color.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/provider.dart';
import 'package:maando/src/pages/posts/post.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/utils/date.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/logout.dart';
import 'package:maando/src/utils/textos/admin_text.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/utils/textos/post_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/iconos.dart';
import 'package:flutter/widgets.dart';
import 'dart:ui';

import 'package:maando/src/widgets/loading/loading.dart';

class Posts2 extends StatefulWidget {
  @override
  _Posts2State createState() => _Posts2State();
}

class _Posts2State extends State<Posts2> {
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollControllerUsers = ScrollController();
  TextEditingController controladorSearchUser = TextEditingController();
  int cont = 20;
  int contUsers = 20;
  Http _http = Http();
  List<Post> listPosts;
  String searchInput = '';

  List<String> listOrder = [
    postText.descendingDate(),
    postText.dateRange(),
    postText.myPosts()
  ];
  List<String> listOrderValues = [
    'descending',
    'daterange',
    'myposts',
    'keyword'
  ];
  bool orderDeploy = false;
  dynamic orderByRequest;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    blocGeneral.changeViewNavBar(false);
       Future.delayed(Duration(milliseconds: 500), () {
          blocGeneral.changeViewNavBar(true);
        });
    // blocGeneral.orderBy == 'daterange'
    if (blocGeneral.orderByStreamValue == false || blocGeneral.orderBy == 'descending') {
      _http
          .postGetAll(
              context: context,
              email: preference.prefsInternal.get('email'),
              cont: cont)
          .then((posts) {
        final valueMap = json.decode(posts);
        // print('LOS POST  =====>>> ${valueMap}');
        if (valueMap['ok'] == false) {
        } else {
          blocGeneral.changePosts(valueMap["posts"]);
        }
      });
    } else if (blocGeneral.orderBy == 'daterange') {}

    // *********

    _scrollController
      ..addListener(() {
        blocGeneral.changeViewNavBar(false);
        Future.delayed(Duration(milliseconds: 500), () {
          blocGeneral.changeViewNavBar(true);
        });

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollController.offset >=
                _scrollController.position.maxScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta abajo

          if (blocGeneral.orderBy != 'descending') return;
          cont = cont + 20;
          _http
              .postGetAll(
                  context: context,
                  email: preference.prefsInternal.get('email'),
                  cont: cont)
              .then((home) {
            final valueMap = json.decode(home);
            // print('LOS POST  =====>>> ${valueMap}');
            if (valueMap['ok'] == false) {
              logout();
              Timer(Duration(milliseconds: 100), () {
                Navigator.pushReplacementNamed(context, 'login');
              });
            } else {
              blocGeneral.changePosts(valueMap["posts"]);
            }
          });
        }
        if (_scrollController.offset <=
                _scrollController.position.minScrollExtent &&
            !_scrollController.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });

//  OBTENER LO USUARIOS  *************
  _http.getUserAdmin(email: preference.prefsInternal.get('email'), cont: contUsers)
    .then((users) {
      final valueMap = json.decode(users);
      if (valueMap['ok'] == false) {
      } else {
        blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
        blocAdmin.changeUsers(valueMap["users"]);
      }
    });

    _scrollControllerUsers
      ..addListener(() {

        // Escuchar cuando llegue al scroll arriba y abajo
        if (_scrollControllerUsers.offset >=
                _scrollControllerUsers.position.maxScrollExtent &&
            !_scrollControllerUsers.position.outOfRange) {
          // cuando llega hasta abajo

          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
          contUsers = contUsers + 20;
          _http.getUserAdmin(
                  email: preference.prefsInternal.get('email'), cont: contUsers)
              .then((users) {
                 Navigator.pop(context);
            final valueMap = json.decode(users);
            if (valueMap['ok'] == false) {
            } else {
              blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
              blocAdmin.changeUsers(valueMap["users"]);
            }
          });
        }
        if (_scrollControllerUsers.offset <=
                _scrollControllerUsers.position.minScrollExtent &&
            !_scrollControllerUsers.position.outOfRange) {
          // cuando llega hasta arriba
        }
      });
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'post');
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);
    final bloc = ProviderApp.ofPost(context);
   
    
  
    return Scaffold(
        backgroundColor: Color.fromRGBO(251, 251, 251, 1),
        body: 
        Container(
          height:  double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: height * 0.14),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          _title(context, responsive),
                          // chatWithTheMaandoTeam(context, responsive)
                        ]),
                        SizedBox(height: height * 0.01),
                        _seachUser(responsive),
                        StreamBuilder(
                          stream: blocAdmin.usersStream,
                          builder: (BuildContext context, snapshotUser) {
                            if(snapshotUser.hasData){
                              List<Widget> listaUsuarios = [];

                              for(var u in snapshotUser.data){
                                listaUsuarios.add(_users(height, width, responsive, u));
                              }
                              return Container(
                                      margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                                      width: width,
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        controller: _scrollControllerUsers,
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: listaUsuarios,
                                        ),
                                      ),
                                    );
                            }else if (snapshotUser.hasError) {
                              return Center(
                                  child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('Error!!',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromRGBO(0, 0, 0, 1.0),
                                            fontSize: responsive.ip(3))),
                                  ],
                                ),
                              ));
                            } else {
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: width * 0.03),
                                child: Row(
                                  children: [
                                    _usersLoading(height, width, responsive),
                                    _usersLoading(height, width, responsive),
                                    _usersLoading(height, width, responsive),
                                    _usersLoading(height, width, responsive),
                                    _usersLoading(height, width, responsive),
                                  ],
                                ),
                              );
                            }
                          }
                        )
                      ],
                    ),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _inputSearch(responsive),
                        _orderBy(responsive),
                      ],
                    ),
                  _listPost(bloc)
                  ],
                ),
              ),
              _createPost(context, bloc, responsive),
                Container(
                  color: Color.fromRGBO(251, 251, 251, 1),
                  child: _appBar()),
            ],
          ),
        ));
  }

  // ****************************************************
  Widget _title(BuildContext context, Responsive responsive) {
    return Container(
      margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
      child: Text(postText.posts(),
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(0, 0, 0, 1.0),
              fontSize: responsive.ip(3.5)))
    );
  }

  Widget chatWithTheMaandoTeam(BuildContext context, Responsive responsive) {
    return GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, 'posts_to_admins');
          },
          child: Container(
            margin: EdgeInsets.only(right: variableGlobal.margenPageWith(context)),
            padding: EdgeInsets.all(responsive.wd(2)),
            decoration: BoxDecoration(
                        color: Color.fromRGBO(86, 194, 227, 1),
                        borderRadius: BorderRadius.circular(4.0)),
            child: Center(
              child: Text(postText.chatWithTheMaandoTeam(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(251, 251, 251, 1),
                      fontSize: responsive.ip(2))),
            )
      ),
    );
  }

  // ********************+


  Widget _users(double height, double width, Responsive responsive, dynamic user){

    String avatar = (user["avatar"] == null || user["avatar"] == '') 
    ? "https://firebasestorage.googleapis.com/v0/b/maando-3ec60.appspot.com/o/general%2Ficon%20-%20userx.png?alt=media&token=6ca11e14-94c4-423e-893a-e546a4cd8ecc"
    : user["avatar"];

    return CupertinoButton(
      padding: EdgeInsets.all(0),
      minSize: 0,
      onPressed: (){
        blocChat.changeEmailDestiny(user["email"]);
        blocChat.changeFullNameDestiny(user["fullName"]);
        blocChat.changeAvatarDestiny(user["avatar"]);
        Navigator.pushNamed(context, 'chat', arguments: user);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            height: responsive.ip(12),
            width: responsive.ip(8),
            margin: EdgeInsets.symmetric(horizontal: width * 0.01),
            padding: EdgeInsets.symmetric(horizontal: width * 0.02),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor('#F2B705')),
              borderRadius: BorderRadius.circular(16)
              ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(avatar),
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Text('',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: responsive.ip(1.2)),
                    ),
                ),
                SizedBox(height: responsive.ip(0.5)),
                Text(shortString(user["name"], 15),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: responsive.ip(1.2)),
                )
              ],
            ),
          ),
          (user['session'] == true) 
          ? Positioned(
            top: responsive.ip(1),
            left: responsive.ip(1),
            child: Container(
              height: responsive.ip(1.1),
              width: responsive.ip(1.1),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(100)
              ),
            ),
          )
          : Positioned(
            top: responsive.ip(1),
            left: responsive.ip(1),
            child: Container(
              height: responsive.ip(1.1),
              width: responsive.ip(1.1),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(100)
              )),
          )

        ],
      ),
    );
  }


  Widget _usersLoading(double height, double width, Responsive responsive){
    return Container(
      height: responsive.ip(12),
      width: responsive.ip(6),
      margin: EdgeInsets.symmetric(horizontal: width * 0.01),
      child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.transparent,
                  child: Image.asset('assets/images/general/jar-loading.gif'),
                ),
    );
  }

  Widget _listPost(PostBloc bloc) {
    final Responsive  responsive = Responsive.of(context);
    return StreamBuilder<List<dynamic>>(
        stream: blocGeneral.postsStream,
        // ignore: missing_return
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            listPosts = [];
            if (snapshot.data.length <= 0) {
              return Center(
                child: Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(generalText.weWillGetItThereFast(),
                      textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(0, 0, 0, 1.0),
                              fontSize: responsive.ip(3))),
                    ],
                  ),
                ),
              );
            } else {
              for (var p in snapshot.data) {

                String phone = '';

                blocGeneral.aiportsOrigin.forEach((country) {
                  if (p["user"]["country"] == country["name"]) {
                    phone =
                        '+${country["indicative-code"]}${p["user"]["phone"]}';
                  }
                });

                listPosts.add(Post(
                    postId: p["_id"],
                    emailUser: p["user"]["email"],
                    img: p["user"]["avatar"],
                    name: p["user"]["name"],
                    phoneWhatsApps: '$phone',
                    date: '${obtenerTiempoDePublicacion(p["created_on"])["number"]} ${obtenerTiempoDePublicacion(p["created_on"])["time"]}',
                    content: p["body"]));
              }
              return Column(
                children: [
                  Column(children: listPosts),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.15)
                ],
              );
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Error!!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(0, 0, 0, 1.0),
                            fontSize: responsive.ip(3))),
                  ],
                ),
              ),
            );
          } else {
            return Container(
              margin: EdgeInsets.only(top: 100.0),
              child: Center(child: CircularProgressIndicator()),
            );
          }
        });
  }

// ******************
  Widget _appBar() {
    return StreamBuilder<bool>(
        stream: blocGeneral.viewNavBarStream,
        initialData: true,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshoptNavBar) {
          if (snapshoptNavBar.hasError) {
            return Container();
          } else if (snapshoptNavBar.hasData) {
            if (snapshoptNavBar.data == true) {
              return FadeInDown(
                child: Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    margin: EdgeInsets.only(
                      left: variableGlobal.margenPageWith(context),
                      right: variableGlobal.margenPageWith(context),
                      top: variableGlobal.margenTopGeneral(context),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            iconFace1(context),
                          ],
                        ),
                        Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // alignment: Alignment.center,
                          children: [
                            arrwBackYellowPersonalizado(context, 'principal'),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.chat, color: HexColor('#F2CB05')),
                                  onPressed: (){
                                      Navigator.pushNamed(context, 'my_conversations');
                                  },
                                ),
                                notification(context, 'post'),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 0.03,
                                ),
                                search(context, 'home')
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                ),
              );
            } else {
              return Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  margin: EdgeInsets.only(
                    left: variableGlobal.margenPageWith(context),
                    right: variableGlobal.margenPageWith(context),
                    top: variableGlobal.margenTopGeneral(context),
                  ),
                  child: Container());
            }
          } else {
            return Container(
                margin: EdgeInsets.only(
                  left: variableGlobal.margenPageWith(context),
                  right: variableGlobal.margenPageWith(context),
                  top: variableGlobal.margenTopGeneral(context),
                ),
                child: Container());
          }
        });
  }

// ***************************************************
  Widget _inputSearch(Responsive responsive) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.45,
      margin: EdgeInsets.only(
          left: variableGlobal.margenPageWith(context),
          right: variableGlobal.margenPageWith(context)),
      child: Form(
        // key: formKey,
        child: TextFormField(
            style: TextStyle(
                fontSize: responsive.ip(2),
                fontWeight: FontWeight.w600,
                color: Color.fromRGBO(173, 181, 189, 1)),
            textInputAction: TextInputAction.done,
            cursorColor: Colors.deepOrange,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              alignLabelWithHint: true,
              labelText: generalText.search(),
              border: InputBorder.none,
              labelStyle: TextStyle(
                  fontSize: responsive.ip(2),
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(173, 181, 189, 1)),
            ),
            onChanged: (value) {
              searchInput = value;
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http
                  .postGetAllPostByKeyWord(
                      context: context,
                      email: preference.prefsInternal.get('email'),
                      keyword: searchInput.trim())
                  .then((posts) {
                    Navigator.pop(context);
                final valueMap = json.decode(posts);
                // print('LOS POST  =====>>> ${valueMap}');
                if (valueMap['ok'] == false) {
                } else {
                  cont = 5;
                  blocGeneral.changeOrderBy(listOrderValues[3]);
                  blocGeneral.changePosts(valueMap["posts"]);
                }
              });
            }),
      ),
    );
  }

  Widget _orderBy(Responsive responsive) {
    return Container(
        margin: EdgeInsets.only(
          top: 22,
            left: variableGlobal.margenPageWith(context)),
        child: DropdownButton(
          underline: Container(
              decoration:
                  BoxDecoration(border: Border(bottom: BorderSide.none))),
          items: listOrder.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: TextStyle(
              color: Color.fromRGBO(173, 181, 189, 1),
              fontWeight: FontWeight.w700),
          icon: arrawdown(context),
          hint: Text(postText.orderBy(),
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color.fromRGBO(0, 0, 0, 1.0),
                  fontSize: responsive.ip(1.8))),
          onChanged: (newValue) {
            FocusScope.of(context).requestFocus(new FocusNode());
            if (newValue == postText.descendingDate()) {
              blocGeneral.changeOrderBy(listOrderValues[0]);
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http
                  .postGetAll(
                      context: context,
                      email: preference.prefsInternal.get('email'),
                      cont: cont)
                  .then((posts) {
                    Navigator.pop(context);
                final valueMap = json.decode(posts);
                // print('LOS POST  =====>>> ${valueMap}');
                if (valueMap['ok'] == false) {
                } else {
                  blocGeneral.changePosts(valueMap["posts"]);
                }
              });
            } else if (newValue == postText.dateRange()) {
              blocGeneral.changeOrderBy(listOrderValues[1]);
              cont = 5;
              Navigator.pushNamed(context, 'date_range');
            } else {
              showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
              _http
                  .postGetAllPostByUserEmail(
                      context: context,
                      email: preference.prefsInternal.get('email'),
                      useremail: preference.prefsInternal.get('email'))
                  .then((posts) {
                    Navigator.pop(context);
                    final valueMap = json.decode(posts);
                // print('LOS POST  =====>>> ${valueMap}');
                if (valueMap['ok'] == false) {
                } else {
                  cont = 5;
                  blocGeneral.changeOrderBy(listOrderValues[2]);
                  blocGeneral.changePosts(valueMap["posts"]);
                }
              });
            }
          },
        ));
  }

  // ************************** BOTON DE IR A CREAR UN POST ****************************
  Widget _createPost(BuildContext context, PostBloc bloc, Responsive responsive) {

   final Size measure = MediaQuery.of(context).size;

    return Container(
      height: MediaQuery.of(context).size.height * 0.08,
      margin: EdgeInsets.only(
          left: variableGlobal.margenPageWith(context),
          right: variableGlobal.margenPageWith(context),
          top: variableGlobal.topNavigation(context)),
      child: RaisedButton(
        onPressed: () {
          showDialog(context:context,
              builder: (context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
                content: Container(
                  height: measure.height * 0.35,
                  width: measure.width * 0.25,
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
                            bloc.changePost(value)
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
                          if(bloc.post.trim().length <= 0) return;
                          showDialog(context: context, barrierColor: Colors.transparent, barrierDismissible: false, builder: (BuildContext context){return loading(context);});
                                
                                _http.postCreate(
                                    context: context,
                                    email: preference.prefsInternal.get('email'),
                                    body: bloc.post.trim(),
                                    title: 'Title').then((value) {
                                      print(">>>>>>>>>> SERVIDOR 1 ${blocGeneral.posts.length}");
                                    Navigator.pop(context);
                                    bloc.changePost('');  

                                  if(json.decode(value)["ok"] == true){
                                    blocGeneral.posts.removeWhere((item) => item["_id"] == json.decode(value)["newPost"]["_id"]);
                                    blocGeneral.posts.insert(0, json.decode(value)["newPost"]);
                                    blocGeneral.changePosts(blocGeneral.posts);
                                    bloc.changePost('');
                                    blocSocket.socket.addEntityToPosts(json.decode(value)["newPost"]); // enviamos un socket para que actualize el post de los dem??s
                                    print(">>>>>>>>>> SERVIDOR 2 ${blocGeneral.posts.length}");
                                    Navigator.pop(context);
                                    return;
                                  }else{
                                    // blocGeneral.posts.removeWhere((item) => item["_id"] == _idAux);
                                    // blocGeneral.changePosts(blocGeneral.posts);
                                    Navigator.pop(context);
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

          /*
          bloc.changePost('');
          Navigator.pushReplacementNamed(context, 'create_post',
              arguments: json.encode(null));
           */
        },
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(postText.createPost(),
                  style: TextStyle(
                    color: Color.fromRGBO(255, 206, 6, 1),
                    fontSize: responsive.ip(2.5)
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
  }



  // **************  BUSCAR USUARIOS
  // *********

   Widget _seachUser(Responsive responsive) {
    String text =
        (_validarSearchUser(blocAdmin) == false) ? adminText.searchUser() : '';
    if(blocAdmin.searchUserStreamValue != false) controladorSearchUser.text = (_validarSearchUser(blocAdmin) == false) ? blocAdmin.searchUser : blocAdmin.searchUser;
    controladorSearchUser.selection = TextSelection.collapsed(offset: controladorSearchUser.text.length); //  esa linea sirve para que el cursor quede delante del texto


      return StreamBuilder(
              stream: blocAdmin.searchUserStream,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
            margin: EdgeInsets.only(left: variableGlobal.margenPageWith(context)),
            child: TextFormField(
                style: TextStyle(fontSize: responsive.ip(2.5), fontWeight: FontWeight.normal, color: Color.fromRGBO(173, 181, 189, 1)),
                controller: controladorSearchUser,
                textInputAction: TextInputAction.done,
                cursorColor: Colors.deepOrange,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                contentPadding: EdgeInsets.all(0),
                labelText: text,
                border: InputBorder.none,
                labelStyle: TextStyle(
                  fontSize: responsive.ip(2.5),
                  fontWeight: FontWeight.normal,
                  color: Color.fromRGBO(173, 181, 189, 1),
                ),
                errorText: snapshot.error as dynamic
                ),
                onChanged: (value){
                  Http().searchUser(value.trim()).then((valueResp){
                    final valueMap = json.decode(valueResp);
                    if(valueMap["ok"] == true){
                      if(value.trim().length <= 0){
                        Http().getUserAdmin(
                                email: preference.prefsInternal.get('email') as String, cont: contUsers)
                            .then((users) {
                          final valueMap = json.decode(users);
                          // print('LOS USERS  =====>>> ${valueMap}');
                          if (valueMap['ok'] == false) {
                            // logout();
                            // Timer(Duration(milliseconds: 100), () {
                            //   Navigator.pushNamed(context, 'login');
                            // });
                          } else {
                            blocAdmin.changeTotalUsers(valueMap["totalUsers"]);
                            blocAdmin.changeUsers(valueMap["users"]);
                          }
                        });
                      }
                      blocAdmin.changeUsers(valueMap["users"]);
                    }else{}
                  });
                },
                onTap: () {
                  text = '';
                }),
          );
        });
  }

  bool _validarSearchUser(AdminBloc bloc) {
    bool validate = false;
    try{
      if (bloc.searchUserStreamValue == false) {
          validate = false;
      } else {
        if (bloc.searchUser.length <= 0) {
          validate = false;
        } else {
          validate = true;
        }
      }
    }catch(e){
      validate = false;
    }
    return validate;
  }
}