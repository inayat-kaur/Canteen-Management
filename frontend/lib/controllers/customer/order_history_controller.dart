import 'dart:convert';
import 'package:frontend/my_services.dart';
import 'package:http/http.dart';
import 'package:frontend/models/Order.dart';
import 'package:frontend/urls.dart';

Future<List<Order>> getOrders(
    Map<String, List<Order>> groupedOrdersUser) async {
  Map<String, List<Order>> gou = {};
  List<Order> orders = [];
  Client client = Client();
  MyService myService = MyService();
  String id = myService.getProfile().username;
  String token = myService.getToken();
  final response = await client.get(
    getOrdersByUser(id),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  if (response.statusCode == 200) {
    List<dynamic> jsonData = json.decode(response.body);
    orders = jsonData.map((e) => Order.fromJson(e)).toList();

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
  gou.addAll(groupedOrdersUser);
  groupedOrdersUser = gou;
  return orders;
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
