import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/controllers/general/profile_page_controller.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/User.dart';
import '../../urls.dart';

Future<bool> loginUser(String username, String password) async {
  Client client = Client();
  Response response = await client
      .post(login, body: {"username": username, "password": password});
  if (response.statusCode == 201) {
    String token = response.body.substring(1, response.body.length - 1);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('username', username);

    return true;
  }
  client.close();
  return false;
}

Future<int> getRole(String username) async {
  Map<String, dynamic> profile = await getProfile();
  return profile['role'];
}
