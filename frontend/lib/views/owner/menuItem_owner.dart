import 'package:flutter/material.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:frontend/views/owner/edit_menu_item_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart.dart';
import '../../models/menu.dart';

class menuItem extends StatefulWidget {
  final String name;
  final int price;
  final int rating;
  final String image;
  final int count;
  final Menu mymenu;

  const menuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
    required this.count,
    required this.mymenu,
  }) : super(key: key);

  @override
  _menuItemState createState() => _menuItemState();
}

class _menuItemState extends State<menuItem> {
  bool isAddedToCart = false;

  Future<void> checkIfItemAddedToCart() async {
    print("checkIfItemAddedToCart");
    List<Cart> cartItems = await fetchCart();
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].item == widget.name) {
        setState(() {
          isAddedToCart = true;
        });
        break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    checkIfItemAddedToCart();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 15, top: 5, end: 15, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
          width: 2.0,
        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: ListTile(
        contentPadding:
            EdgeInsetsDirectional.only(start: 15, top: 10, end: 15, bottom: 10),
        horizontalTitleGap: 20,
        leading: Image.asset(widget.image),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.name,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(widget.rating.toString()),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' \u{20B9}${widget.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(4),
                ),
                // child: GestureDetector(
                //   onTap: () {
                //     print("tap detected");
                //     if (!isAddedToCart) {
                //       print("add to cart case");
                //       setState(() {
                //         isAddedToCart = true;
                //       });
                //       addToCart(widget.name);
                //     } else {
                //       print("remove from cart case");
                //       setState(() {
                //         isAddedToCart = false;
                //       });
                //       deleteItem(widget.name);
                //     }
                //   },
                child: IconButton(
                    icon: Icon(Icons.edit, color: Colors.green),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditMenuItem(
                                    menu: widget.mymenu,
                                  )));
                    })),
            // child: Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           itemCount--;
            //         });
            //       },
            //       child: Icon(Icons.remove, size: 20),
            //     ),
            //     SizedBox(width: 8),
            //     Text(itemCount.toString(), style: TextStyle(fontSize: 16)),
            //     SizedBox(width: 8),
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           itemCount++;
            //         });
            //       },
            //       child: Icon(Icons.add, size: 20),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
