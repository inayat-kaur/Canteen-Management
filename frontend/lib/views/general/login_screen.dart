import 'package:flutter/material.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../urls.dart';
import '../const/colors.dart';
import 'sign_up_screen.dart';
import 'forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'cartScreen.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "/loginScreen";

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
              Spacer(
                flex: 7,
              ),
              Text(
                "Login",
                style: Helper.getTheme(context).titleLarge,
              ),
              Spacer(
                flex: 1,
              ),
              Text("Add your details to login"),
              Spacer(
                flex: 1,
              ),
              TextField(
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
              SizedBox(height: 10),
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
              Spacer(
                flex: 1,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    Response response = await client.post(login,
                        body: {"username": username, "password": password});
                    if (response.statusCode == 201) {
                      String token =
                          response.body.substring(1, response.body.length - 1);
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('token', token);
                      prefs.setString('username', username);
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) => Profile()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login Failed"),
                        ),
                      );
                    }
                  },
                  child: Text("Login"),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => ForgetPassword()));
                },
                child: Text("Forget your password?"),
              ),
              Spacer(
                flex: 4,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SignUpScreen.routeName);
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
