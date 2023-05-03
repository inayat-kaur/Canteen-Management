import 'package:flutter/material.dart';
import 'package:frontend/controllers/customer/home_controller.dart';
import 'package:frontend/controllers/general/profile_page_controller.dart';
import 'package:frontend/views/customer/menuItem.dart';
import 'package:frontend/views/customer/category_menu_page.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/owner/menu_page.dart';

import '../../models/menu.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Menu> menu = [];
  List<String> categoriesList = ['ygftydf','rdtygu','htf6','gvy'];

  Future<void> fetchMenuItems() async {
    String token = await getToken();
    menu = await fetchMenu(token);
    print("====================================");
    print(menu);
    categoriesList = await fetchCategories(token);
    print(categoriesList);
  }

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text("Welcome"),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              //Navigate to cart page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => menuPageOwner(),
              //   ),
              //);
            },
          ),
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
          //     // onChanged: (value) {
          //     //   List<Menu> filteredMenu = searchMenu(menu, value);
          //     //   Navigator.push(
          //     //     context,
          //     //     MaterialPageRoute(
          //     //         builder: (context) => CategoryMenuPage(
          //     //               category: filteredMenu,
          //     //             )),
          //     //   );
          //     // },
          //   ),
          // ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            height: 200.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        margin: EdgeInsets.only(right: 10.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 30.0,
                            top: 45.0,
                          ),
                          child: Image.asset(
                            'assets/images/real/fruit.jpg',
                            fit: BoxFit.cover,
                          ),
                          // Image.network(
                          //   'frontend/assets/real/fruit.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'First text field',
                              style: TextStyle(fontSize: 20.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Second text fieldjsiuaye78fhodif90weif0wrofiljah',
                              style: TextStyle(fontSize: 16.0),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 10,
                  height: 150.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150.0,
                        height: 150.0,
                        margin: EdgeInsets.only(right: 10.0),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: 30.0,
                            top: 45.0,
                          ),
                          child: Image.asset(
                            'assets/images/real/fruit.jpg',
                            fit: BoxFit.cover,
                          ),
                          // Image.network(
                          //
                          //
                          //   'assets/images/real/fruit.jpg',
                          //   fit: BoxFit.cover,
                          // ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'First text field',
                              style: TextStyle(fontSize: 20.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Second text fieldjsiuaye78fhodif90weif0wrofiljah',
                              style: TextStyle(fontSize: 16.0),
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        Expanded(

          child: GridView.builder(
            itemCount: categoriesList.length,
            itemBuilder: (context, index) => _buildClickableContainer( context,categoriesList[index],
                'assets/images/real/fruit.jpg',  menu),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
             childAspectRatio: 1,
            ),
          ),)


      //


          // Expanded(
          //   child: ListView.builder(
          //     itemCount: _items.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return ListTile(
          //         leading: Image.network(_items[index]["image"]),
          //         title: Text(_items[index]["name"]),
          //         subtitle: Text(_items[index]["description"]),
          //         trailing: Text("\$${_items[index]["price"]}"),
          //         onTap: () {
          //           // Navigate to item detail page
          //         },
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}

Widget _buildClickableContainer(BuildContext context, String title,
    String imageUrl, List<Menu> menu) {
  return GestureDetector(
    onTap: () {
      List<Menu> filteredMenu = filterMenuBasedOnCategory(menu, title);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryMenuPage(
                  category: filteredMenu,
                )),
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 5,right:5 ,top: 5,bottom: 5),
     width: MediaQuery.of(context).size.width / 3 - 20.0,
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            //imageUrl,
            'assets/images/real/fruit.jpg',
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5.0),

        ],
      ),
    ),
  );
}
