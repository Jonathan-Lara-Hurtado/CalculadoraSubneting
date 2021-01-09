import 'dart:ui';

import 'package:calculadora_de_redes/admob/ad_manager.dart';
import 'package:calculadora_de_redes/screens/homescreen.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splashscreen/splashscreen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseAdMob.instance.initialize(appId: AdManager.appId);
  runApp(
    GetMaterialApp(
      title: 'Calculator',
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      image: Image.asset('assets/splash.png'),
      seconds: 3,
      photoSize: 100.0,
      navigateAfterSeconds: HomeScreen(),
      title: Text(
        'Calculator',
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    );
  }
}
