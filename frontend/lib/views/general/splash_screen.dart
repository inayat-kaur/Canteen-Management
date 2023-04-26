import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/views/customer/cart_screen.dart';
import 'package:frontend/views/customer/menu_page.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'package:frontend/views/customer/order_history_user.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:frontend/views/general/order_history_canteen.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  Future<void> getNextPage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    
    if (token != null && token != "") {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
      // Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
    } else {
      Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
    }
  }

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 4000), () {
      //navigate to login screen
      getNextPage();
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: Helper.getScreenWidth(context),
          height: Helper.getScreenHeight(context),
          child: Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.asset(
                  Helper.getAssetName("splashIcon.png", "virtual"),
                  fit: BoxFit.fill,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  Helper.getAssetName("MealMonkeyLogo.png", "virtual"),
                ),
              )
            ],
          )),
    );
  }
}
