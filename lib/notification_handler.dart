import 'package:firebase_notification/helpers/native_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

abstract class NotificationHandler {
  static FirebaseMessaging messaging = FirebaseMessaging.instance;

  static void getToken() async {
    await messaging
        .requestPermission(
      announcement: true,
      criticalAlert: true,
    )
        .then(
      (value) async {
        await messaging.getToken().then(
          (value) {
            debugPrint('FCM Token: $value');
          },
        );
      },
    );
  }

  static void initializeNotificationHandler() async {
    await FirebaseMessaging.instance.getInitialMessage().then(handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
    FirebaseMessaging.onMessage.listen(handleNotification);
  }

  static void handleNotification(RemoteMessage? message) async {
    if (message == null) return;
    NativeFunctions.showNotification(
      message.data,
    );
    // await showDialog(
    //   context: navigatorKey.currentState!.context,
    //   builder: (_) => AlertDialog(
    //     title: Text(
    //         'Title: ${message.data['title']}'),
    //     content: Text(
    //         'Text: ${message.data['text']}'),
    //     actions: [
    //       TextButton(
    //         onPressed: () {
    //           Navigator.of(navigatorKey
    //                   .currentState!.context)
    //               .pop();
    //         },
    //         child: const Text('Close'),
    //       ),
    //     ],
    //   ),
    // );
  }
}
