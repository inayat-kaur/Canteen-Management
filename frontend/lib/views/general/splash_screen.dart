import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/views/general/landing_screen.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
      //navigate to login screen
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
