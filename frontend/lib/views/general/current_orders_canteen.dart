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
import '../../models/order.dart';

class currentOrderCanteen extends StatefulWidget {
  const currentOrderCanteen({super.key});
  static const routeName = "/currentOrderCanteen";
  @override
  State<currentOrderCanteen> createState() => _currentOrderCanteenState();
}

class _currentOrderCanteenState extends State<currentOrderCanteen> {
  List<Order> orders = [];
  Map<String, List<Order>> groupedReadyOrders =
      LinkedHashMap<String, List<Order>>();
  Map<String, List<Order>> groupedUnderprepOrders =
      LinkedHashMap<String, List<Order>>();
  User user = User(username: '', role: 0, name: '', phone: '', password: '');
  bool isLoading = false;
  get http => null;
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
    List<Order> underPreparationOrders =
        orders.where((order) => order.orderStatus == "U").toList();

    List<Order> readyOrders =
        orders.where((order) => order.orderStatus == "R").toList();

    underPreparationOrders.sort((a, b) => a.time.compareTo(b.time));
    readyOrders.sort((a, b) => a.time.compareTo(b.time));
    for (Order order in underPreparationOrders) {
      groupedUnderprepOrders.putIfAbsent(order.orderId, () => []).add(order);
    }
    for (Order order in readyOrders) {
      groupedReadyOrders.putIfAbsent(order.orderId, () => []).add(order);
    }
    setState(() {
      // Set isLoading to false after loading data
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Current Orders'),
          actions: [
            IconButton(
              icon:
                  isLoading ? CircularProgressIndicator() : Icon(Icons.refresh),
              onPressed: () {
                // Add your code here to refresh the data from the database

                orders.clear();
                groupedReadyOrders.clear();
                groupedUnderprepOrders.clear();
                _getOrders();
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'Ready Orders',
              ),
              Tab(
                text: 'Underpreparation',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildReadyOrdersList(),
            _buildUnderprepOrdersList(),
          ],
        ),
      ),
    );
  }

  Widget _buildReadyOrdersList() {
    return Stack(
      children: [
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        ListView.builder(
          itemCount: groupedReadyOrders.length,
          itemBuilder: (BuildContext context, int index) {
            String orderid = groupedReadyOrders.keys.toList()[index];
            List<Order> userOrders = groupedReadyOrders[orderid]!;

            int totalPrice = 0;
            for (Order order in userOrders) {
              totalPrice += order.price * order.quantity;
            }
            bool isPaymentCollected = userOrders[0].paymentStatus == "Y";
            bool isOrderReady =
                false; // Add this variable to track the order status
            Color paymentButtonColor =
                Colors.grey; // Set initial button color to grey

            // Check if payment is already collected
            if (isPaymentCollected) {
              paymentButtonColor = Colors
                  .green; // Change button color to green if payment is already collected
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
                      userOrders[0].username,
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
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Status:',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        Text(
                          isPaymentCollected ? 'Collected' : 'Pending',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: isPaymentCollected
                                ? null // Disable button if payment is already collected
                                : () {
                                    //todo
                                    // Function to mark payment collected

                                    setState(() {
                                      isPaymentCollected = true;
                                      paymentButtonColor = Colors.green;
                                    });
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                paymentButtonColor,
                              ),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                            child: Text('Payment Done'),
                          ),
                        ),
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Function to mark order collected
                              //todo
                              setState(() {
                                isOrderReady = true;
                              });
                            },
                            child: Text('Order Collected'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                          ),
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
    );
  }

  Widget _buildUnderprepOrdersList() {
    return Stack(
      children: [
        if (isLoading)
          Center(
            child: CircularProgressIndicator(),
          ),
        ListView.builder(
          itemCount: groupedUnderprepOrders.length,
          itemBuilder: (BuildContext context, int index) {
            String orderid = groupedUnderprepOrders.keys.toList()[index];
            List<Order> userOrders = groupedUnderprepOrders[orderid]!;

            int totalPrice = 0;
            for (Order order in userOrders) {
              totalPrice += order.price * order.quantity;
            }
            bool isPaymentCollected = userOrders[0].paymentStatus == "Y";
            bool isOrderCollected =
                false; // Add this variable to track the order status
            Color paymentButtonColor =
                Colors.grey; // Set initial button color to grey

            // Check if payment is already collected
            if (isPaymentCollected) {
              paymentButtonColor = Colors
                  .green; // Change button color to green if payment is already collected
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
                      userOrders[0].username,
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
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Payment Status:',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        Text(
                          isPaymentCollected ? 'Collected' : 'Pending',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: isPaymentCollected
                                ? null // Disable button if payment is already collected
                                : () {
                                    //todo
                                    // Function to mark payment collected

                                    setState(() {
                                      isPaymentCollected = true;
                                      paymentButtonColor = Colors.green;
                                    });
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                paymentButtonColor,
                              ),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                            child: Text('Payment Done'),
                          ),
                        ),
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Function to mark order collected
                              //todo
                              setState(() {
                                isOrderCollected = true;
                              });
                            },
                            child: Text('Order Ready'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                          ),
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
    );
  }
}
