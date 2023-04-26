import 'package:frontend/models/cart.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Product {
  String image;
  String title;
  int price;

  Product({required this.image, required this.title, required this.price});
}

Future<List<Menu>> fetchMenu() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  Client client = Client();
  final response = await client.get(getMenu, headers: {
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    final List<dynamic> menuJson = json.decode(response.body);
    List<Menu> menu = [];
    for (int i = 0; i < menuJson.length; i++) {
      menu.add(Menu.fromJson(menuJson[i]));
    }
    return menu;
  } else {
    throw Exception('Failed to fetch menu');
  }
}

Future<List<Cart>> fetchCart() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  Client client = Client();
  final response = await client.get(getMyCart, headers: {
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode == 200) {
    final List<dynamic> cartJson = json.decode(response.body);
    List<Cart> cart = [];
    for (int i = 0; i < cartJson.length; i++) {
      cart.add(Cart.fromJson(cartJson[i]));
    }
    return cart;
  } else {
    throw Exception('Failed to fetch cart');
  }
}

Future<List<Product>> getProducts() async {
  List<Product> foodProducts = [];
  List<Menu> menu = await fetchMenu();
  print(menu);
  List<Cart> cart = await fetchCart();
  print(cart);
  for (int i = 0; i < cart.length; i++) {
    for (int j = 0; j < menu.length; j++) {
      if (cart[i].item == menu[j].item) {
        foodProducts.add(Product(
          image: 'assets/images/food.jpg',
          title: menu[j].item,
          price: menu[j].price,
        ));
      }
    }
  }
  return foodProducts;
}
