import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:frontend/views/utils/helper.dart';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../../urls.dart';
import '../utils/colors.dart';
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
  Map<String, List<Order>> groupedOrders = LinkedHashMap<String, List<Order>>();
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
      getOrders,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);

      orders = [];
      setState(() {
        orders = jsonData.map((e) => Order.fromJson(e)).toList();
      });
    } else {
      throw Exception('Error fetching profile');
    }
    List<Order> collectedOrders = orders
        .where(
            (order) => order.orderStatus == "C" && order.paymentStatus == "Y")
        .toList();

    collectedOrders.sort((a, b) => b.time.compareTo(a.time));
    for (Order order in collectedOrders) {
      groupedOrders.putIfAbsent(order.username, () => []).add(order);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
      ),
      body: ListView.builder(
        itemCount: groupedOrders.length,
        itemBuilder: (BuildContext context, int index) {
          String username = groupedOrders.keys.toList()[index];
          List<Order> userOrders = groupedOrders[username]!;

          // Calculate the total price for all items in the order
          int totalPrice = 0;
          for (Order order in userOrders) {
            totalPrice += order.price * order.quantity;
          }

          return Container(
            margin: EdgeInsets.fromLTRB(8, 4, 8, 4),
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey.shade300,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: ListTile(
              title: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 8.0),
                child: Center(
                  child: Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (Order order in userOrders)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('${order.quantity}x ${order.item}'),
                        Text('₹${order.price * order.quantity}'),
                      ],
                    ),
                  Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '₹${totalPrice}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
