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
  List<Product> foodProducts = [];
  int total = 0;

  @override
  void initState() {
    List<Product> products = getProducts();
    setState(() {
      foodProducts = products;
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
                      Text(
                        "Payment",
                        style: Helper.getTheme(context).titleLarge,
                      ),
                      Expanded(
                          child:
                              ListView(padding: EdgeInsets.all(20), children: [
                        ListView.builder(
                          itemBuilder: (context, index) => ListTile(
                            title: Text(foodProducts[index].title),
                            subtitle: Text(
                                foodProducts[index].quantity.toString() +
                                    " x " +
                                    foodProducts[index].price.toString()),
                            trailing: Text((foodProducts[index].quantity *
                                    foodProducts[index].price)
                                .toString()),
                          ),
                          itemCount: foodProducts.length,
                          shrinkWrap: true,
                        )
                      ])),
                      Divider(),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total"),
                            Text(getTotal(foodProducts).toString())
                          ]),
                    ])))));
  }
}
