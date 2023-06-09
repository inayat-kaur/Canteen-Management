import 'package:flutter/material.dart';
import 'package:frontend/views/customer/home_screen.dart';

import '../../models/Order.dart';
import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../my_services.dart';
import '../../urls.dart';
import 'package:http/http.dart';

// get all the products/items which are common to both menu and cart
List<Product> getProducts() {
  MyService myService = MyService();
  List<Menu> menu = myService.getMyMenu();
  List<Cart> cart = myService.getCart();
  List<Product> foodProducts = getProductsHelper(menu, cart);
  return foodProducts;
}

List<Product> getProductsHelper(List<Menu> menu, List<Cart> cart) {
  List<Product> foodProducts = [];
  for (int i = 0; i < cart.length; i++) {
    for (int j = 0; j < menu.length; j++) {
      if (cart[i].item == menu[j].item) {
        foodProducts.add(Product(
          image: 'assets/images/food.jpg',
          title: menu[j].item,
          price: menu[j].price,
          quantity: cart[i].quantity,
          availability: menu[j].availability,
          rating: menu[j].rating,
          category: menu[j].category,
          type: menu[j].type,
        ));
      }
    }
  }
  return foodProducts;
}

// calculates the total of the items in the cart
int getTotal(List<Product> products) {
  int total = 0;
  for (int i = 0; i < products.length; i++) {
    total += products[i].price * products[i].quantity;
  }
  return total;
}

// the function places an order of the items in the cart.
Future<void> orderCartItems(
    List<Product> foodProducts, List<String> orderOptions, context) async {
  MyService myService = MyService();
  String token = myService.getToken();
  String OrderID = generateOrderId(token);
  Order order = Order(
      orderId: OrderID,
      username: "",
      orderType: "I",
      item: "",
      quantity: 0,
      price: 0,
      orderStatus: "U",
      paymentStatus: "N",
      time: DateTime.now());
  Client client = Client();
  for (int i = 0; i < foodProducts.length; i++) {
    order.item = foodProducts[i].title;
    order.quantity = foodProducts[i].quantity;
    order.price = foodProducts[i].price;
    final response = await client.post(addOrder, headers: {
      'Authorization': 'Bearer $token',
    }, body: {
      'orderId': order.orderId,
      'orderType': order.orderType,
      'item': order.item,
      'quantity': order.quantity.toString(),
      'price': order.price.toString(),
      'orderStatus': order.orderStatus,
      'paymentStatus': order.paymentStatus,
      'delivery_time': order.time.toString(),
    });
    print(response.statusCode);
    print("Order placed");
  }
  final response = await client
      .delete(emptyCart, headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    MyService myService = MyService();
    List<Cart> cart = myService.getCart();
    Cart item;
    for (item in cart) {
      myService.removeCart(item);
    }
    print('Cart emptied');
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => HomeScreen()),
        (route) => false);
  } else {
    throw Exception('Failed to empty cart');
  }
  client.close();
}

String generateOrderId(String token) {
  String OrderID = '';
  String temp = token.split('.')[1];
  OrderID += DateTime.now().minute.toString();
  OrderID += temp.substring(0, 2);
  OrderID += DateTime.now().hour.toString();
  OrderID += temp.substring(2, 4);
  OrderID += DateTime.now().day.toString();
  OrderID += DateTime.now().second.toString();
  OrderID += temp.substring(6, 8);
  OrderID += DateTime.now().year.toString();
  OrderID += temp.substring(8, 12);
  OrderID += DateTime.now().month.toString();
  OrderID += DateTime.now().millisecond.toString();
  return OrderID;
}
