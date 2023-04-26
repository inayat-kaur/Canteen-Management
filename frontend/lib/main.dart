// @dart=2.9
import 'package:flutter/material.dart';
import 'package:frontend/views/general/sign_up_screen.dart';
import 'package:frontend/views/customer/menu_page.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'views/general/splash_screen.dart';
import 'views/owner/order_history_canteen.dart';
import 'views/general/login_screen.dart';
import 'package:frontend/views/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Canteen Management App',
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
        textTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColor.primary, fontSize: 25),
          bodyMedium: TextStyle(
            color: AppColor.secondary,
          ),
        ),
      ),
      home: menuPage(),
      routes: {
        LandingScreen.routeName: (context) => LandingScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        SignUpScreen.routeName: (context) => SignUpScreen(),
        OrderHistoryCanteen.routeName: (context) => OrderHistoryCanteen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
