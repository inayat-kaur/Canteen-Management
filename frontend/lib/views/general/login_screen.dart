import 'package:flutter/material.dart';
<<<<<<< HEAD:frontend/lib/screens/loginScreen.dart
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:frontend/screens/cartScreen.dart';
import 'package:frontend/utils/helper.dart';
=======
import 'package:frontend/views/utils/helper.dart';
<<<<<<< HEAD
>>>>>>> aa45361a12a31cd2f1fef3eb56e4d9dcc0f2154b:frontend/lib/views/general/login_screen.dart
=======
import 'package:http/http.dart';
import '../../urls.dart';
>>>>>>> fd7c2297f8353d4471c375b54335659b15fbab93
import '../const/colors.dart';
import 'sign_up_screen.dart';
import '../utils/customTextInput.dart';
import 'forget_password.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class LoginScreen extends StatelessWidget {
//   // const LoginScreen({super.key});
//   static const routeName = "/loginScreen";

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         height: Helper.getScreenHeight(context),
//         width: Helper.getScreenWidth(context),
//         child: SafeArea(
//             child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Spacer(
//                 flex: 7,
//               ),
//               Text(
//                 "Login",
//                 style: Helper.getTheme(context).titleLarge,
//               ),
//               Spacer(
//                 flex: 1,
//               ),
//               Text("Add your details to login"),
//               Spacer(
//                 flex: 1,
//               ),
//               CustomTextInput(
//                 hintText: "Your Email",
//               ),
//               // Spacer(flex: 1,),
//               SizedBox(height: 10),
//               CustomTextInput(
//                 hintText: "Password",
//               ),
//               Spacer(
//                 flex: 1,
//               ),
//               SizedBox(
//                 height: 50,
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () {},
//                   child: Text("Login"),
//                 ),
//               ),
//               Spacer(
//                 flex: 1,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context).push(
//                       MaterialPageRoute(builder: (_) => ForgetPassword()));
//                 },
//                 child: Text("Forget your password?"),
//               ),
//               Spacer(
//                 flex: 4,
//               ),
//               GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .pushReplacementNamed(SignUpScreen.routeName);
//                 },
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text("Don't have an Account?"),
//                     Text(
//                       "Sign Up",
//                       style: TextStyle(
//                         color: AppColor.orange,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         )),
//       ),
//     );
//   }
// }

class LoginScreen extends StatefulWidget {
  // const LoginScreen({super.key});
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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                controller: _usernameController,
              ),
              SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
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
<<<<<<< HEAD
                  onPressed: () {Navigator.of(context)
                                .pushReplacementNamed(CartScreen.routeName);},
=======
                  onPressed: () async {
                    Response response = await client.post(login, body: {
                      "username": _usernameController.text,
                      "password": _passwordController.text
                    });
                    if (response.statusCode == 201) {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("token", response.body);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login Successful"),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Login Failed"),
                        ),
                      );
                    }
                  },
>>>>>>> fd7c2297f8353d4471c375b54335659b15fbab93
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
