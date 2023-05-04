import 'package:flutter/material.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart.dart';

// widget to display menu on cart screen
class menuItemCart extends StatefulWidget {
  final Product product;


  const menuItemCart({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  _menuItemStateCart createState() => _menuItemStateCart();
}

class _menuItemStateCart extends State<menuItemCart> {
  bool isAddedToCart = false;
  int itemCount = 0;

  Future<void> checkIfItemAddedToCart() async {
    print("checkIfItemAddedToCart");
    List<Cart> cartItems = await fetchCart();
    for (int i = 0; i < cartItems.length; i++) {
      if (cartItems[i].item == widget.product.title) {
        setState(() {
          itemCount = cartItems[i].quantity;
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
        leading: Image.network(widget.product.image),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.product.title,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 16),
                SizedBox(width: 4),
                Text(widget.product.rating.toString()),
              ],
            ),
          ],
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ' \u{20B9}${widget.product.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(4),
              ),

              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (itemCount > 0) itemCount--;
                      });
                    },
                    child: Icon(Icons.remove, size: 20),
                  ),
                  SizedBox(width: 8),
                  Text(itemCount.toString(), style: TextStyle(fontSize: 16)),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        itemCount++;
                      });
                    },
                    child: Icon(Icons.add, size: 20),
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      updateQuantity(widget.product.title, itemCount);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Quantity Updated"),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.check,
                      size: 22,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
