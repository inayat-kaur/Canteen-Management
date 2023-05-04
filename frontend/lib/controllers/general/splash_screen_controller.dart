import 'package:flutter/material.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> getNextPage(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null || token == '') {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LandingScreen()));
    // Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
  } else {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
  }
}
