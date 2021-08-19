import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:dealtoutv2/UI/HomePage.dart';
import 'package:dealtoutv2/UI/MappingPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Utils/Authentification.dart';
import 'globalsvariable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  data();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: primaryColor,
        fontFamily: 'Segoe UI',
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        backgroundColor: Colors.black,
          splash: 'assets/images/logo.png',
          nextScreen: users == null ? MappingPage() : HomePage(),
          splashTransition: SplashTransition.scaleTransition,
          centered: true,
          duration: 3000,
        ),
    );
  }
}