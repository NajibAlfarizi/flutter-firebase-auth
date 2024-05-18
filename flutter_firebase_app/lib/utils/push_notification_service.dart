// ignore_for_file: prefer_const_constructors

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future initialize() async {
    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _localNotificationsPlugin.initialize(initializationSettings);
  }

  void showNotification(String title, String body) {
    var androidPlatformChannel = AndroidNotificationDetails(
        'chanel_id_1', 'chanel_name',
        importance: Importance.high);

    var platformChannel = NotificationDetails(android: androidPlatformChannel);
    _localNotificationsPlugin.show(0, title, body, platformChannel);
  }
}
