import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/screens/cartScreen.dart';
import 'package:frontend/views/utils/helper.dart';
import '../views/const/colors.dart';
import '../views/general/sign_up_screen.dart';
import '../views/utils/customTextInput.dart';
class LoginScreen extends StatelessWidget {
  // const LoginScreen({super.key});
  static const routeName = "/loginScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Helper.getScreenHeight(context),
        width: Helper.getScreenWidth(context),
        child: SafeArea(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 7,),
              Text(
                "Login",
                style: Helper.getTheme(context).titleLarge,
              ),
              Spacer(flex: 1,),
              Text("Add your details to login"),
              Spacer(flex: 1,),
              CustomTextInput(
                hintText: "Your Email",
              ),
              // Spacer(flex: 1,),
              SizedBox(
                height:10
              ),
              CustomTextInput(
                hintText: "Password",
              ),
              Spacer(flex: 1,),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {Navigator.of(context)
                                .pushReplacementNamed(CartScreen.routeName);},
                  child: Text("Login"),
                ),
              ),
              Spacer(flex: 1,),
              GestureDetector(
                onTap: () {
                  // Navigator.of(context).pushReplacementNamed(ForgetPassword.routeName);
                },
                child: Text("Forget your password?"),
              ),
              Spacer(flex: 4,),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an Account?"),
                    Text(
                      "Sign Up",
                      style: TextStyle(
                        color: AppColor.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}

