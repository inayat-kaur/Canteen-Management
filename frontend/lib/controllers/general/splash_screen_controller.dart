import 'package:flutter/material.dart';
import 'package:frontend/my_services.dart';
import 'package:frontend/views/customer/home_screen.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'package:frontend/views/owner/menu_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> getNextPage(BuildContext context) async {
  MyService myService = MyService();
  if (myService.getProfile().username == "") {
    await myService.initialize();
  }
  String token = myService.getToken();
  if (token == null || token == '') {
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (_) => LandingScreen()));
    // Navigator.of(context).pushReplacementNamed(LandingScreen.routeName);
  } else {
    if (myService.getProfile().role == 0)
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
    else
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (_) => menuPageOwner()));
  }
}
