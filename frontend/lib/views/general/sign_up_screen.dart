import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/urls.dart';
import 'package:frontend/views/general/login_screen.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';
import 'package:http/http.dart';

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
  Client client = Client();

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
                        User user = User(
                          name: _nameController.text,
                          role: 0,
                          username: _emailController.text,
                          phone: _phoneController.text,
                          password: _passwordController.text,
                        );
                        Response response =
                            await client.post(signUp, body: user.toJson());
                        if (response.statusCode == 201) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Sign Up Successful"),
                            ),
                          );
                          Navigator.of(context)
                              .pushReplacementNamed(LoginScreen.routeName);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Sign Up Failed"),
                            ),
                          );
                        }
                      }
                    },
                    child: Text("Sign Up"),
                  ),
                ),
                Spacer(),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushReplacementNamed(LoginScreen.routeName);
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
