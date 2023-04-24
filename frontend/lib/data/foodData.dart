import 'package:flutter/material.dart';

import '../views/utils/helper.dart';

class Product {
  final int price;
  final String title,image;
//match item to id and than use id for image
  Product({

    required this.image,
    required this.title, //item
    required this.price,
  });
}

// Our food Products

List<Product> foodProducts = [
  Product(

    image: Helper.getAssetName("coffee.jpg", "real"),
    title: "Coffee",
    price: 64,
  ),
  Product(

    image: Helper.getAssetName("pizza.jpg", "real"),
    title: "Pizza",
    price: 50,
  ),
  Product(

    image: Helper.getAssetName("apple_pie.jpg", "real"),
    title: "Apple Pie",
    price: 19,
  ),
  Product(

    image: Helper.getAssetName("hamburger.jpg", "real"),
    title: "Hamburger",
    price: 36,
  ),
  Product(
    image: Helper.getAssetName("rice.jpg", "real"),
    title: "Rice",
    price: 15,
  ),
];
