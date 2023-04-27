import 'package:flutter/material.dart';
import 'package:frontend/views/customer/menu_page.dart';
import 'package:frontend/views/general/order_history_canteen.dart';
import 'package:frontend/views/general/order_user.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../urls.dart';
import '../utils/colors.dart';
import 'sign_up_screen.dart';
import 'forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/views/customer/order_history_user.dart';
import 'package:frontend/views/general/current_orders_canteen.dart';
import '../customer/cart_screen.dart';

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
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (_) => const currentOrderCanteen()));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Login Failed"),
                        ),
                      );
                    }
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
                child: const Text("Forget your password?"),
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
