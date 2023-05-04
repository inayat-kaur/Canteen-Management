import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/Cart.dart';
import 'package:frontend/models/Menu.dart';

void main() {
  test('Test Cart constructor', () {
    Cart cart = Cart(username: 'user1', item: 'item1', quantity: 2);
    expect(cart.username, 'user1');
    expect(cart.item, 'item1');
    expect(cart.quantity, 2);
  });

  test('Test Cart fromJson', () {
    Map<String, dynamic> json = {
      'username': 'user1',
      'item': 'item1',
      'quantity': 2,
    };
    Cart cart = Cart.fromJson(json);
    expect(cart.username, 'user1');
    expect(cart.item, 'item1');
    expect(cart.quantity, 2);
  });

  test('Test Cart toJson', () {
    Cart cart = Cart(username: 'user1', item: 'item1', quantity: 2);
    Map<String, dynamic> json = cart.toJson();
    expect(json['username'], 'user1');
    expect(json['item'], 'item1');
    expect(json['quantity'], 2);
  });

  test('Test Product constructor', () {
    Product product = Product(
        image: 'image1',
        title: 'title1',
        price: 10,
        quantity: 2,
        availability: 'available',
        rating: 4,
        category: 'category1',
        type: 1);
    expect(product.image, 'image1');
    expect(product.title, 'title1');
    expect(product.price, 10);
    expect(product.quantity, 2);
    expect(product.availability, 'available');
    expect(product.rating, 4);
    expect(product.category, 'category1');
    expect(product.type, 1);
  });
}
