import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/widgets/customTextInput.dart';

import '../utils/helper.dart';

class ForgetPassword extends StatelessWidget {
  // const ForgetPassword({super.key});
  static const routeName = "/resetPasswordScreen";
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
                  Spacer(),
                  Text(
                    "Please enter your email to receive a new Password",
                    textAlign: TextAlign.center,
                  ),
                  Spacer(),
                  CustomTextInput(hintText: "Email"),
                  Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text("Send"),
                    ),
                  ),
                  Spacer(flex:16)
                ],
              )),
        ),
      ),
    );
  }
}
