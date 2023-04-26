import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../../urls.dart';
import 'dart:convert';
import '../../models/Order.dart';
import 'dart:collection';
import 'package:intl/intl.dart';

class orderHistoryUser extends StatefulWidget {
  const orderHistoryUser({super.key});
  static const routeName = "/orderHistoryUser";
  @override
  State<orderHistoryUser> createState() => _orderHistoryUserState();
}

class _orderHistoryUserState extends State<orderHistoryUser> {
  List<Order> orders = [];
  Map<String, List<Order>> groupedOrdersUser =
      LinkedHashMap<String, List<Order>>();
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

    orders.sort(
      (a, b) {
        // First, sort by order status
        var orderStatusCompare = a.orderStatus.compareTo(b.orderStatus);
        if (orderStatusCompare != 0) {
          if (a.orderStatus == "R") {
            return -1; // Move Ready orders to the front
          }
          if (b.orderStatus == "R") {
            return 1;
          }
          if (a.orderStatus == "U") {
            return -1; // Move Under prep orders after Ready orders
          }
          if (b.orderStatus == "U") {
            return 1;
          }
          if (a.orderStatus == "C") {
            return 1; // Move Collected orders to the back
          }
          if (b.orderStatus == "C") {
            return -1;
          }
        }
        // Then, sort by time in decreasing order
        return b.time.compareTo(a.time);
      },
    );

    for (Order order in orders) {
      groupedOrdersUser.putIfAbsent(order.orderId, () => []).add(order);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [
          IconButton(
            icon: isLoading ? const CircularProgressIndicator() : const Icon(Icons.refresh),
            onPressed: () {
              orders.clear();
              groupedOrdersUser.clear();
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
            itemCount: groupedOrdersUser.length,
            itemBuilder: (BuildContext context, int index) {
              String orderid = groupedOrdersUser.keys.toList()[index];
              List<Order> userOrders = groupedOrdersUser[orderid]!;
              bool paymentStatus = userOrders[0].paymentStatus == "Y";
              String orderstatus = userOrders[0].orderStatus;
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
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 8.0),
                        child: Text(
                          "#${userOrders[0].orderId}",
                          // ("Ordered date : ${DateFormat('MMMM d, h:mm a').format(userOrders[0].time)}"),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        ),
                      ),

                     Text(
                        
                          DateFormat('MMMM d, h:mm a').format(userOrders[0].time),
                          style: const TextStyle(
                           fontWeight: FontWeight.w100,
                            fontSize: 15.0,
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
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Order Status:',
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          Text(
                            orderStatus(orderstatus),
                            style: const TextStyle(fontWeight: FontWeight.w100),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Payment Status:',
                            style: TextStyle(fontWeight: FontWeight.w100),
                          ),
                          Text(
                            paymentStatus ? 'Done' : 'Pending',
                            style: const TextStyle(fontWeight: FontWeight.w100),
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

  String orderStatus(String status) {
    if (status == "C") {
      return "Collected";
    } else if (status == "U") {
      return "UnderPreparation";
    } else if (status == "R") {
      return "Ready";
    } else {
      return "Not Accepted";
    }
  }
}
