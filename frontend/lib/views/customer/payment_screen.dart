import 'package:flutter/material.dart';

import '../../controllers/customer/payment_screen_controller.dart';
import '../../models/cart.dart';
import '../utils/helper.dart';

class Payment extends StatefulWidget {
  const Payment({super.key});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<Product> foodProduct = [];
  int total = 0;

  @override
  void initState() {
    List<Product> products = getProducts();
    setState(() {
      foodProduct = products;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Payment"), centerTitle: true),
        body: Container(
            width: Helper.getScreenWidth(context),
            height: Helper.getScreenHeight(context),
            child: SafeArea(
                child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 30,
                    ),
                    child: Column(children: [
                      Expanded(
                          child:
                              ListView(padding: EdgeInsets.all(20), children: [
                        ListView.builder(
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsetsDirectional.only(bottom: 5),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(13.0),
                            ),
                            child: ListTile(
                              title: Text(foodProduct[index].title),
                              subtitle: Text(
                                  foodProduct[index].quantity.toString() +
                                      " x " +
                                      foodProduct[index].price.toString()),
                              trailing: Text("\u{20B9}" +
                                  (foodProduct[index].quantity *
                                          foodProduct[index].price)
                                      .toString()),
                            ),
                          ),
                          itemCount: foodProduct.length,
                          shrinkWrap: true,
                        )
                      ])),
                      Divider(
                        color: Colors.orangeAccent,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Text("\u{20B9}" + getTotal(foodProduct).toString())
                          ]),
                      Divider(
                        color: Colors.orangeAccent,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            List<String> orderOptions = [];
                            orderCartItems(foodProduct, orderOptions, context);
                          },
                          child: Text("Order Now"))
                    ])))));
  }
}
