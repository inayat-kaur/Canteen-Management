import 'package:flutter/material.dart';

import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart' as http;
import '../../urls.dart';
import '../const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/Order.dart';

class orderHistoryCanteen extends StatefulWidget {
  const orderHistoryCanteen({super.key});
  static const routeName = "/orderHistoryCanteen";
  @override
  State<orderHistoryCanteen> createState() => _orderHistoryCanteenState();
}

class _orderHistoryCanteenState extends State<orderHistoryCanteen> {
  List<Order> orders = [];
  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  Future<void> _getOrders() async {
    var response =
        await http.get(Uri.parse('http://172.26.13.173:3000/getorders'));
    var jsonData = json.decode(response.body) as List<dynamic>;
    orders = jsonData.map((e) => Order.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order History"),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          final order = orders[index];
          return ListTile(
            title: Text('${order.username}: ${order.quantity} x ${order.item}'),
          );
        },
      ),
    );
  }
}
