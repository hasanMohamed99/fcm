import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/app.dart';
import 'package:flutter/material.dart';

class NotificationHandler {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void getToken() async {
    await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      announcement: true,
      criticalAlert: true,
    ).then(
      (value) async {
        await messaging.getToken().then(
          (value) {
            debugPrint('FCM Token: $value');
          },
        );
      },
    );
  }

  static Future initializeNotificationHandler() async {
    await FirebaseMessaging.instance.getInitialMessage().then(handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
    FirebaseMessaging.onMessage.listen(handleNotification);
  }

  static Future<void> handleNotification(RemoteMessage? message) async {
    if (message == null) return;
    await showDialog(
      context: navigatorKey.currentState!.context,
      builder: (_) => AlertDialog(
        title: Text('Title: ${message.notification?.title}'),
        content: Text('Body: ${message.notification?.body}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(navigatorKey.currentState!.context).pop();
            },
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
