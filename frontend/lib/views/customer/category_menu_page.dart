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



  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => menuItem(
                //             imagePath: 'https://example.com/image.jpg',
                //             name: 'Item Name',
                //             price: 10,
                //             rating: 4,
                //             itemCount: 0,
                //           )),
                // );
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
      body: Column(
        children: [
          SizedBox(height: 5.0),
          TextField(
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            )
          ),
          // Padding(
          //   padding: const EdgeInsets.all(8.0),
          //   child: TextField(
          //     decoration: InputDecoration(
          //       hintText: "Search",
          //       prefixIcon: Icon(Icons.search),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(20.0),
          //       ),
          //     ),
          //   ),
          // ),
          Expanded(
            child: Text('Text')
          )
          // ListView.builder(
          //   itemCount: 1,
          //   itemBuilder: (context, index) {
          //     return Text("Test");
          //     // return  menuItem(
          //     //
          //     //   name: 'Item Name',
          //     //   price: 10,
          //     //   rating: 4,
          //     //   image: 'assets/images/real/fruit.jpg',
          //     //
          //     // );
          //       // add other properties as needed
          //
          //   },
          // ),

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
