import 'package:frontend/models/order.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';
import 'dart:convert';
import '../../my_services.dart';

// add a menu item to the cart. It returns 201 on successful addition
Future<void> addToCart(String name) async {
  MyService myService = MyService();
  String token = myService.getToken();
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
    myService.addCart(Cart(
        item: name, username: myService.getProfile().username, quantity: 1));
    print('Added to cart');
  } else {
    throw Exception('Failed to add to cart');
  }
}

// fetches the complete menu from the database
Future<List<Menu>> fetchMenu() async {
  MyService myService = MyService();
  if (myService.getMyMenu().isNotEmpty) {
    return myService.getMyMenu();
  }

  String token = myService.getToken();
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

// fetches the complete cart for a given user/customer
Future<List<Cart>> fetchCart() async {
  MyService myService = MyService();
  if (myService.getCart().isNotEmpty) {
    return myService.getCart();
  }

  String token = myService.getToken();
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

// get the common products in cart and menu
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

// update the quantity of a given food item in the menu
void updateQuantity(String item, int quantity) async {
  MyService myService = MyService();
  String token = myService.getToken();
  Client client = Client();
  final response = await client.put(updateCartItemQuantity(item), headers: {
    'Authorization': 'Bearer $token',
  }, body: {
    'quantity': quantity.toString(),
  });
  client.close();
  if (response.statusCode == 200) {
    myService.incrementInCart(item, quantity);
    print('Quantity updated');
  } else {
    throw Exception('Failed to update quantity');
  }
}

// delete the item from the cart
void deleteItem(String item) async {
  MyService myService = MyService();
  String token = myService.getToken();
  Client client = Client();
  final response = await client.delete(deleteCartItem(item),
      headers: {'Authorization': 'Bearer $token'});
  client.close();
  if (response.statusCode == 200) {
    Cart cartItem = Cart(item: '', quantity: 0, username: '');
    for (int i = 0; i < myService.getCart().length; i++) {
      if (myService.getCart()[i].item == item) {
        cartItem = myService.getCart()[i];
        break;
      }
    }
    myService.removeCart(cartItem);
    print('Item deleted');
  } else {
    throw Exception('Failed to delete item');
  }
}
