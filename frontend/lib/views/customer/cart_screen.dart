import 'package:flutter/material.dart';
import 'package:frontend/views/customer/payment_screen.dart';
import 'package:frontend/views/utils/colors.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:frontend/models/cart.dart';
import 'order_options_dialog.dart';

//TODO
//Ordering deleted Items

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product> foodProducts = [];
  int total = 0;

  Future<void> initialize() async {
    List<Product> products = await getProducts();
    setState(() {
      foodProducts = products;
    });
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: ListView(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: foodProducts.length,
                  itemBuilder: (context, index) =>
                      FavouriteCard(product: foodProducts[index])),
              SizedBox(height: 30),
              Container(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      child: Text(
                        "Place Order",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        // List<String> orderOptions = [];
                        // orderOptions = await showDialog(
                        //   context: context,
                        //   builder: (BuildContext context) {
                        //     return ServiceDialog();
                        //   },
                        // );
                        // orderCartItems(foodProducts, orderOptions);
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => Payment()));
                      },
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
  const FavouriteCard({Key? key, required this.product}) : super(key: key);
  final Product product;

  @override
  State<FavouriteCard> createState() => _FavouriteCardState();
}

class _FavouriteCardState extends State<FavouriteCard> {
  bool isdeleted = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: isdeleted
          ? Text("")
          : InkWell(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8.0),
                decoration: BoxDecoration(
                    color: (widget.product.availability == "A")
                        ? AppColor.orange.withOpacity(0.3)
                        : AppColor.orange.withOpacity(0.1),
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
                          Row(
                            children: [
                              Text(
                                widget.product.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.orange,
                                ),
                              ),
                              const Spacer(),
                              Text(widget.product.category),
                              const Spacer(),
                              (widget.product.type == 0)
                                  ? Icon(
                                      Icons.center_focus_strong_sharp,
                                      color: Color.fromARGB(255, 9, 85, 11),
                                      size: 30,
                                    )
                                  : Icon(
                                      Icons.center_focus_strong_sharp,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                            ],
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
                                    onTap: () {
                                      setState(() {
                                        if (widget.product.quantity > 1) {
                                          widget.product.quantity--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: AppColor.orange,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Icon(
                                        Icons.remove,
                                        color: AppColor.placeholderBg,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  Text(
                                    widget.product.quantity.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8.0,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        widget.product.quantity++;
                                      });
                                    },
                                    child: Container(
                                      height: 25,
                                      width: 25,
                                      decoration: BoxDecoration(
                                          color: AppColor.orange,
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      child: const Icon(
                                        Icons.add,
                                        color: AppColor.placeholderBg,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              RatingStars(widget.product.rating),
                              SizedBox(
                                width: 10,
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
                          Row(
                            children: [
                              ElevatedButton(
                                child: Text("Save Changes"),
                                onPressed: () {
                                  updateQuantity(widget.product.title,
                                      widget.product.quantity);
                                },
                              ),
                              ElevatedButton(
                                child: Text("Delete Item"),
                                onPressed: () {
                                  deleteItem(widget.product.title);
                                  setState(() {
                                    isdeleted = true;
                                  });
                                },
                              ),
                            ],
                          )
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

class RatingStars extends StatefulWidget {
  final int rating;
  const RatingStars(this.rating, {super.key});

  @override
  State<RatingStars> createState() => _RatingStarsState();
}

class _RatingStarsState extends State<RatingStars> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: (widget.rating >= 1) ? Colors.red : Colors.grey,
          ),
          Icon(
            Icons.star,
            color: (widget.rating >= 2) ? Colors.red : Colors.grey,
          ),
          Icon(
            Icons.star,
            color: (widget.rating >= 3) ? Colors.red : Colors.grey,
          ),
          Icon(
            Icons.star,
            color: (widget.rating >= 4) ? Colors.red : Colors.grey,
          ),
          Icon(
            Icons.star,
            color: (widget.rating >= 5) ? Colors.red : Colors.grey,
          ),
        ],
      ),
    );
  }
}
