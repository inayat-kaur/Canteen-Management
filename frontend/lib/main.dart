import 'package:flutter/material.dart';
import 'package:frontend/views/general/sign_up_screen.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'views/general/splash_screen.dart';
import 'views/general/login_screen.dart';
import 'package:frontend/views/const/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Metropolis",
        primarySwatch: Colors.red,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            AppColor.orange,
          ),
          shape: MaterialStateProperty.all(
            StadiumBorder(),
          ),
          elevation: MaterialStateProperty.all(0),
        )),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: AppColor.primary, fontSize: 25),
          bodyMedium: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
