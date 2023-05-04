import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/customer/payment_screen_controller.dart';
import 'package:frontend/models/cart.dart';
import 'package:frontend/models/menu.dart';

void main() {
  test('should return a list of Product objects', () {
    final menu = [
      Menu(
        item: 'Item 1',
        price: 100,
        availability: 'A',
        rating: 4,
        category: 'Category 1',
        type: 0,
        image: 'assets/images/food.jpg',
      ),
      Menu(
        item: 'Item 2',
        price: 200,
        availability: 'A',
        rating: 3,
        category: 'Category 2',
        type: 1,
        image: 'assets/images/food.jpg',
      ),
      Menu(
        item: 'Item 3',
        price: 300,
        availability: 'U',
        rating: 5,
        category: 'Category 1',
        type: 0,
        image: 'assets/images/food.jpg',
      ),
    ];
    final cart = [
      Cart(username: "me", item: 'Item 1', quantity: 2),
      Cart(username: "me", item: 'Item 3', quantity: 1),
    ];
    final expectedProducts = [
      Product(
        image: 'assets/images/food.jpg',
        title: 'Item 1',
        price: 100,
        quantity: 2,
        availability: 'A',
        rating: 4,
        category: 'Category 1',
        type: 0,
      ),
      Product(
        image: 'assets/images/food.jpg',
        title: 'Item 3',
        price: 300,
        quantity: 1,
        availability: 'U',
        rating: 5,
        category: 'Category 1',
        type: 0,
      ),
    ];
    final result = getProductsHelper(menu, cart);
    expect(result[0].image, equals(expectedProducts[0].image));
    expect(result[0].title, equals(expectedProducts[0].title));
    expect(result[0].price, equals(expectedProducts[0].price));
    expect(result[0].quantity, equals(expectedProducts[0].quantity));
    expect(result[0].availability, equals(expectedProducts[0].availability));
    expect(result[0].rating, equals(expectedProducts[0].rating));
    expect(result[0].category, equals(expectedProducts[0].category));
    expect(result[0].type, equals(expectedProducts[0].type));
    expect(result[1].image, equals(expectedProducts[1].image));
    expect(result[1].title, equals(expectedProducts[1].title));
    expect(result[1].price, equals(expectedProducts[1].price));
    expect(result[1].quantity, equals(expectedProducts[1].quantity));
    expect(result[1].availability, equals(expectedProducts[1].availability));
    expect(result[1].rating, equals(expectedProducts[1].rating));
    expect(result[1].category, equals(expectedProducts[1].category));
    expect(result[1].type, equals(expectedProducts[1].type));
  });

  test('should return an empty list if both menu and cart are empty', () {
    final List<Menu> menu = [];
    final List<Cart> cart = [];
    final result = getProductsHelper(menu, cart);
    expect(result, isEmpty);
  });

  test('should return an empty list if cart is empty', () {
    final menu = [
      Menu(
        item: 'Item 1',
        price: 100,
        availability: 'A',
        rating: 4,
        category: 'Category 1',
        type: 0,
        image: 'image1.jpg',
      ),
      Menu(
        item: 'Item 2',
        price: 200,
        availability: 'A',
        rating: 3,
        category: 'Category 2',
        type: 1,
        image: 'image2.jpg',
      ),
    ];
    final List<Cart> cart = [];
    final result = getProductsHelper(menu, cart);
    expect(result, isEmpty);
  });

  test('should return an empty list if menu is empty', () {
    final List<Menu> menu = [];
    final cart = [
      Cart(item: 'Item 1', quantity: 2, username: 'me'),
      Cart(item: 'Item 3', quantity: 1, username: 'me'),
    ];
    final result = getProductsHelper(menu, cart);
    expect(result, isEmpty);
  });

  test('should return an empty list if there is no matching item', () {
    final menu = [
      Menu(
        item: 'Item 1',
        price: 100,
        availability: 'A',
        rating: 4,
        category: 'Category 1',
        type: 0,
        image: 'image1.jpg',
      ),
      Menu(
        item: 'Item 2',
        price: 200,
        availability: 'A',
        rating: 3,
        category: 'Category 2',
        type: 1,
        image: 'image2.jpg',
      ),
    ];
    final cart = [
      Cart(item: 'Item 5', quantity: 2, username: 'me'),
      Cart(item: 'Item 6', quantity: 1, username: 'me'),
    ];
    final result = getProductsHelper(menu, cart);
    expect(result, isEmpty);
  });

  group('getTotal', () {
    test('returns correct total for list of products', () {
      List<Product> products = [
        Product(
          image: 'assets/images/food.jpg',
          title: 'Pizza',
          price: 100,
          quantity: 2,
          availability: 'A',
          rating: 4,
          category: 'Fast Food',
          type: 0,
        ),
        Product(
          image: 'assets/images/food.jpg',
          title: 'Burger',
          price: 50,
          quantity: 3,
          availability: 'A',
          rating: 3,
          category: 'Fast Food',
          type: 0,
        ),
      ];

      expect(getTotal(products), equals(350));
    });

    test('returns 0 for empty list of products', () {
      List<Product> products = [];

      expect(getTotal(products), equals(0));
    });
  });

  test('Generate Order ID from Token', () {
    String token =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
    String orderId = generateOrderId(token);
    // orderid should not be null
    expect(orderId, isNotNull);
  });
}
