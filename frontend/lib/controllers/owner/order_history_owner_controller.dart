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
