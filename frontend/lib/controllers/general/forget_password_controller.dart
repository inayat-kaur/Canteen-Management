import 'package:flutter/material.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:http/http.dart';
import '../../urls.dart';
import '../../my_services.dart';

Future<void> resetPass1(context, String password) async {
  Client client = Client();
  MyService myService = MyService();
  String token = myService.getToken();
  final response = await client.post(
    resetPassword1,
    headers: {
      'Authorization': 'Bearer $token',
    },
    body: {
      'password': password,
    },
  );
  if (response.statusCode == 201) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password reset successfully"),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password reset failed"),
      ),
    );
  }
}

Future<bool> resetPass2(
    context, String username, String password, String otp, bool otpSent) async {
  Client client = Client();
  final response = await client.post(
    resetPassword2,
    body: {
      'username': username,
      'password': password,
      'OTP': otp,
    },
  );
  if (response.statusCode == 201) {
    if (!otpSent) otpSent = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password reset successfully"),
      ),
    );
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
  } else if (response.statusCode == 401) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("OTP is incorrect"),
      ),
    );
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Password reset failed"),
      ),
    );
  }
  return otpSent;
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
