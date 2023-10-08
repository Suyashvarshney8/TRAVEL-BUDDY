import 'package:flutter/material.dart';
import 'package:klndrive/HomeScreen/homeScreen.dart';
import 'package:klndrive/HomeScreen/findaRide.dart';
import 'package:klndrive/Profile/profile.dart';
import 'package:klndrive/auth/login.dart';
import 'package:klndrive/auth/registerUser.dart';
import 'package:klndrive/auth/otpPage.dart';
import 'package:klndrive/auth/otpHome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var userName = prefs.getBool("userName");
  runApp(MyApp(screen: (userName == null) ? HomeSCreen() : HomeScreen()));
}

class MyApp extends StatelessWidget {
  final Widget? screen;
  MyApp({this.screen});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel Buddy',
      //test phase
      home: SplashScreen(
          seconds: 4,
          navigateAfterSeconds: screen!,
          title: new Text(
            "Travel Buddy - Let's get started",
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          styleTextUnderTheLoader: new TextStyle(),
          loaderColor: Colors.white),
      routes: {
        '/otphome': (context) => OtpHome(),
        '/otppage': (context) => OtpPage(),
        '/homescreen': (context) => HomeScreen(),
        '/register': (context) => SignUp(),
        '/profile': (context) => ProfilePage(),
        '/findaride': (context) => FindaRide(),
      },
    );
  }
}
