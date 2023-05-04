import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/models/Order.dart';

void main() {
  group('Order tests', () {
    test('Order can be created', () {
      final order = Order(
        orderId: '1234',
        username: 'John',
        orderType: 'I',
        item: 'Burger',
        quantity: 2,
        price: 10,
        orderStatus: 'N',
        paymentStatus: 'N',
        time: DateTime.now(),
      );
      expect(order.orderId, '1234');
      expect(order.username, 'John');
      expect(order.orderType, 'I');
      expect(order.item, 'Burger');
      expect(order.quantity, 2);
      expect(order.price, 10);
      expect(order.orderStatus, 'N');
      expect(order.paymentStatus, 'N');
    });

    test('Order can be converted to JSON', () {
      final order = Order(
        orderId: '1234',
        username: 'John',
        orderType: 'I',
        item: 'Burger',
        quantity: 2,
        price: 10,
        orderStatus: 'N',
        paymentStatus: 'N',
        time: DateTime.now(),
      );
      final json = order.toJson();
      expect(json['orderId'], '1234');
      expect(json['username'], 'John');
      expect(json['orderType'], 'I');
      expect(json['item'], 'Burger');
      expect(json['quantity'], 2);
      expect(json['price'], 10);
      expect(json['order_status'], 'N');
      expect(json['payment_status'], 'N');
      expect(json['delivery_time'], order.time.toIso8601String());
    });

    test('Order can be created from JSON', () {
      final json = {
        'orderId': '1234',
        'username': 'John',
        'orderType': 'I',
        'item': 'Burger',
        'quantity': 2,
        'price': 10,
        'order_status': 'N',
        'payment_status': 'N',
        'delivery_time': DateTime.now().toIso8601String(),
      };
      final order = Order.fromJson(json);
      expect(order.orderId, '1234');
      expect(order.username, 'John');
      expect(order.orderType, 'I');
      expect(order.item, 'Burger');
      expect(order.quantity, 2);
      expect(order.price, 10);
      expect(order.orderStatus, 'N');
      expect(order.paymentStatus, 'N');
    });
  });
}
