import 'package:flutter/material.dart';
import 'package:frontend/controllers/general/profile_page_controller.dart';
import 'package:frontend/views/customer/order_history_user.dart';
import 'package:frontend/views/general/forget_password.dart';
import 'package:frontend/views/general/landing_screen.dart';
import '../../models/user.dart';
import '../utils/colors.dart';
import '../utils/helper.dart';

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

  void initialize() async {
    User user1 = await getProfile();
    setState(() {
      user = user1;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
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
                                    onPressed: () async {
                                      String newName = await updateName(
                                          _nameController.text.trim());
                                      setState(() {
                                        user.name = newName;
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
                                    onPressed: () async {
                                      String newPhone = await updatePhone(
                                          _phoneController.text.trim());
                                      setState(() {
                                        user.name = newPhone;
                                        editName = false;
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
                          (user.role == 1)
                              ? Text("")
                              : ListTile(
                                  leading: Icon(Icons.history),
                                  title: Text("Check Order History"),
                                  onTap: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                orderHistoryUser()));
                                  },
                                ),
                          SizedBox(height: 20),
                          ListTile(
                            leading: Icon(Icons.logout),
                            title: Text("Logout"),
                            onTap: () async {
                              logout();
                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                      builder: (_) => LandingScreen()),
                                  (route) => false);
                            },
                          )
                        ]),
                      ),
                    ])))));
  }
}
