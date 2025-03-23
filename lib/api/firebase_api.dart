import 'package:kilimboga/data/dummy_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await _firebaseMessaging.requestPermission();

    fcm = await _firebaseMessaging.getToken();

    await prefs.setString("fcm", fcm!);

    initPushNotification();
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
  }

  Future<void> showNotification(RemoteMessage message) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );

    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0, // Notification ID
      message.notification?.title ?? "New Message",
      message.notification?.body ?? "You have received a message",
      platformChannelSpecifics,
    );
  }

  Future initPushNotification() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint(
          "Message received: ${message.notification?.toMap().toString()}");
      showNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint("Message received: ${message.notification?.toString()}");

      debugPrint('A new onMessageOpenedApp event was published!');
    });
  }
}
