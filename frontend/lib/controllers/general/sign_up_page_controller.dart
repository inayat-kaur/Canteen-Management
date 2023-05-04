import 'package:frontend/urls.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:http/http.dart';
import '../../views/general/login_screen.dart';

void signUpUser(context, String name, String username, String password,
    String phone, String otp) async {
  Client client = Client();
  User user = User(
    name: name,
    role: 0,
    username: username,
    phone: phone,
    password: password,
  );
  Map<String, dynamic> body = user.toJson();
  body["OTP"] = otp;
  Response response = await client.post(signUp, body: body);
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sign Up Successful"),
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => LoginScreen(),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sign Up Failed"),
      ),
    );
  }
}

void sendOTP(context, String username) async {
  Client client = Client();
  final response = await client.post(
    mailOTP,
    body: {
      "username": username,
    },
  );
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP sent successfully"),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP sending failed"),
      ),
    );
  }
}
