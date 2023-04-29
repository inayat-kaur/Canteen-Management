import 'package:flutter/material.dart';
import 'package:frontend/views/owner/edit_menu_item_screen.dart';

class menuItemOwner extends StatefulWidget {
  final String name;
  final double price;
  final double rating;
  final String image;


  const menuItemOwner({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,

  }) : super(key: key);

  @override
  _menuItemStateOwner createState() => _menuItemStateOwner();
}

class _menuItemStateOwner extends State<menuItemOwner> {
  int itemCount =0;





  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 15,top:5,end:15,bottom:5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange,
          width: 2.0,

        ),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child:ListTile(
        contentPadding: EdgeInsetsDirectional.only(start: 15,top:10,end:15,bottom:10),
        horizontalTitleGap: 20,
        leading: Image.asset(widget.image ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.name, overflow: TextOverflow.ellipsis,),
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
            Text(' \u{20B9}${widget.price.toStringAsFixed(2)}',
              overflow: TextOverflow.ellipsis,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(4),
              ),
              child: GestureDetector(
                onTap: () {
                  // Handle text click
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => EditMenuItem(
                  //             imagePath: 'https://example.com/image.jpg',
                  //             name: 'Item Name',
                  //             price: 10,
                  //             rating: 4,
                  //             itemCount: 0,
                  //           )),
                  // );
                },
                child: Text(
                  'Edit',
                  style: TextStyle(
                   // decoration: TextDecoration.underline,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}