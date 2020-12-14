import 'package:erp/loginandsplash/intro.dart';

import 'utilities/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/auth.dart';
import './loginandsplash/auth_screen.dart';
import './loginandsplash/login_screen.dart';
import './constants.dart';
import './Supervisor/supervisormain.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.transparent,
  //   statusBarBrightness: Brightness.light,
  // ));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                  title: 'ERP',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    accentColor: kDarkButtonBg,
                    fontFamily: 'google_sans',
                  ),
                  debugShowCheckedModeBanner: false,
                  home: auth.isAuth
                      ? splash()
                      : FutureBuilder(
                          future: auth.tryAutoLogin(),
                          builder: (ctx, authResultSnapshot) =>
                              authResultSnapshot.connectionState ==
                                      ConnectionState.waiting
                                  ? Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : splash(),
                        ),
                  routes: {
                    '/supervisor': (ctx) => Supervisor(),
                    '/splash': (ctx) => splash(),
                    '/intro': (ctx) => OnboardingScreen(),
                    AuthScreen.routeName: (ctx) => AuthScreen(),
                    LoginScreen.routeName: (ctx) => LoginScreen(),
                  })),
    );
  }
}
