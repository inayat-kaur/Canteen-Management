import 'package:flutter/material.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:frontend/views/utils/customTextInput.dart';
import '../const/colors.dart';
import '../utils/helper.dart';

class SignUpScreen extends StatelessWidget {
  // const SignUpScreen({super.key});
  static const routeName = '/signupScreen';
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
                CustomTextInput(
                  hintText: "Name",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Email",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Phone Number",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Password",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Confirm Password",
                ),
                Spacer(),
                CustomTextInput(
                  hintText: "Address",
                ),
                Spacer(),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
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
