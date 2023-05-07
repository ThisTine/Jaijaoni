import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jaijaoni/functions/utils/save_token_to_database.dart';
import 'package:jaijaoni/screens/home.dart';

class HomeWrapper extends StatefulWidget {
  const HomeWrapper({super.key});

  @override
  State<HomeWrapper> createState() => _HomeWrapperState();
}

class _HomeWrapperState extends State<HomeWrapper> {
      Future<void> setupToken() async {
    String? token = kIsWeb ? await FirebaseMessaging.instance.getToken(vapidKey: "BINEKY5zoqK5aMJpFwnCTEQHoMpgtVhgYu01lnrWkzNuIo2MUeL9U8CX_7yU7EqRx-TV-HWdqFX1TJkjH1ojX4Q") : await FirebaseMessaging.instance.getToken();
    await saveTokenToDatabase(token!);
    FirebaseMessaging.instance.onTokenRefresh.listen(saveTokenToDatabase);
  }
  @override
  void initState() {
    super.initState();
    setupToken();
  }
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}