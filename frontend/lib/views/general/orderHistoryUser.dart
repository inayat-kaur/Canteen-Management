import 'package:flutter/material.dart';

import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../urls.dart';
import '../const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class orderHistoryCanteen extends StatefulWidget {
  const orderHistoryCanteen({super.key});
  static const routeName = "/orderHistoryUser";
  @override
  State<orderHistoryCanteen> createState() => _orderHistoryCanteenState();
}

class _orderHistoryCanteenState extends State<orderHistoryCanteen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: ListView.builder(
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
             
          
        },
      ),
    );
  }
}
