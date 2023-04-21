import 'package:flutter/material.dart';
import 'package:frontend/urls.dart';
import 'package:frontend/views/general/forget_password.dart';
import 'package:frontend/views/general/landing_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../const/colors.dart';
import '../utils/helper.dart';
import 'dart:convert';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user = User(username: '', role: 0, name: '', phone: '', password: '');

  get http => null;

  Future<void> getProfile() async {
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = await prefs.getString('username');
    if (id == null) id = '';
    String? token = await prefs.getString('token');
    final response = await client.get(
      getUserProfile(id),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = jsonDecode(response.body);
      Map<String, dynamic> message = jsonMap['message'][0];
      setState(() {
        user.fromJson(message);
      });
    } else {
      throw Exception('Error fetching profile');
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

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
                    "Profile",
                    style: Helper.getTheme(context).titleLarge,
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.email, color: AppColor.placeholder),
                      Text(
                        user.username,
                        style: TextStyle(color: AppColor.placeholder),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.person, color: AppColor.placeholder),
                      Text(
                        user.name,
                        style: TextStyle(color: AppColor.placeholder),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      Icon(Icons.phone, color: AppColor.placeholder),
                      Text(
                        user.phone,
                        style: TextStyle(color: AppColor.placeholder),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.lock,
                            color: AppColor.placeholder,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ForgetPassword()));
                          },
                          color: AppColor.placeholder),
                      Text(
                        "Change Password",
                        style: TextStyle(color: AppColor.placeholder),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    children: [
                      IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: AppColor.placeholder,
                          ),
                          onPressed: () async {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('token', '');
                            Navigator.of(context)
                                .pushReplacementNamed(LandingScreen.routeName);
                          },
                          color: AppColor.placeholder),
                      Text(
                        "Logout",
                        style: TextStyle(color: AppColor.placeholder),
                      )
                    ],
                  ),
                ],
              ),
            ))));
  }
}
