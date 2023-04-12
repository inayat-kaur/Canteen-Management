// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/screens/SignUpScreen.dart';
import 'package:frontend/screens/landingScreen.dart';
import './screens/splashScreen.dart';
import './screens/landingScreen.dart';
import './screens/loginScreen.dart';
import './screens/SignUpScreen.dart';
import './screens/forgetPassword.dart';
import 'package:frontend/const/colors.dart';

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
          titleLarge: TextStyle(color: AppColor.primary,fontSize: 25),
          bodyMedium: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: SplashScreen(),
      routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        ForgetPassword.routeName: (context) => ForgetPassword(),

      },
    );
  }
}
