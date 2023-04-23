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
  bool editPhone = false;
  bool editName = false;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  Future<void> getProfile() async {
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    final response = await client.get(
      getUserProfile,
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
    client.close();
  }

  Future<void> updateName() async {
    String newName = _nameController.text.trim();
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    final response = await client.put(updateUserName, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'name': newName,
    });
    if (response.statusCode == 200) {
      setState(() {
        user.name = newName;
      });
    } else {
      throw Exception('Error updating profile');
    }
    client.close();
  }

  Future<void> updatePhone() async {
    String newPhone = _phoneController.text.trim();
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    final response = await client.put(updateUserPhone, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'phone': newPhone,
    });
    if (response.statusCode == 200) {
      setState(() {
        user.phone = newPhone;
      });
    } else {
      throw Exception('Error updating profile');
    }
    client.close();
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
                    child: Column(children: [
                      Text(
                        "Profile",
                        style: Helper.getTheme(context).titleLarge,
                      ),
                      Expanded(
                        child: ListView(padding: EdgeInsets.all(20), children: [
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(user.username),
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.person),
                            title: editName
                                ? TextField(
                                    decoration: InputDecoration(
                                      hintText: "Your Name",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      fillColor: AppColor.placeholderBg,
                                      hintStyle: TextStyle(
                                        color: AppColor.placeholder,
                                      ),
                                    ),
                                    controller: _nameController,
                                  )
                                : Text(user.name),
                            trailing: editName
                                ? IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: () {
                                      updateName();
                                      setState(() {
                                        editName = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        editName = true;
                                      });
                                    },
                                  ),
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: editPhone
                                ? TextField(
                                    decoration: InputDecoration(
                                      hintText: "Your Phone",
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      fillColor: AppColor.placeholderBg,
                                      hintStyle: TextStyle(
                                        color: AppColor.placeholder,
                                      ),
                                    ),
                                    controller: _phoneController,
                                  )
                                : Text(user.phone),
                            trailing: editPhone
                                ? IconButton(
                                    icon: Icon(Icons.save),
                                    onPressed: () {
                                      updatePhone();
                                      setState(() {
                                        editPhone = false;
                                      });
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        editPhone = true;
                                      });
                                    },
                                  ),
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.lock),
                            title: Text("Change Password"),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (_) => ForgetPassword()));
                            },
                          ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text("Logout"),
                            onTap: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString('token', '');
                              Navigator.of(context).pushReplacementNamed(
                                  LandingScreen.routeName);
                            },
                          )
                        ]),
                      ),
                    ])))));
  }
}
