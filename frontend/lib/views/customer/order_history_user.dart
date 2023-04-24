import 'package:flutter/material.dart';

import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../urls.dart';
import '../utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderHistoryUser extends StatefulWidget {
  const OrderHistoryUser({super.key});
  static const routeName = "/orderHistoryUser";
  @override
  State<OrderHistoryUser> createState() => _OrderHistoryUserState();
}

class _OrderHistoryUserState extends State<OrderHistoryUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {},
      ),
    );
  }
}
