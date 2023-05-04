import 'package:flutter/material.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart.dart';
import '../../models/menu.dart';


class menuItem extends StatefulWidget {
  final Menu menuitem;
  // final String name;
  // final int price;
  // final int rating;
  // final String image;
  // final int count;

  const menuItem({
    Key? key,
    required this.menuitem,
    // required this.name,
    // required this.price,
    // required this.rating,
    // required this.image,
    // required this.count,
  }) : super(key: key);

  @override
  _menuItemState createState() => _menuItemState();
}

class _menuItemState extends State<menuItem> {
  bool isAddedToCart = false;
  bool isAvailable = true;

  Future<void> checkIfItemAddedToCart() async {
    print("checkIfItemAddedToCart");
    List<Cart> cartItems = await fetchCart();
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].item == widget.menuitem.item) {
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
    isAvailable = widget.menuitem.availability=='A';
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
        leading: Image.network(widget.menuitem.image),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.menuitem.item,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(widget.menuitem.rating.toString()),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' \u{20B9}${widget.menuitem.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      print("tap detected");
                      if (!isAddedToCart) {
                        print("add to cart case");
                        setState(() {
                          isAddedToCart = true;
                        });
                        addToCart(widget.name);
                      } else {
                        print("remove from cart case");
                        setState(() {
                          isAddedToCart = false;
                        });
                        deleteItem(widget.name);
                      }
                    },
                    child: isAddedToCart
                        ? Text("Remove from Cart")
                        : Text("Add to Cart"),
                  )),
            ),
            // child: IconButton(
            //     icon: Icon(Icons.add_shopping_cart, color: Colors.green),
            //     onPressed: () => addToCart(widget.name))),
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
