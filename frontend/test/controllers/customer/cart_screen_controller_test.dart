import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/controllers/customer/cart_screen_controller.dart';
import 'package:frontend/models/menu.dart';
import 'package:frontend/urls.dart';
import 'package:http/http.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend/my_services.dart';
import 'package:frontend/models/cart.dart';
import 'dart:convert';

//class MockClient extends Mock implements Client {}

@GenerateMocks([Client, MyService])
void main() {
  // final String name = 'Samosa';
  // final String token =
  //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RfY3VzdG9tZXJAZ21haWwuY29tIiwiaWF0IjoxNjgzMTk3ODY0fQ.KAyY6TCXt8_Jm-CyIHF3n1R-nwvHMirkyZ9TbZ_OBiw';
  // final String username = 'test_customer@gmail.com';
  // final List<Cart> cart = [
  //   Cart(username: username, item: 'Samosa', quantity: 2),
  //   Cart(username: username, item: 'Item 2', quantity: 1)
  // ];

  // test('Adding existing item to cart increases its quantity', () async {
  //   final myService = MockMyService();
  //   final client = MockClient();
  //   final response = Response('{"success": true}', 201);

  //   when(myService.getToken()).thenReturn(token);
  //   when(myService.getCart()).thenReturn(cart);

  //   await addToCart(name, client);

  //   verify(updateQuantity(name, 3)).called(1);
  //   verifyNever(client.post(addCartItem,
  //       headers: anyNamed('headers'), body: anyNamed('body')));

  //   clearInteractions(myService);
  //   clearInteractions(client);
  // });

  // test('Adding new item to cart creates a new cart item', () async {
  //   final myService = MockMyService();
  //   final client = MockClient();
  //   final response = Response('{"success": true}', 201);

  //   when(myService.getToken()).thenReturn(token);
  //   when(myService.getCart()).thenReturn(cart);
  //   when(client.post(addCartItem,
  //           headers: anyNamed('headers'), body: anyNamed('body')))
  //       .thenAnswer((_) async => response);

  //   await addToCart(name, client);

  //   verify(myService.addCart(Cart(
  //           item: name,
  //           username: myService.getProfile().username,
  //           quantity: 1)))
  //       .called(1);
  //   verify(client.post(
  //     addCartItem,
  //     headers: {'Authorization': 'Bearer $token'},
  //     body: {'item': name, 'quantity': '1'},
  //   )).called(1);

  //   clearInteractions(myService);
  //   clearInteractions(client);
  // });

  // test('Adding item to cart fails with non-201 response', () async {
  //   final myService = MockMyService();
  //   final client = MockClient();
  //   final response = Response('{"success": false}', 400);

  //   when(myService.getToken()).thenReturn(token);
  //   when(myService.getCart()).thenReturn(cart);
  //   when(client.post(addCartItem,
  //           headers: anyNamed('headers'), body: anyNamed('body')))
  //       .thenAnswer((_) async => Future.value(response));

  //   expect(() => addToCart(name, client), throwsException);

  //   verifyNever(myService.addCart(Cart(
  //       item: name, username: myService.getProfile().username, quantity: 1)));
  //   verify(client.post(
  //     addCartItem,
  //     headers: {'Authorization': 'Bearer $token'},
  //     body: {'item': name, 'quantity': '1'},
  //   )).called(1);

  //   clearInteractions(myService);
  //   clearInteractions(client);
  // });

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
}

class MockMyService extends Mock implements MyService {
  // @override
  // String getToken() {
  //   return "";
  // }
}
