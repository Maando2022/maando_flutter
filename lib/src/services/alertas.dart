// @dart=2.9
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// https://pub.flutter-io.cn/documentation/adaptive_dialog/latest/adaptive_dialog/showOkCancelAlertDialog.html

Future showOkSussecces({
  @required BuildContext context,
  String title,
  String message,
  String okLabel = 'Continue',
  // String cancelLabel = 'Cancel',
  OkCancelAlertDefaultType defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.cupertino,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) async {
  // final isCupertinoStyle = Theme.of(context).isCupertinoStyle;
  String defaultCancelLabel() {
    final label = MaterialLocalizations.of(context).cancelButtonLabel;
    // return isCupertinoStyle ? label.capitalizedForce : label;
  }

  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    actions: [
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.ok,
        isDestructiveAction: isDestructiveAction,
      ),
    ],
  );
  return result ?? OkCancelResult.cancel;
}

Future<OkCancelResult> showOkCancelAlertDialogGoogle({
  @required BuildContext context,
  String title,
  String message,
  String okLabel = 'Continue',
  String cancelLabel = 'Cancel',
  OkCancelAlertDefaultType defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) async {
  // final isCupertinoStyle = Theme.of(context).isCupertinoStyle;
  String defaultCancelLabel() {
    final label = MaterialLocalizations.of(context).cancelButtonLabel;
    // return isCupertinoStyle ? label.capitalizedForce : label;
  }

  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    actions: [
      AlertDialogAction(
        label: cancelLabel ?? defaultCancelLabel(),
        key: OkCancelResult.cancel,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.cancel,
      ),
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.ok,
        isDestructiveAction: isDestructiveAction,
      ),
    ],
  );
  return result ?? OkCancelResult.cancel;
}

Future<OkCancelResult> showOkCancelAlertDialogFacebook({
  @required BuildContext context,
  String title,
  String message,
  String okLabel = 'Continue',
  String cancelLabel = 'Cancel',
  OkCancelAlertDefaultType defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) async {
  // final isCupertinoStyle = Theme.of(context).isCupertinoStyle;
  String defaultCancelLabel() {
    final label = MaterialLocalizations.of(context).cancelButtonLabel;
    // return isCupertinoStyle ? label.capitalizedForce : label;
  }

  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    actions: [
      AlertDialogAction(
        label: cancelLabel ?? defaultCancelLabel(),
        key: OkCancelResult.cancel,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.cancel,
      ),
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.ok,
        isDestructiveAction: isDestructiveAction,
      ),
    ],
  );
  return result ?? OkCancelResult.cancel;
}

Future alertExpiredToken({
  @required BuildContext context,
  String title,
  String message,
  String okLabel = 'Continue',
  // String cancelLabel = 'Cancel',
  OkCancelAlertDefaultType defaultType,
  bool isDestructiveAction = false,
  bool barrierDismissible = true,
  AdaptiveStyle alertStyle = AdaptiveStyle.adaptive,
  bool useActionSheetForCupertino = false,
  bool useRootNavigator = true,
  VerticalDirection actionsOverflowDirection = VerticalDirection.up,
}) async {
  // final isCupertinoStyle = Theme.of(context).isCupertinoStyle;
  String defaultCancelLabel() {
    final label = MaterialLocalizations.of(context).cancelButtonLabel;
    // return isCupertinoStyle ? label.capitalizedForce : label;
  }

  final result = await showAlertDialog<OkCancelResult>(
    context: context,
    title: title,
    message: message,
    barrierDismissible: barrierDismissible,
    style: alertStyle,
    useActionSheetForCupertino: useActionSheetForCupertino,
    useRootNavigator: useRootNavigator,
    actionsOverflowDirection: actionsOverflowDirection,
    actions: [
      AlertDialogAction(
        label: okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
        key: OkCancelResult.ok,
        isDefaultAction: defaultType == OkCancelAlertDefaultType.ok,
        isDestructiveAction: isDestructiveAction,
      ),
    ],
  );
  return result ?? OkCancelResult.cancel;
}

FadeScaleTransitionConfiguration({bool barrierDismissible}) {}
