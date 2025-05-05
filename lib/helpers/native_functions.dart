import 'package:firebase_notification/helpers/extensions.dart';
import 'package:flutter/services.dart';

class NativeFunctions {
  static const _platform = MethodChannel("com.firebase.notification.app");

  static Future<void> showNotification(Map<String, dynamic> args) async {
    try {
      await _platform.invokeMethod(
        'showNotification',
        args,
      );
    } on PlatformException catch (e) {
      "Failed to show notification: '${e.message}'.".redDebugPrint();
    } catch (e) {
      "Failed: '$e'.".redDebugPrint();
    }
  }
}
