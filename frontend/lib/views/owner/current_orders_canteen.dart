import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:collection';
import 'package:http/http.dart';
import '../../models/User.dart';
import '../../urls.dart';
import 'dart:convert';
import '../../models/Order.dart';
import 'package:intl/intl.dart';

class currentOrderCanteen extends StatefulWidget {
  const currentOrderCanteen({super.key});
  static const routeName = "/currentOrderCanteen";
  @override
  State<currentOrderCanteen> createState() => _currentOrderCanteenState();
}

class _currentOrderCanteenState extends State<currentOrderCanteen> {
  List<Order> orders = [];
  bool isPaymentCollected1 = false;
  bool isPaymentCollected2 = false;
  Color paymentButtonColor1 = Colors.grey;
  Color paymentButtonColor2 = Colors.grey;
  Map<String, List<Order>> groupedReadyOrders =
      LinkedHashMap<String, List<Order>>();
  Map<String, List<Order>> groupedUnderprepOrders =
      LinkedHashMap<String, List<Order>>();

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
      isPaymentCollected1 = false;
      isPaymentCollected2 = false;
      paymentButtonColor1 = Colors.grey;
      paymentButtonColor2 = Colors.grey;
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

  Future<void> _updatePaymentStatus(String orderid, String item) async {
    Client client = Client();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString('token');
    final response = await client.put(
      updatePaymentStatus(orderid, item),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      print("Connected");
    } else {
      throw Exception('Error fetching Server');
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Current Orders'),
          actions: [
            IconButton(
              icon: isLoading
                  ? const CircularProgressIndicator()
                  : const Icon(Icons.refresh),
              onPressed: () {
                // Add your code here to refresh the data from the database

                orders.clear();
                groupedReadyOrders.clear();
                groupedUnderprepOrders.clear();
                _getOrders();
              },
            ),
          ],
          bottom: const TabBar(
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
          const Center(
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
            isPaymentCollected1 = userOrders[0].paymentStatus == "Y";
            paymentButtonColor1 = Colors.grey;
            // Check if payment is already collected
            if (isPaymentCollected1) {
              paymentButtonColor1 = Colors
                  .green; // Change button color to green if payment is already collected
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
                          '₹${totalPrice}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Status:',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        Text(
                          isPaymentCollected1 ? 'Collected' : 'Pending',
                          style: const TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: isPaymentCollected1
                                ? null // Disable button if payment is already collected
                                : () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Payment"),
                                          content: const Text(
                                              "Are you sure you want to Make Payment Status Collected?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Dismiss dialog box
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Perform action
                                                for (Order order
                                                    in userOrders) {
                                                  order.paymentStatus = "Y";
                                                }

                                                setState(() {
                                                  isPaymentCollected1 = true;
                                                  paymentButtonColor1 =
                                                      Colors.green;
                                                });
                                                Navigator.pop(context);

                                                // for (Order order
                                                //     in userOrders) {
                                                //   _updatePaymentStatus(
                                                //       order.orderId,
                                                //       order.item);
                                                // }
                                                // TO DO
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                paymentButtonColor1,
                              ),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                            child: const Text('Payment Done'),
                          ),
                        ),
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Function to mark order collected
                              //todo
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Order Status"),
                                    content: const Text(
                                        "Are you sure you want to Mark This Order Collected?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Dismiss dialog box
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Perform action
                                          for (Order order in userOrders) {
                                            order.orderStatus = "C";
                                          }

                                          Navigator.pop(context);

                                          // for (Order order
                                          //     in userOrders) {
                                          //   _updateOrderStatus(
                                          //       order.orderId,
                                          //       order.item);
                                          // }
                                          // TO DO
                                        },
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                            child: const Text('Order Collected'),
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
          const Center(
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
            isPaymentCollected2 = userOrders[0].paymentStatus == "Y";
            // Add this variable to track the order status
            paymentButtonColor2 =
                Colors.grey; // Set initial button color to grey

            // Check if payment is already collected
            if (isPaymentCollected2) {
              paymentButtonColor2 = Colors
                  .green; // Change button color to green if payment is already collected
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
                          '₹${totalPrice}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Payment Status:',
                          style: TextStyle(fontWeight: FontWeight.w100),
                        ),
                        Text(
                          isPaymentCollected2 ? 'Collected' : 'Pending',
                          style: const TextStyle(fontWeight: FontWeight.w100),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: isPaymentCollected2
                                ? null // Disable button if payment is already collected
                                : () {
                                    //todo
                                    // Function to mark payment collected
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text("Confirm Payment"),
                                          content: const Text(
                                              "Are you sure you want to Make Payment Status Collected?"),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                // Dismiss dialog box
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Cancel"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                // Perform action
                                                for (Order order
                                                    in userOrders) {
                                                  order.paymentStatus = "Y";
                                                }

                                                setState(() {
                                                  isPaymentCollected2 = true;
                                                  paymentButtonColor2 =
                                                      Colors.green;
                                                });
                                                Navigator.pop(context);

                                                // for (Order order
                                                //     in userOrders) {
                                                //   _updatePaymentStatus(
                                                //       order.orderId,
                                                //       order.item);
                                                // }
                                                // TO DO
                                              },
                                              child: const Text("Confirm"),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                paymentButtonColor2,
                              ),
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 8.0)),
                            ),
                            child: const Text('Payment Done'),
                          ),
                        ),
                        SizedBox(
                          height: 44.0,
                          width: 96.0,
                          child: ElevatedButton(
                            onPressed: () {
                              // Function to mark order Ready
                              //todo
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Confirm Order Status"),
                                    content: const Text(
                                        "Are you sure you want to Mark This Order Ready?"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          // Dismiss dialog box
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          // Perform action
                                          for (Order order in userOrders) {
                                            order.orderStatus = "R";
                                          }

                                          Navigator.pop(context);

                                          // for (Order order
                                          //     in userOrders) {
                                          //   _updateOrderStatus(
                                          //       order.orderId,
                                          //       order.item);
                                          // }
                                          // TO DO
                                        },
                                        child: const Text("Confirm"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text('Order Ready'),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all<
                                      EdgeInsetsGeometry?>(
                                  const EdgeInsets.symmetric(
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
