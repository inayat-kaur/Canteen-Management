import '../../models/Order.dart';
import '../../models/cart.dart';
import '../../models/menu.dart';
import '../../my_services.dart';
import '../../urls.dart';
import 'package:http/http.dart';

List<Product> getProducts() {
  List<Product> foodProducts = [];
  MyService myService = MyService();
  List<Menu> menu = myService.getMyMenu();
  List<Cart> cart = myService.getCart();
  print("###################################");
  print(menu.length);
  print(cart.length);
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

int getTotal(List<Product> products) {
  int total = 0;
  for (int i = 0; i < products.length; i++) {
    total += products[i].price * products[i].quantity;
  }
  return total;
}

Future<void> orderCartItems(
    List<Product> foodProducts, List<String> orderOptions) async {
  MyService myService = MyService();
  String token = myService.getToken();
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
  print(OrderID);
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
  } else {
    throw Exception('Failed to empty cart');
  }
  client.close();
}
