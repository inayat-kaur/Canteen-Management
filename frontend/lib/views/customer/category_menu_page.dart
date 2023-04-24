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
  void initState() {
    super.initState();
    // In this example, we're just hard-coding some menu items for each category
    // You can replace this with your own data source or API call
    if (widget.category == 'Image 1') {
      menuItems = ['Fried Calamari', 'Bruschetta', 'Garlic Bread'];
    } else if (widget.category == 'Entrees') {
      menuItems = [
        'Spaghetti Bolognese',
        'Chicken Parmesan',
        'Pizza Margherita'
      ];
    } else if (widget.category == 'Desserts') {
      menuItems = ['Tiramisu', 'Cannoli', 'Gelato'];
    }
  }

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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => menuItem(
                            imagePath: 'https://example.com/image.jpg',
                            name: 'Item Name',
                            price: 10,
                            rating: 4,
                            itemCount: 0,
                          )),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                // Navigate to wishlist page
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
        body: menuItem(
          imagePath: 'https://example.com/image.jpg',
          name: 'Item Name',
          price: 10,
          rating: 4,
          itemCount: 0,
        )

        // ListView.builder(
        //   itemCount: menuItems.length,
        //   itemBuilder: (BuildContext context, int index) {
        //     return ListTile(
        //       title: Text(menuItems[index]),
        //       // Add any other menu item information, such as price, here
        //     );
        //   },
        // ),
        );
  }
}
