
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'helpers/show_countries_dialog.dart';
import 'notification_handler.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class App extends StatelessWidget {
  const App({super.key});

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
            SizedBox(
              height: 40,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  showCountriesDialog(context);
                },
                child: const Text(
                  'Show Countries',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
