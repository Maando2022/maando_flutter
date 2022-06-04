// @dart=2.9
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:maando/src/utils/globals.dart';
import 'package:maando/src/utils/textos/onboarding_text.dart';
import 'package:maando/src/widgets/botones.dart';
import 'package:maando/src/widgets/fondo.dart';
import 'package:maando/src/widgets/iconos.dart';


class OnboardingModel {
  String nombre;
  String backcground;
  String title;
  String subtitle1;
  String subtitle2;
  Function progeress;

  OnboardingModel(
      {@required this.nombre,
      @required this.backcground,
      @required this.title,
      @required this.subtitle1,
      @required this.subtitle2,
      @required this.progeress});
}

class OnboardingPage extends StatefulWidget {
  // const OnboardingPage({Key key}) : super(key: key);

  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  List<OnboardingModel> onboardins = [
    OnboardingModel(
      nombre: 'onboarding1',
      backcground: 'assets/images/onboarding/Group-5056@3x.png',
      title: onboardingText.togetherWeAllWin(),
      subtitle1: onboardingText.beTransporterAgent(),
      subtitle2: onboardingText.publishYourFlight(),
      progeress: progeressOnboardong1,
    ),
    OnboardingModel(
      nombre: 'onboarding2',
      backcground: 'assets/images/onboarding/couple-1@3x.png',
      title: onboardingText.togetherWeAllWin(),
      subtitle1: onboardingText.getPaidAnyWhereYouGo(),
      subtitle2: onboardingText.shipmentsInRecordTime(),
      progeress: progeressOnboardong2,
    ),
    OnboardingModel(
      nombre: 'onboardin3',
      backcground: 'assets/images/onboarding/guy-1@3x.png',
      title: onboardingText.togetherWeAllWin(),
      subtitle1: onboardingText.trustingEachOtherAgain(),
      subtitle2: onboardingText.insureYourShipments(),
      progeress: progeressOnboardong3,
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pref.guardarOnboarding('onboarding');
  }

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      child: Swiper(
        // layout: SwiperLayout.TINDER,
        itemWidth: _screenSize.width * 1.0,
        itemHeight: _screenSize.height * 1.0,
        itemBuilder: (BuildContext context, int index) {
          return Hero(
            tag: onboardins[index].nombre,
            child: ClipRRect(
              // borderRadius: BorderRadius.circular(20.0),
              child: Scaffold(
                  body: Container(
                  height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.25),
                        child: Center(
                          child: _fondo(
                              onboardins[index].nombre,
                              onboardins[index].backcground,
                              _screenSize.height,
                              _screenSize.width),
                          // child: fondo(onboardins[index].backcground,
                          //     _screenSize.height, _screenSize.width),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.symmetric(
                                vertical: MediaQuery.of(context).size.height *
                                    0.03),
                                    // fromLTRB
                            padding: EdgeInsets.fromLTRB(
                                MediaQuery.of(context).size.width* 0.08,
                                MediaQuery.of(context).size.height * 0.03,
                                 MediaQuery.of(context).size.width* 0.08,
                                MediaQuery.of(context).size.height * 0.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                iconFace1(context),
                                closeOnboarding(context,
                                    'assets/images/close/close button 1@3x.png')
                              ],
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Text(
                                onboardins[index].title,
                                style: TextStyle(
                                    fontSize: 32.0,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromRGBO(33, 36, 4, 1)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.394,
                          ),
                          Center(
                            child: Container(
                               margin: EdgeInsets.symmetric(
                                 horizontal: variableGlobal.margenPageWith(context)),
                              height: MediaQuery.of(context).size.height * 0.1,
                              child: Text(
                                onboardins[index].subtitle2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.height* 0.027,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromRGBO(33, 36, 4, 1)),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          crearBotonCrearCuenta(),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Center(
                            child: Container(
                              child: CupertinoButton(
                                  child: Text(
                                    onboardingText.login(),
                                    style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.049,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromRGBO(33, 36, 4, 1)),
                                  ),
                                  onPressed: () {
                                    pref.guardarOnboarding('no-onboarding');
                                    Navigator.pushReplacementNamed(context, 'login');
                                  }),
                            ),
                          ),
                          SizedBox(
                            height:
                                MediaQuery.of(context).size.height * 0.025,
                          ),
                          Center(child: onboardins[index].progeress(context)),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.02,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
            ),
          );
        },
        itemCount: onboardins.length,
        // pagination: new SwiperPagination(),
        // scrollDirection: Axis.horizontal,
        fade: 0.5,
        // control: new SwiperControl(
        //     color: Colors.red, padding: EdgeInsets.symmetric(horizontal: 10.0)),
      ),
    );
  }

  Widget _fondo(String nombre, String backcground, height, width) {
    if (nombre == 'onboarding1') {
      return fondo1(backcground, height, width);
    } else if (nombre == 'onboarding2') {
      return fondo2(backcground, height, width);
    } else {
      return fondo3(backcground, height, width);
    }
  }
}
