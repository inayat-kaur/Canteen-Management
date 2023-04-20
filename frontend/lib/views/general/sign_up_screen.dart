import 'package:flutter/material.dart';
import 'package:frontend/models/User.dart';
import 'package:frontend/urls.dart';
import 'package:frontend/views/general/login_screen.dart';
import 'package:frontend/views/utils/customTextInput.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import 'package:http/http.dart';

// class SignUpScreen extends StatelessWidget {
//   // const SignUpScreen({super.key});
//   static const routeName = '/signupScreen';
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Container(
//       width: Helper.getScreenWidth(context),
//       height: Helper.getScreenHeight(context),
//       child: SafeArea(
//         child: Container(
//             padding: const EdgeInsets.symmetric(
//               horizontal: 40,
//               vertical: 30,
//             ),
//             child: Column(
//               children: [
//                 Text(
//                   "Sign Up",
//                   style: Helper.getTheme(context).titleLarge,
//                 ),
//                 Spacer(),
//                 Text(
//                   "Add your details to sign up",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Name",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Email",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Phone Number",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Password",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Confirm Password",
//                 ),
//                 Spacer(),
//                 CustomTextInput(
//                   hintText: "Address",
//                 ),
//                 Spacer(),
//                 SizedBox(
//                   height: 50,
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     onPressed: () {},
//                     child: Text("Sign Up"),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                     onTap: () {
//                       Navigator.of(context)
//                           .pushReplacementNamed(LoginScreen.routeName);
//                     },
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text("Already have an account?"),
//                         Text(
//                           "Login",
//                           style: TextStyle(
//                             color: AppColor.orange,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ],
//                     ))
//               ],
//             )),
//       ),
//     ));
//   }
// }

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
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _nameController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _emailController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _phoneController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _passwordController,
                ),
                Spacer(),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Confirm Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  controller: _confirmPasswordController,
                ),
                SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
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
                        client.post(signUp, body: user.toJson());
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
