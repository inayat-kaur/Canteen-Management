import 'package:flutter/material.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'package:frontend/views/general/login_screen.dart';
import '../../my_services.dart';

Future<void> getNextPage(BuildContext context) async {
  MyService myService = MyService();
  String token = myService.getToken();

  if (token != null && token != '') {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LoginScreen()));
    // Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
  } else {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LandingScreen()));
  }
}
