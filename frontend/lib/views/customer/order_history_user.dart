import 'package:flutter/material.dart';
import '../../models/User.dart';
import '../../models/Order.dart';
import 'dart:collection';
import 'package:intl/intl.dart';
import '../../../controllers/customer/order_history_controller.dart';

class orderHistoryUser extends StatefulWidget {
  const orderHistoryUser({super.key});

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

  _getOrders() async {
    setState(() {
      isLoading = true;
    });
    List<Order> od = await getOrders(groupedOrdersUser);
    setState(() {
      orders = od;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Orders"),
        actions: [
          IconButton(
            icon: isLoading
                ? const CircularProgressIndicator()
                : const Icon(Icons.refresh),
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
}
