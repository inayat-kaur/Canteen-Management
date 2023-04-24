import 'package:flutter/material.dart';
import 'package:frontend/views/const/colors.dart';
import 'package:frontend/data/foodData.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);
  static const routeName = "/ViewCart";
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
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
                  itemCount: 4,
                  itemBuilder: (context, index) => FavouriteCard(
                        product: foodProducts[index],
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

class FavouriteCard extends StatelessWidget {
  const FavouriteCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);
  final Product product;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: InkWell(
        onTap: press,
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
                    product.image,
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
                      product.title,
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
                                child: const Icon(
                                  Icons.remove,
                                  color: AppColor.placeholderBg,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8.0,
                            ),
                            const Text(
                              "1",
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
                                child: const Icon(
                                  Icons.add,
                                  color: AppColor.placeholderBg,
                                ),
                              ),
                            )
                          ],
                        ),
                        Text(
                          "Rs. ${product.price}",
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
