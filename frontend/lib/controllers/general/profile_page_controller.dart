import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:frontend/urls.dart';

Future<Map<String, dynamic>> getProfile() async {
  Client client = Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  final response = await client.get(
    getUserProfile,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  client.close();
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonMap = jsonDecode(response.body);
    Map<String, dynamic> message = jsonMap['message'][0];
    return message;
  } else {
    throw Exception('Error fetching profile');
  }
}

Future<String> updateName(String newName) async {
  Client client = Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  final response = await client.put(updateUserName, headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'name': newName,
  });
  client.close();
  if (response.statusCode == 200) {
    return newName;
  } else {
    throw Exception('Error updating profile');
  }
}

Future<String> updatePhone(String newPhone) async {
  Client client = Client();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  final response = await client.put(updateUserPhone, headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'phone': newPhone,
  });
  client.close();
  if (response.statusCode == 200) {
    return newPhone;
  } else {
    throw Exception('Error updating profile');
  }
}

Future<void> logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('token');
}

Future<String> getToken() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = await prefs.getString('token');
  if (token == null) {
    return "";
  }
  print("getToken() called");
  return token;
}

Future<String> getUsername() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? username = await prefs.getString('username');
  if (username == null) {
    return "";
  }
  print("getUsername() called");
  return username;
}
