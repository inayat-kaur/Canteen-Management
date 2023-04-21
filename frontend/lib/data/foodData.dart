import 'package:flutter/material.dart';

import '../views/utils/helper.dart';

class Product {
  final int id, price;
  final String title,image;
  final double rating;

  Product({
    required this.id,
    required this.image,
    this.rating = 0.0,
    required this.title,
    required this.price,
  });
}

// Our food Products

List<Product> foodProducts = [
  Product(
    id: 1,
    image: Helper.getAssetName("coffee.jpg", "real"),
    title: "Coffee",
    price: 64,
    rating: 4.8,
  ),
  Product(
    id: 2,
    image: Helper.getAssetName("pizza.jpg", "real"),
    title: "Pizza",
    price: 50,
    rating: 4.1,
  ),
  Product(
    id: 3,
    image: Helper.getAssetName("apple_pie.jpg", "real"),
    title: "Apple Pie",
    price: 19,
    rating: 4.0,
  ),
  Product(
    id: 4,
    image: Helper.getAssetName("hamburger.jpg", "real"),
    title: "Hamburger",
    price: 36,
    rating: 4.1,
  ),
  Product(
    id: 5,
    image: Helper.getAssetName("rice.jpg", "real"),
    title: "Rice",
    price: 15,
    rating: 4.2,
  ),
];
