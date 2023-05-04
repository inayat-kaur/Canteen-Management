import 'package:flutter/material.dart';
import 'package:frontend/views/customer/menuItem.dart';
import '../../models/menu.dart';
import '../general/profile_page.dart';
import 'cart_screen.dart';

class CategoryMenuPage extends StatefulWidget {
  final List<Menu> category;
  final String searchValue;
  final List<Menu> original;
  final String categoryTitle;

  CategoryMenuPage(
      {Key? key,
        required this.category,
        required this.searchValue,
        required this.original,
        required this.categoryTitle})
      : super(key: key);

  @override
  _CategoryMenuPageState createState() => _CategoryMenuPageState();
}

class _CategoryMenuPageState extends State<CategoryMenuPage> {
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    setState(() {
      _searchController.text = widget.searchValue;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          // IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {
          //     // Navigate to wishlist page
          //   },
          // ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Profile()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                )),
          ),
          SizedBox(height: 5.0),
          Expanded(
            child: (widget.category.isNotEmpty)
                ? ListView.builder(
              itemCount: widget.category.length,
              itemBuilder: (context, index) {
                return menuItem(menuitem: widget.category[index]);
              },
            )
                : Text("No items found"),
          ),
        ],
      ),
    );
    // body:menuItem(
    //   imagePath: 'assets/images/real/fruit.jpg',
    //   name: 'Item Name',
    //   price: 10,
    //   rating: 4,
    //   itemCount: 0,
    // )

    // ListView.builder(
    //   itemCount: menuItems.length,
    //   itemBuilder: (BuildContext context, int index) {
    //     return ListTile(
    //       title: Text(menuItems[index]),
    //       // Add any other menu item information, such as price, here
    //     );
    //   },
    // ),
    // );
  }
}