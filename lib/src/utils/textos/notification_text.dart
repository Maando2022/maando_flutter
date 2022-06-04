import 'dart:io';

class NotificationText {
  String lang = Platform.localeName.substring(0, 2);

  String notifications() {
      // return 'Notifications';
    if (lang == 'en') {
      return 'Notifications';
    } else if (lang == 'es') {
      return 'Notificaciones';
    } else {
      return 'Notifications';
    }
  }
}

NotificationText notificationText = NotificationText();
