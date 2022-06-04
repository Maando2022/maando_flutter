// @dart=2.9
import 'dart:convert';
import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/socket_bloc.dart';
// import 'package:maando/src/pages/complete_registration_page.dart';
import 'package:maando/src/pages/home/home_page_8_2.dart';
import 'package:maando/src/pages/home/home_page_8_2.dart';
import 'package:maando/src/pages/shipments_service_page.dart';
import 'package:maando/src/services/conectivity.dart';
import 'package:maando/src/services/http_v1/http.dart';
import 'package:maando/src/services/shared_pref.dart';
import 'package:maando/src/services/socket_io.dart';
// import 'package:maando/src/utils/ciudades.dart';
import 'package:maando/src/utils/expireToken.dart';
import 'package:maando/src/utils/responsive.dart';
import 'package:maando/src/utils/textos/general_text.dart';
import 'package:maando/src/widgets/app_bar.dart';
import 'package:maando/src/widgets/drawers/drawer_home.dart';
import 'package:maando/src/widgets/navigation_bar.dart';


class PrincipalPage extends StatefulWidget {
  PrincipalPage({Key key}) : super(key: key);

  @override
  _PrincipalPageState createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> with TickerProviderStateMixin {
  final blocNavigator = blocGeneral;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  AnimationController _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    blocGeneral.changeViewNavBar(false);
    Future.delayed(Duration(milliseconds: 100), () {
          blocGeneral.changeViewNavBar(true);
    });
    // position. listenPosition(context);

    // ****  OBTENEMOS MIS ANUNCIOS
    Http().verMisAnuncios(context: context, email: preference.prefsInternal.get('email'))
      .then((myAdsMap){
      
        // print('>>>>>>>>>>>>>>>>>>  $myAdsMap');
        if(myAdsMap["ok"] == true){
          blocGeneral.changeListMyAds(myAdsMap["adsBD"]);
        }else{
          blocGeneral.changeListMyAds([]);
        }
      });
    // ****  OBTENEMOS MIS VUELOS
    Http().verMisVuelos(context: context, email: preference.prefsInternal.get('email'))
      .then((myFlighysMap){
        if(myFlighysMap["ok"] == true){
          blocGeneral.changeListMyFlights(myFlighysMap["flightDB"]);
        }else{
          blocGeneral.changeListMyFlights([]);
        }
      });

      // OBTENEMOS EL USUARIO
       Http().findUserForEmail(email: preference.prefsInternal.get('email')).then((user){
          var userMap = json.decode(user);
          if(userMap["ok"] == true){
            print('USER _____________________________ ${userMap["user"]}');
            blocSocket.changeUser(userMap["user"]);
          }
      });

    // OBTENEMOS LOS ADMINISTRADORES
      Http().getAdmins().then((admins){
          var adminsMap = json.decode(admins);
          blocGeneral.changeAdmins(adminsMap["admins"]);
      });

      // OBTENEMOS LOS LOS PAISES CUIDADES Y AEROPUERTOS
      Http().getAiports().then((aiports){          
          blocGeneral.changeAiportsOrigin(aiports["contriesOrigin"]);
          blocGeneral.changeAiportsDestination(aiports["contriesDestination"]);
      });


    _animation = AnimationController(duration: Duration(seconds: 4), vsync: this);
    _animation.repeat();

  }

  Future<String> getPhone() async {
    await prefsInternal.obtenerPreferencias();
    return await prefsInternal.prefsInternal.get('phone');
  }

  @override
  Widget build(BuildContext context) {
    conectivity.validarConexion(context, 'principal');
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final Responsive  responsive = Responsive.of(context);


    print('Display --- height  ${MediaQuery.of(context).size.height}');
    print('Display --- width  ${MediaQuery.of(context).size.width}');

    // devolverCiudadActual().then((value){
    //   print("${value[0].name}, ${value[0].subLocality}, ${value[0].locality}, ${value[0].administrativeArea} ${value[0].postalCode}, ${value[0].country}");
    // });
    

    // listPlaces('Mall plaza, cartgena').then((value){
    //   print('placeId =============>>>>>>>>>>  ${value.results[0].placeId}');
    // });


    blocSocket.changeSocket(new SocketService());

    if (ModalRoute.of(context).settings.arguments == null) {
      blocNavigator.homePrincipal();
    } else {
      final shipmentsService =
          jsonDecode(ModalRoute.of(context).settings.arguments);
      if (shipmentsService["shipments"] == true) {
        blocNavigator.shipmentPrincipal();
      } else {
        blocNavigator.servicePrincipal();
      }
    }

    return StreamBuilder<List<dynamic>>(
              stream: blocGeneral.aiportsOriginStream,
              builder: (_, AsyncSnapshot<List<dynamic>> snapshotConutriesOrigin){
                  if(snapshotConutriesOrigin.hasData){
                      if(snapshotConutriesOrigin.data.length <= 0){
                        return Container(
                          child: Column(
                            children: [
                              SizedBox(height: responsive.ip(30)),
                              Container(
                                  margin: EdgeInsets.only(bottom: height * 0.05),
                                  child: AnimatedBuilder(
                                    animation: _animation,
                                          builder: (_, child) {
                                            return Transform.rotate(
                                              angle: _animation.value * 2 * pi,
                                              child: child,
                                            );
                                          },
                                      child: CircleAvatar(
                                                  backgroundColor: Colors.transparent,
                                                  radius: responsive.ip(3.5),
                                                  child: Container(
                                                    child: SvgPicture.asset(
                                                              "assets/icon/maando.svg"
                                                            ),
                                                  ),
                                            ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(horizontal: responsive.ip(4)),
      
                                  child: RichText(
                                    textAlign: TextAlign.center,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(text: generalText.nowMaandoIsLoading(), 
                                          style: TextStyle(color: Colors.black, fontSize: responsive.ip(3),fontWeight: FontWeight.bold)),
                                        TextSpan(text: generalText.pleaseWaitForAnAmazingExperience(), 
                                          style: TextStyle(color: Colors.black, fontSize: responsive.ip(2.5),fontWeight: FontWeight.w300))
                                    ]
                                  ),
                                )
                              )
                            ],
                          )
                        );
                      }else{
                            return StreamBuilder<List<bool>>(
                                stream: blocNavigator.navigationStream,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<bool>> snapshopt) {
                                  if (snapshopt.hasData) {
                                    return Scaffold(
                                      key: _scaffoldKey,
                                      drawer: DrawerHome(),
                                      extendBody: true,
                                      drawerDragStartBehavior: DragStartBehavior.down,
                                      body: Stack(
                                        children: [
                                          Container(
                                            child:
                                                _mostraPrincipal(snapshopt.data, height, width),
                                          ),
                                          NavigationBar1(
                                            home: 'home',
                                            shipments: '',
                                            service: '',
                                          )
                                        ],
                                      ),
                                    );
                                  } else if (snapshopt.hasError) {
                                    return Container(
                                      margin: EdgeInsets.only(top: height * 0.5),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.only(top: height * 0.5),
                                      child: Center(child: CircularProgressIndicator()),
                                    );
                                  }
                                });
                      }
                  }else if(snapshotConutriesOrigin.hasError){
                      return Container(
                        margin: EdgeInsets.only(top: height * 0.4),
                        child: Center(child: CircularProgressIndicator()),
                      );
                  }else{
                      return Container(
                        margin: EdgeInsets.only(top: height * 0.4),
                        child: Center(child: CircularProgressIndicator()),
                      );
                  }
                },
          );
  }

  Widget _mostraPrincipal(List<bool> arrayOption, double height, double width) {
    if (arrayOption[0] == true &&
        arrayOption[1] == false &&
        arrayOption[2] == false) {
      return Stack(
        children: [
          HomePage(),
          Positioned(
              top: 0,
              width: width,
              child: Container(
                color: Color.fromRGBO(251, 251, 251, 1),
                child: AppBarWidget(scaffoldKey: _scaffoldKey))
                ),
        ],
      );
    } else if (arrayOption[0] == false &&
        arrayOption[1] == true &&
        arrayOption[2] == false) {
      return Stack(
        children: [
          ShipmentsServivesPage(
            shipments: true,
            service: false,
          ),
          Positioned(
              top: 0,
              width: width,
              child: Container(
                color: Color.fromRGBO(251, 251, 251, 1),
                child: AppBarWidget(scaffoldKey: _scaffoldKey))),
        ],
      );
    } else if (arrayOption[0] == false &&
        arrayOption[1] == false &&
        arrayOption[2] == true) {
      return Stack(
        children: [
          ShipmentsServivesPage(
            shipments: false,
            service: true,
          ),
          Positioned(
              top: 0,
              width: width,
              child: Container(
                color: Color.fromRGBO(251, 251, 251, 1),
                child: AppBarWidget(scaffoldKey: _scaffoldKey))),
        ],
      );
    } else {
      return Container();
    }
  }
}
