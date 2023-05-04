import 'dart:async';
import 'package:flutter/material.dart';
import 'package:frontend/controllers/general/splash_screen_controller.dart';
import '../utils/helper.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 4000), () {
      //navigate to login screen
      getNextPage(context);
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
              // Align(
              //   alignment: Alignment.center,
              //   child: Image.asset(
              //     Helper.getAssetName("MealMonkeyLogo.png", "virtual"),
              //   ),
              // )
            ],
          )),
    );
  }
}
