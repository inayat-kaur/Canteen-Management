import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/menu.dart';

void main() {
  test('Menu instance can be created', () {
    Menu menu = Menu(
        item: "Burger",
        price: 10,
        availability: "A",
        rating: 4,
        category: "Fast Food",
        type: 1,
        image: "burger.jpg");
    expect(menu.item, "Burger");
    expect(menu.price, 10);
    expect(menu.availability, "A");
    expect(menu.rating, 4);
    expect(menu.category, "Fast Food");
    expect(menu.type, 1);
    expect(menu.image, "burger.jpg");
  });

  test('Menu instance can be created from JSON', () {
    Map<String, dynamic> json = {
      "item": "Pizza",
      "price": 15,
      "availability": "A",
      "rating": 4,
      "category": "Italian",
      "type": 0,
      "image": "pizza.jpg"
    };
    Menu menu = Menu.fromJson(json);
    expect(menu.item, "Pizza");
    expect(menu.price, 15);
    expect(menu.availability, "A");
    expect(menu.rating, 4);
    expect(menu.category, "Italian");
    expect(menu.type, 0);
    expect(menu.image, "pizza.jpg");
  });

  test('Menu instance can be converted to JSON', () {
    Menu menu = Menu(
        item: "Burger",
        price: 10,
        availability: "A",
        rating: 4,
        category: "Fast Food",
        type: 1,
        image: "burger.jpg");
    Map<String, dynamic> json = menu.toJson();
    expect(json['item'], "Burger");
    expect(json['price'], "10");
    expect(json['availability'], "A");
    expect(json['rating'], "4");
    expect(json['category'], "Fast Food");
    expect(json['type'], "1");
    expect(json['image'], "burger.jpg");
  });
}
