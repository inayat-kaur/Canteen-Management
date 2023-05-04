import 'package:flutter/material.dart';
import 'package:frontend/views/general/profile_page.dart';
import 'package:frontend/views/owner/category_menu_owner.dart';
import '../../controllers/owner/menu_page_controller.dart';
import '../../models/menu.dart';
import '../../my_services.dart';
import 'order_history_canteen.dart';
import 'add_new_category_item.dart';

class menuPageOwner extends StatefulWidget {
  @override
  _menuPageStateOwner createState() => _menuPageStateOwner();
}

class _menuPageStateOwner extends State<menuPageOwner> {
  final TextEditingController _text1Controller = TextEditingController();
  final TextEditingController _text2Controller = TextEditingController();

  String _savedText1 = '';
  String _savedText2 = '';

  late List<Menu> menu = [];
  late List<String> categoriesList = [];

  Future<void> fetchMenuItems() async {
    MyService myService = MyService();
    String token = myService.getToken();
    List<Menu> menu2 = await fetchMenu();
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
    categoriesList.add("Add new Category");
  }

  @override
  void initState() {
    super.initState();
    fetchMenuItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Menu"),
        actions: [
          IconButton(
            icon: Icon(Icons.history),
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => orderHistoryCanteen()));
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
            ),
          ),
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
                            TextField(
                              controller: _text1Controller,
                              decoration: InputDecoration(
                                labelText: 'Enter Offer',
                              ),
                            ),
                            TextField(
                              controller: _text2Controller,
                              decoration: InputDecoration(
                                labelText: 'Details',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _savedText1 = _text1Controller.text;
                                  _savedText2 = _text2Controller.text;
                                });
                                // Save text to database or variable
                              },
                              child: Text('Save'),
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
                            TextField(
                              controller: _text1Controller,
                              decoration: InputDecoration(
                                labelText: 'Enter Offer',
                              ),
                            ),
                            TextField(
                              controller: _text2Controller,
                              decoration: InputDecoration(
                                labelText: 'Details',
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  _savedText1 = _text1Controller.text;
                                  _savedText2 = _text2Controller.text;
                                });
                                // Save text to database or variable
                              },
                              child: Text('Save'),
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
              itemBuilder: (context, index) => _buildClickableContainer(context,
                  categoriesList[index], 'assets/images/real/fruit.jpg', menu),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1,
              ),
            ),
          )

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

Widget _buildClickableContainer(
    BuildContext context, String title, String imageUrl, List<Menu> menu) {
  if (title == "Add new Category") {
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
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNewCategoryItem()));
                },
                icon: Icon(
                  Icons.add,
                  size: 50.0,
                  color: Colors.black,
                )),
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
