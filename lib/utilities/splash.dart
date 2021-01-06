import 'dart:async';
import 'package:erp/loginandsplash/auth_screen.dart';

import 'package:erp/loginandsplash/intro.dart';
import 'package:erp/loginandsplash/login_screen.dart';
import 'package:erp/SuperVisor/supervisormain.dart';
import 'package:erp/constants.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:erp/providers/auth.dart';

void main() {
  runApp(splash());
}

class splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Splash Screen',
      theme: ThemeData(
        primarySwatch: maroon,
      ),
      routes: {
        '/supervisor': (ctx) => Supervisor(),
        '/splash': (ctx) => splash(),
        '/intro': (ctx) => OnboardingScreen(),
        AuthScreen.routeName: (ctx) => AuthScreen(),
        LoginScreen.routeName: (ctx) => LoginScreen(),
      },
      home: Splash2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Splash2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 2,
      routeName: '/splash',
      navigateAfterSeconds: new SecondScreen(),
      title: new Text(
        'Maxroof',
        textScaleFactor: 2,
      ),
      image: new Image.asset('assets/applogo.png'),
      loadingText: Text("Loading"),
      photoSize: 100.0,
      loaderColor: Colors.blue,
    );
  }
}

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    if (Provider.of<Auth>(context, listen: false).session == null) {
      return AuthScreen();
    } else if (Provider.of<Auth>(context, listen: false).role == 'Supervisor') {
      return Supervisor();
    } else if (Provider.of<Auth>(context, listen: false).role == '') {
      return OnboardingScreen();
    } else if (Provider.of<Auth>(context, listen: false).role == '') {
      return OnboardingScreen();
    } else {
      return LoginScreen();
    }
  }
}
