import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/my_services.dart';
import 'package:frontend/views/customer/home_screen.dart';
import 'package:frontend/views/owner/menu_page.dart';
import 'package:http/http.dart';
import '../../models/user.dart';
import '../../urls.dart';

Future<void> loginUser(String username, String password, context) async {
  Client client = Client();
  Response response = await client
      .post(login, body: {"username": username, "password": password});
  if (response.statusCode == 201) {
    String token = response.body.substring(1, response.body.length - 1);
    MyService myService = MyService();
    myService.updateToken(token);
    response = await client.get(getUserProfile, headers: {
      'Authorization': 'Bearer $token',
    });
    print("###########################");
    print(token);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = json.decode(response.body);
      User user =
          User(name: "", phone: "", username: "", role: 0, password: "");
      user.fromJson(body['message'][0]);
      MyService myService = MyService();
      myService.updateProfile(user);
      if (user.role == 0) {
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => menuPageOwner()));
      }
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Login Failed"),
      ),
    );
  }
  client.close();
}
