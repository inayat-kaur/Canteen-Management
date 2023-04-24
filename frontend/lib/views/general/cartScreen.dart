import 'package:flutter/material.dart';
import 'package:frontend/views/const/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:frontend/controllers/cart_controller.dart';
import 'package:http/http.dart' as http;
import '../../urls.dart';
import 'dart:convert';
import '../../main.dart';
import '../../models/Cart.dart';
import '../../models/menu.dart';


class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);
  // final Cart c = Get.put(Cart(quantity: ));
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Cart cart = Cart(username: '',item: '',quantity: 0);
  get http => null;
   Future<void> getUsername() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     String? token = await prefs.getString('token');
         Future<List<Menu>> fetchMenu(String token) async {
    final response = await http.get(
      getMenu,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> menuJson = json.decode(response.body);
      List<Menu> menu = [];
      menuJson.forEach((item) {
        menu.add(Menu.fromJson(item));
      });
      return menu;
    } else {
      throw Exception('Failed to fetch menu');
    }
  }
   }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.orange,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // bottomNavigationBar: const CustomBottomBar(selectMenu: MenuState.cart),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: ListView(
            children: [
              ListView.builder(
                  //use shrink wrap true and scrollphysics to avoid error because we are using listview in side listview or column
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  // itemCount: 4,
                  itemBuilder: (context, index) => FavouriteCard(
                        product: Cart[index],
                        press: () {},
                      )),
                      SizedBox(height: 30),
                      Container(
                        padding: EdgeInsets.only(left:30),
                        child: Column(
                           crossAxisAlignment:  CrossAxisAlignment.start,
                          children: [
                            
                            Text(
                              "Grand Total:",
                              // textAlign: TextAlign.left,
                              style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                      ),                         
                            ),
                            SizedBox(
                              height:20
                            ),
                            Text(
                              "Place Order",
                              style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                      ),                         
                            ),
                          ],
                        ),
                        
                      ),
            ],
          ),

        ),

      ),
    );
  }
}

class FavouriteCard extends StatefulWidget {
  const FavouriteCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);
  final Cart product;
  final VoidCallback press;

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  void add(int price){
    setState(() {
      price++;
    });
  }

    void minus(int price){
    setState(() {
      price--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: widget.press,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
          decoration: BoxDecoration(
              color: AppColor.orange.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15.0)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Image.asset(
                    widget.product.image,
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.item,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColor.orange,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: AppColor.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.remove,
                                  color: AppColor.placeholderBg,),
                                  onPressed:()=> minus(widget.product.quantity),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              '${widget.product.quantity}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                    color: AppColor.orange,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add,
                                  color: AppColor.placeholderBg,),
                                  onPressed:()=> add(widget.product.quantity),
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Rs. ${widget.product.price}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
