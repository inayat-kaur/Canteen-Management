import 'package:flutter/material.dart';
import 'package:frontend/views/customer/payment_screen.dart';
import 'package:frontend/views/utils/colors.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/views/customer/menu_item_cart.dart';
import 'order_options_dialog.dart';

//TODO
//Ordering deleted Items

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> foodProducts = [];

  Future<void> initialize() async {
    List<Product> products = await getProducts();
    setState(() {
      foodProducts = products;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0),
          Expanded(
            child: ListView.builder(
              itemCount: foodProducts.length,
              itemBuilder: (context, index) {
                return menuItemCart(
                  product: foodProducts[index],
                );
                // return menuItemCart(
                //   name: foodProducts[index].title,
                //   price: foodProducts[index].price,
                //   rating: foodProducts[index].rating,
                //   image: "assets/images/real/pizza.jpg",
                //   count: 1,
                // );
              },
            ),
          ),
          SizedBox(height: 30),
          Container(
            padding: EdgeInsets.only(left: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ElevatedButton(
                  child: Text(
                    "Place Order",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () async {
                    // List<String> orderOptions = [];
                    // orderOptions = await showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) {
                    //     return ServiceDialog();
                    //   },
                    // );
                    // orderCartItems(foodProducts, orderOptions);
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => Payment()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
