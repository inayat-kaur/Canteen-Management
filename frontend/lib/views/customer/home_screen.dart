import 'package:flutter/material.dart';
import 'package:frontend/controllers/customer/home_controller.dart';
import 'package:frontend/controllers/general/profile_page_controller.dart';
import 'package:frontend/views/customer/menuItem.dart';
import 'package:frontend/views/customer/category_menu_page.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/owner/menu_page.dart';

import '../../models/menu.dart';
import '../../my_services.dart';
import 'cart_screen.dart';
//building widget tree to show home screen of customer
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Menu> menu = [];
  List<String> categoriesList = [];
// fetching menu from database
  Future<void> fetchMenuItems() async {
    MyService myService = MyService();
    String token = myService.getToken();
    List<Menu> menu2 = await fetchMenu(token);
    setState(() {
      menu = menu2;
    });
    print("====================================");
    print(menu);
    List<String> categoriesList2 = await fetchCategories(token);
    setState(() {
      categoriesList = categoriesList2;
    });
    print(categoriesList);
  }

  @override
  void initState() {
    MyService myService = MyService();
    myService.initialize();
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
            icon: Icon(Icons.person),
            onPressed: () {
              //Naviagte to profile page
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => Profile()));
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 5.0),
         //Container holding two horizontal slidable widgets
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
                            'assets/images/virtual/offer.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Today\'s Special',
                              style: TextStyle(fontSize: 23.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              'Maharaja Thali',
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
                            'assets/images/virtual/clock.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Timimgs',
                              style: TextStyle(fontSize: 23.0),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              '11 AM -11 PM',
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
              itemBuilder: (context, index) => _buildClickableContainer(
                  context, categoriesList[index], menu),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildClickableContainer(
    BuildContext context, String title, List<Menu> menu) {
  List<Menu> filteredMenu = filterMenuBasedOnCategory(menu, title);
  String imageUrl = filteredMenu[0].image;
  return GestureDetector(
    onTap: () {
      List<Menu> filteredMenu = filterMenuBasedOnCategory(menu, title);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CategoryMenuPage(
                  category: filteredMenu,
                  searchValue: "",
                  original: filteredMenu,
                  categoryTitle: filteredMenu[0].category,
                )),
      );
    },
    child: Container(
      margin: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
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
          Image.network(
            imageUrl,
            width: 70.0,
            height: 70.0,
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
