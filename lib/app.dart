import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'notification_handler.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() async{
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    await checkInitialMessage();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    switch (state) {
      case AppLifecycleState.resumed:
        debugPrint('AppLifecycleState: $state');
        await checkInitialMessage();
        break;
      default:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }

  // Check if app was opened from a notification when terminated
  Future<void> checkInitialMessage() async {
    RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      debugPrint('Remote Message by notification: ${initialMessage.data}');
    } else {
      debugPrint('Remote Message by app icon: ${initialMessage?.data}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
        useMaterial3: true,
        fontFamily: GoogleFonts.ubuntu().fontFamily,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Notification'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  NotificationHandler.getToken();
                },
                child: const Text(
                  'Generate FCM Token',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
