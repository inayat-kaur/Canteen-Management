// import 'package:flutter/material.dart';
//
//
// class menuItem extends StatefulWidget {
//   final String name;
//   final int price;
//   final int rating;
//   final String imagePath;
//   final int itemCount;
//   const menuItem({ Key? key, required this.name,required this.price,required this.rating,required this.imagePath,required this.itemCount }): super(key: key);
//   @override
//   State<menuItem> createState() => _menuItemState();
// }
//
// class _menuItemState extends State<menuItem> {
//  int itemCount=0;
//
//   void addItem() {
//     setState(() {
//       itemCount ++;
//     });
//   }
//
//   void removeItem() {
//     setState(() {
//       if (itemCount > 0) {
//         itemCount--;
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     return
//     Container(
//           width: double.infinity-12, // width equal to phone screen
//           height: 160, // fixed height of 20
//           padding: EdgeInsets.only(right: 5,left: 5,top:5),
//           child: Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(10), // round corners with radius of 10
//               border: Border.all(color: Colors.orange.shade400), // grey border
//             ),
//             padding: EdgeInsets.all(10), // padding of 10 on all sides
//             child:
//                 Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Flexible(
//                           child:
//                           Container(
//                             decoration: BoxDecoration(
//                               border: Border.all(
//                                 color: Colors.green.shade200,
//                                 width: 1.0,
//                               ),
//                             ),
//                             child:
//                             Image.asset(
//
//                               'assets/images/real/fruit.jpg',
//                               width: 30,
//                               height: 90,
//                             ),
//                           )
//                       ),
//
//                       Column(
//                         children: <Widget>[
//                           // First Row
//                           Row(
//                             children: <Widget>[
//                               // Widgets for the first row
//
//                               Text(' $widget.name ',
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 17,
//                                 ),),
//                               Icon(
//                                 Icons.star,
//                                 color: Colors.yellow,
//
//                               ),
//                               Text(' $widget.rating ',
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 13,
//                                 ),),
//
//                             ],
//                           ),
//
//                           // Second Row
//                           Row(
//                             children: <Widget>[
//                               // Widgets for the second row
//                               Icon(
//                                 Icons.currency_rupee,
//                                 color: Colors.black,
//
//                               ),
//                               Text(' $widget.price ',
//                                 style: const TextStyle(
//                                   color: Colors.black,
//                                   fontSize: 13,
//                                 ),),
//                               Flexible(
//                                   child:
//                                   Container(
//                                     child:
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
//                                         ElevatedButton(
//                                           onPressed: removeItem,
//                                           child: Icon(Icons.remove),
//                                           style: ElevatedButton.styleFrom(
//                                             shape: CircleBorder(),
//                                             padding: EdgeInsets.all(9),
//                                           ),
//                                         ),
//                                         SizedBox(width: 1),
//                                         Text(itemCount.toString(), style: TextStyle(fontSize: 17)),
//                                         SizedBox(width: 1),
//                                         ElevatedButton(
//                                           onPressed: addItem,
//                                           child: Icon(Icons.add),
//                                           style: ElevatedButton.styleFrom(
//                                             shape: CircleBorder(),
//                                             padding: EdgeInsets.all(9),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   )
//                               ),
//
//                             ],
//                           ),
//                         ],
//                       ),
//
//
//
//                     ]
//                 ),
//
//            // the child widget you want to wrap with this container
//           ),
//         );
//
//
//
//
// }}
//
//
//
import 'package:flutter/material.dart';

class menuItem extends StatefulWidget {
  final String name;
  final double price;
  final double rating;
  final String image;

  const menuItem({
    Key? key,
    required this.name,
    required this.price,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  _menuItemState createState() => _menuItemState();
}

class _menuItemState extends State<menuItem> {
  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(widget.image),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(widget.name),
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
          Text('\$${widget.price.toStringAsFixed(2)}'),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      itemCount--;
                    });
                  },
                  child: Icon(Icons.remove, size: 16),
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
                  child: Icon(Icons.add, size: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
