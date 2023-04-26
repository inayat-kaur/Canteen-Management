import 'package:flutter/material.dart';
import 'package:frontend/views/customer/menuItem.dart';

class CategoryMenuPage extends StatefulWidget {
  final String category;

  CategoryMenuPage({Key? key, required this.category}) : super(key: key);

  @override
  _CategoryMenuPageState createState() => _CategoryMenuPageState();
}

class _CategoryMenuPageState extends State<CategoryMenuPage> {
  List<String> menuItems = [];




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.category),
          actions: [
            IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                // Navigate to cart page
              },
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Navigate to profile page
              },
            ),
          ],
        ),
        // body: menuItem(
        //   imagePath: 'assets/images/real/fruit.jpg',
        //   name: 'Item Name',
        //   price: 10,
        //   rating: 4,
        //   itemCount: 0,
        // )


    );
  }
}
