import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_notification/firebase_options.dart';
import 'package:firebase_notification/notification_handler.dart';
import 'package:flutter/material.dart';
import 'app.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationHandler.initializeNotificationHandler();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const App());
}
