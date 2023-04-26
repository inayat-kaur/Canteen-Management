import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../../urls.dart';
import '../utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../models/order.dart';
import 'dart:collection';

class orderHistoryUser extends StatefulWidget {
  const orderHistoryUser({super.key});
  static const routeName = "/orderHistoryUser";
  @override
  State<orderHistoryUser> createState() => _orderHistoryUserState();
}

class _orderHistoryUserState extends State<orderHistoryUser> {
  List<Order> orders = [];
  User user = User(username: '', role: 0, name: '', phone: '', password: '');
  get http => null;
  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  Future<void> _getOrders() async {
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = await prefs.getString('username');
    if (id == null) id = '';
    String? token = await prefs.getString('token');
    final response = await client.get(
      getOrdersByUser(id),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      orders = [];
      setState(
        () {
          orders = jsonData.map((e) => Order.fromJson(e)).toList();
        },
      );
      // print(orders[0].username);
    } else {
      throw Exception('Error fetching profile');
    }
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
            title: Text(order.username),
            subtitle: Text('${order.quantity} X ${order.item}'),
            trailing: TextButton(
              child: Text('Reorder'),
              onPressed: () {
                // Implement reorder functionality here
              },
            ),
          );
        },
      ),
    );
  }
}
