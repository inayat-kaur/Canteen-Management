import 'package:flutter/material.dart';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../controllers/general/login_screen_controller.dart';
import '../utils/colors.dart';
import 'sign_up_screen.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  Client client = Client();

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
            children: [
              const Spacer(
                flex: 7,
              ),
              Text(
                "Login",
                style: Helper.getTheme(context).titleLarge,
              ),
              const Spacer(
                flex: 1,
              ),
              const Text("Add your details to login"),
              const Spacer(
                flex: 1,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: "Your Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: AppColor.placeholderBg,
                  hintStyle: const TextStyle(
                    color: AppColor.placeholder,
                  ),
                ),
                controller: _usernameController,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: AppColor.placeholderBg,
                  hintStyle: const TextStyle(
                    color: AppColor.placeholder,
                  ),
                ),
                controller: _passwordController,
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text.trim();
                    String password = _passwordController.text.trim();
                    await loginUser(username, password, context);
                  },
                  child: const Text("Login"),
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ForgetPassword()));
                },
                child: const Text("Forgot your password?"),
              ),
              const Spacer(
                flex: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
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
