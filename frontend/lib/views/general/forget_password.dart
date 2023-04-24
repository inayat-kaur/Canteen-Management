import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../urls.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  int resetPassword = 1;
  bool otpSent = false;

  Future<void> resetPass1(context) async {
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    String password = _passwordController.text.trim();
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

  void resetPass2(context) async {
    Client client = Client();
    final response = await client.post(
      resetPassword2,
      body: {
        'username': _usernameController.text.trim(),
        'password': _passwordController.text.trim(),
        'otp': _otpController.text.trim(),
      },
    );
    if (response.statusCode == 201) {
      if (!otpSent) otpSent = true;
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

  void sendOTP(context) async {
    Client client = Client();
    final response = await client.post(
      mailOTP,
      body: {
        "username": _usernameController.text.trim(),
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

  Future<void> getLoggedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    if (token == null || token == '') {
      setState(() {
        resetPassword = 2;
      });
    }
  }

  @override
  void initState() {
    getLoggedInState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Helper.getScreenWidth(context),
        height: Helper.getScreenHeight(context),
        child: SafeArea(
          child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 30,
              ),
              child: Column(
                children: [
                  Text(
                    "Reset Password",
                    style: Helper.getTheme(context).titleLarge,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  (resetPassword == 1)
                      ? Text("")
                      : TextField(
                          decoration: InputDecoration(
                            hintText: "Your Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: AppColor.placeholderBg,
                            hintStyle: TextStyle(
                              color: AppColor.placeholder,
                            ),
                          ),
                          controller: _usernameController,
                        ),
                  Spacer(
                    flex: 1,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "New Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: AppColor.placeholderBg,
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                      ),
                    ),
                    controller: _passwordController,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Confirm Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: AppColor.placeholderBg,
                      hintStyle: TextStyle(
                        color: AppColor.placeholder,
                      ),
                    ),
                    controller: _confirmPasswordController,
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  (resetPassword == 1)
                      ? Text("")
                      : TextField(
                          decoration: InputDecoration(
                            hintText: "OTP",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            fillColor: AppColor.placeholderBg,
                            hintStyle: TextStyle(
                              color: AppColor.placeholder,
                            ),
                          ),
                          controller: _otpController,
                        ),
                  Spacer(
                    flex: 1,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_passwordController.text.trim() !=
                            _confirmPasswordController.text.trim()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  "Password and Confirm Password do not match"),
                            ),
                          );
                        } else {
                          if (resetPassword == 1) {
                            resetPass1(context);
                          } else {
                            resetPass2(context);
                          }
                        }
                      },
                      child: Text("Reset"),
                    ),
                  ),
                  (resetPassword == 2)
                      ? SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              sendOTP(context);
                            },
                            child: (otpSent)
                                ? Text("Resend OTP")
                                : Text("Send OTP"),
                          ),
                        )
                      : Text(""),
                  Spacer(flex: 16)
                ],
              )),
        ),
      ),
    );
  }
}
