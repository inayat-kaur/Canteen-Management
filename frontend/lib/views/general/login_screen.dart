import 'package:flutter/material.dart';
import 'package:frontend/views/customer/category_menu_page.dart';
import 'package:frontend/views/customer/home_screen.dart';
import 'package:frontend/views/general/order_history_canteen.dart';
import 'package:frontend/views/general/order_user.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/general/current_orders_canteen.dart';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../controllers/general/login_screen_controller.dart';
import '../../models/menu.dart';
import '../../urls.dart';
import '../customer/menuItem.dart';
import '../utils/colors.dart';
import 'sign_up_screen.dart';
import 'forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/views/customer/order_history_user.dart';
import 'cart_screen.dart';

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
                    String username = _usernameController.text.trim();
                    String password = _passwordController.text.trim();

                    bool credentialsValidated =
                        await loginUser(username, password);
                    if (credentialsValidated) {
                      int role = await getRole(username);
                      if (role == 0) {
                        // Navigator.of(context).pushReplacement(
                        //     MaterialPageRoute(builder: (_) => HomeScreen()));
                        Menu maggi = Menu(
                            item: "Maggi",
                            price: 20,
                            availability: "A",
                            rating: 4,
                            category: "Snacks",
                            type: 0);
                        List<Menu> menu = [maggi];
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => CategoryMenuPage(category: menu)));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (_) => const currentOrderCanteen()));
                      }
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
