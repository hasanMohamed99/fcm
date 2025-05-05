import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_notification/firebase_options.dart';
import 'package:firebase_notification/helpers/extensions.dart';
import 'package:firebase_notification/notification_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_libphonenumber/flutter_libphonenumber.dart';
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
void _isolateMain(RootIsolateToken rootIsolateToken) async {
  // Register the background isolate with the root isolate.
  BackgroundIsolateBinaryMessenger
      .ensureInitialized(rootIsolateToken);
  // You can now use the shared_preferences plugin.
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  // Isolate.spawn(_isolateMain, rootIsolateToken);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  NotificationHandler.initializeNotificationHandler();
  HttpOverrides.global = MyHttpOverrides();
  await init();
  runApp(const App());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  const platform = MethodChannel("com.firebase.notification.app");

  try {
    await platform.invokeMethod(
      'showNotification',
      message.data,
    );
  } on PlatformException catch (e) {
    "Failed to show notification: '${e.message}'.".redDebugPrint();
  } catch (e) {
    "Failed: '$e'.".redDebugPrint();
  }
}