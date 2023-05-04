import 'package:flutter/material.dart';
import 'package:frontend/controllers/general/sign_up_page_controller.dart';
import 'package:frontend/views/general/login_screen.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';

class SignUpScreen extends StatefulWidget {
  // const SignUpScreen({super.key});
  static const routeName = '/signupScreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  bool otpSent = false;

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
                  "Sign Up",
                  style: Helper.getTheme(context).titleLarge,
                ),
                Spacer(),
                Text(
                  "Add your details to sign up",
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: AppColor.placeholderBg,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                    ),
                  ),
                  controller: _nameController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: AppColor.placeholderBg,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                    ),
                  ),
                  controller: _emailController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    fillColor: AppColor.placeholderBg,
                    hintStyle: TextStyle(
                      color: AppColor.placeholder,
                    ),
                  ),
                  controller: _phoneController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
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
                Spacer(),
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
                Spacer(),
                TextField(
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
                Spacer(),
                SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        sendOTP(context, _emailController.text.trim());
                        setState(() {
                          otpSent = true;
                        });
                      },
                      child: (otpSent) ? Text("Resend OTP") : Text("Send OTP"),
                    )),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      print("Sign Up Button Pressed");
                      //check if password is valid
                      if (_passwordController.text !=
                          _confirmPasswordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                                "Password and Confirm Password do not match"),
                          ),
                        );
                      } else {
                        signUpUser(
                            context,
                            _nameController.text.trim(),
                            _emailController.text.trim(),
                            _passwordController.text.trim(),
                            _phoneController.text.trim(),
                            _otpController.text.trim());
                      }
                    },
                    child: Text("Sign Up"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => SignUpScreen()));
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?"),
                        Text(
                          "Login",
                          style: TextStyle(
                            color: AppColor.orange,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ))
              ],
            )),
      ),
    ));
  }
}
