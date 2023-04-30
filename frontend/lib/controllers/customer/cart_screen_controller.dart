import 'package:frontend/controllers/general/profile_page_controller.dart';
import 'package:frontend/models/order.dart';
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
  int quantity;
  String availability;
  int rating;
  String category;
  int type;

  Product(
      {required this.image,
      required this.title,
      required this.price,
      required this.quantity,
      required this.availability,
      required this.rating,
      required this.category,
      required this.type});
}

Future<void> addToCart(String name) async {
  String token = await getToken();
  Client client = Client();
  print("Add to cart called");
  final response = await client.post(addCartItem, headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'item': name,
    'quantity': '1',
  });
  client.close();
  if (response.statusCode == 201) {
    print('Added to cart');
  } else {
    throw Exception('Failed to add to cart');
  }
}

Future<List<Menu>> fetchMenu() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  Client client = Client();
  final response = await client.get(getMenu, headers: {
    'Authorization': 'Bearer $token',
  });
  client.close();
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
  client.close();
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
  List<Cart> cart = await fetchCart();
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

void updateQuantity(String item, int quantity) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  Client client = Client();
  final response = await client.put(updateCartItemQuantity(item), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'quantity': quantity.toString(),
  });
  client.close();
  if (response.statusCode == 200) {
    print('Quantity updated');
  } else {
    throw Exception('Failed to update quantity');
  }
}

void deleteItem(String item) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  Client client = Client();
  final response = await client.delete(deleteCartItem(item),
      headers: {'Authorization': 'Bearer $token'});
  client.close();
  if (response.statusCode == 200) {
    print('Item deleted');
  } else {
    throw Exception('Failed to delete item');
  }
}

int getTotal(List<Product> products) {
  int total = 0;
  for (int i = 0; i < products.length; i++) {
    total += products[i].price * products[i].quantity;
  }
  return total;
}

Future<void> orderCartItems(
    List<Product> foodProducts, List<String> orderOptions) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String token = prefs.getString('token')!;
  String OrderID = '';
  String temp = token.split('.')[1];
  OrderID += temp.substring(2, 4);
  OrderID += DateTime.now().hour.toString();
  OrderID += temp.substring(0, 2);
  OrderID += DateTime.now().day.toString();
  OrderID += DateTime.now().second.toString();
  OrderID += temp.substring(6, 8);
  OrderID += DateTime.now().minute.toString();
  OrderID += DateTime.now().year.toString();
  OrderID += temp.substring(8, 12);
  OrderID += DateTime.now().month.toString();
  OrderID += DateTime.now().millisecond.toString();
  print(OrderID);
  Order order = Order(
      orderId: OrderID,
      username: "",
      orderType: "I",
      item: "",
      quantity: 0,
      price: 0,
      orderStatus: "N",
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
    print("Order placed");
  }
  final response = await client
      .delete(emptyCart, headers: {'Authorization': 'Bearer $token'});
  if (response.statusCode == 200) {
    print('Cart emptied');
  } else {
    throw Exception('Failed to empty cart');
  }
  client.close();
}
