// @dart=2.9
import 'package:flutter/material.dart';
import 'package:maando/src/blocs/complete_register_bloc.dart';
import 'package:maando/src/blocs/create_account_bloc.dart';
import 'package:maando/src/blocs/general_bloc.dart';
import 'package:maando/src/blocs/login_bloc.dart';
import 'package:maando/src/blocs/post_bloc.dart';
import 'package:maando/src/blocs/shipment_service_bloc.dart';
import 'ad_form_bloc.dart';
import 'flight_form_bloc.dart';

class ProviderApp extends InheritedWidget {
  static ProviderApp _instancia;

  factory ProviderApp({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderApp._internal(
        key: key,
        child: child,
      );
    }
    return _instancia;
  }

  ProviderApp._internal({Key key, Widget child}) : super(key: key, child: child);

  final loginBloc = LoginBloc();
  final createAccountBloc = CreateAccountBloc();
  final completeRegisterBloc = CompleteRegisterBloc();
  final adFormBloc = AdFormBloc();
  final flightFormBloc = FlightFormBloc();
  final generaltBloc = GeneralBloc();
  final shipmentServiceBloc = ShipmentServiceBloc();
  final postBloc = PostBloc();

  // Provider({Key key, Widget child}) : super(key: key, child: child);

  // AL IMPLEMENTARSE VA A NOTIFICAR A TODO SU HIJOS
  // Busca en el "context" (en el árbol de Widgets) un elemento de tipo LoginBloc
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CreateAccountBloc ofCreate_Account(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderApp>()
        .createAccountBloc;
  }
  static CompleteRegisterBloc ofCompleteRegister(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderApp>()
        .completeRegisterBloc;
  }

  // *****************************************************

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderApp>().loginBloc;
  }

  static AdFormBloc ofAdForm(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderApp>().adFormBloc;
  }

  static FlightFormBloc ofFlightForm(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderApp>().flightFormBloc;
  }

  static GeneralBloc ofGeneral(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ProviderApp>().generaltBloc;
  }

  static ShipmentServiceBloc ofShipmentService(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderApp>()
        .shipmentServiceBloc;
  }

  static PostBloc ofPost(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ProviderApp>()
        .postBloc;
  }
}
