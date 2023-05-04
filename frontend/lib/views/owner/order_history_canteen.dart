import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../../urls.dart';
import 'dart:convert';
import '../../models/Order.dart';
import 'package:intl/intl.dart';

class orderHistoryCanteen extends StatefulWidget {
  const orderHistoryCanteen({super.key});

  @override
  State<orderHistoryCanteen> createState() => _orderHistoryCanteenState();
}

class _orderHistoryCanteenState extends State<orderHistoryCanteen> {
  List<Order> orders = [];
  Map<String, List<Order>> groupedOrders = LinkedHashMap<String, List<Order>>();
  User user = User(username: '', role: 0, name: '', phone: '', password: '');
  get http => null;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  Future<void> _getOrders() async {
    setState(() {
      isLoading = true;
    });
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? id = await prefs.getString('username');
    id ??= '';
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
      groupedOrders.putIfAbsent(order.orderId, () => []).add(order);
    }
    setState(() {
      // Set isLoading to false after loading data
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Order History"),
        actions: [
          IconButton(
            icon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh),
            onPressed: () {
              // Add your code here to refresh the data from the database

              orders.clear();
              groupedOrders.clear();
              _getOrders();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
          ListView.builder(
            itemCount: groupedOrders.length,
            itemBuilder: (BuildContext context, int index) {
              String orderid = groupedOrders.keys.toList()[index];
              List<Order> userOrders = groupedOrders[orderid]!;

              // Calculate the total price for all items in the order
              int totalPrice = 0;
              for (Order order in userOrders) {
                totalPrice += order.price * order.quantity;
              }

              return Container(
                margin: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 8.0),
                        child: Center(
                          child: Text(
                            userOrders[0].username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0.0, 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "#${userOrders[0].orderId}",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              DateFormat('MMMM d, h:mm a')
                                  .format(userOrders[0].time),
                              style: const TextStyle(
                                fontWeight: FontWeight.w100,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '₹$totalPrice',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
